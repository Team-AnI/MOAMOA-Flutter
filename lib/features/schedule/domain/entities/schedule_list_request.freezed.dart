// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_list_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScheduleListRequest {

 int get meetingId; DateTime get startDate; DateTime get endDate;
/// Create a copy of ScheduleListRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleListRequestCopyWith<ScheduleListRequest> get copyWith => _$ScheduleListRequestCopyWithImpl<ScheduleListRequest>(this as ScheduleListRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleListRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,startDate,endDate);

@override
String toString() {
  return 'ScheduleListRequest(meetingId: $meetingId, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class $ScheduleListRequestCopyWith<$Res>  {
  factory $ScheduleListRequestCopyWith(ScheduleListRequest value, $Res Function(ScheduleListRequest) _then) = _$ScheduleListRequestCopyWithImpl;
@useResult
$Res call({
 int meetingId, DateTime startDate, DateTime endDate
});




}
/// @nodoc
class _$ScheduleListRequestCopyWithImpl<$Res>
    implements $ScheduleListRequestCopyWith<$Res> {
  _$ScheduleListRequestCopyWithImpl(this._self, this._then);

  final ScheduleListRequest _self;
  final $Res Function(ScheduleListRequest) _then;

/// Create a copy of ScheduleListRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingId = null,Object? startDate = null,Object? endDate = null,}) {
  return _then(ScheduleListRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduleListRequest].
extension ScheduleListRequestPatterns on ScheduleListRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleListRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleListRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleListRequest value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleListRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleListRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleListRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int meetingId,  DateTime startDate,  DateTime endDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleListRequest() when $default != null:
return $default(_that.meetingId,_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int meetingId,  DateTime startDate,  DateTime endDate)  $default,) {final _that = this;
switch (_that) {
case _ScheduleListRequest():
return $default(_that.meetingId,_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int meetingId,  DateTime startDate,  DateTime endDate)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleListRequest() when $default != null:
return $default(_that.meetingId,_that.startDate,_that.endDate);case _:
  return null;

}
}

}

/// @nodoc


class _ScheduleListRequest implements ScheduleListRequest {
  const _ScheduleListRequest({required this.meetingId, required this.startDate, required this.endDate});
  

@override final  int meetingId;
@override final  DateTime startDate;
@override final  DateTime endDate;

/// Create a copy of ScheduleListRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleListRequestCopyWith<_ScheduleListRequest> get copyWith => __$ScheduleListRequestCopyWithImpl<_ScheduleListRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleListRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,startDate,endDate);

@override
String toString() {
  return 'ScheduleListRequest(meetingId: $meetingId, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class _$ScheduleListRequestCopyWith<$Res> implements $ScheduleListRequestCopyWith<$Res> {
  factory _$ScheduleListRequestCopyWith(_ScheduleListRequest value, $Res Function(_ScheduleListRequest) _then) = __$ScheduleListRequestCopyWithImpl;
@override @useResult
$Res call({
 int meetingId, DateTime startDate, DateTime endDate
});




}
/// @nodoc
class __$ScheduleListRequestCopyWithImpl<$Res>
    implements _$ScheduleListRequestCopyWith<$Res> {
  __$ScheduleListRequestCopyWithImpl(this._self, this._then);

  final _ScheduleListRequest _self;
  final $Res Function(_ScheduleListRequest) _then;

/// Create a copy of ScheduleListRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingId = null,Object? startDate = null,Object? endDate = null,}) {
  return _then(_ScheduleListRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
