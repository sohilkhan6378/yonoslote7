/// Environment configuration parsed from compile-time defines.
class Env {
  Env._();

  static late final String flavor;
  static late final String paymentKey;
  static late final List<String> allowedRegions;

  static void loadFromMap(Map<String, String> map) {
    flavor = map['FLAVOR'] ?? 'dev';
    paymentKey = map['RZP_KEY'] ?? 'mock_key';
    allowedRegions = (map['ALLOWED_REGIONS'] ?? 'IN')
        .split(',')
        .map((e) => e.trim())
        .where((element) => element.isNotEmpty)
        .toList();
  }
}
