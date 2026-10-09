// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CurrentGroup {

 Group get group; GroupMember get membership;
/// Create a copy of CurrentGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentGroupCopyWith<CurrentGroup> get copyWith => _$CurrentGroupCopyWithImpl<CurrentGroup>(this as CurrentGroup, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentGroup&&(identical(other.group, group) || other.group == group)&&(identical(other.membership, membership) || other.membership == membership));
}


@override
int get hashCode => Object.hash(runtimeType,group,membership);

@override
String toString() {
  return 'CurrentGroup(group: $group, membership: $membership)';
}


}

/// @nodoc
abstract mixin class $CurrentGroupCopyWith<$Res>  {
  factory $CurrentGroupCopyWith(CurrentGroup value, $Res Function(CurrentGroup) _then) = _$CurrentGroupCopyWithImpl;
@useResult
$Res call({
 Group group, GroupMember membership
});


$GroupCopyWith<$Res> get group;$GroupMemberCopyWith<$Res> get membership;

}
/// @nodoc
class _$CurrentGroupCopyWithImpl<$Res>
    implements $CurrentGroupCopyWith<$Res> {
  _$CurrentGroupCopyWithImpl(this._self, this._then);

  final CurrentGroup _self;
  final $Res Function(CurrentGroup) _then;

/// Create a copy of CurrentGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? group = null,Object? membership = null,}) {
  return _then(CurrentGroup(
group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as Group,membership: null == membership ? _self.membership : membership // ignore: cast_nullable_to_non_nullable
as GroupMember,
  ));
}
/// Create a copy of CurrentGroup
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupCopyWith<$Res> get group {
  
  return $GroupCopyWith<$Res>(_self.group, (value) {
    return _then(_self.copyWith(group: value));
  });
}/// Create a copy of CurrentGroup
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupMemberCopyWith<$Res> get membership {
  
  return $GroupMemberCopyWith<$Res>(_self.membership, (value) {
    return _then(_self.copyWith(membership: value));
  });
}
}


/// Adds pattern-matching-related methods to [CurrentGroup].
extension CurrentGroupPatterns on CurrentGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrentGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentGroup() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrentGroup value)  $default,){
final _that = this;
switch (_that) {
case _CurrentGroup():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrentGroup value)?  $default,){
final _that = this;
switch (_that) {
case _CurrentGroup() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Group group,  GroupMember membership)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentGroup() when $default != null:
return $default(_that.group,_that.membership);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Group group,  GroupMember membership)  $default,) {final _that = this;
switch (_that) {
case _CurrentGroup():
return $default(_that.group,_that.membership);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Group group,  GroupMember membership)?  $default,) {final _that = this;
switch (_that) {
case _CurrentGroup() when $default != null:
return $default(_that.group,_that.membership);case _:
  return null;

}
}

}

/// @nodoc


class _CurrentGroup implements CurrentGroup {
   _CurrentGroup({required this.group, required this.membership}): assert(group.id == membership.groupId, '모임과 구성원 정보의 모임 ID가 일치해야 합니다.');
  

@override final  Group group;
@override final  GroupMember membership;

/// Create a copy of CurrentGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentGroupCopyWith<_CurrentGroup> get copyWith => __$CurrentGroupCopyWithImpl<_CurrentGroup>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentGroup&&(identical(other.group, group) || other.group == group)&&(identical(other.membership, membership) || other.membership == membership));
}


@override
int get hashCode => Object.hash(runtimeType,group,membership);

@override
String toString() {
  return 'CurrentGroup(group: $group, membership: $membership)';
}


}

/// @nodoc
abstract mixin class _$CurrentGroupCopyWith<$Res> implements $CurrentGroupCopyWith<$Res> {
  factory _$CurrentGroupCopyWith(_CurrentGroup value, $Res Function(_CurrentGroup) _then) = __$CurrentGroupCopyWithImpl;
@override @useResult
$Res call({
 Group group, GroupMember membership
});


@override $GroupCopyWith<$Res> get group;@override $GroupMemberCopyWith<$Res> get membership;

}
/// @nodoc
class __$CurrentGroupCopyWithImpl<$Res>
    implements _$CurrentGroupCopyWith<$Res> {
  __$CurrentGroupCopyWithImpl(this._self, this._then);

  final _CurrentGroup _self;
  final $Res Function(_CurrentGroup) _then;

/// Create a copy of CurrentGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? group = null,Object? membership = null,}) {
  return _then(_CurrentGroup(
group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as Group,membership: null == membership ? _self.membership : membership // ignore: cast_nullable_to_non_nullable
as GroupMember,
  ));
}

/// Create a copy of CurrentGroup
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupCopyWith<$Res> get group {
  
  return $GroupCopyWith<$Res>(_self.group, (value) {
    return _then(_self.copyWith(group: value));
  });
}/// Create a copy of CurrentGroup
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupMemberCopyWith<$Res> get membership {
  
  return $GroupMemberCopyWith<$Res>(_self.membership, (value) {
    return _then(_self.copyWith(membership: value));
  });
}
}

// dart format on
