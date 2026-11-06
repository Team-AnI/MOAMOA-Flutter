// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GroupState {

 List<CurrentGroup> get groups; CurrentGroup? get currentGroup; bool get isSubmitting; bool get isLoading; String? get errorMessage; GroupFailureReason? get failureReason;
/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupStateCopyWith<GroupState> get copyWith => _$GroupStateCopyWithImpl<GroupState>(this as GroupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupState&&const DeepCollectionEquality().equals(other.groups, groups)&&(identical(other.currentGroup, currentGroup) || other.currentGroup == currentGroup)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(groups),currentGroup,isSubmitting,isLoading,errorMessage,failureReason);

@override
String toString() {
  return 'GroupState(groups: $groups, currentGroup: $currentGroup, isSubmitting: $isSubmitting, isLoading: $isLoading, errorMessage: $errorMessage, failureReason: $failureReason)';
}


}

/// @nodoc
abstract mixin class $GroupStateCopyWith<$Res>  {
  factory $GroupStateCopyWith(GroupState value, $Res Function(GroupState) _then) = _$GroupStateCopyWithImpl;
@useResult
$Res call({
 List<CurrentGroup> groups, CurrentGroup? currentGroup, bool isSubmitting, bool isLoading, String? errorMessage, GroupFailureReason? failureReason
});


$CurrentGroupCopyWith<$Res>? get currentGroup;

}
/// @nodoc
class _$GroupStateCopyWithImpl<$Res>
    implements $GroupStateCopyWith<$Res> {
  _$GroupStateCopyWithImpl(this._self, this._then);

  final GroupState _self;
  final $Res Function(GroupState) _then;

/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? groups = null,Object? currentGroup = freezed,Object? isSubmitting = null,Object? isLoading = null,Object? errorMessage = freezed,Object? failureReason = freezed,}) {
  return _then(GroupState(
groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as List<CurrentGroup>,currentGroup: freezed == currentGroup ? _self.currentGroup : currentGroup // ignore: cast_nullable_to_non_nullable
as CurrentGroup?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as GroupFailureReason?,
  ));
}
/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentGroupCopyWith<$Res>? get currentGroup {
    if (_self.currentGroup == null) {
    return null;
  }

  return $CurrentGroupCopyWith<$Res>(_self.currentGroup!, (value) {
    return _then(_self.copyWith(currentGroup: value));
  });
}
}


/// Adds pattern-matching-related methods to [GroupState].
extension GroupStatePatterns on GroupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupState value)  $default,){
final _that = this;
switch (_that) {
case _GroupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupState value)?  $default,){
final _that = this;
switch (_that) {
case _GroupState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CurrentGroup> groups,  CurrentGroup? currentGroup,  bool isSubmitting,  bool isLoading,  String? errorMessage,  GroupFailureReason? failureReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupState() when $default != null:
return $default(_that.groups,_that.currentGroup,_that.isSubmitting,_that.isLoading,_that.errorMessage,_that.failureReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CurrentGroup> groups,  CurrentGroup? currentGroup,  bool isSubmitting,  bool isLoading,  String? errorMessage,  GroupFailureReason? failureReason)  $default,) {final _that = this;
switch (_that) {
case _GroupState():
return $default(_that.groups,_that.currentGroup,_that.isSubmitting,_that.isLoading,_that.errorMessage,_that.failureReason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CurrentGroup> groups,  CurrentGroup? currentGroup,  bool isSubmitting,  bool isLoading,  String? errorMessage,  GroupFailureReason? failureReason)?  $default,) {final _that = this;
switch (_that) {
case _GroupState() when $default != null:
return $default(_that.groups,_that.currentGroup,_that.isSubmitting,_that.isLoading,_that.errorMessage,_that.failureReason);case _:
  return null;

}
}

}

/// @nodoc


class _GroupState implements GroupState {
  const _GroupState({ List<CurrentGroup> groups = const [], this.currentGroup, this.isSubmitting = false, this.isLoading = false, this.errorMessage, this.failureReason}): _groups = groups;
  

 final  List<CurrentGroup> _groups;
@override@JsonKey() List<CurrentGroup> get groups {
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groups);
}

@override final  CurrentGroup? currentGroup;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool isLoading;
@override final  String? errorMessage;
@override final  GroupFailureReason? failureReason;

/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupStateCopyWith<_GroupState> get copyWith => __$GroupStateCopyWithImpl<_GroupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupState&&const DeepCollectionEquality().equals(other._groups, _groups)&&(identical(other.currentGroup, currentGroup) || other.currentGroup == currentGroup)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_groups),currentGroup,isSubmitting,isLoading,errorMessage,failureReason);

@override
String toString() {
  return 'GroupState(groups: $groups, currentGroup: $currentGroup, isSubmitting: $isSubmitting, isLoading: $isLoading, errorMessage: $errorMessage, failureReason: $failureReason)';
}


}

/// @nodoc
abstract mixin class _$GroupStateCopyWith<$Res> implements $GroupStateCopyWith<$Res> {
  factory _$GroupStateCopyWith(_GroupState value, $Res Function(_GroupState) _then) = __$GroupStateCopyWithImpl;
@override @useResult
$Res call({
 List<CurrentGroup> groups, CurrentGroup? currentGroup, bool isSubmitting, bool isLoading, String? errorMessage, GroupFailureReason? failureReason
});


@override $CurrentGroupCopyWith<$Res>? get currentGroup;

}
/// @nodoc
class __$GroupStateCopyWithImpl<$Res>
    implements _$GroupStateCopyWith<$Res> {
  __$GroupStateCopyWithImpl(this._self, this._then);

  final _GroupState _self;
  final $Res Function(_GroupState) _then;

/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? groups = null,Object? currentGroup = freezed,Object? isSubmitting = null,Object? isLoading = null,Object? errorMessage = freezed,Object? failureReason = freezed,}) {
  return _then(_GroupState(
groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<CurrentGroup>,currentGroup: freezed == currentGroup ? _self.currentGroup : currentGroup // ignore: cast_nullable_to_non_nullable
as CurrentGroup?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as GroupFailureReason?,
  ));
}

/// Create a copy of GroupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentGroupCopyWith<$Res>? get currentGroup {
    if (_self.currentGroup == null) {
    return null;
  }

  return $CurrentGroupCopyWith<$Res>(_self.currentGroup!, (value) {
    return _then(_self.copyWith(currentGroup: value));
  });
}
}

// dart format on
