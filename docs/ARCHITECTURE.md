# Architecture Overview

RummyPro follows a strict MVC + Service + Repository structure with GetX for dependency injection and navigation.

## Layered Design
- **Presentation Layer**: Views (Widgets) consume controllers. Controllers expose reactive state and delegate logic to services/repositories.
- **Domain Layer**: Pure Dart services encapsulating core business rules (Rummy engine, RNG, security, payments abstraction).
- **Data Layer**: Repositories translating between Firestore documents and strongly-typed models.
- **Core Layer**: App-wide utilities, bindings, routing, theming, localization, and constants.

## Startup Flow
1. `main_<flavor>.dart` loads flavor configuration via `Env` and initializes Firebase.
2. `AppBindings` registers repositories/services/controllers.
3. `GetMaterialApp` loads translations, routes, and theme.
4. Splash screen checks authentication, KYC status, and remote config to determine the initial route.

## Sequence Diagrams

### Joining a Table
```
User -> LobbyController: selectTable(tableId)
LobbyController -> WalletRepository: fetchBalance(uid)
LobbyController -> TableRepository: attemptJoinTable(tableId, uid)
TableRepository -> Cloud Function: verifyBalanceAndSeat()
Cloud Function -> WalletRepository: debitEntryFee()
Cloud Function -> TableRepository: addPlayer(tableId, uid)
LobbyController -> RummyController: prepareRound(tableId)
```

### Settling a Rummy Round
```
RummyController -> Cloud Function: submitShow(roundData)
Cloud Function -> RummyEngine (server): validateMelds()
Cloud Function -> WalletRepository: creditPrizePool()
Cloud Function -> TransactionRepository: recordTransactions()
Cloud Function -> NotificationService: pushResults()
RummyController <- Cloud Function: settlementResult
RummyController -> View: updateResults()
```

## State Management
- Controllers extend `GetxController` and use Rx wrappers for UI updates.
- `Bindings` ensure dependencies are registered before routes are accessed.
- `Get.find<T>()` is used sparingly and only where dependency is guaranteed.

## Extensibility
- `GameEngine` interface allows registering additional games. `MiniGameEngine` demonstrates a lightweight implementation.
- `PaymentGatewayService` exposes an abstract API with `MockPaymentGateway` for non-production builds.

## Error Handling
- Repositories throw `RepositoryException` for I/O failures.
- Services use `Result<T>` wrappers to differentiate success/failure without exceptions.
- Controllers map errors to user-friendly messages with localization support.

## Offline Strategy
- Firestore uses cache-first reads for lobby and wallet information.
- Sensitive operations (payments, settlements) remain online-only via Cloud Functions.

## Security Considerations
- Sensitive keys are passed through `--dart-define` or Remote Config; never stored in source control.
- Cloud Functions enforce idempotency and administrative boundaries.
- Client-side validation supplements server-side authoritative checks but never replaces them.
