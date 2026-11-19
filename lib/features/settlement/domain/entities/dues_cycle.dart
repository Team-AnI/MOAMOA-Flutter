enum DuesCycle {
  weekly,
  monthly,
  unknown;

  static DuesCycle fromServer(String value) => switch (value) {
    'WEEKLY' => weekly,
    'MONTHLY' => monthly,
    _ => unknown,
  };
  String get serverValue => name.toUpperCase();
}
