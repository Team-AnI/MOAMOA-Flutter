// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_member_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GroupMemberModel {
  num get memberId;
  String? get userName;
  String get role;
  Object? get profileColor;

  /// Create a copy of GroupMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GroupMemberModelCopyWith<GroupMemberModel> get copyWith =>
      _$GroupMemberModelCopyWithImpl<GroupMemberModel>(
        this as GroupMemberModel,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GroupMemberModel &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality().equals(
              other.profileColor,
              profileColor,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    memberId,
    userName,
    role,
    const DeepCollectionEquality().hash(profileColor),
  );

  @override
  String toString() {
    return 'GroupMemberModel(memberId: $memberId, userName: $userName, role: $role, profileColor: $profileColor)';
  }
}

/// @nodoc
abstract mixin class $GroupMemberModelCopyWith<$Res> {
  factory $GroupMemberModelCopyWith(
    GroupMemberModel value,
    $Res Function(GroupMemberModel) _then,
  ) = _$GroupMemberModelCopyWithImpl;
  @useResult
  $Res call({
    num memberId,
    String? userName,
    String role,
    Object? profileColor,
  });
}

/// @nodoc
class _$GroupMemberModelCopyWithImpl<$Res>
    implements $GroupMemberModelCopyWith<$Res> {
  _$GroupMemberModelCopyWithImpl(this._self, this._then);

  final GroupMemberModel _self;
  final $Res Function(GroupMemberModel) _then;

  /// Create a copy of GroupMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? userName = freezed,
    Object? role = null,
    Object? profileColor = freezed,
  }) {
    return _then(
      GroupMemberModel(
        memberId: null == memberId
            ? _self.memberId
            : memberId // ignore: cast_nullable_to_non_nullable
                  as num,
        userName: freezed == userName
            ? _self.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String?,
        role: null == role
            ? _self.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        profileColor: freezed == profileColor
            ? _self.profileColor
            : profileColor,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [GroupMemberModel].
extension GroupMemberModelPatterns on GroupMemberModel {
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
    TResult Function(_GroupMemberModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GroupMemberModel() when $default != null:
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
    TResult Function(_GroupMemberModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GroupMemberModel():
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
    TResult? Function(_GroupMemberModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GroupMemberModel() when $default != null:
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
      num memberId,
      String? userName,
      String role,
      Object? profileColor,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GroupMemberModel() when $default != null:
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
      num memberId,
      String? userName,
      String role,
      Object? profileColor,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GroupMemberModel():
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
      num memberId,
      String? userName,
      String role,
      Object? profileColor,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GroupMemberModel() when $default != null:
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
@JsonSerializable(createToJson: false)
class _GroupMemberModel implements GroupMemberModel {
  const _GroupMemberModel({
    required this.memberId,
    this.userName,
    required this.role,
    this.profileColor,
  });
  factory _GroupMemberModel.fromJson(Map<String, dynamic> json) =>
      _$GroupMemberModelFromJson(json);

  @override
  final num memberId;
  @override
  final String? userName;
  @override
  final String role;
  @override
  final Object? profileColor;

  /// Create a copy of GroupMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GroupMemberModelCopyWith<_GroupMemberModel> get copyWith =>
      __$GroupMemberModelCopyWithImpl<_GroupMemberModel>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GroupMemberModel &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality().equals(
              other.profileColor,
              profileColor,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    memberId,
    userName,
    role,
    const DeepCollectionEquality().hash(profileColor),
  );

  @override
  String toString() {
    return 'GroupMemberModel(memberId: $memberId, userName: $userName, role: $role, profileColor: $profileColor)';
  }
}

/// @nodoc
abstract mixin class _$GroupMemberModelCopyWith<$Res>
    implements $GroupMemberModelCopyWith<$Res> {
  factory _$GroupMemberModelCopyWith(
    _GroupMemberModel value,
    $Res Function(_GroupMemberModel) _then,
  ) = __$GroupMemberModelCopyWithImpl;
  @override
  @useResult
  $Res call({
    num memberId,
    String? userName,
    String role,
    Object? profileColor,
  });
}

/// @nodoc
class __$GroupMemberModelCopyWithImpl<$Res>
    implements _$GroupMemberModelCopyWith<$Res> {
  __$GroupMemberModelCopyWithImpl(this._self, this._then);

  final _GroupMemberModel _self;
  final $Res Function(_GroupMemberModel) _then;

  /// Create a copy of GroupMemberModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? memberId = null,
    Object? userName = freezed,
    Object? role = null,
    Object? profileColor = freezed,
  }) {
    return _then(
      _GroupMemberModel(
        memberId: null == memberId
            ? _self.memberId
            : memberId // ignore: cast_nullable_to_non_nullable
                  as num,
        userName: freezed == userName
            ? _self.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String?,
        role: null == role
            ? _self.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        profileColor: freezed == profileColor
            ? _self.profileColor
            : profileColor,
      ),
    );
  }
}
