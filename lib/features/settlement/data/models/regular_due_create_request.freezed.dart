// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'regular_due_create_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegularDueCreateRequest {
  @JsonKey(includeToJson: false)
  int get meetingId;
  String get title;
  int get amount;
  String get cycleType;
  String get cycleDay;
  String get sendTime;
  int get dueDays;
  String get bankName;
  String get accountNumber;
  String get accountHolder;
  bool get postNotice;

  /// Create a copy of RegularDueCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegularDueCreateRequestCopyWith<RegularDueCreateRequest> get copyWith =>
      _$RegularDueCreateRequestCopyWithImpl<RegularDueCreateRequest>(
        this as RegularDueCreateRequest,
        _$identity,
      );

  /// Serializes this RegularDueCreateRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegularDueCreateRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.cycleType, cycleType) ||
                other.cycleType == cycleType) &&
            (identical(other.cycleDay, cycleDay) ||
                other.cycleDay == cycleDay) &&
            (identical(other.sendTime, sendTime) ||
                other.sendTime == sendTime) &&
            (identical(other.dueDays, dueDays) || other.dueDays == dueDays) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.accountHolder, accountHolder) ||
                other.accountHolder == accountHolder) &&
            (identical(other.postNotice, postNotice) ||
                other.postNotice == postNotice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    meetingId,
    title,
    amount,
    cycleType,
    cycleDay,
    sendTime,
    dueDays,
    bankName,
    accountNumber,
    accountHolder,
    postNotice,
  );

  @override
  String toString() {
    return 'RegularDueCreateRequest(meetingId: $meetingId, title: $title, amount: $amount, cycleType: $cycleType, cycleDay: $cycleDay, sendTime: $sendTime, dueDays: $dueDays, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, postNotice: $postNotice)';
  }
}

/// @nodoc
abstract mixin class $RegularDueCreateRequestCopyWith<$Res> {
  factory $RegularDueCreateRequestCopyWith(
    RegularDueCreateRequest value,
    $Res Function(RegularDueCreateRequest) _then,
  ) = _$RegularDueCreateRequestCopyWithImpl;
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int meetingId,
    String title,
    int amount,
    String cycleType,
    String cycleDay,
    String sendTime,
    int dueDays,
    String bankName,
    String accountNumber,
    String accountHolder,
    bool postNotice,
  });
}

/// @nodoc
class _$RegularDueCreateRequestCopyWithImpl<$Res>
    implements $RegularDueCreateRequestCopyWith<$Res> {
  _$RegularDueCreateRequestCopyWithImpl(this._self, this._then);

  final RegularDueCreateRequest _self;
  final $Res Function(RegularDueCreateRequest) _then;

  /// Create a copy of RegularDueCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetingId = null,
    Object? title = null,
    Object? amount = null,
    Object? cycleType = null,
    Object? cycleDay = null,
    Object? sendTime = null,
    Object? dueDays = null,
    Object? bankName = null,
    Object? accountNumber = null,
    Object? accountHolder = null,
    Object? postNotice = null,
  }) {
    return _then(
      RegularDueCreateRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _self.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        cycleType: null == cycleType
            ? _self.cycleType
            : cycleType // ignore: cast_nullable_to_non_nullable
                  as String,
        cycleDay: null == cycleDay
            ? _self.cycleDay
            : cycleDay // ignore: cast_nullable_to_non_nullable
                  as String,
        sendTime: null == sendTime
            ? _self.sendTime
            : sendTime // ignore: cast_nullable_to_non_nullable
                  as String,
        dueDays: null == dueDays
            ? _self.dueDays
            : dueDays // ignore: cast_nullable_to_non_nullable
                  as int,
        bankName: null == bankName
            ? _self.bankName
            : bankName // ignore: cast_nullable_to_non_nullable
                  as String,
        accountNumber: null == accountNumber
            ? _self.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        accountHolder: null == accountHolder
            ? _self.accountHolder
            : accountHolder // ignore: cast_nullable_to_non_nullable
                  as String,
        postNotice: null == postNotice
            ? _self.postNotice
            : postNotice // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [RegularDueCreateRequest].
extension RegularDueCreateRequestPatterns on RegularDueCreateRequest {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_RegularDueCreateRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegularDueCreateRequest() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_RegularDueCreateRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueCreateRequest():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_RegularDueCreateRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueCreateRequest() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
      @JsonKey(includeToJson: false) int meetingId,
      String title,
      int amount,
      String cycleType,
      String cycleDay,
      String sendTime,
      int dueDays,
      String bankName,
      String accountNumber,
      String accountHolder,
      bool postNotice,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegularDueCreateRequest() when $default != null:
        return $default(
          _that.meetingId,
          _that.title,
          _that.amount,
          _that.cycleType,
          _that.cycleDay,
          _that.sendTime,
          _that.dueDays,
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
          _that.postNotice,
        );
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
      @JsonKey(includeToJson: false) int meetingId,
      String title,
      int amount,
      String cycleType,
      String cycleDay,
      String sendTime,
      int dueDays,
      String bankName,
      String accountNumber,
      String accountHolder,
      bool postNotice,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueCreateRequest():
        return $default(
          _that.meetingId,
          _that.title,
          _that.amount,
          _that.cycleType,
          _that.cycleDay,
          _that.sendTime,
          _that.dueDays,
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
          _that.postNotice,
        );
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
      @JsonKey(includeToJson: false) int meetingId,
      String title,
      int amount,
      String cycleType,
      String cycleDay,
      String sendTime,
      int dueDays,
      String bankName,
      String accountNumber,
      String accountHolder,
      bool postNotice,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueCreateRequest() when $default != null:
        return $default(
          _that.meetingId,
          _that.title,
          _that.amount,
          _that.cycleType,
          _that.cycleDay,
          _that.sendTime,
          _that.dueDays,
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
          _that.postNotice,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RegularDueCreateRequest implements RegularDueCreateRequest {
  const _RegularDueCreateRequest({
    @JsonKey(includeToJson: false) required this.meetingId,
    required this.title,
    required this.amount,
    required this.cycleType,
    required this.cycleDay,
    required this.sendTime,
    required this.dueDays,
    required this.bankName,
    required this.accountNumber,
    required this.accountHolder,
    required this.postNotice,
  });
  factory _RegularDueCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$RegularDueCreateRequestFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int meetingId;
  @override
  final String title;
  @override
  final int amount;
  @override
  final String cycleType;
  @override
  final String cycleDay;
  @override
  final String sendTime;
  @override
  final int dueDays;
  @override
  final String bankName;
  @override
  final String accountNumber;
  @override
  final String accountHolder;
  @override
  final bool postNotice;

  /// Create a copy of RegularDueCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RegularDueCreateRequestCopyWith<_RegularDueCreateRequest> get copyWith =>
      __$RegularDueCreateRequestCopyWithImpl<_RegularDueCreateRequest>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$RegularDueCreateRequestToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegularDueCreateRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.cycleType, cycleType) ||
                other.cycleType == cycleType) &&
            (identical(other.cycleDay, cycleDay) ||
                other.cycleDay == cycleDay) &&
            (identical(other.sendTime, sendTime) ||
                other.sendTime == sendTime) &&
            (identical(other.dueDays, dueDays) || other.dueDays == dueDays) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.accountHolder, accountHolder) ||
                other.accountHolder == accountHolder) &&
            (identical(other.postNotice, postNotice) ||
                other.postNotice == postNotice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    meetingId,
    title,
    amount,
    cycleType,
    cycleDay,
    sendTime,
    dueDays,
    bankName,
    accountNumber,
    accountHolder,
    postNotice,
  );

  @override
  String toString() {
    return 'RegularDueCreateRequest(meetingId: $meetingId, title: $title, amount: $amount, cycleType: $cycleType, cycleDay: $cycleDay, sendTime: $sendTime, dueDays: $dueDays, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, postNotice: $postNotice)';
  }
}

/// @nodoc
abstract mixin class _$RegularDueCreateRequestCopyWith<$Res>
    implements $RegularDueCreateRequestCopyWith<$Res> {
  factory _$RegularDueCreateRequestCopyWith(
    _RegularDueCreateRequest value,
    $Res Function(_RegularDueCreateRequest) _then,
  ) = __$RegularDueCreateRequestCopyWithImpl;
  @override
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int meetingId,
    String title,
    int amount,
    String cycleType,
    String cycleDay,
    String sendTime,
    int dueDays,
    String bankName,
    String accountNumber,
    String accountHolder,
    bool postNotice,
  });
}

/// @nodoc
class __$RegularDueCreateRequestCopyWithImpl<$Res>
    implements _$RegularDueCreateRequestCopyWith<$Res> {
  __$RegularDueCreateRequestCopyWithImpl(this._self, this._then);

  final _RegularDueCreateRequest _self;
  final $Res Function(_RegularDueCreateRequest) _then;

  /// Create a copy of RegularDueCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? meetingId = null,
    Object? title = null,
    Object? amount = null,
    Object? cycleType = null,
    Object? cycleDay = null,
    Object? sendTime = null,
    Object? dueDays = null,
    Object? bankName = null,
    Object? accountNumber = null,
    Object? accountHolder = null,
    Object? postNotice = null,
  }) {
    return _then(
      _RegularDueCreateRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _self.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        cycleType: null == cycleType
            ? _self.cycleType
            : cycleType // ignore: cast_nullable_to_non_nullable
                  as String,
        cycleDay: null == cycleDay
            ? _self.cycleDay
            : cycleDay // ignore: cast_nullable_to_non_nullable
                  as String,
        sendTime: null == sendTime
            ? _self.sendTime
            : sendTime // ignore: cast_nullable_to_non_nullable
                  as String,
        dueDays: null == dueDays
            ? _self.dueDays
            : dueDays // ignore: cast_nullable_to_non_nullable
                  as int,
        bankName: null == bankName
            ? _self.bankName
            : bankName // ignore: cast_nullable_to_non_nullable
                  as String,
        accountNumber: null == accountNumber
            ? _self.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        accountHolder: null == accountHolder
            ? _self.accountHolder
            : accountHolder // ignore: cast_nullable_to_non_nullable
                  as String,
        postNotice: null == postNotice
            ? _self.postNotice
            : postNotice // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}
