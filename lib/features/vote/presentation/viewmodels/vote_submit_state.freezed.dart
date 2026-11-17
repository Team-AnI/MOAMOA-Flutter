// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vote_submit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VoteSubmitState {

 VoteSubmitStatus get status; String? get errorMessage;
/// Create a copy of VoteSubmitState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoteSubmitStateCopyWith<VoteSubmitState> get copyWith => _$VoteSubmitStateCopyWithImpl<VoteSubmitState>(this as VoteSubmitState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoteSubmitState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage);

@override
String toString() {
  return 'VoteSubmitState(status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $VoteSubmitStateCopyWith<$Res>  {
  factory $VoteSubmitStateCopyWith(VoteSubmitState value, $Res Function(VoteSubmitState) _then) = _$VoteSubmitStateCopyWithImpl;
@useResult
$Res call({
 VoteSubmitStatus status, String? errorMessage
});




}
/// @nodoc
class _$VoteSubmitStateCopyWithImpl<$Res>
    implements $VoteSubmitStateCopyWith<$Res> {
  _$VoteSubmitStateCopyWithImpl(this._self, this._then);

  final VoteSubmitState _self;
  final $Res Function(VoteSubmitState) _then;

/// Create a copy of VoteSubmitState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorMessage = freezed,}) {
  return _then(VoteSubmitState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VoteSubmitStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VoteSubmitState].
extension VoteSubmitStatePatterns on VoteSubmitState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoteSubmitState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoteSubmitState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoteSubmitState value)  $default,){
final _that = this;
switch (_that) {
case _VoteSubmitState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoteSubmitState value)?  $default,){
final _that = this;
switch (_that) {
case _VoteSubmitState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( VoteSubmitStatus status,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoteSubmitState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( VoteSubmitStatus status,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _VoteSubmitState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( VoteSubmitStatus status,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _VoteSubmitState() when $default != null:
return $default(_that.status,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _VoteSubmitState implements VoteSubmitState {
  const _VoteSubmitState({this.status = VoteSubmitStatus.initial, this.errorMessage});
  

@override@JsonKey() final  VoteSubmitStatus status;
@override final  String? errorMessage;

/// Create a copy of VoteSubmitState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoteSubmitStateCopyWith<_VoteSubmitState> get copyWith => __$VoteSubmitStateCopyWithImpl<_VoteSubmitState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoteSubmitState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,errorMessage);

@override
String toString() {
  return 'VoteSubmitState(status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$VoteSubmitStateCopyWith<$Res> implements $VoteSubmitStateCopyWith<$Res> {
  factory _$VoteSubmitStateCopyWith(_VoteSubmitState value, $Res Function(_VoteSubmitState) _then) = __$VoteSubmitStateCopyWithImpl;
@override @useResult
$Res call({
 VoteSubmitStatus status, String? errorMessage
});




}
/// @nodoc
class __$VoteSubmitStateCopyWithImpl<$Res>
    implements _$VoteSubmitStateCopyWith<$Res> {
  __$VoteSubmitStateCopyWithImpl(this._self, this._then);

  final _VoteSubmitState _self;
  final $Res Function(_VoteSubmitState) _then;

/// Create a copy of VoteSubmitState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorMessage = freezed,}) {
  return _then(_VoteSubmitState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VoteSubmitStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
