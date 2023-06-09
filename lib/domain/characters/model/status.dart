enum Status {
  dead,
  alive,
  unknown,
}

extension StatusExtension on Status {
  String get value {
    switch (this) {
      case Status.dead:
        return 'Dead';
      case Status.alive:
        return 'Alive';
      default:
        return 'Unknown';
    }
  }
}

extension StringStatus on String {
  Status get toStatus {
    return Status.values.firstWhere(
      (e) => e.toString() == 'Status.${toLowerCase()}',
      orElse: () => Status.unknown,
    );
  }
}
