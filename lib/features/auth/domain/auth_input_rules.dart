/// 회원·인증 입력값 규칙 (PRD 8.6)
///
/// 화면에서 바로 안내할 때와, UseCase 가 서버에 보내기 전에 확인할 때 함께 씁니다.
/// 회원가입·비밀번호 재설정에서 같은 비밀번호 규칙을 씁니다.
extension AuthInputRulesX on String {
  static final _email = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  static final _hasLetter = RegExp('[A-Za-z]');
  static final _hasDigit = RegExp('[0-9]');

  // 영문·숫자와 공백을 뺀 ASCII 기호만 허용합니다.
  static final _allowedPassword = RegExp(r'^[!-~]+$');

  /// 이름이 비었거나(공백만 포함) 20자를 넘으면 안내 문구, 맞으면 null 입니다.
  String? get nameError {
    final name = trim();
    if (name.isEmpty) return '이름을 입력해주세요.';
    if (name.length > 20) return '이름은 20자까지 입력할 수 있어요.';
    return null;
  }

  /// 이메일이 비었거나 형식이 다르거나 255자를 넘으면 안내 문구, 맞으면 null 입니다.
  String? get emailError {
    final email = trim();
    if (email.isEmpty) return '이메일을 입력해주세요.';
    if (email.length > 255) return '이메일은 255자까지 입력할 수 있어요.';
    if (!_email.hasMatch(email)) return '올바른 이메일 형식이 아니에요.';
    return null;
  }

  /// 휴대폰 번호(선택)가 20자를 넘으면 안내 문구, 비었거나 맞으면 null 입니다.
  String? get phoneError =>
      trim().length > 20 ? '휴대폰 번호는 20자까지 입력할 수 있어요.' : null;

  /// 로그인 비밀번호가 비었으면 안내 문구, 아니면 null 입니다.
  ///
  /// 로그인은 가입 때 규칙과 관계없이 입력했는지만 봅니다. 맞는지는 서버가 판단합니다.
  String? get loginPasswordError => isEmpty ? '비밀번호를 입력해주세요.' : null;

  /// 비밀번호가 규칙(영문과 숫자 포함 8~72자, 영문·숫자·기호만)에 맞지 않으면 안내 문구, 맞으면 null 입니다.
  String? get passwordError {
    if (isEmpty) return '비밀번호를 입력해주세요.';
    if (!_allowedPassword.hasMatch(this)) return '영문, 숫자, 기호만 사용할 수 있어요.';
    if (length < 8 || length > 72) return '8~72자로 입력해주세요.';
    if (!_hasLetter.hasMatch(this) || !_hasDigit.hasMatch(this)) {
      return '영문과 숫자를 모두 포함해주세요.';
    }
    return null;
  }
}
