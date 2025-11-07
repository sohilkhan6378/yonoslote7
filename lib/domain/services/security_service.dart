/// Placeholder for security utilities such as suspicious pattern checks.
class SecurityService {
  bool isRegionAllowed({required String userRegion, required List<String> allowedRegions}) {
    return allowedRegions.contains(userRegion);
  }

  bool passesAgeGate({required DateTime birthDate}) {
    final now = DateTime.now();
    final age = now.year - birthDate.year - ((now.month < birthDate.month ||
            (now.month == birthDate.month && now.day < birthDate.day))
        ? 1
        : 0);
    return age >= 18;
  }
}
