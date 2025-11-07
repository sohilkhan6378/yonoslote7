# Cloud Functions

This directory contains Firebase Cloud Functions used for authoritative money flow and game orchestration.

## Setup
```bash
cd functions
npm install
npm run lint
npm run build
firebase deploy --only functions
```

## Functions
- `createDepositOrder`: Creates a pending transaction record and returns an order ID for the client to confirm.
- `requestWithdrawal`: Validates balance and deducts funds pending admin approval.
- `setCustomClaimAdmin`: Assigns admin privileges to a Firebase Auth user.
- `dealRummyRound`: Triggered when a table transitions to dealing; prepares a server-side round document.
- `seedDemoData`: Populates Firestore with sample user, wallet, and table documents.

> **Note:** Implement payment provider verification, webhook signature validation, and production-grade RNG before launch.
