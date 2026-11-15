// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fetch_vote_responses_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FetchVoteResponsesRequest {

 int get meetingId; int get scheduleId;
/// Create a copy of FetchVoteResponsesRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchVoteResponsesRequestCopyWith<FetchVoteResponsesRequest> get copyWith => _$FetchVoteResponsesRequestCopyWithImpl<FetchVoteResponsesRequest>(this as FetchVoteResponsesRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchVoteResponsesRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,scheduleId);

@override
String toString() {
  return 'FetchVoteResponsesRequest(meetingId: $meetingId, scheduleId: $scheduleId)';
}


}

/// @nodoc
abstract mixin class $FetchVoteResponsesRequestCopyWith<$Res>  {
  factory $FetchVoteResponsesRequestCopyWith(FetchVoteResponsesRequest value, $Res Function(FetchVoteResponsesRequest) _then) = _$FetchVoteResponsesRequestCopyWithImpl;
@useResult
$Res call({
 int meetingId, int scheduleId
});




}
/// @nodoc
class _$FetchVoteResponsesRequestCopyWithImpl<$Res>
    implements $FetchVoteResponsesRequestCopyWith<$Res> {
  _$FetchVoteResponsesRequestCopyWithImpl(this._self, this._then);

  final FetchVoteResponsesRequest _self;
  final $Res Function(FetchVoteResponsesRequest) _then;

/// Create a copy of FetchVoteResponsesRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingId = null,Object? scheduleId = null,}) {
  return _then(FetchVoteResponsesRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,scheduleId: null == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FetchVoteResponsesRequest].
extension FetchVoteResponsesRequestPatterns on FetchVoteResponsesRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FetchVoteResponsesRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchVoteResponsesRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FetchVoteResponsesRequest value)  $default,){
final _that = this;
switch (_that) {
case _FetchVoteResponsesRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FetchVoteResponsesRequest value)?  $default,){
final _that = this;
switch (_that) {
case _FetchVoteResponsesRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int meetingId,  int scheduleId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchVoteResponsesRequest() when $default != null:
return $default(_that.meetingId,_that.scheduleId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int meetingId,  int scheduleId)  $default,) {final _that = this;
switch (_that) {
case _FetchVoteResponsesRequest():
return $default(_that.meetingId,_that.scheduleId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int meetingId,  int scheduleId)?  $default,) {final _that = this;
switch (_that) {
case _FetchVoteResponsesRequest() when $default != null:
return $default(_that.meetingId,_that.scheduleId);case _:
  return null;

}
}

}

/// @nodoc


class _FetchVoteResponsesRequest implements FetchVoteResponsesRequest {
  const _FetchVoteResponsesRequest({required this.meetingId, required this.scheduleId});
  

@override final  int meetingId;
@override final  int scheduleId;

/// Create a copy of FetchVoteResponsesRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchVoteResponsesRequestCopyWith<_FetchVoteResponsesRequest> get copyWith => __$FetchVoteResponsesRequestCopyWithImpl<_FetchVoteResponsesRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchVoteResponsesRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,scheduleId);

@override
String toString() {
  return 'FetchVoteResponsesRequest(meetingId: $meetingId, scheduleId: $scheduleId)';
}


}

/// @nodoc
abstract mixin class _$FetchVoteResponsesRequestCopyWith<$Res> implements $FetchVoteResponsesRequestCopyWith<$Res> {
  factory _$FetchVoteResponsesRequestCopyWith(_FetchVoteResponsesRequest value, $Res Function(_FetchVoteResponsesRequest) _then) = __$FetchVoteResponsesRequestCopyWithImpl;
@override @useResult
$Res call({
 int meetingId, int scheduleId
});




}
/// @nodoc
class __$FetchVoteResponsesRequestCopyWithImpl<$Res>
    implements _$FetchVoteResponsesRequestCopyWith<$Res> {
  __$FetchVoteResponsesRequestCopyWithImpl(this._self, this._then);

  final _FetchVoteResponsesRequest _self;
  final $Res Function(_FetchVoteResponsesRequest) _then;

/// Create a copy of FetchVoteResponsesRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingId = null,Object? scheduleId = null,}) {
  return _then(_FetchVoteResponsesRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,scheduleId: null == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
