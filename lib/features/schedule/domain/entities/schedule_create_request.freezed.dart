// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_create_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScheduleCreateRequest {

 int get meetingId; String get title; String get description; DateTime get startAt; DateTime? get endAt; String get location;
/// Create a copy of ScheduleCreateRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleCreateRequestCopyWith<ScheduleCreateRequest> get copyWith => _$ScheduleCreateRequestCopyWithImpl<ScheduleCreateRequest>(this as ScheduleCreateRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleCreateRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,title,description,startAt,endAt,location);

@override
String toString() {
  return 'ScheduleCreateRequest(meetingId: $meetingId, title: $title, description: $description, startAt: $startAt, endAt: $endAt, location: $location)';
}


}

/// @nodoc
abstract mixin class $ScheduleCreateRequestCopyWith<$Res>  {
  factory $ScheduleCreateRequestCopyWith(ScheduleCreateRequest value, $Res Function(ScheduleCreateRequest) _then) = _$ScheduleCreateRequestCopyWithImpl;
@useResult
$Res call({
 int meetingId, String title, String description, DateTime startAt, DateTime? endAt, String location
});




}
/// @nodoc
class _$ScheduleCreateRequestCopyWithImpl<$Res>
    implements $ScheduleCreateRequestCopyWith<$Res> {
  _$ScheduleCreateRequestCopyWithImpl(this._self, this._then);

  final ScheduleCreateRequest _self;
  final $Res Function(ScheduleCreateRequest) _then;

/// Create a copy of ScheduleCreateRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingId = null,Object? title = null,Object? description = null,Object? startAt = null,Object? endAt = freezed,Object? location = null,}) {
  return _then(ScheduleCreateRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,endAt: freezed == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduleCreateRequest].
extension ScheduleCreateRequestPatterns on ScheduleCreateRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleCreateRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleCreateRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleCreateRequest value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleCreateRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleCreateRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleCreateRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int meetingId,  String title,  String description,  DateTime startAt,  DateTime? endAt,  String location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleCreateRequest() when $default != null:
return $default(_that.meetingId,_that.title,_that.description,_that.startAt,_that.endAt,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int meetingId,  String title,  String description,  DateTime startAt,  DateTime? endAt,  String location)  $default,) {final _that = this;
switch (_that) {
case _ScheduleCreateRequest():
return $default(_that.meetingId,_that.title,_that.description,_that.startAt,_that.endAt,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int meetingId,  String title,  String description,  DateTime startAt,  DateTime? endAt,  String location)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleCreateRequest() when $default != null:
return $default(_that.meetingId,_that.title,_that.description,_that.startAt,_that.endAt,_that.location);case _:
  return null;

}
}

}

/// @nodoc


class _ScheduleCreateRequest implements ScheduleCreateRequest {
  const _ScheduleCreateRequest({required this.meetingId, required this.title, this.description = '', required this.startAt, this.endAt, this.location = ''});
  

@override final  int meetingId;
@override final  String title;
@override@JsonKey() final  String description;
@override final  DateTime startAt;
@override final  DateTime? endAt;
@override@JsonKey() final  String location;

/// Create a copy of ScheduleCreateRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleCreateRequestCopyWith<_ScheduleCreateRequest> get copyWith => __$ScheduleCreateRequestCopyWithImpl<_ScheduleCreateRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleCreateRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,title,description,startAt,endAt,location);

@override
String toString() {
  return 'ScheduleCreateRequest(meetingId: $meetingId, title: $title, description: $description, startAt: $startAt, endAt: $endAt, location: $location)';
}


}

/// @nodoc
abstract mixin class _$ScheduleCreateRequestCopyWith<$Res> implements $ScheduleCreateRequestCopyWith<$Res> {
  factory _$ScheduleCreateRequestCopyWith(_ScheduleCreateRequest value, $Res Function(_ScheduleCreateRequest) _then) = __$ScheduleCreateRequestCopyWithImpl;
@override @useResult
$Res call({
 int meetingId, String title, String description, DateTime startAt, DateTime? endAt, String location
});




}
/// @nodoc
class __$ScheduleCreateRequestCopyWithImpl<$Res>
    implements _$ScheduleCreateRequestCopyWith<$Res> {
  __$ScheduleCreateRequestCopyWithImpl(this._self, this._then);

  final _ScheduleCreateRequest _self;
  final $Res Function(_ScheduleCreateRequest) _then;

/// Create a copy of ScheduleCreateRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingId = null,Object? title = null,Object? description = null,Object? startAt = null,Object? endAt = freezed,Object? location = null,}) {
  return _then(_ScheduleCreateRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,endAt: freezed == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
