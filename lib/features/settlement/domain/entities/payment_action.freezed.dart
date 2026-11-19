// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentAction {
  int get paymentId;
  PaymentStatus get status;
  DateTime? get submittedAt;
  DateTime? get confirmedAt;
  String? get rejectionReason;

  /// Create a copy of PaymentAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PaymentActionCopyWith<PaymentAction> get copyWith =>
      _$PaymentActionCopyWithImpl<PaymentAction>(
        this as PaymentAction,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PaymentAction &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.confirmedAt, confirmedAt) ||
                other.confirmedAt == confirmedAt) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    paymentId,
    status,
    submittedAt,
    confirmedAt,
    rejectionReason,
  );

  @override
  String toString() {
    return 'PaymentAction(paymentId: $paymentId, status: $status, submittedAt: $submittedAt, confirmedAt: $confirmedAt, rejectionReason: $rejectionReason)';
  }
}

/// @nodoc
abstract mixin class $PaymentActionCopyWith<$Res> {
  factory $PaymentActionCopyWith(
    PaymentAction value,
    $Res Function(PaymentAction) _then,
  ) = _$PaymentActionCopyWithImpl;
  @useResult
  $Res call({
    int paymentId,
    PaymentStatus status,
    DateTime? submittedAt,
    DateTime? confirmedAt,
    String? rejectionReason,
  });
}

/// @nodoc
class _$PaymentActionCopyWithImpl<$Res>
    implements $PaymentActionCopyWith<$Res> {
  _$PaymentActionCopyWithImpl(this._self, this._then);

  final PaymentAction _self;
  final $Res Function(PaymentAction) _then;

  /// Create a copy of PaymentAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentId = null,
    Object? status = null,
    Object? submittedAt = freezed,
    Object? confirmedAt = freezed,
    Object? rejectionReason = freezed,
  }) {
    return _then(
      PaymentAction(
        paymentId: null == paymentId
            ? _self.paymentId
            : paymentId // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as PaymentStatus,
        submittedAt: freezed == submittedAt
            ? _self.submittedAt
            : submittedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        confirmedAt: freezed == confirmedAt
            ? _self.confirmedAt
            : confirmedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        rejectionReason: freezed == rejectionReason
            ? _self.rejectionReason
            : rejectionReason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [PaymentAction].
extension PaymentActionPatterns on PaymentAction {
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
    TResult Function(_PaymentAction value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaymentAction() when $default != null:
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
    TResult Function(_PaymentAction value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaymentAction():
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
    TResult? Function(_PaymentAction value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaymentAction() when $default != null:
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
      int paymentId,
      PaymentStatus status,
      DateTime? submittedAt,
      DateTime? confirmedAt,
      String? rejectionReason,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PaymentAction() when $default != null:
        return $default(
          _that.paymentId,
          _that.status,
          _that.submittedAt,
          _that.confirmedAt,
          _that.rejectionReason,
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
      int paymentId,
      PaymentStatus status,
      DateTime? submittedAt,
      DateTime? confirmedAt,
      String? rejectionReason,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaymentAction():
        return $default(
          _that.paymentId,
          _that.status,
          _that.submittedAt,
          _that.confirmedAt,
          _that.rejectionReason,
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
      int paymentId,
      PaymentStatus status,
      DateTime? submittedAt,
      DateTime? confirmedAt,
      String? rejectionReason,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PaymentAction() when $default != null:
        return $default(
          _that.paymentId,
          _that.status,
          _that.submittedAt,
          _that.confirmedAt,
          _that.rejectionReason,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PaymentAction implements PaymentAction {
  const _PaymentAction({
    required this.paymentId,
    required this.status,
    this.submittedAt,
    this.confirmedAt,
    this.rejectionReason,
  });

  @override
  final int paymentId;
  @override
  final PaymentStatus status;
  @override
  final DateTime? submittedAt;
  @override
  final DateTime? confirmedAt;
  @override
  final String? rejectionReason;

  /// Create a copy of PaymentAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PaymentActionCopyWith<_PaymentAction> get copyWith =>
      __$PaymentActionCopyWithImpl<_PaymentAction>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PaymentAction &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.confirmedAt, confirmedAt) ||
                other.confirmedAt == confirmedAt) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    paymentId,
    status,
    submittedAt,
    confirmedAt,
    rejectionReason,
  );

  @override
  String toString() {
    return 'PaymentAction(paymentId: $paymentId, status: $status, submittedAt: $submittedAt, confirmedAt: $confirmedAt, rejectionReason: $rejectionReason)';
  }
}

/// @nodoc
abstract mixin class _$PaymentActionCopyWith<$Res>
    implements $PaymentActionCopyWith<$Res> {
  factory _$PaymentActionCopyWith(
    _PaymentAction value,
    $Res Function(_PaymentAction) _then,
  ) = __$PaymentActionCopyWithImpl;
  @override
  @useResult
  $Res call({
    int paymentId,
    PaymentStatus status,
    DateTime? submittedAt,
    DateTime? confirmedAt,
    String? rejectionReason,
  });
}

/// @nodoc
class __$PaymentActionCopyWithImpl<$Res>
    implements _$PaymentActionCopyWith<$Res> {
  __$PaymentActionCopyWithImpl(this._self, this._then);

  final _PaymentAction _self;
  final $Res Function(_PaymentAction) _then;

  /// Create a copy of PaymentAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? paymentId = null,
    Object? status = null,
    Object? submittedAt = freezed,
    Object? confirmedAt = freezed,
    Object? rejectionReason = freezed,
  }) {
    return _then(
      _PaymentAction(
        paymentId: null == paymentId
            ? _self.paymentId
            : paymentId // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as PaymentStatus,
        submittedAt: freezed == submittedAt
            ? _self.submittedAt
            : submittedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        confirmedAt: freezed == confirmedAt
            ? _self.confirmedAt
            : confirmedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        rejectionReason: freezed == rejectionReason
            ? _self.rejectionReason
            : rejectionReason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}
