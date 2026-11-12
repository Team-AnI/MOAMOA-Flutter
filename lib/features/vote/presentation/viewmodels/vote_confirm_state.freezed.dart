// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vote_confirm_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VoteConfirmState {

 VoteConfirmStatus get status; String? get errorMessage;
/// Create a copy of VoteConfirmState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoteConfirmStateCopyWith<VoteConfirmState> get copyWith => _$VoteConfirmStateCopyWithImpl<VoteConfirmState>(this as VoteConfirmState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoteConfirmState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage);

@override
String toString() {
  return 'VoteConfirmState(status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $VoteConfirmStateCopyWith<$Res>  {
  factory $VoteConfirmStateCopyWith(VoteConfirmState value, $Res Function(VoteConfirmState) _then) = _$VoteConfirmStateCopyWithImpl;
@useResult
$Res call({
 VoteConfirmStatus status, String? errorMessage
});




}
/// @nodoc
class _$VoteConfirmStateCopyWithImpl<$Res>
    implements $VoteConfirmStateCopyWith<$Res> {
  _$VoteConfirmStateCopyWithImpl(this._self, this._then);

  final VoteConfirmState _self;
  final $Res Function(VoteConfirmState) _then;

/// Create a copy of VoteConfirmState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorMessage = freezed,}) {
  return _then(VoteConfirmState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VoteConfirmStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VoteConfirmState].
extension VoteConfirmStatePatterns on VoteConfirmState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoteConfirmState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoteConfirmState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoteConfirmState value)  $default,){
final _that = this;
switch (_that) {
case _VoteConfirmState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoteConfirmState value)?  $default,){
final _that = this;
switch (_that) {
case _VoteConfirmState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( VoteConfirmStatus status,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoteConfirmState() when $default != null:
return $default(_that.status,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( VoteConfirmStatus status,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _VoteConfirmState():
return $default(_that.status,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( VoteConfirmStatus status,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _VoteConfirmState() when $default != null:
return $default(_that.status,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _VoteConfirmState implements VoteConfirmState {
  const _VoteConfirmState({this.status = VoteConfirmStatus.initial, this.errorMessage});
  

@override@JsonKey() final  VoteConfirmStatus status;
@override final  String? errorMessage;

/// Create a copy of VoteConfirmState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoteConfirmStateCopyWith<_VoteConfirmState> get copyWith => __$VoteConfirmStateCopyWithImpl<_VoteConfirmState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoteConfirmState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage);

@override
String toString() {
  return 'VoteConfirmState(status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$VoteConfirmStateCopyWith<$Res> implements $VoteConfirmStateCopyWith<$Res> {
  factory _$VoteConfirmStateCopyWith(_VoteConfirmState value, $Res Function(_VoteConfirmState) _then) = __$VoteConfirmStateCopyWithImpl;
@override @useResult
$Res call({
 VoteConfirmStatus status, String? errorMessage
});




}
/// @nodoc
class __$VoteConfirmStateCopyWithImpl<$Res>
    implements _$VoteConfirmStateCopyWith<$Res> {
  __$VoteConfirmStateCopyWithImpl(this._self, this._then);

  final _VoteConfirmState _self;
  final $Res Function(_VoteConfirmState) _then;

/// Create a copy of VoteConfirmState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorMessage = freezed,}) {
  return _then(_VoteConfirmState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VoteConfirmStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
