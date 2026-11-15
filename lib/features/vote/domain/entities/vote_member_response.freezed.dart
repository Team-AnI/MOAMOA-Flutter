// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vote_member_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VoteMemberResponse {

 int get memberId; String? get userName; bool get responded; DateTime? get submittedAt;
/// Create a copy of VoteMemberResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoteMemberResponseCopyWith<VoteMemberResponse> get copyWith => _$VoteMemberResponseCopyWithImpl<VoteMemberResponse>(this as VoteMemberResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoteMemberResponse&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.responded, responded) || other.responded == responded)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt));
}


@override
int get hashCode => Object.hash(runtimeType,memberId,userName,responded,submittedAt);

@override
String toString() {
  return 'VoteMemberResponse(memberId: $memberId, userName: $userName, responded: $responded, submittedAt: $submittedAt)';
}


}

/// @nodoc
abstract mixin class $VoteMemberResponseCopyWith<$Res>  {
  factory $VoteMemberResponseCopyWith(VoteMemberResponse value, $Res Function(VoteMemberResponse) _then) = _$VoteMemberResponseCopyWithImpl;
@useResult
$Res call({
 int memberId, String? userName, bool responded, DateTime? submittedAt
});




}
/// @nodoc
class _$VoteMemberResponseCopyWithImpl<$Res>
    implements $VoteMemberResponseCopyWith<$Res> {
  _$VoteMemberResponseCopyWithImpl(this._self, this._then);

  final VoteMemberResponse _self;
  final $Res Function(VoteMemberResponse) _then;

/// Create a copy of VoteMemberResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? memberId = null,Object? userName = freezed,Object? responded = null,Object? submittedAt = freezed,}) {
  return _then(VoteMemberResponse(
memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as int,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,responded: null == responded ? _self.responded : responded // ignore: cast_nullable_to_non_nullable
as bool,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [VoteMemberResponse].
extension VoteMemberResponsePatterns on VoteMemberResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoteMemberResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoteMemberResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoteMemberResponse value)  $default,){
final _that = this;
switch (_that) {
case _VoteMemberResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoteMemberResponse value)?  $default,){
final _that = this;
switch (_that) {
case _VoteMemberResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int memberId,  String? userName,  bool responded,  DateTime? submittedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoteMemberResponse() when $default != null:
return $default(_that.memberId,_that.userName,_that.responded,_that.submittedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int memberId,  String? userName,  bool responded,  DateTime? submittedAt)  $default,) {final _that = this;
switch (_that) {
case _VoteMemberResponse():
return $default(_that.memberId,_that.userName,_that.responded,_that.submittedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int memberId,  String? userName,  bool responded,  DateTime? submittedAt)?  $default,) {final _that = this;
switch (_that) {
case _VoteMemberResponse() when $default != null:
return $default(_that.memberId,_that.userName,_that.responded,_that.submittedAt);case _:
  return null;

}
}

}

/// @nodoc


class _VoteMemberResponse implements VoteMemberResponse {
  const _VoteMemberResponse({required this.memberId, this.userName, required this.responded, this.submittedAt});
  

@override final  int memberId;
@override final  String? userName;
@override final  bool responded;
@override final  DateTime? submittedAt;

/// Create a copy of VoteMemberResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoteMemberResponseCopyWith<_VoteMemberResponse> get copyWith => __$VoteMemberResponseCopyWithImpl<_VoteMemberResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoteMemberResponse&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.responded, responded) || other.responded == responded)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt));
}


@override
int get hashCode => Object.hash(runtimeType,memberId,userName,responded,submittedAt);

@override
String toString() {
  return 'VoteMemberResponse(memberId: $memberId, userName: $userName, responded: $responded, submittedAt: $submittedAt)';
}


}

/// @nodoc
abstract mixin class _$VoteMemberResponseCopyWith<$Res> implements $VoteMemberResponseCopyWith<$Res> {
  factory _$VoteMemberResponseCopyWith(_VoteMemberResponse value, $Res Function(_VoteMemberResponse) _then) = __$VoteMemberResponseCopyWithImpl;
@override @useResult
$Res call({
 int memberId, String? userName, bool responded, DateTime? submittedAt
});




}
/// @nodoc
class __$VoteMemberResponseCopyWithImpl<$Res>
    implements _$VoteMemberResponseCopyWith<$Res> {
  __$VoteMemberResponseCopyWithImpl(this._self, this._then);

  final _VoteMemberResponse _self;
  final $Res Function(_VoteMemberResponse) _then;

/// Create a copy of VoteMemberResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? memberId = null,Object? userName = freezed,Object? responded = null,Object? submittedAt = freezed,}) {
  return _then(_VoteMemberResponse(
memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as int,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,responded: null == responded ? _self.responded : responded // ignore: cast_nullable_to_non_nullable
as bool,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
