// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_payment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementPaymentModel {
  int get paymentId;
  int get amount;
  String get status;
  int? get memberId;
  String? get userName;
  DateTime? get submittedAt;
  DateTime? get refundedAt;

  /// Create a copy of SettlementPaymentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettlementPaymentModelCopyWith<SettlementPaymentModel> get copyWith =>
      _$SettlementPaymentModelCopyWithImpl<SettlementPaymentModel>(
        this as SettlementPaymentModel,
        _$identity,
      );

  /// Serializes this SettlementPaymentModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettlementPaymentModel &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    paymentId,
    amount,
    status,
    memberId,
    userName,
    submittedAt,
    refundedAt,
  );

  @override
  String toString() {
    return 'SettlementPaymentModel(paymentId: $paymentId, amount: $amount, status: $status, memberId: $memberId, userName: $userName, submittedAt: $submittedAt, refundedAt: $refundedAt)';
  }
}

/// @nodoc
abstract mixin class $SettlementPaymentModelCopyWith<$Res> {
  factory $SettlementPaymentModelCopyWith(
    SettlementPaymentModel value,
    $Res Function(SettlementPaymentModel) _then,
  ) = _$SettlementPaymentModelCopyWithImpl;
  @useResult
  $Res call({
    int paymentId,
    int amount,
    String status,
    int? memberId,
    String? userName,
    DateTime? submittedAt,
    DateTime? refundedAt,
  });
}

/// @nodoc
class _$SettlementPaymentModelCopyWithImpl<$Res>
    implements $SettlementPaymentModelCopyWith<$Res> {
  _$SettlementPaymentModelCopyWithImpl(this._self, this._then);

  final SettlementPaymentModel _self;
  final $Res Function(SettlementPaymentModel) _then;

  /// Create a copy of SettlementPaymentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentId = null,
    Object? amount = null,
    Object? status = null,
    Object? memberId = freezed,
    Object? userName = freezed,
    Object? submittedAt = freezed,
    Object? refundedAt = freezed,
  }) {
    return _then(
      SettlementPaymentModel(
        paymentId: null == paymentId
            ? _self.paymentId
            : paymentId // ignore: cast_nullable_to_non_nullable
                  as int,
        amount: null == amount
            ? _self.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
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

/// Adds pattern-matching-related methods to [SettlementPaymentModel].
extension SettlementPaymentModelPatterns on SettlementPaymentModel {
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
    TResult Function(_SettlementPaymentModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementPaymentModel() when $default != null:
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
    TResult Function(_SettlementPaymentModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementPaymentModel():
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
    TResult? Function(_SettlementPaymentModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementPaymentModel() when $default != null:
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
      int amount,
      String status,
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
      case _SettlementPaymentModel() when $default != null:
        return $default(
          _that.paymentId,
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
      int paymentId,
      int amount,
      String status,
      int? memberId,
      String? userName,
      DateTime? submittedAt,
      DateTime? refundedAt,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementPaymentModel():
        return $default(
          _that.paymentId,
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
      int paymentId,
      int amount,
      String status,
      int? memberId,
      String? userName,
      DateTime? submittedAt,
      DateTime? refundedAt,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementPaymentModel() when $default != null:
        return $default(
          _that.paymentId,
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
@JsonSerializable()
class _SettlementPaymentModel implements SettlementPaymentModel {
  const _SettlementPaymentModel({
    required this.paymentId,
    required this.amount,
    required this.status,
    this.memberId,
    this.userName,
    this.submittedAt,
    this.refundedAt,
  });
  factory _SettlementPaymentModel.fromJson(Map<String, dynamic> json) =>
      _$SettlementPaymentModelFromJson(json);

  @override
  final int paymentId;
  @override
  final int amount;
  @override
  final String status;
  @override
  final int? memberId;
  @override
  final String? userName;
  @override
  final DateTime? submittedAt;
  @override
  final DateTime? refundedAt;

  /// Create a copy of SettlementPaymentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettlementPaymentModelCopyWith<_SettlementPaymentModel> get copyWith =>
      __$SettlementPaymentModelCopyWithImpl<_SettlementPaymentModel>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$SettlementPaymentModelToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettlementPaymentModel &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    paymentId,
    amount,
    status,
    memberId,
    userName,
    submittedAt,
    refundedAt,
  );

  @override
  String toString() {
    return 'SettlementPaymentModel(paymentId: $paymentId, amount: $amount, status: $status, memberId: $memberId, userName: $userName, submittedAt: $submittedAt, refundedAt: $refundedAt)';
  }
}

/// @nodoc
abstract mixin class _$SettlementPaymentModelCopyWith<$Res>
    implements $SettlementPaymentModelCopyWith<$Res> {
  factory _$SettlementPaymentModelCopyWith(
    _SettlementPaymentModel value,
    $Res Function(_SettlementPaymentModel) _then,
  ) = __$SettlementPaymentModelCopyWithImpl;
  @override
  @useResult
  $Res call({
    int paymentId,
    int amount,
    String status,
    int? memberId,
    String? userName,
    DateTime? submittedAt,
    DateTime? refundedAt,
  });
}

/// @nodoc
class __$SettlementPaymentModelCopyWithImpl<$Res>
    implements _$SettlementPaymentModelCopyWith<$Res> {
  __$SettlementPaymentModelCopyWithImpl(this._self, this._then);

  final _SettlementPaymentModel _self;
  final $Res Function(_SettlementPaymentModel) _then;

  /// Create a copy of SettlementPaymentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? paymentId = null,
    Object? amount = null,
    Object? status = null,
    Object? memberId = freezed,
    Object? userName = freezed,
    Object? submittedAt = freezed,
    Object? refundedAt = freezed,
  }) {
    return _then(
      _SettlementPaymentModel(
        paymentId: null == paymentId
            ? _self.paymentId
            : paymentId // ignore: cast_nullable_to_non_nullable
                  as int,
        amount: null == amount
            ? _self.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
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
