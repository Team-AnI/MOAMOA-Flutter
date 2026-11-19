// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_setup_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileSetupState {

/// 고른 프로필 색. 처음에는 서버 기본값과 같은 연파랑입니다.
 ProfileColor get color; ProfileSetupStatus get status;/// [status] 가 failure 일 때만 값이 있습니다.
 Object? get error;
/// Create a copy of ProfileSetupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileSetupStateCopyWith<ProfileSetupState> get copyWith => _$ProfileSetupStateCopyWithImpl<ProfileSetupState>(this as ProfileSetupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSetupState&&(identical(other.color, color) || other.color == color)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,color,status,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'ProfileSetupState(color: $color, status: $status, error: $error)';
}


}

/// @nodoc
abstract mixin class $ProfileSetupStateCopyWith<$Res>  {
  factory $ProfileSetupStateCopyWith(ProfileSetupState value, $Res Function(ProfileSetupState) _then) = _$ProfileSetupStateCopyWithImpl;
@useResult
$Res call({
 ProfileColor color, ProfileSetupStatus status, Object? error
});




}
/// @nodoc
class _$ProfileSetupStateCopyWithImpl<$Res>
    implements $ProfileSetupStateCopyWith<$Res> {
  _$ProfileSetupStateCopyWithImpl(this._self, this._then);

  final ProfileSetupState _self;
  final $Res Function(ProfileSetupState) _then;

/// Create a copy of ProfileSetupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? color = null,Object? status = null,Object? error = freezed,}) {
  return _then(ProfileSetupState(
color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as ProfileColor,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProfileSetupStatus,error: freezed == error ? _self.error : error ,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileSetupState].
extension ProfileSetupStatePatterns on ProfileSetupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileSetupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileSetupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileSetupState value)  $default,){
final _that = this;
switch (_that) {
case _ProfileSetupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileSetupState value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileSetupState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProfileColor color,  ProfileSetupStatus status,  Object? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileSetupState() when $default != null:
return $default(_that.color,_that.status,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProfileColor color,  ProfileSetupStatus status,  Object? error)  $default,) {final _that = this;
switch (_that) {
case _ProfileSetupState():
return $default(_that.color,_that.status,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProfileColor color,  ProfileSetupStatus status,  Object? error)?  $default,) {final _that = this;
switch (_that) {
case _ProfileSetupState() when $default != null:
return $default(_that.color,_that.status,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileSetupState implements ProfileSetupState {
  const _ProfileSetupState({this.color = ProfileColor.lightBlue, this.status = ProfileSetupStatus.initial, this.error});
  

/// 고른 프로필 색. 처음에는 서버 기본값과 같은 연파랑입니다.
@override@JsonKey() final  ProfileColor color;
@override@JsonKey() final  ProfileSetupStatus status;
/// [status] 가 failure 일 때만 값이 있습니다.
@override final  Object? error;

/// Create a copy of ProfileSetupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileSetupStateCopyWith<_ProfileSetupState> get copyWith => __$ProfileSetupStateCopyWithImpl<_ProfileSetupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileSetupState&&(identical(other.color, color) || other.color == color)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,color,status,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'ProfileSetupState(color: $color, status: $status, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ProfileSetupStateCopyWith<$Res> implements $ProfileSetupStateCopyWith<$Res> {
  factory _$ProfileSetupStateCopyWith(_ProfileSetupState value, $Res Function(_ProfileSetupState) _then) = __$ProfileSetupStateCopyWithImpl;
@override @useResult
$Res call({
 ProfileColor color, ProfileSetupStatus status, Object? error
});




}
/// @nodoc
class __$ProfileSetupStateCopyWithImpl<$Res>
    implements _$ProfileSetupStateCopyWith<$Res> {
  __$ProfileSetupStateCopyWithImpl(this._self, this._then);

  final _ProfileSetupState _self;
  final $Res Function(_ProfileSetupState) _then;

/// Create a copy of ProfileSetupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? color = null,Object? status = null,Object? error = freezed,}) {
  return _then(_ProfileSetupState(
color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as ProfileColor,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProfileSetupStatus,error: freezed == error ? _self.error : error ,
  ));
}


}

// dart format on
