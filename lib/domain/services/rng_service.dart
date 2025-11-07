import 'dart:math';

/// Wrapper around Random to support deterministic seeds for auditing.
class RngService {
  Random seeded(int seed) => Random(seed);

  int nextSeed() => Random().nextInt(1 << 32);
}
