// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementPayment {
  int get id;
  int get amount;
  PaymentStatus get status;
  int? get memberId;
  String? get userName;
  DateTime? get submittedAt;
  DateTime? get refundedAt;

  /// Create a copy of SettlementPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettlementPaymentCopyWith<SettlementPayment> get copyWith =>
      _$SettlementPaymentCopyWithImpl<SettlementPayment>(
        this as SettlementPayment,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettlementPayment &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.refundedAt, refundedAt) ||
                other.refundedAt == refundedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    amount,
    status,
    memberId,
    userName,
    submittedAt,
    refundedAt,
  );

  @override
  String toString() {
    return 'SettlementPayment(id: $id, amount: $amount, status: $status, memberId: $memberId, userName: $userName, submittedAt: $submittedAt, refundedAt: $refundedAt)';
  }
}

/// @nodoc
abstract mixin class $SettlementPaymentCopyWith<$Res> {
  factory $SettlementPaymentCopyWith(
    SettlementPayment value,
    $Res Function(SettlementPayment) _then,
  ) = _$SettlementPaymentCopyWithImpl;
  @useResult
  $Res call({
    int id,
    int amount,
    PaymentStatus status,
    int? memberId,
    String? userName,
    DateTime? submittedAt,
    DateTime? refundedAt,
  });
}

/// @nodoc
class _$SettlementPaymentCopyWithImpl<$Res>
    implements $SettlementPaymentCopyWith<$Res> {
  _$SettlementPaymentCopyWithImpl(this._self, this._then);

  final SettlementPayment _self;
  final $Res Function(SettlementPayment) _then;

  /// Create a copy of SettlementPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? status = null,
    Object? memberId = freezed,
    Object? userName = freezed,
    Object? submittedAt = freezed,
    Object? refundedAt = freezed,
  }) {
    return _then(
      SettlementPayment(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        amount: null == amount
            ? _self.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as PaymentStatus,
        memberId: freezed == memberId
            ? _self.memberId
            : memberId // ignore: cast_nullable_to_non_nullable
                  as int?,
        userName: freezed == userName
            ? _self.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String?,
        submittedAt: freezed == submittedAt
            ? _self.submittedAt
            : submittedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        refundedAt: freezed == refundedAt
            ? _self.refundedAt
            : refundedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [SettlementPayment].
extension SettlementPaymentPatterns on SettlementPayment {
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
    TResult Function(_SettlementPayment value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementPayment() when $default != null:
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
    TResult Function(_SettlementPayment value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementPayment():
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
    TResult? Function(_SettlementPayment value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementPayment() when $default != null:
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
      int id,
      int amount,
      PaymentStatus status,
      int? memberId,
      String? userName,
      DateTime? submittedAt,
      DateTime? refundedAt,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementPayment() when $default != null:
        return $default(
          _that.id,
          _that.amount,
          _that.status,
          _that.memberId,
          _that.userName,
          _that.submittedAt,
          _that.refundedAt,
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
      int id,
      int amount,
      PaymentStatus status,
      int? memberId,
      String? userName,
      DateTime? submittedAt,
      DateTime? refundedAt,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementPayment():
        return $default(
          _that.id,
          _that.amount,
          _that.status,
          _that.memberId,
          _that.userName,
          _that.submittedAt,
          _that.refundedAt,
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
      int id,
      int amount,
      PaymentStatus status,
      int? memberId,
      String? userName,
      DateTime? submittedAt,
      DateTime? refundedAt,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementPayment() when $default != null:
        return $default(
          _that.id,
          _that.amount,
          _that.status,
          _that.memberId,
          _that.userName,
          _that.submittedAt,
          _that.refundedAt,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SettlementPayment implements SettlementPayment {
  const _SettlementPayment({
    required this.id,
    required this.amount,
    required this.status,
    this.memberId,
    this.userName,
    this.submittedAt,
    this.refundedAt,
  });

  @override
  final int id;
  @override
  final int amount;
  @override
  final PaymentStatus status;
  @override
  final int? memberId;
  @override
  final String? userName;
  @override
  final DateTime? submittedAt;
  @override
  final DateTime? refundedAt;

  /// Create a copy of SettlementPayment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettlementPaymentCopyWith<_SettlementPayment> get copyWith =>
      __$SettlementPaymentCopyWithImpl<_SettlementPayment>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettlementPayment &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.refundedAt, refundedAt) ||
                other.refundedAt == refundedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    amount,
    status,
    memberId,
    userName,
    submittedAt,
    refundedAt,
  );

  @override
  String toString() {
    return 'SettlementPayment(id: $id, amount: $amount, status: $status, memberId: $memberId, userName: $userName, submittedAt: $submittedAt, refundedAt: $refundedAt)';
  }
}

/// @nodoc
abstract mixin class _$SettlementPaymentCopyWith<$Res>
    implements $SettlementPaymentCopyWith<$Res> {
  factory _$SettlementPaymentCopyWith(
    _SettlementPayment value,
    $Res Function(_SettlementPayment) _then,
  ) = __$SettlementPaymentCopyWithImpl;
  @override
  @useResult
  $Res call({
    int id,
    int amount,
    PaymentStatus status,
    int? memberId,
    String? userName,
    DateTime? submittedAt,
    DateTime? refundedAt,
  });
}

/// @nodoc
class __$SettlementPaymentCopyWithImpl<$Res>
    implements _$SettlementPaymentCopyWith<$Res> {
  __$SettlementPaymentCopyWithImpl(this._self, this._then);

  final _SettlementPayment _self;
  final $Res Function(_SettlementPayment) _then;

  /// Create a copy of SettlementPayment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? status = null,
    Object? memberId = freezed,
    Object? userName = freezed,
    Object? submittedAt = freezed,
    Object? refundedAt = freezed,
  }) {
    return _then(
      _SettlementPayment(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        amount: null == amount
            ? _self.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as PaymentStatus,
        memberId: freezed == memberId
            ? _self.memberId
            : memberId // ignore: cast_nullable_to_non_nullable
                  as int?,
        userName: freezed == userName
            ? _self.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String?,
        submittedAt: freezed == submittedAt
            ? _self.submittedAt
            : submittedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        refundedAt: freezed == refundedAt
            ? _self.refundedAt
            : refundedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}
