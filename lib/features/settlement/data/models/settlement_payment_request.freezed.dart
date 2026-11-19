// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_payment_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementPaymentRequest {
  @JsonKey(includeToJson: false)
  int get meetingId;
  @JsonKey(includeToJson: false)
  int get settlementId;
  @JsonKey(includeToJson: false)
  int? get paymentId;
  @JsonKey(includeIfNull: false)
  String? get reason;

  /// Create a copy of SettlementPaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettlementPaymentRequestCopyWith<SettlementPaymentRequest> get copyWith =>
      _$SettlementPaymentRequestCopyWithImpl<SettlementPaymentRequest>(
        this as SettlementPaymentRequest,
        _$identity,
      );

  /// Serializes this SettlementPaymentRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettlementPaymentRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.settlementId, settlementId) ||
                other.settlementId == settlementId) &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, meetingId, settlementId, paymentId, reason);

  @override
  String toString() {
    return 'SettlementPaymentRequest(meetingId: $meetingId, settlementId: $settlementId, paymentId: $paymentId, reason: $reason)';
  }
}

/// @nodoc
abstract mixin class $SettlementPaymentRequestCopyWith<$Res> {
  factory $SettlementPaymentRequestCopyWith(
    SettlementPaymentRequest value,
    $Res Function(SettlementPaymentRequest) _then,
  ) = _$SettlementPaymentRequestCopyWithImpl;
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int meetingId,
    @JsonKey(includeToJson: false) int settlementId,
    @JsonKey(includeToJson: false) int? paymentId,
    @JsonKey(includeIfNull: false) String? reason,
  });
}

/// @nodoc
class _$SettlementPaymentRequestCopyWithImpl<$Res>
    implements $SettlementPaymentRequestCopyWith<$Res> {
  _$SettlementPaymentRequestCopyWithImpl(this._self, this._then);

  final SettlementPaymentRequest _self;
  final $Res Function(SettlementPaymentRequest) _then;

  /// Create a copy of SettlementPaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetingId = null,
    Object? settlementId = null,
    Object? paymentId = freezed,
    Object? reason = freezed,
  }) {
    return _then(
      SettlementPaymentRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
        settlementId: null == settlementId
            ? _self.settlementId
            : settlementId // ignore: cast_nullable_to_non_nullable
                  as int,
        paymentId: freezed == paymentId
            ? _self.paymentId
            : paymentId // ignore: cast_nullable_to_non_nullable
                  as int?,
        reason: freezed == reason
            ? _self.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [SettlementPaymentRequest].
extension SettlementPaymentRequestPatterns on SettlementPaymentRequest {
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
    TResult Function(_SettlementPaymentRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementPaymentRequest() when $default != null:
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
    TResult Function(_SettlementPaymentRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementPaymentRequest():
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
    TResult? Function(_SettlementPaymentRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementPaymentRequest() when $default != null:
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
      @JsonKey(includeToJson: false) int settlementId,
      @JsonKey(includeToJson: false) int? paymentId,
      @JsonKey(includeIfNull: false) String? reason,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementPaymentRequest() when $default != null:
        return $default(
          _that.meetingId,
          _that.settlementId,
          _that.paymentId,
          _that.reason,
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
      @JsonKey(includeToJson: false) int settlementId,
      @JsonKey(includeToJson: false) int? paymentId,
      @JsonKey(includeIfNull: false) String? reason,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementPaymentRequest():
        return $default(
          _that.meetingId,
          _that.settlementId,
          _that.paymentId,
          _that.reason,
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
      @JsonKey(includeToJson: false) int settlementId,
      @JsonKey(includeToJson: false) int? paymentId,
      @JsonKey(includeIfNull: false) String? reason,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementPaymentRequest() when $default != null:
        return $default(
          _that.meetingId,
          _that.settlementId,
          _that.paymentId,
          _that.reason,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SettlementPaymentRequest implements SettlementPaymentRequest {
  const _SettlementPaymentRequest({
    @JsonKey(includeToJson: false) required this.meetingId,
    @JsonKey(includeToJson: false) required this.settlementId,
    @JsonKey(includeToJson: false) this.paymentId,
    @JsonKey(includeIfNull: false) this.reason,
  });
  factory _SettlementPaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$SettlementPaymentRequestFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int meetingId;
  @override
  @JsonKey(includeToJson: false)
  final int settlementId;
  @override
  @JsonKey(includeToJson: false)
  final int? paymentId;
  @override
  @JsonKey(includeIfNull: false)
  final String? reason;

  /// Create a copy of SettlementPaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettlementPaymentRequestCopyWith<_SettlementPaymentRequest> get copyWith =>
      __$SettlementPaymentRequestCopyWithImpl<_SettlementPaymentRequest>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$SettlementPaymentRequestToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettlementPaymentRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.settlementId, settlementId) ||
                other.settlementId == settlementId) &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, meetingId, settlementId, paymentId, reason);

  @override
  String toString() {
    return 'SettlementPaymentRequest(meetingId: $meetingId, settlementId: $settlementId, paymentId: $paymentId, reason: $reason)';
  }
}

/// @nodoc
abstract mixin class _$SettlementPaymentRequestCopyWith<$Res>
    implements $SettlementPaymentRequestCopyWith<$Res> {
  factory _$SettlementPaymentRequestCopyWith(
    _SettlementPaymentRequest value,
    $Res Function(_SettlementPaymentRequest) _then,
  ) = __$SettlementPaymentRequestCopyWithImpl;
  @override
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int meetingId,
    @JsonKey(includeToJson: false) int settlementId,
    @JsonKey(includeToJson: false) int? paymentId,
    @JsonKey(includeIfNull: false) String? reason,
  });
}

/// @nodoc
class __$SettlementPaymentRequestCopyWithImpl<$Res>
    implements _$SettlementPaymentRequestCopyWith<$Res> {
  __$SettlementPaymentRequestCopyWithImpl(this._self, this._then);

  final _SettlementPaymentRequest _self;
  final $Res Function(_SettlementPaymentRequest) _then;

  /// Create a copy of SettlementPaymentRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? meetingId = null,
    Object? settlementId = null,
    Object? paymentId = freezed,
    Object? reason = freezed,
  }) {
    return _then(
      _SettlementPaymentRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
        settlementId: null == settlementId
            ? _self.settlementId
            : settlementId // ignore: cast_nullable_to_non_nullable
                  as int,
        paymentId: freezed == paymentId
            ? _self.paymentId
            : paymentId // ignore: cast_nullable_to_non_nullable
                  as int?,
        reason: freezed == reason
            ? _self.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}
