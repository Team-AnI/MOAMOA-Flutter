// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'regular_dues_list_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegularDuesListRequest {
  @JsonKey(includeToJson: false)
  int get meetingId;

  /// Create a copy of RegularDuesListRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegularDuesListRequestCopyWith<RegularDuesListRequest> get copyWith =>
      _$RegularDuesListRequestCopyWithImpl<RegularDuesListRequest>(
        this as RegularDuesListRequest,
        _$identity,
      );

  /// Serializes this RegularDuesListRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegularDuesListRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, meetingId);

  @override
  String toString() {
    return 'RegularDuesListRequest(meetingId: $meetingId)';
  }
}

/// @nodoc
abstract mixin class $RegularDuesListRequestCopyWith<$Res> {
  factory $RegularDuesListRequestCopyWith(
    RegularDuesListRequest value,
    $Res Function(RegularDuesListRequest) _then,
  ) = _$RegularDuesListRequestCopyWithImpl;
  @useResult
  $Res call({@JsonKey(includeToJson: false) int meetingId});
}

/// @nodoc
class _$RegularDuesListRequestCopyWithImpl<$Res>
    implements $RegularDuesListRequestCopyWith<$Res> {
  _$RegularDuesListRequestCopyWithImpl(this._self, this._then);

  final RegularDuesListRequest _self;
  final $Res Function(RegularDuesListRequest) _then;

  /// Create a copy of RegularDuesListRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? meetingId = null}) {
    return _then(
      RegularDuesListRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [RegularDuesListRequest].
extension RegularDuesListRequestPatterns on RegularDuesListRequest {
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
    TResult Function(_RegularDuesListRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegularDuesListRequest() when $default != null:
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
    TResult Function(_RegularDuesListRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDuesListRequest():
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
    TResult? Function(_RegularDuesListRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDuesListRequest() when $default != null:
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
      case _RegularDuesListRequest() when $default != null:
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
      case _RegularDuesListRequest():
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
      case _RegularDuesListRequest() when $default != null:
        return $default(_that.meetingId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RegularDuesListRequest implements RegularDuesListRequest {
  const _RegularDuesListRequest({
    @JsonKey(includeToJson: false) required this.meetingId,
  });
  factory _RegularDuesListRequest.fromJson(Map<String, dynamic> json) =>
      _$RegularDuesListRequestFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int meetingId;

  /// Create a copy of RegularDuesListRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RegularDuesListRequestCopyWith<_RegularDuesListRequest> get copyWith =>
      __$RegularDuesListRequestCopyWithImpl<_RegularDuesListRequest>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$RegularDuesListRequestToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegularDuesListRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, meetingId);

  @override
  String toString() {
    return 'RegularDuesListRequest(meetingId: $meetingId)';
  }
}

/// @nodoc
abstract mixin class _$RegularDuesListRequestCopyWith<$Res>
    implements $RegularDuesListRequestCopyWith<$Res> {
  factory _$RegularDuesListRequestCopyWith(
    _RegularDuesListRequest value,
    $Res Function(_RegularDuesListRequest) _then,
  ) = __$RegularDuesListRequestCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(includeToJson: false) int meetingId});
}

/// @nodoc
class __$RegularDuesListRequestCopyWithImpl<$Res>
    implements _$RegularDuesListRequestCopyWith<$Res> {
  __$RegularDuesListRequestCopyWithImpl(this._self, this._then);

  final _RegularDuesListRequest _self;
  final $Res Function(_RegularDuesListRequest) _then;

  /// Create a copy of RegularDuesListRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? meetingId = null}) {
    return _then(
      _RegularDuesListRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}
