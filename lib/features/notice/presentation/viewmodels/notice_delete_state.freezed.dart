// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notice_delete_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NoticeDeleteState {

 NoticeDeleteStatus get status;/// [status] 가 failure 일 때만 값이 있습니다.
 Object? get error;
/// Create a copy of NoticeDeleteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoticeDeleteStateCopyWith<NoticeDeleteState> get copyWith => _$NoticeDeleteStateCopyWithImpl<NoticeDeleteState>(this as NoticeDeleteState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoticeDeleteState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'NoticeDeleteState(status: $status, error: $error)';
}


}

/// @nodoc
abstract mixin class $NoticeDeleteStateCopyWith<$Res>  {
  factory $NoticeDeleteStateCopyWith(NoticeDeleteState value, $Res Function(NoticeDeleteState) _then) = _$NoticeDeleteStateCopyWithImpl;
@useResult
$Res call({
 NoticeDeleteStatus status, Object? error
});




}
/// @nodoc
class _$NoticeDeleteStateCopyWithImpl<$Res>
    implements $NoticeDeleteStateCopyWith<$Res> {
  _$NoticeDeleteStateCopyWithImpl(this._self, this._then);

  final NoticeDeleteState _self;
  final $Res Function(NoticeDeleteState) _then;

/// Create a copy of NoticeDeleteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,}) {
  return _then(NoticeDeleteState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NoticeDeleteStatus,error: freezed == error ? _self.error : error ,
  ));
}

}


/// Adds pattern-matching-related methods to [NoticeDeleteState].
extension NoticeDeleteStatePatterns on NoticeDeleteState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoticeDeleteState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoticeDeleteState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoticeDeleteState value)  $default,){
final _that = this;
switch (_that) {
case _NoticeDeleteState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoticeDeleteState value)?  $default,){
final _that = this;
switch (_that) {
case _NoticeDeleteState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NoticeDeleteStatus status,  Object? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoticeDeleteState() when $default != null:
return $default(_that.status,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NoticeDeleteStatus status,  Object? error)  $default,) {final _that = this;
switch (_that) {
case _NoticeDeleteState():
return $default(_that.status,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NoticeDeleteStatus status,  Object? error)?  $default,) {final _that = this;
switch (_that) {
case _NoticeDeleteState() when $default != null:
return $default(_that.status,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _NoticeDeleteState implements NoticeDeleteState {
  const _NoticeDeleteState({this.status = NoticeDeleteStatus.initial, this.error});
  

@override@JsonKey() final  NoticeDeleteStatus status;
/// [status] 가 failure 일 때만 값이 있습니다.
@override final  Object? error;

/// Create a copy of NoticeDeleteState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoticeDeleteStateCopyWith<_NoticeDeleteState> get copyWith => __$NoticeDeleteStateCopyWithImpl<_NoticeDeleteState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoticeDeleteState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'NoticeDeleteState(status: $status, error: $error)';
}


}

/// @nodoc
abstract mixin class _$NoticeDeleteStateCopyWith<$Res> implements $NoticeDeleteStateCopyWith<$Res> {
  factory _$NoticeDeleteStateCopyWith(_NoticeDeleteState value, $Res Function(_NoticeDeleteState) _then) = __$NoticeDeleteStateCopyWithImpl;
@override @useResult
$Res call({
 NoticeDeleteStatus status, Object? error
});




}
/// @nodoc
class __$NoticeDeleteStateCopyWithImpl<$Res>
    implements _$NoticeDeleteStateCopyWith<$Res> {
  __$NoticeDeleteStateCopyWithImpl(this._self, this._then);

  final _NoticeDeleteState _self;
  final $Res Function(_NoticeDeleteState) _then;

/// Create a copy of NoticeDeleteState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,}) {
  return _then(_NoticeDeleteState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NoticeDeleteStatus,error: freezed == error ? _self.error : error ,
  ));
}


}

// dart format on
