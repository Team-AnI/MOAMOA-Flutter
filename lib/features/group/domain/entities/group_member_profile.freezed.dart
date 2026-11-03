// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_member_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GroupMemberProfile {
  int get memberId;
  String? get userName;
  MemberRole get role;
  GroupProfileColor get profileColor;

  /// Create a copy of GroupMemberProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GroupMemberProfileCopyWith<GroupMemberProfile> get copyWith =>
      _$GroupMemberProfileCopyWithImpl<GroupMemberProfile>(
        this as GroupMemberProfile,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GroupMemberProfile &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.profileColor, profileColor) ||
                other.profileColor == profileColor));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, memberId, userName, role, profileColor);

  @override
  String toString() {
    return 'GroupMemberProfile(memberId: $memberId, userName: $userName, role: $role, profileColor: $profileColor)';
  }
}

/// @nodoc
abstract mixin class $GroupMemberProfileCopyWith<$Res> {
  factory $GroupMemberProfileCopyWith(
    GroupMemberProfile value,
    $Res Function(GroupMemberProfile) _then,
  ) = _$GroupMemberProfileCopyWithImpl;
  @useResult
  $Res call({
    int memberId,
    String? userName,
    MemberRole role,
    GroupProfileColor profileColor,
  });
}

/// @nodoc
class _$GroupMemberProfileCopyWithImpl<$Res>
    implements $GroupMemberProfileCopyWith<$Res> {
  _$GroupMemberProfileCopyWithImpl(this._self, this._then);

  final GroupMemberProfile _self;
  final $Res Function(GroupMemberProfile) _then;

  /// Create a copy of GroupMemberProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? userName = freezed,
    Object? role = null,
    Object? profileColor = null,
  }) {
    return _then(
      GroupMemberProfile(
        memberId: null == memberId
            ? _self.memberId
            : memberId // ignore: cast_nullable_to_non_nullable
                  as int,
        userName: freezed == userName
            ? _self.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String?,
        role: null == role
            ? _self.role
            : role // ignore: cast_nullable_to_non_nullable
                  as MemberRole,
        profileColor: null == profileColor
            ? _self.profileColor
            : profileColor // ignore: cast_nullable_to_non_nullable
                  as GroupProfileColor,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GroupMemberProfile].
extension GroupMemberProfilePatterns on GroupMemberProfile {
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
    TResult Function(_GroupMemberProfile value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GroupMemberProfile() when $default != null:
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
    TResult Function(_GroupMemberProfile value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GroupMemberProfile():
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
    TResult? Function(_GroupMemberProfile value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GroupMemberProfile() when $default != null:
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
      int memberId,
      String? userName,
      MemberRole role,
      GroupProfileColor profileColor,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GroupMemberProfile() when $default != null:
        return $default(
          _that.memberId,
          _that.userName,
          _that.role,
          _that.profileColor,
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
      int memberId,
      String? userName,
      MemberRole role,
      GroupProfileColor profileColor,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GroupMemberProfile():
        return $default(
          _that.memberId,
          _that.userName,
          _that.role,
          _that.profileColor,
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
      int memberId,
      String? userName,
      MemberRole role,
      GroupProfileColor profileColor,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GroupMemberProfile() when $default != null:
        return $default(
          _that.memberId,
          _that.userName,
          _that.role,
          _that.profileColor,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GroupMemberProfile implements GroupMemberProfile {
  const _GroupMemberProfile({
    required this.memberId,
    this.userName,
    required this.role,
    this.profileColor = GroupProfileColor.lightBlue,
  });

  @override
  final int memberId;
  @override
  final String? userName;
  @override
  final MemberRole role;
  @override
  @JsonKey()
  final GroupProfileColor profileColor;

  /// Create a copy of GroupMemberProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GroupMemberProfileCopyWith<_GroupMemberProfile> get copyWith =>
      __$GroupMemberProfileCopyWithImpl<_GroupMemberProfile>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GroupMemberProfile &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.profileColor, profileColor) ||
                other.profileColor == profileColor));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, memberId, userName, role, profileColor);

  @override
  String toString() {
    return 'GroupMemberProfile(memberId: $memberId, userName: $userName, role: $role, profileColor: $profileColor)';
  }
}

/// @nodoc
abstract mixin class _$GroupMemberProfileCopyWith<$Res>
    implements $GroupMemberProfileCopyWith<$Res> {
  factory _$GroupMemberProfileCopyWith(
    _GroupMemberProfile value,
    $Res Function(_GroupMemberProfile) _then,
  ) = __$GroupMemberProfileCopyWithImpl;
  @override
  @useResult
  $Res call({
    int memberId,
    String? userName,
    MemberRole role,
    GroupProfileColor profileColor,
  });
}

/// @nodoc
class __$GroupMemberProfileCopyWithImpl<$Res>
    implements _$GroupMemberProfileCopyWith<$Res> {
  __$GroupMemberProfileCopyWithImpl(this._self, this._then);

  final _GroupMemberProfile _self;
  final $Res Function(_GroupMemberProfile) _then;

  /// Create a copy of GroupMemberProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? memberId = null,
    Object? userName = freezed,
    Object? role = null,
    Object? profileColor = null,
  }) {
    return _then(
      _GroupMemberProfile(
        memberId: null == memberId
            ? _self.memberId
            : memberId // ignore: cast_nullable_to_non_nullable
                  as int,
        userName: freezed == userName
            ? _self.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String?,
        role: null == role
            ? _self.role
            : role // ignore: cast_nullable_to_non_nullable
                  as MemberRole,
        profileColor: null == profileColor
            ? _self.profileColor
            : profileColor // ignore: cast_nullable_to_non_nullable
                  as GroupProfileColor,
      ),
    );
  }
}
