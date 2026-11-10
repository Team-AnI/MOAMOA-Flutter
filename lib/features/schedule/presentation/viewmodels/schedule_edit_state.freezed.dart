// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_edit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScheduleEditState {

 ScheduleEditStatus get status;
/// Create a copy of ScheduleEditState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleEditStateCopyWith<ScheduleEditState> get copyWith => _$ScheduleEditStateCopyWithImpl<ScheduleEditState>(this as ScheduleEditState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleEditState&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'ScheduleEditState(status: $status)';
}


}

/// @nodoc
abstract mixin class $ScheduleEditStateCopyWith<$Res>  {
  factory $ScheduleEditStateCopyWith(ScheduleEditState value, $Res Function(ScheduleEditState) _then) = _$ScheduleEditStateCopyWithImpl;
@useResult
$Res call({
 ScheduleEditStatus status
});




}
/// @nodoc
class _$ScheduleEditStateCopyWithImpl<$Res>
    implements $ScheduleEditStateCopyWith<$Res> {
  _$ScheduleEditStateCopyWithImpl(this._self, this._then);

  final ScheduleEditState _self;
  final $Res Function(ScheduleEditState) _then;

/// Create a copy of ScheduleEditState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,}) {
  return _then(ScheduleEditState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ScheduleEditStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduleEditState].
extension ScheduleEditStatePatterns on ScheduleEditState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleEditState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleEditState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleEditState value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleEditState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleEditState value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleEditState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ScheduleEditStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleEditState() when $default != null:
return $default(_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ScheduleEditStatus status)  $default,) {final _that = this;
switch (_that) {
case _ScheduleEditState():
return $default(_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ScheduleEditStatus status)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleEditState() when $default != null:
return $default(_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _ScheduleEditState implements ScheduleEditState {
  const _ScheduleEditState({this.status = ScheduleEditStatus.initial});
  

@override@JsonKey() final  ScheduleEditStatus status;

/// Create a copy of ScheduleEditState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleEditStateCopyWith<_ScheduleEditState> get copyWith => __$ScheduleEditStateCopyWithImpl<_ScheduleEditState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleEditState&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'ScheduleEditState(status: $status)';
}


}

/// @nodoc
abstract mixin class _$ScheduleEditStateCopyWith<$Res> implements $ScheduleEditStateCopyWith<$Res> {
  factory _$ScheduleEditStateCopyWith(_ScheduleEditState value, $Res Function(_ScheduleEditState) _then) = __$ScheduleEditStateCopyWithImpl;
@override @useResult
$Res call({
 ScheduleEditStatus status
});




}
/// @nodoc
class __$ScheduleEditStateCopyWithImpl<$Res>
    implements _$ScheduleEditStateCopyWith<$Res> {
  __$ScheduleEditStateCopyWithImpl(this._self, this._then);

  final _ScheduleEditState _self;
  final $Res Function(_ScheduleEditState) _then;

/// Create a copy of ScheduleEditState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_ScheduleEditState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ScheduleEditStatus,
  ));
}


}

// dart format on
