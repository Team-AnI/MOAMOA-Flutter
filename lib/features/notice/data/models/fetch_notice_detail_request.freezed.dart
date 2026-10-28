// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fetch_notice_detail_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FetchNoticeDetailRequest {

 int get meetingId; int get noticeId;
/// Create a copy of FetchNoticeDetailRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchNoticeDetailRequestCopyWith<FetchNoticeDetailRequest> get copyWith => _$FetchNoticeDetailRequestCopyWithImpl<FetchNoticeDetailRequest>(this as FetchNoticeDetailRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchNoticeDetailRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.noticeId, noticeId) || other.noticeId == noticeId));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,noticeId);

@override
String toString() {
  return 'FetchNoticeDetailRequest(meetingId: $meetingId, noticeId: $noticeId)';
}


}

/// @nodoc
abstract mixin class $FetchNoticeDetailRequestCopyWith<$Res>  {
  factory $FetchNoticeDetailRequestCopyWith(FetchNoticeDetailRequest value, $Res Function(FetchNoticeDetailRequest) _then) = _$FetchNoticeDetailRequestCopyWithImpl;
@useResult
$Res call({
 int meetingId, int noticeId
});




}
/// @nodoc
class _$FetchNoticeDetailRequestCopyWithImpl<$Res>
    implements $FetchNoticeDetailRequestCopyWith<$Res> {
  _$FetchNoticeDetailRequestCopyWithImpl(this._self, this._then);

  final FetchNoticeDetailRequest _self;
  final $Res Function(FetchNoticeDetailRequest) _then;

/// Create a copy of FetchNoticeDetailRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingId = null,Object? noticeId = null,}) {
  return _then(FetchNoticeDetailRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,noticeId: null == noticeId ? _self.noticeId : noticeId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FetchNoticeDetailRequest].
extension FetchNoticeDetailRequestPatterns on FetchNoticeDetailRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FetchNoticeDetailRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchNoticeDetailRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FetchNoticeDetailRequest value)  $default,){
final _that = this;
switch (_that) {
case _FetchNoticeDetailRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FetchNoticeDetailRequest value)?  $default,){
final _that = this;
switch (_that) {
case _FetchNoticeDetailRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int meetingId,  int noticeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchNoticeDetailRequest() when $default != null:
return $default(_that.meetingId,_that.noticeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int meetingId,  int noticeId)  $default,) {final _that = this;
switch (_that) {
case _FetchNoticeDetailRequest():
return $default(_that.meetingId,_that.noticeId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int meetingId,  int noticeId)?  $default,) {final _that = this;
switch (_that) {
case _FetchNoticeDetailRequest() when $default != null:
return $default(_that.meetingId,_that.noticeId);case _:
  return null;

}
}

}

/// @nodoc


class _FetchNoticeDetailRequest implements FetchNoticeDetailRequest {
  const _FetchNoticeDetailRequest({required this.meetingId, required this.noticeId});
  

@override final  int meetingId;
@override final  int noticeId;

/// Create a copy of FetchNoticeDetailRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchNoticeDetailRequestCopyWith<_FetchNoticeDetailRequest> get copyWith => __$FetchNoticeDetailRequestCopyWithImpl<_FetchNoticeDetailRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchNoticeDetailRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.noticeId, noticeId) || other.noticeId == noticeId));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,noticeId);

@override
String toString() {
  return 'FetchNoticeDetailRequest(meetingId: $meetingId, noticeId: $noticeId)';
}


}

/// @nodoc
abstract mixin class _$FetchNoticeDetailRequestCopyWith<$Res> implements $FetchNoticeDetailRequestCopyWith<$Res> {
  factory _$FetchNoticeDetailRequestCopyWith(_FetchNoticeDetailRequest value, $Res Function(_FetchNoticeDetailRequest) _then) = __$FetchNoticeDetailRequestCopyWithImpl;
@override @useResult
$Res call({
 int meetingId, int noticeId
});




}
/// @nodoc
class __$FetchNoticeDetailRequestCopyWithImpl<$Res>
    implements _$FetchNoticeDetailRequestCopyWith<$Res> {
  __$FetchNoticeDetailRequestCopyWithImpl(this._self, this._then);

  final _FetchNoticeDetailRequest _self;
  final $Res Function(_FetchNoticeDetailRequest) _then;

/// Create a copy of FetchNoticeDetailRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingId = null,Object? noticeId = null,}) {
  return _then(_FetchNoticeDetailRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,noticeId: null == noticeId ? _self.noticeId : noticeId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
