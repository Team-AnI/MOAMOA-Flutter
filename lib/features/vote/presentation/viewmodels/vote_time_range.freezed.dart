// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vote_time_range.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VoteTimeRange {

/// 하루 중 시작 시각 (0:00 부터 지난 시간)
 Duration get start;/// 하루 중 종료 시각. 이 시각은 후보에 들어가지 않습니다.
 Duration get end; VoteSlotInterval get interval;
/// Create a copy of VoteTimeRange
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoteTimeRangeCopyWith<VoteTimeRange> get copyWith => _$VoteTimeRangeCopyWithImpl<VoteTimeRange>(this as VoteTimeRange, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoteTimeRange&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.interval, interval) || other.interval == interval));
}


@override
int get hashCode => Object.hash(runtimeType,start,end,interval);

@override
String toString() {
  return 'VoteTimeRange(start: $start, end: $end, interval: $interval)';
}


}

/// @nodoc
abstract mixin class $VoteTimeRangeCopyWith<$Res>  {
  factory $VoteTimeRangeCopyWith(VoteTimeRange value, $Res Function(VoteTimeRange) _then) = _$VoteTimeRangeCopyWithImpl;
@useResult
$Res call({
 Duration start, Duration end, VoteSlotInterval interval
});




}
/// @nodoc
class _$VoteTimeRangeCopyWithImpl<$Res>
    implements $VoteTimeRangeCopyWith<$Res> {
  _$VoteTimeRangeCopyWithImpl(this._self, this._then);

  final VoteTimeRange _self;
  final $Res Function(VoteTimeRange) _then;

/// Create a copy of VoteTimeRange
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = null,Object? interval = null,}) {
  return _then(VoteTimeRange(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as Duration,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as Duration,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as VoteSlotInterval,
  ));
}

}


/// Adds pattern-matching-related methods to [VoteTimeRange].
extension VoteTimeRangePatterns on VoteTimeRange {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoteTimeRange value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoteTimeRange() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoteTimeRange value)  $default,){
final _that = this;
switch (_that) {
case _VoteTimeRange():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoteTimeRange value)?  $default,){
final _that = this;
switch (_that) {
case _VoteTimeRange() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Duration start,  Duration end,  VoteSlotInterval interval)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoteTimeRange() when $default != null:
return $default(_that.start,_that.end,_that.interval);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Duration start,  Duration end,  VoteSlotInterval interval)  $default,) {final _that = this;
switch (_that) {
case _VoteTimeRange():
return $default(_that.start,_that.end,_that.interval);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Duration start,  Duration end,  VoteSlotInterval interval)?  $default,) {final _that = this;
switch (_that) {
case _VoteTimeRange() when $default != null:
return $default(_that.start,_that.end,_that.interval);case _:
  return null;

}
}

}

/// @nodoc


class _VoteTimeRange implements VoteTimeRange {
  const _VoteTimeRange({this.start = const Duration(hours: 18), this.end = const Duration(hours: 20, minutes: 30), this.interval = VoteSlotInterval.thirtyMinutes});
  

/// 하루 중 시작 시각 (0:00 부터 지난 시간)
@override@JsonKey() final  Duration start;
/// 하루 중 종료 시각. 이 시각은 후보에 들어가지 않습니다.
@override@JsonKey() final  Duration end;
@override@JsonKey() final  VoteSlotInterval interval;

/// Create a copy of VoteTimeRange
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoteTimeRangeCopyWith<_VoteTimeRange> get copyWith => __$VoteTimeRangeCopyWithImpl<_VoteTimeRange>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoteTimeRange&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.interval, interval) || other.interval == interval));
}


@override
int get hashCode => Object.hash(runtimeType,start,end,interval);

@override
String toString() {
  return 'VoteTimeRange(start: $start, end: $end, interval: $interval)';
}


}

/// @nodoc
abstract mixin class _$VoteTimeRangeCopyWith<$Res> implements $VoteTimeRangeCopyWith<$Res> {
  factory _$VoteTimeRangeCopyWith(_VoteTimeRange value, $Res Function(_VoteTimeRange) _then) = __$VoteTimeRangeCopyWithImpl;
@override @useResult
$Res call({
 Duration start, Duration end, VoteSlotInterval interval
});




}
/// @nodoc
class __$VoteTimeRangeCopyWithImpl<$Res>
    implements _$VoteTimeRangeCopyWith<$Res> {
  __$VoteTimeRangeCopyWithImpl(this._self, this._then);

  final _VoteTimeRange _self;
  final $Res Function(_VoteTimeRange) _then;

/// Create a copy of VoteTimeRange
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,Object? interval = null,}) {
  return _then(_VoteTimeRange(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as Duration,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as Duration,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as VoteSlotInterval,
  ));
}


}

// dart format on
