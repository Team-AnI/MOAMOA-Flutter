// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_me_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateMeRequest {

/// LIGHT_BLUE·GRAY·BLUE·DARK
@JsonKey(includeIfNull: false) String? get profileColor;
/// Create a copy of UpdateMeRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateMeRequestCopyWith<UpdateMeRequest> get copyWith => _$UpdateMeRequestCopyWithImpl<UpdateMeRequest>(this as UpdateMeRequest, _$identity);

  /// Serializes this UpdateMeRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateMeRequest&&(identical(other.profileColor, profileColor) || other.profileColor == profileColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profileColor);

@override
String toString() {
  return 'UpdateMeRequest(profileColor: $profileColor)';
}


}

/// @nodoc
abstract mixin class $UpdateMeRequestCopyWith<$Res>  {
  factory $UpdateMeRequestCopyWith(UpdateMeRequest value, $Res Function(UpdateMeRequest) _then) = _$UpdateMeRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) String? profileColor
});




}
/// @nodoc
class _$UpdateMeRequestCopyWithImpl<$Res>
    implements $UpdateMeRequestCopyWith<$Res> {
  _$UpdateMeRequestCopyWithImpl(this._self, this._then);

  final UpdateMeRequest _self;
  final $Res Function(UpdateMeRequest) _then;

/// Create a copy of UpdateMeRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profileColor = freezed,}) {
  return _then(UpdateMeRequest(
profileColor: freezed == profileColor ? _self.profileColor : profileColor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateMeRequest].
extension UpdateMeRequestPatterns on UpdateMeRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateMeRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateMeRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateMeRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateMeRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateMeRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateMeRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? profileColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateMeRequest() when $default != null:
return $default(_that.profileColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? profileColor)  $default,) {final _that = this;
switch (_that) {
case _UpdateMeRequest():
return $default(_that.profileColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  String? profileColor)?  $default,) {final _that = this;
switch (_that) {
case _UpdateMeRequest() when $default != null:
return $default(_that.profileColor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateMeRequest implements UpdateMeRequest {
  const _UpdateMeRequest({@JsonKey(includeIfNull: false) this.profileColor});
  factory _UpdateMeRequest.fromJson(Map<String, dynamic> json) => _$UpdateMeRequestFromJson(json);

/// LIGHT_BLUE·GRAY·BLUE·DARK
@override@JsonKey(includeIfNull: false) final  String? profileColor;

/// Create a copy of UpdateMeRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateMeRequestCopyWith<_UpdateMeRequest> get copyWith => __$UpdateMeRequestCopyWithImpl<_UpdateMeRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateMeRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateMeRequest&&(identical(other.profileColor, profileColor) || other.profileColor == profileColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,profileColor);

@override
String toString() {
  return 'UpdateMeRequest(profileColor: $profileColor)';
}


}

/// @nodoc
abstract mixin class _$UpdateMeRequestCopyWith<$Res> implements $UpdateMeRequestCopyWith<$Res> {
  factory _$UpdateMeRequestCopyWith(_UpdateMeRequest value, $Res Function(_UpdateMeRequest) _then) = __$UpdateMeRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) String? profileColor
});




}
/// @nodoc
class __$UpdateMeRequestCopyWithImpl<$Res>
    implements _$UpdateMeRequestCopyWith<$Res> {
  __$UpdateMeRequestCopyWithImpl(this._self, this._then);

  final _UpdateMeRequest _self;
  final $Res Function(_UpdateMeRequest) _then;

/// Create a copy of UpdateMeRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profileColor = freezed,}) {
  return _then(_UpdateMeRequest(
profileColor: freezed == profileColor ? _self.profileColor : profileColor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
