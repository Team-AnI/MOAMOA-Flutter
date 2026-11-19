// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_cancel_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementCancelRequest {
  @JsonKey(includeToJson: false)
  int get meetingId;
  @JsonKey(includeToJson: false)
  int get settlementId;
  @JsonKey(includeIfNull: false)
  String? get reason;

  /// Create a copy of SettlementCancelRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettlementCancelRequestCopyWith<SettlementCancelRequest> get copyWith =>
      _$SettlementCancelRequestCopyWithImpl<SettlementCancelRequest>(
        this as SettlementCancelRequest,
        _$identity,
      );

  /// Serializes this SettlementCancelRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettlementCancelRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.settlementId, settlementId) ||
                other.settlementId == settlementId) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, meetingId, settlementId, reason);

  @override
  String toString() {
    return 'SettlementCancelRequest(meetingId: $meetingId, settlementId: $settlementId, reason: $reason)';
  }
}

/// @nodoc
abstract mixin class $SettlementCancelRequestCopyWith<$Res> {
  factory $SettlementCancelRequestCopyWith(
    SettlementCancelRequest value,
    $Res Function(SettlementCancelRequest) _then,
  ) = _$SettlementCancelRequestCopyWithImpl;
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int meetingId,
    @JsonKey(includeToJson: false) int settlementId,
    @JsonKey(includeIfNull: false) String? reason,
  });
}

/// @nodoc
class _$SettlementCancelRequestCopyWithImpl<$Res>
    implements $SettlementCancelRequestCopyWith<$Res> {
  _$SettlementCancelRequestCopyWithImpl(this._self, this._then);

  final SettlementCancelRequest _self;
  final $Res Function(SettlementCancelRequest) _then;

  /// Create a copy of SettlementCancelRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetingId = null,
    Object? settlementId = null,
    Object? reason = freezed,
  }) {
    return _then(
      SettlementCancelRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
        settlementId: null == settlementId
            ? _self.settlementId
            : settlementId // ignore: cast_nullable_to_non_nullable
                  as int,
        reason: freezed == reason
            ? _self.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [SettlementCancelRequest].
extension SettlementCancelRequestPatterns on SettlementCancelRequest {
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
    TResult Function(_SettlementCancelRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementCancelRequest() when $default != null:
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
    TResult Function(_SettlementCancelRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementCancelRequest():
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
    TResult? Function(_SettlementCancelRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementCancelRequest() when $default != null:
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
      @JsonKey(includeIfNull: false) String? reason,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementCancelRequest() when $default != null:
        return $default(_that.meetingId, _that.settlementId, _that.reason);
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
      @JsonKey(includeIfNull: false) String? reason,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementCancelRequest():
        return $default(_that.meetingId, _that.settlementId, _that.reason);
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
      @JsonKey(includeIfNull: false) String? reason,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementCancelRequest() when $default != null:
        return $default(_that.meetingId, _that.settlementId, _that.reason);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SettlementCancelRequest implements SettlementCancelRequest {
  const _SettlementCancelRequest({
    @JsonKey(includeToJson: false) required this.meetingId,
    @JsonKey(includeToJson: false) required this.settlementId,
    @JsonKey(includeIfNull: false) this.reason,
  });
  factory _SettlementCancelRequest.fromJson(Map<String, dynamic> json) =>
      _$SettlementCancelRequestFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int meetingId;
  @override
  @JsonKey(includeToJson: false)
  final int settlementId;
  @override
  @JsonKey(includeIfNull: false)
  final String? reason;

  /// Create a copy of SettlementCancelRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettlementCancelRequestCopyWith<_SettlementCancelRequest> get copyWith =>
      __$SettlementCancelRequestCopyWithImpl<_SettlementCancelRequest>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$SettlementCancelRequestToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettlementCancelRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.settlementId, settlementId) ||
                other.settlementId == settlementId) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, meetingId, settlementId, reason);

  @override
  String toString() {
    return 'SettlementCancelRequest(meetingId: $meetingId, settlementId: $settlementId, reason: $reason)';
  }
}

/// @nodoc
abstract mixin class _$SettlementCancelRequestCopyWith<$Res>
    implements $SettlementCancelRequestCopyWith<$Res> {
  factory _$SettlementCancelRequestCopyWith(
    _SettlementCancelRequest value,
    $Res Function(_SettlementCancelRequest) _then,
  ) = __$SettlementCancelRequestCopyWithImpl;
  @override
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int meetingId,
    @JsonKey(includeToJson: false) int settlementId,
    @JsonKey(includeIfNull: false) String? reason,
  });
}

/// @nodoc
class __$SettlementCancelRequestCopyWithImpl<$Res>
    implements _$SettlementCancelRequestCopyWith<$Res> {
  __$SettlementCancelRequestCopyWithImpl(this._self, this._then);

  final _SettlementCancelRequest _self;
  final $Res Function(_SettlementCancelRequest) _then;

  /// Create a copy of SettlementCancelRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? meetingId = null,
    Object? settlementId = null,
    Object? reason = freezed,
  }) {
    return _then(
      _SettlementCancelRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
        settlementId: null == settlementId
            ? _self.settlementId
            : settlementId // ignore: cast_nullable_to_non_nullable
                  as int,
        reason: freezed == reason
            ? _self.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}
