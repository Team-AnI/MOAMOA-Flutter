// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_edit_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementEditInput {
  String? get title;
  int? get totalAmount;
  List<int>? get memberIds;
  String? get bankName;
  String? get accountNumber;
  String? get accountHolder;
  DateTime? get dueAt;
  bool get unlinkSchedule;

  /// Create a copy of SettlementEditInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettlementEditInputCopyWith<SettlementEditInput> get copyWith =>
      _$SettlementEditInputCopyWithImpl<SettlementEditInput>(
        this as SettlementEditInput,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettlementEditInput &&
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
            (identical(other.unlinkSchedule, unlinkSchedule) ||
                other.unlinkSchedule == unlinkSchedule));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    totalAmount,
    const DeepCollectionEquality().hash(memberIds),
    bankName,
    accountNumber,
    accountHolder,
    dueAt,
    unlinkSchedule,
  );

  @override
  String toString() {
    return 'SettlementEditInput(title: $title, totalAmount: $totalAmount, memberIds: $memberIds, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, dueAt: $dueAt, unlinkSchedule: $unlinkSchedule)';
  }
}

/// @nodoc
abstract mixin class $SettlementEditInputCopyWith<$Res> {
  factory $SettlementEditInputCopyWith(
    SettlementEditInput value,
    $Res Function(SettlementEditInput) _then,
  ) = _$SettlementEditInputCopyWithImpl;
  @useResult
  $Res call({
    String? title,
    int? totalAmount,
    List<int>? memberIds,
    String? bankName,
    String? accountNumber,
    String? accountHolder,
    DateTime? dueAt,
    bool unlinkSchedule,
  });
}

/// @nodoc
class _$SettlementEditInputCopyWithImpl<$Res>
    implements $SettlementEditInputCopyWith<$Res> {
  _$SettlementEditInputCopyWithImpl(this._self, this._then);

  final SettlementEditInput _self;
  final $Res Function(SettlementEditInput) _then;

  /// Create a copy of SettlementEditInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? totalAmount = freezed,
    Object? memberIds = freezed,
    Object? bankName = freezed,
    Object? accountNumber = freezed,
    Object? accountHolder = freezed,
    Object? dueAt = freezed,
    Object? unlinkSchedule = null,
  }) {
    return _then(
      SettlementEditInput(
        title: freezed == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalAmount: freezed == totalAmount
            ? _self.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as int?,
        memberIds: freezed == memberIds
            ? _self.memberIds
            : memberIds // ignore: cast_nullable_to_non_nullable
                  as List<int>?,
        bankName: freezed == bankName
            ? _self.bankName
            : bankName // ignore: cast_nullable_to_non_nullable
                  as String?,
        accountNumber: freezed == accountNumber
            ? _self.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        accountHolder: freezed == accountHolder
            ? _self.accountHolder
            : accountHolder // ignore: cast_nullable_to_non_nullable
                  as String?,
        dueAt: freezed == dueAt
            ? _self.dueAt
            : dueAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        unlinkSchedule: null == unlinkSchedule
            ? _self.unlinkSchedule
            : unlinkSchedule // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [SettlementEditInput].
extension SettlementEditInputPatterns on SettlementEditInput {
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
    TResult Function(_SettlementEditInput value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementEditInput() when $default != null:
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
    TResult Function(_SettlementEditInput value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementEditInput():
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
    TResult? Function(_SettlementEditInput value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementEditInput() when $default != null:
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
      String? title,
      int? totalAmount,
      List<int>? memberIds,
      String? bankName,
      String? accountNumber,
      String? accountHolder,
      DateTime? dueAt,
      bool unlinkSchedule,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementEditInput() when $default != null:
        return $default(
          _that.title,
          _that.totalAmount,
          _that.memberIds,
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
          _that.dueAt,
          _that.unlinkSchedule,
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
      String? title,
      int? totalAmount,
      List<int>? memberIds,
      String? bankName,
      String? accountNumber,
      String? accountHolder,
      DateTime? dueAt,
      bool unlinkSchedule,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementEditInput():
        return $default(
          _that.title,
          _that.totalAmount,
          _that.memberIds,
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
          _that.dueAt,
          _that.unlinkSchedule,
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
      String? title,
      int? totalAmount,
      List<int>? memberIds,
      String? bankName,
      String? accountNumber,
      String? accountHolder,
      DateTime? dueAt,
      bool unlinkSchedule,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementEditInput() when $default != null:
        return $default(
          _that.title,
          _that.totalAmount,
          _that.memberIds,
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
          _that.dueAt,
          _that.unlinkSchedule,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SettlementEditInput implements SettlementEditInput {
  const _SettlementEditInput({
    this.title,
    this.totalAmount,
    List<int>? memberIds,
    this.bankName,
    this.accountNumber,
    this.accountHolder,
    this.dueAt,
    this.unlinkSchedule = false,
  }) : _memberIds = memberIds;

  @override
  final String? title;
  @override
  final int? totalAmount;
  final List<int>? _memberIds;
  @override
  List<int>? get memberIds {
    final value = _memberIds;
    if (value == null) return null;
    if (_memberIds is EqualUnmodifiableListView) return _memberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? bankName;
  @override
  final String? accountNumber;
  @override
  final String? accountHolder;
  @override
  final DateTime? dueAt;
  @override
  @JsonKey()
  final bool unlinkSchedule;

  /// Create a copy of SettlementEditInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettlementEditInputCopyWith<_SettlementEditInput> get copyWith =>
      __$SettlementEditInputCopyWithImpl<_SettlementEditInput>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettlementEditInput &&
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
            (identical(other.unlinkSchedule, unlinkSchedule) ||
                other.unlinkSchedule == unlinkSchedule));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    totalAmount,
    const DeepCollectionEquality().hash(_memberIds),
    bankName,
    accountNumber,
    accountHolder,
    dueAt,
    unlinkSchedule,
  );

  @override
  String toString() {
    return 'SettlementEditInput(title: $title, totalAmount: $totalAmount, memberIds: $memberIds, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, dueAt: $dueAt, unlinkSchedule: $unlinkSchedule)';
  }
}

/// @nodoc
abstract mixin class _$SettlementEditInputCopyWith<$Res>
    implements $SettlementEditInputCopyWith<$Res> {
  factory _$SettlementEditInputCopyWith(
    _SettlementEditInput value,
    $Res Function(_SettlementEditInput) _then,
  ) = __$SettlementEditInputCopyWithImpl;
  @override
  @useResult
  $Res call({
    String? title,
    int? totalAmount,
    List<int>? memberIds,
    String? bankName,
    String? accountNumber,
    String? accountHolder,
    DateTime? dueAt,
    bool unlinkSchedule,
  });
}

/// @nodoc
class __$SettlementEditInputCopyWithImpl<$Res>
    implements _$SettlementEditInputCopyWith<$Res> {
  __$SettlementEditInputCopyWithImpl(this._self, this._then);

  final _SettlementEditInput _self;
  final $Res Function(_SettlementEditInput) _then;

  /// Create a copy of SettlementEditInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = freezed,
    Object? totalAmount = freezed,
    Object? memberIds = freezed,
    Object? bankName = freezed,
    Object? accountNumber = freezed,
    Object? accountHolder = freezed,
    Object? dueAt = freezed,
    Object? unlinkSchedule = null,
  }) {
    return _then(
      _SettlementEditInput(
        title: freezed == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalAmount: freezed == totalAmount
            ? _self.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as int?,
        memberIds: freezed == memberIds
            ? _self._memberIds
            : memberIds // ignore: cast_nullable_to_non_nullable
                  as List<int>?,
        bankName: freezed == bankName
            ? _self.bankName
            : bankName // ignore: cast_nullable_to_non_nullable
                  as String?,
        accountNumber: freezed == accountNumber
            ? _self.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        accountHolder: freezed == accountHolder
            ? _self.accountHolder
            : accountHolder // ignore: cast_nullable_to_non_nullable
                  as String?,
        dueAt: freezed == dueAt
            ? _self.dueAt
            : dueAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        unlinkSchedule: null == unlinkSchedule
            ? _self.unlinkSchedule
            : unlinkSchedule // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}
