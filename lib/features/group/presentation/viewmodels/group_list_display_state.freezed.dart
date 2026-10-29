// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_list_display_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GroupListDisplayState {

 GroupState get source; GroupListPreferences get preferences; String? get userName;
/// Create a copy of GroupListDisplayState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupListDisplayStateCopyWith<GroupListDisplayState> get copyWith => _$GroupListDisplayStateCopyWithImpl<GroupListDisplayState>(this as GroupListDisplayState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupListDisplayState&&(identical(other.source, source) || other.source == source)&&(identical(other.preferences, preferences) || other.preferences == preferences)&&(identical(other.userName, userName) || other.userName == userName));
}


@override
int get hashCode => Object.hash(runtimeType,source,preferences,userName);

@override
String toString() {
  return 'GroupListDisplayState(source: $source, preferences: $preferences, userName: $userName)';
}


}

/// @nodoc
abstract mixin class $GroupListDisplayStateCopyWith<$Res>  {
  factory $GroupListDisplayStateCopyWith(GroupListDisplayState value, $Res Function(GroupListDisplayState) _then) = _$GroupListDisplayStateCopyWithImpl;
@useResult
$Res call({
 GroupState source, GroupListPreferences preferences, String? userName
});


$GroupStateCopyWith<$Res> get source;$GroupListPreferencesCopyWith<$Res> get preferences;

}
/// @nodoc
class _$GroupListDisplayStateCopyWithImpl<$Res>
    implements $GroupListDisplayStateCopyWith<$Res> {
  _$GroupListDisplayStateCopyWithImpl(this._self, this._then);

  final GroupListDisplayState _self;
  final $Res Function(GroupListDisplayState) _then;

/// Create a copy of GroupListDisplayState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? source = null,Object? preferences = null,Object? userName = freezed,}) {
  return _then(GroupListDisplayState(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as GroupState,preferences: null == preferences ? _self.preferences : preferences // ignore: cast_nullable_to_non_nullable
as GroupListPreferences,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of GroupListDisplayState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupStateCopyWith<$Res> get source {
  
  return $GroupStateCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}/// Create a copy of GroupListDisplayState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupListPreferencesCopyWith<$Res> get preferences {
  
  return $GroupListPreferencesCopyWith<$Res>(_self.preferences, (value) {
    return _then(_self.copyWith(preferences: value));
  });
}
}


/// Adds pattern-matching-related methods to [GroupListDisplayState].
extension GroupListDisplayStatePatterns on GroupListDisplayState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupListDisplayState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupListDisplayState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupListDisplayState value)  $default,){
final _that = this;
switch (_that) {
case _GroupListDisplayState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupListDisplayState value)?  $default,){
final _that = this;
switch (_that) {
case _GroupListDisplayState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GroupState source,  GroupListPreferences preferences,  String? userName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupListDisplayState() when $default != null:
return $default(_that.source,_that.preferences,_that.userName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GroupState source,  GroupListPreferences preferences,  String? userName)  $default,) {final _that = this;
switch (_that) {
case _GroupListDisplayState():
return $default(_that.source,_that.preferences,_that.userName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GroupState source,  GroupListPreferences preferences,  String? userName)?  $default,) {final _that = this;
switch (_that) {
case _GroupListDisplayState() when $default != null:
return $default(_that.source,_that.preferences,_that.userName);case _:
  return null;

}
}

}

/// @nodoc


class _GroupListDisplayState implements GroupListDisplayState {
  const _GroupListDisplayState({required this.source, required this.preferences, this.userName});
  

@override final  GroupState source;
@override final  GroupListPreferences preferences;
@override final  String? userName;

/// Create a copy of GroupListDisplayState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupListDisplayStateCopyWith<_GroupListDisplayState> get copyWith => __$GroupListDisplayStateCopyWithImpl<_GroupListDisplayState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupListDisplayState&&(identical(other.source, source) || other.source == source)&&(identical(other.preferences, preferences) || other.preferences == preferences)&&(identical(other.userName, userName) || other.userName == userName));
}


@override
int get hashCode => Object.hash(runtimeType,source,preferences,userName);

@override
String toString() {
  return 'GroupListDisplayState(source: $source, preferences: $preferences, userName: $userName)';
}


}

/// @nodoc
abstract mixin class _$GroupListDisplayStateCopyWith<$Res> implements $GroupListDisplayStateCopyWith<$Res> {
  factory _$GroupListDisplayStateCopyWith(_GroupListDisplayState value, $Res Function(_GroupListDisplayState) _then) = __$GroupListDisplayStateCopyWithImpl;
@override @useResult
$Res call({
 GroupState source, GroupListPreferences preferences, String? userName
});


@override $GroupStateCopyWith<$Res> get source;@override $GroupListPreferencesCopyWith<$Res> get preferences;

}
/// @nodoc
class __$GroupListDisplayStateCopyWithImpl<$Res>
    implements _$GroupListDisplayStateCopyWith<$Res> {
  __$GroupListDisplayStateCopyWithImpl(this._self, this._then);

  final _GroupListDisplayState _self;
  final $Res Function(_GroupListDisplayState) _then;

/// Create a copy of GroupListDisplayState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? source = null,Object? preferences = null,Object? userName = freezed,}) {
  return _then(_GroupListDisplayState(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as GroupState,preferences: null == preferences ? _self.preferences : preferences // ignore: cast_nullable_to_non_nullable
as GroupListPreferences,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of GroupListDisplayState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupStateCopyWith<$Res> get source {
  
  return $GroupStateCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}/// Create a copy of GroupListDisplayState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GroupListPreferencesCopyWith<$Res> get preferences {
  
  return $GroupListPreferencesCopyWith<$Res>(_self.preferences, (value) {
    return _then(_self.copyWith(preferences: value));
  });
}
}

// dart format on
