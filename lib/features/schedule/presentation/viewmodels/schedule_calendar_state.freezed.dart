// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_calendar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScheduleCalendarState {

/// 보고 있는 달의 1일입니다.
 DateTime get month;/// 선택한 날짜(시각 제외)입니다.
 DateTime get selected;
/// Create a copy of ScheduleCalendarState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleCalendarStateCopyWith<ScheduleCalendarState> get copyWith => _$ScheduleCalendarStateCopyWithImpl<ScheduleCalendarState>(this as ScheduleCalendarState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleCalendarState&&(identical(other.month, month) || other.month == month)&&(identical(other.selected, selected) || other.selected == selected));
}


@override
int get hashCode => Object.hash(runtimeType,month,selected);

@override
String toString() {
  return 'ScheduleCalendarState(month: $month, selected: $selected)';
}


}

/// @nodoc
abstract mixin class $ScheduleCalendarStateCopyWith<$Res>  {
  factory $ScheduleCalendarStateCopyWith(ScheduleCalendarState value, $Res Function(ScheduleCalendarState) _then) = _$ScheduleCalendarStateCopyWithImpl;
@useResult
$Res call({
 DateTime month, DateTime selected
});




}
/// @nodoc
class _$ScheduleCalendarStateCopyWithImpl<$Res>
    implements $ScheduleCalendarStateCopyWith<$Res> {
  _$ScheduleCalendarStateCopyWithImpl(this._self, this._then);

  final ScheduleCalendarState _self;
  final $Res Function(ScheduleCalendarState) _then;

/// Create a copy of ScheduleCalendarState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = null,Object? selected = null,}) {
  return _then(ScheduleCalendarState(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as DateTime,selected: null == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduleCalendarState].
extension ScheduleCalendarStatePatterns on ScheduleCalendarState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleCalendarState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleCalendarState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleCalendarState value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleCalendarState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleCalendarState value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleCalendarState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime month,  DateTime selected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleCalendarState() when $default != null:
return $default(_that.month,_that.selected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime month,  DateTime selected)  $default,) {final _that = this;
switch (_that) {
case _ScheduleCalendarState():
return $default(_that.month,_that.selected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime month,  DateTime selected)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleCalendarState() when $default != null:
return $default(_that.month,_that.selected);case _:
  return null;

}
}

}

/// @nodoc


class _ScheduleCalendarState implements ScheduleCalendarState {
  const _ScheduleCalendarState({required this.month, required this.selected});
  

/// 보고 있는 달의 1일입니다.
@override final  DateTime month;
/// 선택한 날짜(시각 제외)입니다.
@override final  DateTime selected;

/// Create a copy of ScheduleCalendarState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleCalendarStateCopyWith<_ScheduleCalendarState> get copyWith => __$ScheduleCalendarStateCopyWithImpl<_ScheduleCalendarState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleCalendarState&&(identical(other.month, month) || other.month == month)&&(identical(other.selected, selected) || other.selected == selected));
}


@override
int get hashCode => Object.hash(runtimeType,month,selected);

@override
String toString() {
  return 'ScheduleCalendarState(month: $month, selected: $selected)';
}


}

/// @nodoc
abstract mixin class _$ScheduleCalendarStateCopyWith<$Res> implements $ScheduleCalendarStateCopyWith<$Res> {
  factory _$ScheduleCalendarStateCopyWith(_ScheduleCalendarState value, $Res Function(_ScheduleCalendarState) _then) = __$ScheduleCalendarStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime month, DateTime selected
});




}
/// @nodoc
class __$ScheduleCalendarStateCopyWithImpl<$Res>
    implements _$ScheduleCalendarStateCopyWith<$Res> {
  __$ScheduleCalendarStateCopyWithImpl(this._self, this._then);

  final _ScheduleCalendarState _self;
  final $Res Function(_ScheduleCalendarState) _then;

/// Create a copy of ScheduleCalendarState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = null,Object? selected = null,}) {
  return _then(_ScheduleCalendarState(
month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as DateTime,selected: null == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
