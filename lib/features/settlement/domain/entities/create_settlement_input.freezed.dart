// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_settlement_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateSettlementInput {
  int get meetingId;
  int? get scheduleId;
  String get title;
  int get totalAmount;
  List<int> get memberIds;
  String get bankName;
  String get accountNumber;
  String get accountHolder;
  DateTime get dueAt;
  bool get postNotice;
  int? get replacesSettlementId;

  /// Create a copy of CreateSettlementInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateSettlementInputCopyWith<CreateSettlementInput> get copyWith =>
      _$CreateSettlementInputCopyWithImpl<CreateSettlementInput>(
        this as CreateSettlementInput,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateSettlementInput &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.scheduleId, scheduleId) ||
                other.scheduleId == scheduleId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            const DeepCollectionEquality().equals(other.memberIds, memberIds) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.accountHolder, accountHolder) ||
                other.accountHolder == accountHolder) &&
            (identical(other.dueAt, dueAt) || other.dueAt == dueAt) &&
            (identical(other.postNotice, postNotice) ||
                other.postNotice == postNotice) &&
            (identical(other.replacesSettlementId, replacesSettlementId) ||
                other.replacesSettlementId == replacesSettlementId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    meetingId,
    scheduleId,
    title,
    totalAmount,
    const DeepCollectionEquality().hash(memberIds),
    bankName,
    accountNumber,
    accountHolder,
    dueAt,
    postNotice,
    replacesSettlementId,
  );

  @override
  String toString() {
    return 'CreateSettlementInput(meetingId: $meetingId, scheduleId: $scheduleId, title: $title, totalAmount: $totalAmount, memberIds: $memberIds, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, dueAt: $dueAt, postNotice: $postNotice, replacesSettlementId: $replacesSettlementId)';
  }
}

/// @nodoc
abstract mixin class $CreateSettlementInputCopyWith<$Res> {
  factory $CreateSettlementInputCopyWith(
    CreateSettlementInput value,
    $Res Function(CreateSettlementInput) _then,
  ) = _$CreateSettlementInputCopyWithImpl;
  @useResult
  $Res call({
    int meetingId,
    int? scheduleId,
    String title,
    int totalAmount,
    List<int> memberIds,
    String bankName,
    String accountNumber,
    String accountHolder,
    DateTime dueAt,
    bool postNotice,
    int? replacesSettlementId,
  });
}

/// @nodoc
class _$CreateSettlementInputCopyWithImpl<$Res>
    implements $CreateSettlementInputCopyWith<$Res> {
  _$CreateSettlementInputCopyWithImpl(this._self, this._then);

  final CreateSettlementInput _self;
  final $Res Function(CreateSettlementInput) _then;

  /// Create a copy of CreateSettlementInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetingId = null,
    Object? scheduleId = freezed,
    Object? title = null,
    Object? totalAmount = null,
    Object? memberIds = null,
    Object? bankName = null,
    Object? accountNumber = null,
    Object? accountHolder = null,
    Object? dueAt = null,
    Object? postNotice = null,
    Object? replacesSettlementId = freezed,
  }) {
    return _then(
      CreateSettlementInput(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
        scheduleId: freezed == scheduleId
            ? _self.scheduleId
            : scheduleId // ignore: cast_nullable_to_non_nullable
                  as int?,
        title: null == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        totalAmount: null == totalAmount
            ? _self.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        memberIds: null == memberIds
            ? _self.memberIds
            : memberIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
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
        dueAt: null == dueAt
            ? _self.dueAt
            : dueAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        postNotice: null == postNotice
            ? _self.postNotice
            : postNotice // ignore: cast_nullable_to_non_nullable
                  as bool,
        replacesSettlementId: freezed == replacesSettlementId
            ? _self.replacesSettlementId
            : replacesSettlementId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [CreateSettlementInput].
extension CreateSettlementInputPatterns on CreateSettlementInput {
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
    TResult Function(_CreateSettlementInput value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreateSettlementInput() when $default != null:
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
    TResult Function(_CreateSettlementInput value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateSettlementInput():
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
    TResult? Function(_CreateSettlementInput value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateSettlementInput() when $default != null:
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
      int meetingId,
      int? scheduleId,
      String title,
      int totalAmount,
      List<int> memberIds,
      String bankName,
      String accountNumber,
      String accountHolder,
      DateTime dueAt,
      bool postNotice,
      int? replacesSettlementId,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreateSettlementInput() when $default != null:
        return $default(
          _that.meetingId,
          _that.scheduleId,
          _that.title,
          _that.totalAmount,
          _that.memberIds,
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
          _that.dueAt,
          _that.postNotice,
          _that.replacesSettlementId,
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
      int meetingId,
      int? scheduleId,
      String title,
      int totalAmount,
      List<int> memberIds,
      String bankName,
      String accountNumber,
      String accountHolder,
      DateTime dueAt,
      bool postNotice,
      int? replacesSettlementId,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateSettlementInput():
        return $default(
          _that.meetingId,
          _that.scheduleId,
          _that.title,
          _that.totalAmount,
          _that.memberIds,
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
          _that.dueAt,
          _that.postNotice,
          _that.replacesSettlementId,
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
      int meetingId,
      int? scheduleId,
      String title,
      int totalAmount,
      List<int> memberIds,
      String bankName,
      String accountNumber,
      String accountHolder,
      DateTime dueAt,
      bool postNotice,
      int? replacesSettlementId,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateSettlementInput() when $default != null:
        return $default(
          _that.meetingId,
          _that.scheduleId,
          _that.title,
          _that.totalAmount,
          _that.memberIds,
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
          _that.dueAt,
          _that.postNotice,
          _that.replacesSettlementId,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CreateSettlementInput implements CreateSettlementInput {
  const _CreateSettlementInput({
    required this.meetingId,
    this.scheduleId,
    required this.title,
    required this.totalAmount,
    required List<int> memberIds,
    required this.bankName,
    required this.accountNumber,
    required this.accountHolder,
    required this.dueAt,
    this.postNotice = false,
    this.replacesSettlementId,
  }) : _memberIds = memberIds;

  @override
  final int meetingId;
  @override
  final int? scheduleId;
  @override
  final String title;
  @override
  final int totalAmount;
  final List<int> _memberIds;
  @override
  List<int> get memberIds {
    if (_memberIds is EqualUnmodifiableListView) return _memberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memberIds);
  }

  @override
  final String bankName;
  @override
  final String accountNumber;
  @override
  final String accountHolder;
  @override
  final DateTime dueAt;
  @override
  @JsonKey()
  final bool postNotice;
  @override
  final int? replacesSettlementId;

  /// Create a copy of CreateSettlementInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreateSettlementInputCopyWith<_CreateSettlementInput> get copyWith =>
      __$CreateSettlementInputCopyWithImpl<_CreateSettlementInput>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreateSettlementInput &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.scheduleId, scheduleId) ||
                other.scheduleId == scheduleId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            const DeepCollectionEquality().equals(
              other._memberIds,
              _memberIds,
            ) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.accountHolder, accountHolder) ||
                other.accountHolder == accountHolder) &&
            (identical(other.dueAt, dueAt) || other.dueAt == dueAt) &&
            (identical(other.postNotice, postNotice) ||
                other.postNotice == postNotice) &&
            (identical(other.replacesSettlementId, replacesSettlementId) ||
                other.replacesSettlementId == replacesSettlementId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    meetingId,
    scheduleId,
    title,
    totalAmount,
    const DeepCollectionEquality().hash(_memberIds),
    bankName,
    accountNumber,
    accountHolder,
    dueAt,
    postNotice,
    replacesSettlementId,
  );

  @override
  String toString() {
    return 'CreateSettlementInput(meetingId: $meetingId, scheduleId: $scheduleId, title: $title, totalAmount: $totalAmount, memberIds: $memberIds, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, dueAt: $dueAt, postNotice: $postNotice, replacesSettlementId: $replacesSettlementId)';
  }
}

/// @nodoc
abstract mixin class _$CreateSettlementInputCopyWith<$Res>
    implements $CreateSettlementInputCopyWith<$Res> {
  factory _$CreateSettlementInputCopyWith(
    _CreateSettlementInput value,
    $Res Function(_CreateSettlementInput) _then,
  ) = __$CreateSettlementInputCopyWithImpl;
  @override
  @useResult
  $Res call({
    int meetingId,
    int? scheduleId,
    String title,
    int totalAmount,
    List<int> memberIds,
    String bankName,
    String accountNumber,
    String accountHolder,
    DateTime dueAt,
    bool postNotice,
    int? replacesSettlementId,
  });
}

/// @nodoc
class __$CreateSettlementInputCopyWithImpl<$Res>
    implements _$CreateSettlementInputCopyWith<$Res> {
  __$CreateSettlementInputCopyWithImpl(this._self, this._then);

  final _CreateSettlementInput _self;
  final $Res Function(_CreateSettlementInput) _then;

  /// Create a copy of CreateSettlementInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? meetingId = null,
    Object? scheduleId = freezed,
    Object? title = null,
    Object? totalAmount = null,
    Object? memberIds = null,
    Object? bankName = null,
    Object? accountNumber = null,
    Object? accountHolder = null,
    Object? dueAt = null,
    Object? postNotice = null,
    Object? replacesSettlementId = freezed,
  }) {
    return _then(
      _CreateSettlementInput(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
        scheduleId: freezed == scheduleId
            ? _self.scheduleId
            : scheduleId // ignore: cast_nullable_to_non_nullable
                  as int?,
        title: null == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        totalAmount: null == totalAmount
            ? _self.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        memberIds: null == memberIds
            ? _self._memberIds
            : memberIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
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
        dueAt: null == dueAt
            ? _self.dueAt
            : dueAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        postNotice: null == postNotice
            ? _self.postNotice
            : postNotice // ignore: cast_nullable_to_non_nullable
                  as bool,
        replacesSettlementId: freezed == replacesSettlementId
            ? _self.replacesSettlementId
            : replacesSettlementId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}
