import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

type DepositPayload = {
  uid: string;
  amount: number;
};

type WithdrawalPayload = {
  uid: string;
  amount: number;
};

admin.initializeApp();

const db = admin.firestore();

export const createDepositOrder = functions.https.onCall(async (data: DepositPayload) => {
  if (!data.uid || data.amount <= 0) {
    throw new functions.https.HttpsError('invalid-argument', 'Invalid deposit payload');
  }
  const txRef = db.collection('transactions').doc();
  await txRef.set({
    uid: data.uid,
    amount: data.amount,
    type: 'deposit',
    status: 'pending',
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });
  return { orderId: txRef.id };
});

export const requestWithdrawal = functions.https.onCall(async (data: WithdrawalPayload) => {
  if (!data.uid || data.amount <= 0) {
    throw new functions.https.HttpsError('invalid-argument', 'Invalid withdrawal payload');
  }
  const walletRef = db.collection('wallets').doc(data.uid);
  await db.runTransaction(async (transaction) => {
    const snapshot = await transaction.get(walletRef);
    if (!snapshot.exists) {
      throw new functions.https.HttpsError('not-found', 'Wallet not found');
    }
    const balance = snapshot.data()?.balance ?? 0;
    if (balance < data.amount) {
      throw new functions.https.HttpsError('failed-precondition', 'Insufficient balance');
    }
    transaction.update(walletRef, {
      balance: balance - data.amount,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  });
  return { status: 'requested' };
});

export const setCustomClaimAdmin = functions.https.onCall(async ({ uid }) => {
  if (!uid) {
    throw new functions.https.HttpsError('invalid-argument', 'UID is required');
  }
  await admin.auth().setCustomUserClaims(uid, { admin: true });
  return { success: true };
});

export const seedDemoData = functions.https.onCall(async () => {
  const batch = db.batch();
  const userRef = db.collection('users').doc('demo-user');
  batch.set(userRef, {
    displayName: 'Demo Player',
    email: 'demo@example.com',
    kycStatus: 'approved',
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    banned: false,
    roles: ['player'],
  });
  const walletRef = db.collection('wallets').doc('demo-user');
  batch.set(walletRef, {
    balance: 1000,
    bonusBalance: 0,
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  });
  const tableRef = db.collection('tables').doc('demo-table');
  batch.set(tableRef, {
    gameType: 'rummy',
    entryFee: 100,
    maxPlayers: 6,
    players: [],
    state: 'waiting',
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });
  await batch.commit();
  return { status: 'seeded' };
});

export const dealRummyRound = functions.firestore
  .document('tables/{tableId}')
  .onUpdate(async (change, context) => {
    const beforeState = change.before.data();
    const afterState = change.after.data();
    if (!beforeState || !afterState) {
      return;
    }
    if (beforeState.state === 'waiting' && afterState.state === 'dealing') {
      const tableId = context.params.tableId;
      const players: string[] = afterState.players ?? [];
      const seed = Math.floor(Math.random() * 1_000_000);
      const deals: Record<string, string[]> = {};
      players.forEach((player) => {
        deals[player] = Array(13).fill('CARD');
      });
      await db.collection('gameRounds').doc().set({
        tableId,
        deckSeed: seed,
        deals,
        turnIndex: 0,
        discardPile: [],
        settled: false,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }
  });
