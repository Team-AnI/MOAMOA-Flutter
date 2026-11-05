// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_members_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GroupMembersState {
  List<GroupMemberProfile> get members;
  GroupFailureReason? get failureReason;
  bool get isLoading;
  bool get hasLoaded;

  /// Create a copy of GroupMembersState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GroupMembersStateCopyWith<GroupMembersState> get copyWith =>
      _$GroupMembersStateCopyWithImpl<GroupMembersState>(
        this as GroupMembersState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GroupMembersState &&
            const DeepCollectionEquality().equals(other.members, members) &&
            (identical(other.failureReason, failureReason) ||
                other.failureReason == failureReason) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.hasLoaded, hasLoaded) ||
                other.hasLoaded == hasLoaded));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(members),
    failureReason,
    isLoading,
    hasLoaded,
  );

  @override
  String toString() {
    return 'GroupMembersState(members: $members, failureReason: $failureReason, isLoading: $isLoading, hasLoaded: $hasLoaded)';
  }
}

/// @nodoc
abstract mixin class $GroupMembersStateCopyWith<$Res> {
  factory $GroupMembersStateCopyWith(
    GroupMembersState value,
    $Res Function(GroupMembersState) _then,
  ) = _$GroupMembersStateCopyWithImpl;
  @useResult
  $Res call({
    List<GroupMemberProfile> members,
    GroupFailureReason? failureReason,
    bool isLoading,
    bool hasLoaded,
  });
}

/// @nodoc
class _$GroupMembersStateCopyWithImpl<$Res>
    implements $GroupMembersStateCopyWith<$Res> {
  _$GroupMembersStateCopyWithImpl(this._self, this._then);

  final GroupMembersState _self;
  final $Res Function(GroupMembersState) _then;

  /// Create a copy of GroupMembersState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? members = null,
    Object? failureReason = freezed,
    Object? isLoading = null,
    Object? hasLoaded = null,
  }) {
    return _then(
      GroupMembersState(
        members: null == members
            ? _self.members
            : members // ignore: cast_nullable_to_non_nullable
                  as List<GroupMemberProfile>,
        failureReason: freezed == failureReason
            ? _self.failureReason
            : failureReason // ignore: cast_nullable_to_non_nullable
                  as GroupFailureReason?,
        isLoading: null == isLoading
            ? _self.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasLoaded: null == hasLoaded
            ? _self.hasLoaded
            : hasLoaded // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GroupMembersState].
extension GroupMembersStatePatterns on GroupMembersState {
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
    TResult Function(_GroupMembersState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GroupMembersState() when $default != null:
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
    TResult Function(_GroupMembersState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GroupMembersState():
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
    TResult? Function(_GroupMembersState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GroupMembersState() when $default != null:
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
      List<GroupMemberProfile> members,
      GroupFailureReason? failureReason,
      bool isLoading,
      bool hasLoaded,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GroupMembersState() when $default != null:
        return $default(
          _that.members,
          _that.failureReason,
          _that.isLoading,
          _that.hasLoaded,
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
      List<GroupMemberProfile> members,
      GroupFailureReason? failureReason,
      bool isLoading,
      bool hasLoaded,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GroupMembersState():
        return $default(
          _that.members,
          _that.failureReason,
          _that.isLoading,
          _that.hasLoaded,
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
      List<GroupMemberProfile> members,
      GroupFailureReason? failureReason,
      bool isLoading,
      bool hasLoaded,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GroupMembersState() when $default != null:
        return $default(
          _that.members,
          _that.failureReason,
          _that.isLoading,
          _that.hasLoaded,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GroupMembersState implements GroupMembersState {
  const _GroupMembersState({
    List<GroupMemberProfile> members = const [],
    this.failureReason,
    this.isLoading = false,
    this.hasLoaded = false,
  }) : _members = members;

  final List<GroupMemberProfile> _members;
  @override
  @JsonKey()
  List<GroupMemberProfile> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  final GroupFailureReason? failureReason;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool hasLoaded;

  /// Create a copy of GroupMembersState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GroupMembersStateCopyWith<_GroupMembersState> get copyWith =>
      __$GroupMembersStateCopyWithImpl<_GroupMembersState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GroupMembersState &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            (identical(other.failureReason, failureReason) ||
                other.failureReason == failureReason) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.hasLoaded, hasLoaded) ||
                other.hasLoaded == hasLoaded));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_members),
    failureReason,
    isLoading,
    hasLoaded,
  );

  @override
  String toString() {
    return 'GroupMembersState(members: $members, failureReason: $failureReason, isLoading: $isLoading, hasLoaded: $hasLoaded)';
  }
}

/// @nodoc
abstract mixin class _$GroupMembersStateCopyWith<$Res>
    implements $GroupMembersStateCopyWith<$Res> {
  factory _$GroupMembersStateCopyWith(
    _GroupMembersState value,
    $Res Function(_GroupMembersState) _then,
  ) = __$GroupMembersStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    List<GroupMemberProfile> members,
    GroupFailureReason? failureReason,
    bool isLoading,
    bool hasLoaded,
  });
}

/// @nodoc
class __$GroupMembersStateCopyWithImpl<$Res>
    implements _$GroupMembersStateCopyWith<$Res> {
  __$GroupMembersStateCopyWithImpl(this._self, this._then);

  final _GroupMembersState _self;
  final $Res Function(_GroupMembersState) _then;

  /// Create a copy of GroupMembersState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? members = null,
    Object? failureReason = freezed,
    Object? isLoading = null,
    Object? hasLoaded = null,
  }) {
    return _then(
      _GroupMembersState(
        members: null == members
            ? _self._members
            : members // ignore: cast_nullable_to_non_nullable
                  as List<GroupMemberProfile>,
        failureReason: freezed == failureReason
            ? _self.failureReason
            : failureReason // ignore: cast_nullable_to_non_nullable
                  as GroupFailureReason?,
        isLoading: null == isLoading
            ? _self.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasLoaded: null == hasLoaded
            ? _self.hasLoaded
            : hasLoaded // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}
