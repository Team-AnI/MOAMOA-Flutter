// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unpin_notice_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UnpinNoticeRequest {

 int get meetingId; int get noticeId;
/// Create a copy of UnpinNoticeRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnpinNoticeRequestCopyWith<UnpinNoticeRequest> get copyWith => _$UnpinNoticeRequestCopyWithImpl<UnpinNoticeRequest>(this as UnpinNoticeRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnpinNoticeRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.noticeId, noticeId) || other.noticeId == noticeId));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,noticeId);

@override
String toString() {
  return 'UnpinNoticeRequest(meetingId: $meetingId, noticeId: $noticeId)';
}


}

/// @nodoc
abstract mixin class $UnpinNoticeRequestCopyWith<$Res>  {
  factory $UnpinNoticeRequestCopyWith(UnpinNoticeRequest value, $Res Function(UnpinNoticeRequest) _then) = _$UnpinNoticeRequestCopyWithImpl;
@useResult
$Res call({
 int meetingId, int noticeId
});




}
/// @nodoc
class _$UnpinNoticeRequestCopyWithImpl<$Res>
    implements $UnpinNoticeRequestCopyWith<$Res> {
  _$UnpinNoticeRequestCopyWithImpl(this._self, this._then);

  final UnpinNoticeRequest _self;
  final $Res Function(UnpinNoticeRequest) _then;

/// Create a copy of UnpinNoticeRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingId = null,Object? noticeId = null,}) {
  return _then(UnpinNoticeRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,noticeId: null == noticeId ? _self.noticeId : noticeId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UnpinNoticeRequest].
extension UnpinNoticeRequestPatterns on UnpinNoticeRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UnpinNoticeRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UnpinNoticeRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UnpinNoticeRequest value)  $default,){
final _that = this;
switch (_that) {
case _UnpinNoticeRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UnpinNoticeRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UnpinNoticeRequest() when $default != null:
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
case _UnpinNoticeRequest() when $default != null:
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
case _UnpinNoticeRequest():
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
case _UnpinNoticeRequest() when $default != null:
return $default(_that.meetingId,_that.noticeId);case _:
  return null;

}
}

}

/// @nodoc


class _UnpinNoticeRequest implements UnpinNoticeRequest {
  const _UnpinNoticeRequest({required this.meetingId, required this.noticeId});
  

@override final  int meetingId;
@override final  int noticeId;

/// Create a copy of UnpinNoticeRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnpinNoticeRequestCopyWith<_UnpinNoticeRequest> get copyWith => __$UnpinNoticeRequestCopyWithImpl<_UnpinNoticeRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnpinNoticeRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.noticeId, noticeId) || other.noticeId == noticeId));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,noticeId);

@override
String toString() {
  return 'UnpinNoticeRequest(meetingId: $meetingId, noticeId: $noticeId)';
}


}

/// @nodoc
abstract mixin class _$UnpinNoticeRequestCopyWith<$Res> implements $UnpinNoticeRequestCopyWith<$Res> {
  factory _$UnpinNoticeRequestCopyWith(_UnpinNoticeRequest value, $Res Function(_UnpinNoticeRequest) _then) = __$UnpinNoticeRequestCopyWithImpl;
@override @useResult
$Res call({
 int meetingId, int noticeId
});




}
/// @nodoc
class __$UnpinNoticeRequestCopyWithImpl<$Res>
    implements _$UnpinNoticeRequestCopyWith<$Res> {
  __$UnpinNoticeRequestCopyWithImpl(this._self, this._then);

  final _UnpinNoticeRequest _self;
  final $Res Function(_UnpinNoticeRequest) _then;

/// Create a copy of UnpinNoticeRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingId = null,Object? noticeId = null,}) {
  return _then(_UnpinNoticeRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,noticeId: null == noticeId ? _self.noticeId : noticeId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
