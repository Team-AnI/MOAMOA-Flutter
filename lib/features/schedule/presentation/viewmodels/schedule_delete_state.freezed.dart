// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_delete_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScheduleDeleteState {

 ScheduleDeleteStatus get status;
/// Create a copy of ScheduleDeleteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleDeleteStateCopyWith<ScheduleDeleteState> get copyWith => _$ScheduleDeleteStateCopyWithImpl<ScheduleDeleteState>(this as ScheduleDeleteState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleDeleteState&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'ScheduleDeleteState(status: $status)';
}


}

/// @nodoc
abstract mixin class $ScheduleDeleteStateCopyWith<$Res>  {
  factory $ScheduleDeleteStateCopyWith(ScheduleDeleteState value, $Res Function(ScheduleDeleteState) _then) = _$ScheduleDeleteStateCopyWithImpl;
@useResult
$Res call({
 ScheduleDeleteStatus status
});




}
/// @nodoc
class _$ScheduleDeleteStateCopyWithImpl<$Res>
    implements $ScheduleDeleteStateCopyWith<$Res> {
  _$ScheduleDeleteStateCopyWithImpl(this._self, this._then);

  final ScheduleDeleteState _self;
  final $Res Function(ScheduleDeleteState) _then;

/// Create a copy of ScheduleDeleteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,}) {
  return _then(ScheduleDeleteState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ScheduleDeleteStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduleDeleteState].
extension ScheduleDeleteStatePatterns on ScheduleDeleteState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleDeleteState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleDeleteState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleDeleteState value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleDeleteState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleDeleteState value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleDeleteState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ScheduleDeleteStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleDeleteState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ScheduleDeleteStatus status)  $default,) {final _that = this;
switch (_that) {
case _ScheduleDeleteState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ScheduleDeleteStatus status)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleDeleteState() when $default != null:
return $default(_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _ScheduleDeleteState implements ScheduleDeleteState {
  const _ScheduleDeleteState({this.status = ScheduleDeleteStatus.initial});
  

@override@JsonKey() final  ScheduleDeleteStatus status;

/// Create a copy of ScheduleDeleteState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleDeleteStateCopyWith<_ScheduleDeleteState> get copyWith => __$ScheduleDeleteStateCopyWithImpl<_ScheduleDeleteState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleDeleteState&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'ScheduleDeleteState(status: $status)';
}


}

/// @nodoc
abstract mixin class _$ScheduleDeleteStateCopyWith<$Res> implements $ScheduleDeleteStateCopyWith<$Res> {
  factory _$ScheduleDeleteStateCopyWith(_ScheduleDeleteState value, $Res Function(_ScheduleDeleteState) _then) = __$ScheduleDeleteStateCopyWithImpl;
@override @useResult
$Res call({
 ScheduleDeleteStatus status
});




}
/// @nodoc
class __$ScheduleDeleteStateCopyWithImpl<$Res>
    implements _$ScheduleDeleteStateCopyWith<$Res> {
  __$ScheduleDeleteStateCopyWithImpl(this._self, this._then);

  final _ScheduleDeleteState _self;
  final $Res Function(_ScheduleDeleteState) _then;

/// Create a copy of ScheduleDeleteState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_ScheduleDeleteState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ScheduleDeleteStatus,
  ));
}


}

// dart format on
