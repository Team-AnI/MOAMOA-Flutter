// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_group_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateGroupRequest {

@JsonKey(includeToJson: false) int get meetingId;@JsonKey(includeIfNull: false) String? get name;@JsonKey(includeIfNull: false) String? get description;
/// Create a copy of UpdateGroupRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateGroupRequestCopyWith<UpdateGroupRequest> get copyWith => _$UpdateGroupRequestCopyWithImpl<UpdateGroupRequest>(this as UpdateGroupRequest, _$identity);

  /// Serializes this UpdateGroupRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateGroupRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meetingId,name,description);

@override
String toString() {
  return 'UpdateGroupRequest(meetingId: $meetingId, name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class $UpdateGroupRequestCopyWith<$Res>  {
  factory $UpdateGroupRequestCopyWith(UpdateGroupRequest value, $Res Function(UpdateGroupRequest) _then) = _$UpdateGroupRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false) int meetingId,@JsonKey(includeIfNull: false) String? name,@JsonKey(includeIfNull: false) String? description
});




}
/// @nodoc
class _$UpdateGroupRequestCopyWithImpl<$Res>
    implements $UpdateGroupRequestCopyWith<$Res> {
  _$UpdateGroupRequestCopyWithImpl(this._self, this._then);

  final UpdateGroupRequest _self;
  final $Res Function(UpdateGroupRequest) _then;

/// Create a copy of UpdateGroupRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingId = null,Object? name = freezed,Object? description = freezed,}) {
  return _then(UpdateGroupRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateGroupRequest].
extension UpdateGroupRequestPatterns on UpdateGroupRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateGroupRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateGroupRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateGroupRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateGroupRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateGroupRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateGroupRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  int meetingId, @JsonKey(includeIfNull: false)  String? name, @JsonKey(includeIfNull: false)  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateGroupRequest() when $default != null:
return $default(_that.meetingId,_that.name,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  int meetingId, @JsonKey(includeIfNull: false)  String? name, @JsonKey(includeIfNull: false)  String? description)  $default,) {final _that = this;
switch (_that) {
case _UpdateGroupRequest():
return $default(_that.meetingId,_that.name,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false)  int meetingId, @JsonKey(includeIfNull: false)  String? name, @JsonKey(includeIfNull: false)  String? description)?  $default,) {final _that = this;
switch (_that) {
case _UpdateGroupRequest() when $default != null:
return $default(_that.meetingId,_that.name,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateGroupRequest implements UpdateGroupRequest {
  const _UpdateGroupRequest({@JsonKey(includeToJson: false) required this.meetingId, @JsonKey(includeIfNull: false) this.name, @JsonKey(includeIfNull: false) this.description});
  factory _UpdateGroupRequest.fromJson(Map<String, dynamic> json) => _$UpdateGroupRequestFromJson(json);

@override@JsonKey(includeToJson: false) final  int meetingId;
@override@JsonKey(includeIfNull: false) final  String? name;
@override@JsonKey(includeIfNull: false) final  String? description;

/// Create a copy of UpdateGroupRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateGroupRequestCopyWith<_UpdateGroupRequest> get copyWith => __$UpdateGroupRequestCopyWithImpl<_UpdateGroupRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateGroupRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateGroupRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meetingId,name,description);

@override
String toString() {
  return 'UpdateGroupRequest(meetingId: $meetingId, name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class _$UpdateGroupRequestCopyWith<$Res> implements $UpdateGroupRequestCopyWith<$Res> {
  factory _$UpdateGroupRequestCopyWith(_UpdateGroupRequest value, $Res Function(_UpdateGroupRequest) _then) = __$UpdateGroupRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false) int meetingId,@JsonKey(includeIfNull: false) String? name,@JsonKey(includeIfNull: false) String? description
});




}
/// @nodoc
class __$UpdateGroupRequestCopyWithImpl<$Res>
    implements _$UpdateGroupRequestCopyWith<$Res> {
  __$UpdateGroupRequestCopyWithImpl(this._self, this._then);

  final _UpdateGroupRequest _self;
  final $Res Function(_UpdateGroupRequest) _then;

/// Create a copy of UpdateGroupRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingId = null,Object? name = freezed,Object? description = freezed,}) {
  return _then(_UpdateGroupRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
