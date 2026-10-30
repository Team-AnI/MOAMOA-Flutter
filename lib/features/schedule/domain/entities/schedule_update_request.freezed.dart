// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_update_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScheduleUpdateRequest {

 int get meetingId; int get scheduleId; String? get title; String? get description; DateTime? get startAt; DateTime? get endAt; String? get location;
/// Create a copy of ScheduleUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleUpdateRequestCopyWith<ScheduleUpdateRequest> get copyWith => _$ScheduleUpdateRequestCopyWithImpl<ScheduleUpdateRequest>(this as ScheduleUpdateRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleUpdateRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,scheduleId,title,description,startAt,endAt,location);

@override
String toString() {
  return 'ScheduleUpdateRequest(meetingId: $meetingId, scheduleId: $scheduleId, title: $title, description: $description, startAt: $startAt, endAt: $endAt, location: $location)';
}


}

/// @nodoc
abstract mixin class $ScheduleUpdateRequestCopyWith<$Res>  {
  factory $ScheduleUpdateRequestCopyWith(ScheduleUpdateRequest value, $Res Function(ScheduleUpdateRequest) _then) = _$ScheduleUpdateRequestCopyWithImpl;
@useResult
$Res call({
 int meetingId, int scheduleId, String? title, String? description, DateTime? startAt, DateTime? endAt, String? location
});




}
/// @nodoc
class _$ScheduleUpdateRequestCopyWithImpl<$Res>
    implements $ScheduleUpdateRequestCopyWith<$Res> {
  _$ScheduleUpdateRequestCopyWithImpl(this._self, this._then);

  final ScheduleUpdateRequest _self;
  final $Res Function(ScheduleUpdateRequest) _then;

/// Create a copy of ScheduleUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingId = null,Object? scheduleId = null,Object? title = freezed,Object? description = freezed,Object? startAt = freezed,Object? endAt = freezed,Object? location = freezed,}) {
  return _then(ScheduleUpdateRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,scheduleId: null == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startAt: freezed == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endAt: freezed == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduleUpdateRequest].
extension ScheduleUpdateRequestPatterns on ScheduleUpdateRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleUpdateRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleUpdateRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleUpdateRequest value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleUpdateRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleUpdateRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleUpdateRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int meetingId,  int scheduleId,  String? title,  String? description,  DateTime? startAt,  DateTime? endAt,  String? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleUpdateRequest() when $default != null:
return $default(_that.meetingId,_that.scheduleId,_that.title,_that.description,_that.startAt,_that.endAt,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int meetingId,  int scheduleId,  String? title,  String? description,  DateTime? startAt,  DateTime? endAt,  String? location)  $default,) {final _that = this;
switch (_that) {
case _ScheduleUpdateRequest():
return $default(_that.meetingId,_that.scheduleId,_that.title,_that.description,_that.startAt,_that.endAt,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int meetingId,  int scheduleId,  String? title,  String? description,  DateTime? startAt,  DateTime? endAt,  String? location)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleUpdateRequest() when $default != null:
return $default(_that.meetingId,_that.scheduleId,_that.title,_that.description,_that.startAt,_that.endAt,_that.location);case _:
  return null;

}
}

}

/// @nodoc


class _ScheduleUpdateRequest implements ScheduleUpdateRequest {
  const _ScheduleUpdateRequest({required this.meetingId, required this.scheduleId, this.title, this.description, this.startAt, this.endAt, this.location});
  

@override final  int meetingId;
@override final  int scheduleId;
@override final  String? title;
@override final  String? description;
@override final  DateTime? startAt;
@override final  DateTime? endAt;
@override final  String? location;

/// Create a copy of ScheduleUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleUpdateRequestCopyWith<_ScheduleUpdateRequest> get copyWith => __$ScheduleUpdateRequestCopyWithImpl<_ScheduleUpdateRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleUpdateRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,scheduleId,title,description,startAt,endAt,location);

@override
String toString() {
  return 'ScheduleUpdateRequest(meetingId: $meetingId, scheduleId: $scheduleId, title: $title, description: $description, startAt: $startAt, endAt: $endAt, location: $location)';
}


}

/// @nodoc
abstract mixin class _$ScheduleUpdateRequestCopyWith<$Res> implements $ScheduleUpdateRequestCopyWith<$Res> {
  factory _$ScheduleUpdateRequestCopyWith(_ScheduleUpdateRequest value, $Res Function(_ScheduleUpdateRequest) _then) = __$ScheduleUpdateRequestCopyWithImpl;
@override @useResult
$Res call({
 int meetingId, int scheduleId, String? title, String? description, DateTime? startAt, DateTime? endAt, String? location
});




}
/// @nodoc
class __$ScheduleUpdateRequestCopyWithImpl<$Res>
    implements _$ScheduleUpdateRequestCopyWith<$Res> {
  __$ScheduleUpdateRequestCopyWithImpl(this._self, this._then);

  final _ScheduleUpdateRequest _self;
  final $Res Function(_ScheduleUpdateRequest) _then;

/// Create a copy of ScheduleUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingId = null,Object? scheduleId = null,Object? title = freezed,Object? description = freezed,Object? startAt = freezed,Object? endAt = freezed,Object? location = freezed,}) {
  return _then(_ScheduleUpdateRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,scheduleId: null == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startAt: freezed == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endAt: freezed == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
