enum EnergyLevel {
  low,
  moderate,
  high,
}

extension EnergyLevelExtension on EnergyLevel {
  String get label {
    switch (this) {
      case EnergyLevel.low:
        return 'Low';
      case EnergyLevel.moderate:
        return 'Moderate';
      case EnergyLevel.high:
        return 'High';
    }
  }
}
