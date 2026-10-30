// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fetch_my_role_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FetchMyRoleRequest {

 int get meetingId;
/// Create a copy of FetchMyRoleRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchMyRoleRequestCopyWith<FetchMyRoleRequest> get copyWith => _$FetchMyRoleRequestCopyWithImpl<FetchMyRoleRequest>(this as FetchMyRoleRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchMyRoleRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId);

@override
String toString() {
  return 'FetchMyRoleRequest(meetingId: $meetingId)';
}


}

/// @nodoc
abstract mixin class $FetchMyRoleRequestCopyWith<$Res>  {
  factory $FetchMyRoleRequestCopyWith(FetchMyRoleRequest value, $Res Function(FetchMyRoleRequest) _then) = _$FetchMyRoleRequestCopyWithImpl;
@useResult
$Res call({
 int meetingId
});




}
/// @nodoc
class _$FetchMyRoleRequestCopyWithImpl<$Res>
    implements $FetchMyRoleRequestCopyWith<$Res> {
  _$FetchMyRoleRequestCopyWithImpl(this._self, this._then);

  final FetchMyRoleRequest _self;
  final $Res Function(FetchMyRoleRequest) _then;

/// Create a copy of FetchMyRoleRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingId = null,}) {
  return _then(FetchMyRoleRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FetchMyRoleRequest].
extension FetchMyRoleRequestPatterns on FetchMyRoleRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FetchMyRoleRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchMyRoleRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FetchMyRoleRequest value)  $default,){
final _that = this;
switch (_that) {
case _FetchMyRoleRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FetchMyRoleRequest value)?  $default,){
final _that = this;
switch (_that) {
case _FetchMyRoleRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int meetingId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchMyRoleRequest() when $default != null:
return $default(_that.meetingId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int meetingId)  $default,) {final _that = this;
switch (_that) {
case _FetchMyRoleRequest():
return $default(_that.meetingId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int meetingId)?  $default,) {final _that = this;
switch (_that) {
case _FetchMyRoleRequest() when $default != null:
return $default(_that.meetingId);case _:
  return null;

}
}

}

/// @nodoc


class _FetchMyRoleRequest implements FetchMyRoleRequest {
  const _FetchMyRoleRequest({required this.meetingId});
  

@override final  int meetingId;

/// Create a copy of FetchMyRoleRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchMyRoleRequestCopyWith<_FetchMyRoleRequest> get copyWith => __$FetchMyRoleRequestCopyWithImpl<_FetchMyRoleRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchMyRoleRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId);

@override
String toString() {
  return 'FetchMyRoleRequest(meetingId: $meetingId)';
}


}

/// @nodoc
abstract mixin class _$FetchMyRoleRequestCopyWith<$Res> implements $FetchMyRoleRequestCopyWith<$Res> {
  factory _$FetchMyRoleRequestCopyWith(_FetchMyRoleRequest value, $Res Function(_FetchMyRoleRequest) _then) = __$FetchMyRoleRequestCopyWithImpl;
@override @useResult
$Res call({
 int meetingId
});




}
/// @nodoc
class __$FetchMyRoleRequestCopyWithImpl<$Res>
    implements _$FetchMyRoleRequestCopyWith<$Res> {
  __$FetchMyRoleRequestCopyWithImpl(this._self, this._then);

  final _FetchMyRoleRequest _self;
  final $Res Function(_FetchMyRoleRequest) _then;

/// Create a copy of FetchMyRoleRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingId = null,}) {
  return _then(_FetchMyRoleRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
