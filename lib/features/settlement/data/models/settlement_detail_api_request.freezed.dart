// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_detail_api_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementDetailApiRequest {
  @JsonKey(includeToJson: false)
  int get meetingId;
  @JsonKey(includeToJson: false)
  int get settlementId;

  /// Create a copy of SettlementDetailApiRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettlementDetailApiRequestCopyWith<SettlementDetailApiRequest>
  get copyWith =>
      _$SettlementDetailApiRequestCopyWithImpl<SettlementDetailApiRequest>(
        this as SettlementDetailApiRequest,
        _$identity,
      );

  /// Serializes this SettlementDetailApiRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettlementDetailApiRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.settlementId, settlementId) ||
                other.settlementId == settlementId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, meetingId, settlementId);

  @override
  String toString() {
    return 'SettlementDetailApiRequest(meetingId: $meetingId, settlementId: $settlementId)';
  }
}

/// @nodoc
abstract mixin class $SettlementDetailApiRequestCopyWith<$Res> {
  factory $SettlementDetailApiRequestCopyWith(
    SettlementDetailApiRequest value,
    $Res Function(SettlementDetailApiRequest) _then,
  ) = _$SettlementDetailApiRequestCopyWithImpl;
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int meetingId,
    @JsonKey(includeToJson: false) int settlementId,
  });
}

/// @nodoc
class _$SettlementDetailApiRequestCopyWithImpl<$Res>
    implements $SettlementDetailApiRequestCopyWith<$Res> {
  _$SettlementDetailApiRequestCopyWithImpl(this._self, this._then);

  final SettlementDetailApiRequest _self;
  final $Res Function(SettlementDetailApiRequest) _then;

  /// Create a copy of SettlementDetailApiRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? meetingId = null, Object? settlementId = null}) {
    return _then(
      SettlementDetailApiRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
        settlementId: null == settlementId
            ? _self.settlementId
            : settlementId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [SettlementDetailApiRequest].
extension SettlementDetailApiRequestPatterns on SettlementDetailApiRequest {
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
    TResult Function(_SettlementDetailApiRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementDetailApiRequest() when $default != null:
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
    TResult Function(_SettlementDetailApiRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementDetailApiRequest():
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
    TResult? Function(_SettlementDetailApiRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementDetailApiRequest() when $default != null:
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
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementDetailApiRequest() when $default != null:
        return $default(_that.meetingId, _that.settlementId);
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
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementDetailApiRequest():
        return $default(_that.meetingId, _that.settlementId);
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
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementDetailApiRequest() when $default != null:
        return $default(_that.meetingId, _that.settlementId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SettlementDetailApiRequest implements SettlementDetailApiRequest {
  const _SettlementDetailApiRequest({
    @JsonKey(includeToJson: false) required this.meetingId,
    @JsonKey(includeToJson: false) required this.settlementId,
  });
  factory _SettlementDetailApiRequest.fromJson(Map<String, dynamic> json) =>
      _$SettlementDetailApiRequestFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int meetingId;
  @override
  @JsonKey(includeToJson: false)
  final int settlementId;

  /// Create a copy of SettlementDetailApiRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettlementDetailApiRequestCopyWith<_SettlementDetailApiRequest>
  get copyWith =>
      __$SettlementDetailApiRequestCopyWithImpl<_SettlementDetailApiRequest>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$SettlementDetailApiRequestToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettlementDetailApiRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.settlementId, settlementId) ||
                other.settlementId == settlementId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, meetingId, settlementId);

  @override
  String toString() {
    return 'SettlementDetailApiRequest(meetingId: $meetingId, settlementId: $settlementId)';
  }
}

/// @nodoc
abstract mixin class _$SettlementDetailApiRequestCopyWith<$Res>
    implements $SettlementDetailApiRequestCopyWith<$Res> {
  factory _$SettlementDetailApiRequestCopyWith(
    _SettlementDetailApiRequest value,
    $Res Function(_SettlementDetailApiRequest) _then,
  ) = __$SettlementDetailApiRequestCopyWithImpl;
  @override
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int meetingId,
    @JsonKey(includeToJson: false) int settlementId,
  });
}

/// @nodoc
class __$SettlementDetailApiRequestCopyWithImpl<$Res>
    implements _$SettlementDetailApiRequestCopyWith<$Res> {
  __$SettlementDetailApiRequestCopyWithImpl(this._self, this._then);

  final _SettlementDetailApiRequest _self;
  final $Res Function(_SettlementDetailApiRequest) _then;

  /// Create a copy of SettlementDetailApiRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? meetingId = null, Object? settlementId = null}) {
    return _then(
      _SettlementDetailApiRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
        settlementId: null == settlementId
            ? _self.settlementId
            : settlementId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}
