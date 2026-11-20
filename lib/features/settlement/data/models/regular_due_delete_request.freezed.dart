// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'regular_due_delete_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegularDueDeleteRequest {
  @JsonKey(includeToJson: false)
  int get meetingId;
  @JsonKey(includeToJson: false)
  int get regularDuesId;

  /// Create a copy of RegularDueDeleteRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegularDueDeleteRequestCopyWith<RegularDueDeleteRequest> get copyWith =>
      _$RegularDueDeleteRequestCopyWithImpl<RegularDueDeleteRequest>(
        this as RegularDueDeleteRequest,
        _$identity,
      );

  /// Serializes this RegularDueDeleteRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegularDueDeleteRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.regularDuesId, regularDuesId) ||
                other.regularDuesId == regularDuesId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, meetingId, regularDuesId);

  @override
  String toString() {
    return 'RegularDueDeleteRequest(meetingId: $meetingId, regularDuesId: $regularDuesId)';
  }
}

/// @nodoc
abstract mixin class $RegularDueDeleteRequestCopyWith<$Res> {
  factory $RegularDueDeleteRequestCopyWith(
    RegularDueDeleteRequest value,
    $Res Function(RegularDueDeleteRequest) _then,
  ) = _$RegularDueDeleteRequestCopyWithImpl;
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int meetingId,
    @JsonKey(includeToJson: false) int regularDuesId,
  });
}

/// @nodoc
class _$RegularDueDeleteRequestCopyWithImpl<$Res>
    implements $RegularDueDeleteRequestCopyWith<$Res> {
  _$RegularDueDeleteRequestCopyWithImpl(this._self, this._then);

  final RegularDueDeleteRequest _self;
  final $Res Function(RegularDueDeleteRequest) _then;

  /// Create a copy of RegularDueDeleteRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? meetingId = null, Object? regularDuesId = null}) {
    return _then(
      RegularDueDeleteRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
        regularDuesId: null == regularDuesId
            ? _self.regularDuesId
            : regularDuesId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [RegularDueDeleteRequest].
extension RegularDueDeleteRequestPatterns on RegularDueDeleteRequest {
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
    TResult Function(_RegularDueDeleteRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegularDueDeleteRequest() when $default != null:
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
    TResult Function(_RegularDueDeleteRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueDeleteRequest():
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
    TResult? Function(_RegularDueDeleteRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueDeleteRequest() when $default != null:
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
      @JsonKey(includeToJson: false) int regularDuesId,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegularDueDeleteRequest() when $default != null:
        return $default(_that.meetingId, _that.regularDuesId);
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
      @JsonKey(includeToJson: false) int regularDuesId,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueDeleteRequest():
        return $default(_that.meetingId, _that.regularDuesId);
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
      @JsonKey(includeToJson: false) int regularDuesId,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueDeleteRequest() when $default != null:
        return $default(_that.meetingId, _that.regularDuesId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RegularDueDeleteRequest implements RegularDueDeleteRequest {
  const _RegularDueDeleteRequest({
    @JsonKey(includeToJson: false) required this.meetingId,
    @JsonKey(includeToJson: false) required this.regularDuesId,
  });
  factory _RegularDueDeleteRequest.fromJson(Map<String, dynamic> json) =>
      _$RegularDueDeleteRequestFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int meetingId;
  @override
  @JsonKey(includeToJson: false)
  final int regularDuesId;

  /// Create a copy of RegularDueDeleteRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RegularDueDeleteRequestCopyWith<_RegularDueDeleteRequest> get copyWith =>
      __$RegularDueDeleteRequestCopyWithImpl<_RegularDueDeleteRequest>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$RegularDueDeleteRequestToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegularDueDeleteRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.regularDuesId, regularDuesId) ||
                other.regularDuesId == regularDuesId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, meetingId, regularDuesId);

  @override
  String toString() {
    return 'RegularDueDeleteRequest(meetingId: $meetingId, regularDuesId: $regularDuesId)';
  }
}

/// @nodoc
abstract mixin class _$RegularDueDeleteRequestCopyWith<$Res>
    implements $RegularDueDeleteRequestCopyWith<$Res> {
  factory _$RegularDueDeleteRequestCopyWith(
    _RegularDueDeleteRequest value,
    $Res Function(_RegularDueDeleteRequest) _then,
  ) = __$RegularDueDeleteRequestCopyWithImpl;
  @override
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int meetingId,
    @JsonKey(includeToJson: false) int regularDuesId,
  });
}

/// @nodoc
class __$RegularDueDeleteRequestCopyWithImpl<$Res>
    implements _$RegularDueDeleteRequestCopyWith<$Res> {
  __$RegularDueDeleteRequestCopyWithImpl(this._self, this._then);

  final _RegularDueDeleteRequest _self;
  final $Res Function(_RegularDueDeleteRequest) _then;

  /// Create a copy of RegularDueDeleteRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? meetingId = null, Object? regularDuesId = null}) {
    return _then(
      _RegularDueDeleteRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
        regularDuesId: null == regularDuesId
            ? _self.regularDuesId
            : regularDuesId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}
