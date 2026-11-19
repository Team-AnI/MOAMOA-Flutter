// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_my_profile_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateMyProfileRequest {

 String get name; String? get phone;/// LIGHT_BLUE·GRAY·BLUE·DARK
 String get profileColor;
/// Create a copy of UpdateMyProfileRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateMyProfileRequestCopyWith<UpdateMyProfileRequest> get copyWith => _$UpdateMyProfileRequestCopyWithImpl<UpdateMyProfileRequest>(this as UpdateMyProfileRequest, _$identity);

  /// Serializes this UpdateMyProfileRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateMyProfileRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.profileColor, profileColor) || other.profileColor == profileColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,phone,profileColor);

@override
String toString() {
  return 'UpdateMyProfileRequest(name: $name, phone: $phone, profileColor: $profileColor)';
}


}

/// @nodoc
abstract mixin class $UpdateMyProfileRequestCopyWith<$Res>  {
  factory $UpdateMyProfileRequestCopyWith(UpdateMyProfileRequest value, $Res Function(UpdateMyProfileRequest) _then) = _$UpdateMyProfileRequestCopyWithImpl;
@useResult
$Res call({
 String name, String? phone, String profileColor
});




}
/// @nodoc
class _$UpdateMyProfileRequestCopyWithImpl<$Res>
    implements $UpdateMyProfileRequestCopyWith<$Res> {
  _$UpdateMyProfileRequestCopyWithImpl(this._self, this._then);

  final UpdateMyProfileRequest _self;
  final $Res Function(UpdateMyProfileRequest) _then;

/// Create a copy of UpdateMyProfileRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? phone = freezed,Object? profileColor = null,}) {
  return _then(UpdateMyProfileRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,profileColor: null == profileColor ? _self.profileColor : profileColor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateMyProfileRequest].
extension UpdateMyProfileRequestPatterns on UpdateMyProfileRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateMyProfileRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateMyProfileRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateMyProfileRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateMyProfileRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateMyProfileRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateMyProfileRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? phone,  String profileColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateMyProfileRequest() when $default != null:
return $default(_that.name,_that.phone,_that.profileColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? phone,  String profileColor)  $default,) {final _that = this;
switch (_that) {
case _UpdateMyProfileRequest():
return $default(_that.name,_that.phone,_that.profileColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? phone,  String profileColor)?  $default,) {final _that = this;
switch (_that) {
case _UpdateMyProfileRequest() when $default != null:
return $default(_that.name,_that.phone,_that.profileColor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateMyProfileRequest implements UpdateMyProfileRequest {
  const _UpdateMyProfileRequest({required this.name, required this.phone, required this.profileColor});
  factory _UpdateMyProfileRequest.fromJson(Map<String, dynamic> json) => _$UpdateMyProfileRequestFromJson(json);

@override final  String name;
@override final  String? phone;
/// LIGHT_BLUE·GRAY·BLUE·DARK
@override final  String profileColor;

/// Create a copy of UpdateMyProfileRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateMyProfileRequestCopyWith<_UpdateMyProfileRequest> get copyWith => __$UpdateMyProfileRequestCopyWithImpl<_UpdateMyProfileRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateMyProfileRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateMyProfileRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.profileColor, profileColor) || other.profileColor == profileColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,phone,profileColor);

@override
String toString() {
  return 'UpdateMyProfileRequest(name: $name, phone: $phone, profileColor: $profileColor)';
}


}

/// @nodoc
abstract mixin class _$UpdateMyProfileRequestCopyWith<$Res> implements $UpdateMyProfileRequestCopyWith<$Res> {
  factory _$UpdateMyProfileRequestCopyWith(_UpdateMyProfileRequest value, $Res Function(_UpdateMyProfileRequest) _then) = __$UpdateMyProfileRequestCopyWithImpl;
@override @useResult
$Res call({
 String name, String? phone, String profileColor
});




}
/// @nodoc
class __$UpdateMyProfileRequestCopyWithImpl<$Res>
    implements _$UpdateMyProfileRequestCopyWith<$Res> {
  __$UpdateMyProfileRequestCopyWithImpl(this._self, this._then);

  final _UpdateMyProfileRequest _self;
  final $Res Function(_UpdateMyProfileRequest) _then;

/// Create a copy of UpdateMyProfileRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? phone = freezed,Object? profileColor = null,}) {
  return _then(_UpdateMyProfileRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,profileColor: null == profileColor ? _self.profileColor : profileColor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
