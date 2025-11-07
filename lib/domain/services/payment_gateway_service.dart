/// Abstraction over payment gateways to support deposits and withdrawals.
abstract class PaymentGatewayService {
  Future<String> createDepositOrder(double amount);

  Future<bool> verifyAndCapture({required String orderId, required String signature});
}

/// Mock implementation used in development/staging builds.
class MockPaymentGateway implements PaymentGatewayService {
  @override
  Future<String> createDepositOrder(double amount) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return 'mock-order-${DateTime.now().millisecondsSinceEpoch}';
  }

  @override
  Future<bool> verifyAndCapture({required String orderId, required String signature}) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return true;
  }
}
