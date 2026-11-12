// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_members_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GroupMembersRequest {
  int get meetingId;

  /// Create a copy of GroupMembersRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GroupMembersRequestCopyWith<GroupMembersRequest> get copyWith =>
      _$GroupMembersRequestCopyWithImpl<GroupMembersRequest>(
        this as GroupMembersRequest,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GroupMembersRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, meetingId);

  @override
  String toString() {
    return 'GroupMembersRequest(meetingId: $meetingId)';
  }
}

/// @nodoc
abstract mixin class $GroupMembersRequestCopyWith<$Res> {
  factory $GroupMembersRequestCopyWith(
    GroupMembersRequest value,
    $Res Function(GroupMembersRequest) _then,
  ) = _$GroupMembersRequestCopyWithImpl;
  @useResult
  $Res call({int meetingId});
}

/// @nodoc
class _$GroupMembersRequestCopyWithImpl<$Res>
    implements $GroupMembersRequestCopyWith<$Res> {
  _$GroupMembersRequestCopyWithImpl(this._self, this._then);

  final GroupMembersRequest _self;
  final $Res Function(GroupMembersRequest) _then;

  /// Create a copy of GroupMembersRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? meetingId = null}) {
    return _then(
      GroupMembersRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GroupMembersRequest].
extension GroupMembersRequestPatterns on GroupMembersRequest {
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
    TResult Function(_GroupMembersRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GroupMembersRequest() when $default != null:
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
    TResult Function(_GroupMembersRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GroupMembersRequest():
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
    TResult? Function(_GroupMembersRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GroupMembersRequest() when $default != null:
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
    TResult Function(int meetingId)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GroupMembersRequest() when $default != null:
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
    TResult Function(int meetingId) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GroupMembersRequest():
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
    TResult? Function(int meetingId)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GroupMembersRequest() when $default != null:
        return $default(_that.meetingId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GroupMembersRequest implements GroupMembersRequest {
  const _GroupMembersRequest({required this.meetingId});

  @override
  final int meetingId;

  /// Create a copy of GroupMembersRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GroupMembersRequestCopyWith<_GroupMembersRequest> get copyWith =>
      __$GroupMembersRequestCopyWithImpl<_GroupMembersRequest>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GroupMembersRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, meetingId);

  @override
  String toString() {
    return 'GroupMembersRequest(meetingId: $meetingId)';
  }
}

/// @nodoc
abstract mixin class _$GroupMembersRequestCopyWith<$Res>
    implements $GroupMembersRequestCopyWith<$Res> {
  factory _$GroupMembersRequestCopyWith(
    _GroupMembersRequest value,
    $Res Function(_GroupMembersRequest) _then,
  ) = __$GroupMembersRequestCopyWithImpl;
  @override
  @useResult
  $Res call({int meetingId});
}

/// @nodoc
class __$GroupMembersRequestCopyWithImpl<$Res>
    implements _$GroupMembersRequestCopyWith<$Res> {
  __$GroupMembersRequestCopyWithImpl(this._self, this._then);

  final _GroupMembersRequest _self;
  final $Res Function(_GroupMembersRequest) _then;

  /// Create a copy of GroupMembersRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? meetingId = null}) {
    return _then(
      _GroupMembersRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}
