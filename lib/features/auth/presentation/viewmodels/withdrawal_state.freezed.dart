// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'withdrawal_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WithdrawalState {

 WithdrawalStatus get status;/// [status] 가 failure 일 때만 값이 있습니다.
 Object? get error;
/// Create a copy of WithdrawalState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WithdrawalStateCopyWith<WithdrawalState> get copyWith => _$WithdrawalStateCopyWithImpl<WithdrawalState>(this as WithdrawalState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WithdrawalState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'WithdrawalState(status: $status, error: $error)';
}


}

/// @nodoc
abstract mixin class $WithdrawalStateCopyWith<$Res>  {
  factory $WithdrawalStateCopyWith(WithdrawalState value, $Res Function(WithdrawalState) _then) = _$WithdrawalStateCopyWithImpl;
@useResult
$Res call({
 WithdrawalStatus status, Object? error
});




}
/// @nodoc
class _$WithdrawalStateCopyWithImpl<$Res>
    implements $WithdrawalStateCopyWith<$Res> {
  _$WithdrawalStateCopyWithImpl(this._self, this._then);

  final WithdrawalState _self;
  final $Res Function(WithdrawalState) _then;

/// Create a copy of WithdrawalState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? error = freezed,}) {
  return _then(WithdrawalState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as WithdrawalStatus,error: freezed == error ? _self.error : error ,
  ));
}

}


/// Adds pattern-matching-related methods to [WithdrawalState].
extension WithdrawalStatePatterns on WithdrawalState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WithdrawalState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WithdrawalState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WithdrawalState value)  $default,){
final _that = this;
switch (_that) {
case _WithdrawalState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WithdrawalState value)?  $default,){
final _that = this;
switch (_that) {
case _WithdrawalState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( WithdrawalStatus status,  Object? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WithdrawalState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( WithdrawalStatus status,  Object? error)  $default,) {final _that = this;
switch (_that) {
case _WithdrawalState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( WithdrawalStatus status,  Object? error)?  $default,) {final _that = this;
switch (_that) {
case _WithdrawalState() when $default != null:
return $default(_that.status,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _WithdrawalState implements WithdrawalState {
  const _WithdrawalState({this.status = WithdrawalStatus.initial, this.error});
  

@override@JsonKey() final  WithdrawalStatus status;
/// [status] 가 failure 일 때만 값이 있습니다.
@override final  Object? error;

/// Create a copy of WithdrawalState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WithdrawalStateCopyWith<_WithdrawalState> get copyWith => __$WithdrawalStateCopyWithImpl<_WithdrawalState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WithdrawalState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'WithdrawalState(status: $status, error: $error)';
}


}

/// @nodoc
abstract mixin class _$WithdrawalStateCopyWith<$Res> implements $WithdrawalStateCopyWith<$Res> {
  factory _$WithdrawalStateCopyWith(_WithdrawalState value, $Res Function(_WithdrawalState) _then) = __$WithdrawalStateCopyWithImpl;
@override @useResult
$Res call({
 WithdrawalStatus status, Object? error
});




}
/// @nodoc
class __$WithdrawalStateCopyWithImpl<$Res>
    implements _$WithdrawalStateCopyWith<$Res> {
  __$WithdrawalStateCopyWithImpl(this._self, this._then);

  final _WithdrawalState _self;
  final $Res Function(_WithdrawalState) _then;

/// Create a copy of WithdrawalState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? error = freezed,}) {
  return _then(_WithdrawalState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as WithdrawalStatus,error: freezed == error ? _self.error : error ,
  ));
}


}

// dart format on
