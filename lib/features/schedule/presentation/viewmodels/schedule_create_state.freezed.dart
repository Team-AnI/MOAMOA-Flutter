// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_create_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScheduleCreateState {

 ScheduleCreateStatus get status;/// [status] 가 success 일 때만 값이 있습니다.
 CreatedSchedule? get created;
/// Create a copy of ScheduleCreateState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleCreateStateCopyWith<ScheduleCreateState> get copyWith => _$ScheduleCreateStateCopyWithImpl<ScheduleCreateState>(this as ScheduleCreateState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleCreateState&&(identical(other.status, status) || other.status == status)&&(identical(other.created, created) || other.created == created));
}


@override
int get hashCode => Object.hash(runtimeType,status,created);

@override
String toString() {
  return 'ScheduleCreateState(status: $status, created: $created)';
}


}

/// @nodoc
abstract mixin class $ScheduleCreateStateCopyWith<$Res>  {
  factory $ScheduleCreateStateCopyWith(ScheduleCreateState value, $Res Function(ScheduleCreateState) _then) = _$ScheduleCreateStateCopyWithImpl;
@useResult
$Res call({
 ScheduleCreateStatus status, CreatedSchedule? created
});


$CreatedScheduleCopyWith<$Res>? get created;

}
/// @nodoc
class _$ScheduleCreateStateCopyWithImpl<$Res>
    implements $ScheduleCreateStateCopyWith<$Res> {
  _$ScheduleCreateStateCopyWithImpl(this._self, this._then);

  final ScheduleCreateState _self;
  final $Res Function(ScheduleCreateState) _then;

/// Create a copy of ScheduleCreateState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? created = freezed,}) {
  return _then(ScheduleCreateState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ScheduleCreateStatus,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as CreatedSchedule?,
  ));
}
/// Create a copy of ScheduleCreateState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreatedScheduleCopyWith<$Res>? get created {
    if (_self.created == null) {
    return null;
  }

  return $CreatedScheduleCopyWith<$Res>(_self.created!, (value) {
    return _then(_self.copyWith(created: value));
  });
}
}


/// Adds pattern-matching-related methods to [ScheduleCreateState].
extension ScheduleCreateStatePatterns on ScheduleCreateState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleCreateState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleCreateState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleCreateState value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleCreateState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleCreateState value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleCreateState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ScheduleCreateStatus status,  CreatedSchedule? created)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleCreateState() when $default != null:
return $default(_that.status,_that.created);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ScheduleCreateStatus status,  CreatedSchedule? created)  $default,) {final _that = this;
switch (_that) {
case _ScheduleCreateState():
return $default(_that.status,_that.created);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ScheduleCreateStatus status,  CreatedSchedule? created)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleCreateState() when $default != null:
return $default(_that.status,_that.created);case _:
  return null;

}
}

}

/// @nodoc


class _ScheduleCreateState implements ScheduleCreateState {
  const _ScheduleCreateState({this.status = ScheduleCreateStatus.initial, this.created});
  

@override@JsonKey() final  ScheduleCreateStatus status;
/// [status] 가 success 일 때만 값이 있습니다.
@override final  CreatedSchedule? created;

/// Create a copy of ScheduleCreateState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleCreateStateCopyWith<_ScheduleCreateState> get copyWith => __$ScheduleCreateStateCopyWithImpl<_ScheduleCreateState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleCreateState&&(identical(other.status, status) || other.status == status)&&(identical(other.created, created) || other.created == created));
}


@override
int get hashCode => Object.hash(runtimeType,status,created);

@override
String toString() {
  return 'ScheduleCreateState(status: $status, created: $created)';
}


}

/// @nodoc
abstract mixin class _$ScheduleCreateStateCopyWith<$Res> implements $ScheduleCreateStateCopyWith<$Res> {
  factory _$ScheduleCreateStateCopyWith(_ScheduleCreateState value, $Res Function(_ScheduleCreateState) _then) = __$ScheduleCreateStateCopyWithImpl;
@override @useResult
$Res call({
 ScheduleCreateStatus status, CreatedSchedule? created
});


@override $CreatedScheduleCopyWith<$Res>? get created;

}
/// @nodoc
class __$ScheduleCreateStateCopyWithImpl<$Res>
    implements _$ScheduleCreateStateCopyWith<$Res> {
  __$ScheduleCreateStateCopyWithImpl(this._self, this._then);

  final _ScheduleCreateState _self;
  final $Res Function(_ScheduleCreateState) _then;

/// Create a copy of ScheduleCreateState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? created = freezed,}) {
  return _then(_ScheduleCreateState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ScheduleCreateStatus,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as CreatedSchedule?,
  ));
}

/// Create a copy of ScheduleCreateState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreatedScheduleCopyWith<$Res>? get created {
    if (_self.created == null) {
    return null;
  }

  return $CreatedScheduleCopyWith<$Res>(_self.created!, (value) {
    return _then(_self.copyWith(created: value));
  });
}
}

// dart format on
