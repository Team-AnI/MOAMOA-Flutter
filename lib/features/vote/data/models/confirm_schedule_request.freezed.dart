// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'confirm_schedule_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConfirmScheduleRequest {

@JsonKey(includeToJson: false) int get meetingId;@JsonKey(includeToJson: false) int get scheduleId; String get meetingTime;
/// Create a copy of ConfirmScheduleRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfirmScheduleRequestCopyWith<ConfirmScheduleRequest> get copyWith => _$ConfirmScheduleRequestCopyWithImpl<ConfirmScheduleRequest>(this as ConfirmScheduleRequest, _$identity);

  /// Serializes this ConfirmScheduleRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfirmScheduleRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId)&&(identical(other.meetingTime, meetingTime) || other.meetingTime == meetingTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meetingId,scheduleId,meetingTime);

@override
String toString() {
  return 'ConfirmScheduleRequest(meetingId: $meetingId, scheduleId: $scheduleId, meetingTime: $meetingTime)';
}


}

/// @nodoc
abstract mixin class $ConfirmScheduleRequestCopyWith<$Res>  {
  factory $ConfirmScheduleRequestCopyWith(ConfirmScheduleRequest value, $Res Function(ConfirmScheduleRequest) _then) = _$ConfirmScheduleRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false) int meetingId,@JsonKey(includeToJson: false) int scheduleId, String meetingTime
});




}
/// @nodoc
class _$ConfirmScheduleRequestCopyWithImpl<$Res>
    implements $ConfirmScheduleRequestCopyWith<$Res> {
  _$ConfirmScheduleRequestCopyWithImpl(this._self, this._then);

  final ConfirmScheduleRequest _self;
  final $Res Function(ConfirmScheduleRequest) _then;

/// Create a copy of ConfirmScheduleRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingId = null,Object? scheduleId = null,Object? meetingTime = null,}) {
  return _then(ConfirmScheduleRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,scheduleId: null == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as int,meetingTime: null == meetingTime ? _self.meetingTime : meetingTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ConfirmScheduleRequest].
extension ConfirmScheduleRequestPatterns on ConfirmScheduleRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConfirmScheduleRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConfirmScheduleRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConfirmScheduleRequest value)  $default,){
final _that = this;
switch (_that) {
case _ConfirmScheduleRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConfirmScheduleRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ConfirmScheduleRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  int meetingId, @JsonKey(includeToJson: false)  int scheduleId,  String meetingTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConfirmScheduleRequest() when $default != null:
return $default(_that.meetingId,_that.scheduleId,_that.meetingTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  int meetingId, @JsonKey(includeToJson: false)  int scheduleId,  String meetingTime)  $default,) {final _that = this;
switch (_that) {
case _ConfirmScheduleRequest():
return $default(_that.meetingId,_that.scheduleId,_that.meetingTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false)  int meetingId, @JsonKey(includeToJson: false)  int scheduleId,  String meetingTime)?  $default,) {final _that = this;
switch (_that) {
case _ConfirmScheduleRequest() when $default != null:
return $default(_that.meetingId,_that.scheduleId,_that.meetingTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConfirmScheduleRequest implements ConfirmScheduleRequest {
  const _ConfirmScheduleRequest({@JsonKey(includeToJson: false) required this.meetingId, @JsonKey(includeToJson: false) required this.scheduleId, required this.meetingTime});
  factory _ConfirmScheduleRequest.fromJson(Map<String, dynamic> json) => _$ConfirmScheduleRequestFromJson(json);

@override@JsonKey(includeToJson: false) final  int meetingId;
@override@JsonKey(includeToJson: false) final  int scheduleId;
@override final  String meetingTime;

/// Create a copy of ConfirmScheduleRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfirmScheduleRequestCopyWith<_ConfirmScheduleRequest> get copyWith => __$ConfirmScheduleRequestCopyWithImpl<_ConfirmScheduleRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConfirmScheduleRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmScheduleRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId)&&(identical(other.meetingTime, meetingTime) || other.meetingTime == meetingTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meetingId,scheduleId,meetingTime);

@override
String toString() {
  return 'ConfirmScheduleRequest(meetingId: $meetingId, scheduleId: $scheduleId, meetingTime: $meetingTime)';
}


}

/// @nodoc
abstract mixin class _$ConfirmScheduleRequestCopyWith<$Res> implements $ConfirmScheduleRequestCopyWith<$Res> {
  factory _$ConfirmScheduleRequestCopyWith(_ConfirmScheduleRequest value, $Res Function(_ConfirmScheduleRequest) _then) = __$ConfirmScheduleRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false) int meetingId,@JsonKey(includeToJson: false) int scheduleId, String meetingTime
});




}
/// @nodoc
class __$ConfirmScheduleRequestCopyWithImpl<$Res>
    implements _$ConfirmScheduleRequestCopyWith<$Res> {
  __$ConfirmScheduleRequestCopyWithImpl(this._self, this._then);

  final _ConfirmScheduleRequest _self;
  final $Res Function(_ConfirmScheduleRequest) _then;

/// Create a copy of ConfirmScheduleRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingId = null,Object? scheduleId = null,Object? meetingTime = null,}) {
  return _then(_ConfirmScheduleRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,scheduleId: null == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as int,meetingTime: null == meetingTime ? _self.meetingTime : meetingTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
