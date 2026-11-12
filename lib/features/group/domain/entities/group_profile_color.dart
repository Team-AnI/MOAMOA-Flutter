enum GroupProfileColor {
  lightBlue,
  gray,
  blue,
  dark;

  static GroupProfileColor fromServer(Object? value) => switch (value) {
    'GRAY' => gray,
    'BLUE' => blue,
    'DARK' => dark,
    _ => lightBlue,
  };
}
