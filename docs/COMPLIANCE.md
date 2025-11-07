# Compliance & Responsible Gaming

## Age & Identity Verification
- Enforce 18+ requirement via explicit confirmation during onboarding.
- Store KYC documents securely in Firebase Storage with restricted access.
- KYC workflow statuses: `pending`, `approved`, `rejected`. Only admins can modify status.

## Regional Regulations
- Remote Config controls allowlist/denylist for regions. Block gameplay if the user's IP/declared state is restricted.
- Display localized legal notices in English and Hindi.

## Responsible Gaming Controls
- Allow users to set deposit limits (daily/weekly) and self-exclusion periods.
- Trigger reality check dialogs after fixed play durations.
- Provide contact information for support and helplines.

## Data Privacy
- Follow GDPR/DPDP-style consent prompts; provide clear privacy policy links.
- Use Firestore security rules to restrict data access to the owning user.
- Purge sensitive documents upon account closure per jurisdictional requirements.

## Payments & AML
- Withdrawals require approved KYC and are processed via admin-reviewed Cloud Functions.
- Maintain transaction logs with reason codes to support audits.
- Prevent deposits beyond configured limits to mitigate money laundering risk.

## Audit & Reporting
- Log key events in Analytics (logins, deposits, withdrawals, KYC decisions, game outcomes).
- Admin panel offers CSV exports for compliance reviews.

## Notifications & Marketing
- Do not auto-opt-in users to marketing notifications; gather explicit consent.
- Provide easy opt-out options in settings.

## Disclaimer Text
“इस ऐप में कैश गेम्स 18+ यूज़र्स के लिए हैं। अपने क्षेत्र के क़ानून जाँच लें. जिम्मेदारी से खेलें—डिपॉज़िट लिमिट, रियलिटी चेक और सेल्फ-एक्सक्लूज़न सेटिंग्स उपलब्ध हैं।”
