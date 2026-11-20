// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_account_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementAccountInput {
  String get bankName;
  String get accountNumber;
  String get accountHolder;

  /// Create a copy of SettlementAccountInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettlementAccountInputCopyWith<SettlementAccountInput> get copyWith =>
      _$SettlementAccountInputCopyWithImpl<SettlementAccountInput>(
        this as SettlementAccountInput,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettlementAccountInput &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.accountHolder, accountHolder) ||
                other.accountHolder == accountHolder));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, bankName, accountNumber, accountHolder);

  @override
  String toString() {
    return 'SettlementAccountInput(bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder)';
  }
}

/// @nodoc
abstract mixin class $SettlementAccountInputCopyWith<$Res> {
  factory $SettlementAccountInputCopyWith(
    SettlementAccountInput value,
    $Res Function(SettlementAccountInput) _then,
  ) = _$SettlementAccountInputCopyWithImpl;
  @useResult
  $Res call({String bankName, String accountNumber, String accountHolder});
}

/// @nodoc
class _$SettlementAccountInputCopyWithImpl<$Res>
    implements $SettlementAccountInputCopyWith<$Res> {
  _$SettlementAccountInputCopyWithImpl(this._self, this._then);

  final SettlementAccountInput _self;
  final $Res Function(SettlementAccountInput) _then;

  /// Create a copy of SettlementAccountInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bankName = null,
    Object? accountNumber = null,
    Object? accountHolder = null,
  }) {
    return _then(
      SettlementAccountInput(
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
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [SettlementAccountInput].
extension SettlementAccountInputPatterns on SettlementAccountInput {
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
    TResult Function(_SettlementAccountInput value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementAccountInput() when $default != null:
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
    TResult Function(_SettlementAccountInput value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementAccountInput():
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
    TResult? Function(_SettlementAccountInput value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementAccountInput() when $default != null:
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
      String bankName,
      String accountNumber,
      String accountHolder,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementAccountInput() when $default != null:
        return $default(
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
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
      String bankName,
      String accountNumber,
      String accountHolder,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementAccountInput():
        return $default(
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
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
      String bankName,
      String accountNumber,
      String accountHolder,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementAccountInput() when $default != null:
        return $default(
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SettlementAccountInput implements SettlementAccountInput {
  const _SettlementAccountInput({
    this.bankName = '',
    this.accountNumber = '',
    this.accountHolder = '',
  });

  @override
  @JsonKey()
  final String bankName;
  @override
  @JsonKey()
  final String accountNumber;
  @override
  @JsonKey()
  final String accountHolder;

  /// Create a copy of SettlementAccountInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettlementAccountInputCopyWith<_SettlementAccountInput> get copyWith =>
      __$SettlementAccountInputCopyWithImpl<_SettlementAccountInput>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettlementAccountInput &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.accountHolder, accountHolder) ||
                other.accountHolder == accountHolder));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, bankName, accountNumber, accountHolder);

  @override
  String toString() {
    return 'SettlementAccountInput(bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder)';
  }
}

/// @nodoc
abstract mixin class _$SettlementAccountInputCopyWith<$Res>
    implements $SettlementAccountInputCopyWith<$Res> {
  factory _$SettlementAccountInputCopyWith(
    _SettlementAccountInput value,
    $Res Function(_SettlementAccountInput) _then,
  ) = __$SettlementAccountInputCopyWithImpl;
  @override
  @useResult
  $Res call({String bankName, String accountNumber, String accountHolder});
}

/// @nodoc
class __$SettlementAccountInputCopyWithImpl<$Res>
    implements _$SettlementAccountInputCopyWith<$Res> {
  __$SettlementAccountInputCopyWithImpl(this._self, this._then);

  final _SettlementAccountInput _self;
  final $Res Function(_SettlementAccountInput) _then;

  /// Create a copy of SettlementAccountInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? bankName = null,
    Object? accountNumber = null,
    Object? accountHolder = null,
  }) {
    return _then(
      _SettlementAccountInput(
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
      ),
    );
  }
}
