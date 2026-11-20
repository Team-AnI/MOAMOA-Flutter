// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_list_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementListRequest {
  @JsonKey(includeToJson: false)
  int get meetingId;

  /// Create a copy of SettlementListRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettlementListRequestCopyWith<SettlementListRequest> get copyWith =>
      _$SettlementListRequestCopyWithImpl<SettlementListRequest>(
        this as SettlementListRequest,
        _$identity,
      );

  /// Serializes this SettlementListRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettlementListRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, meetingId);

  @override
  String toString() {
    return 'SettlementListRequest(meetingId: $meetingId)';
  }
}

/// @nodoc
abstract mixin class $SettlementListRequestCopyWith<$Res> {
  factory $SettlementListRequestCopyWith(
    SettlementListRequest value,
    $Res Function(SettlementListRequest) _then,
  ) = _$SettlementListRequestCopyWithImpl;
  @useResult
  $Res call({@JsonKey(includeToJson: false) int meetingId});
}

/// @nodoc
class _$SettlementListRequestCopyWithImpl<$Res>
    implements $SettlementListRequestCopyWith<$Res> {
  _$SettlementListRequestCopyWithImpl(this._self, this._then);

  final SettlementListRequest _self;
  final $Res Function(SettlementListRequest) _then;

  /// Create a copy of SettlementListRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? meetingId = null}) {
    return _then(
      SettlementListRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [SettlementListRequest].
extension SettlementListRequestPatterns on SettlementListRequest {
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
    TResult Function(_SettlementListRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementListRequest() when $default != null:
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
    TResult Function(_SettlementListRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementListRequest():
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
    TResult? Function(_SettlementListRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementListRequest() when $default != null:
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
    TResult Function(@JsonKey(includeToJson: false) int meetingId)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementListRequest() when $default != null:
        return $default(_that.meetingId);
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
    TResult Function(@JsonKey(includeToJson: false) int meetingId) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementListRequest():
        return $default(_that.meetingId);
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
    TResult? Function(@JsonKey(includeToJson: false) int meetingId)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementListRequest() when $default != null:
        return $default(_that.meetingId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SettlementListRequest implements SettlementListRequest {
  const _SettlementListRequest({
    @JsonKey(includeToJson: false) required this.meetingId,
  });
  factory _SettlementListRequest.fromJson(Map<String, dynamic> json) =>
      _$SettlementListRequestFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int meetingId;

  /// Create a copy of SettlementListRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettlementListRequestCopyWith<_SettlementListRequest> get copyWith =>
      __$SettlementListRequestCopyWithImpl<_SettlementListRequest>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$SettlementListRequestToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettlementListRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, meetingId);

  @override
  String toString() {
    return 'SettlementListRequest(meetingId: $meetingId)';
  }
}

/// @nodoc
abstract mixin class _$SettlementListRequestCopyWith<$Res>
    implements $SettlementListRequestCopyWith<$Res> {
  factory _$SettlementListRequestCopyWith(
    _SettlementListRequest value,
    $Res Function(_SettlementListRequest) _then,
  ) = __$SettlementListRequestCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(includeToJson: false) int meetingId});
}

/// @nodoc
class __$SettlementListRequestCopyWithImpl<$Res>
    implements _$SettlementListRequestCopyWith<$Res> {
  __$SettlementListRequestCopyWithImpl(this._self, this._then);

  final _SettlementListRequest _self;
  final $Res Function(_SettlementListRequest) _then;

  /// Create a copy of SettlementListRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? meetingId = null}) {
    return _then(
      _SettlementListRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}
