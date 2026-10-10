// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pin_notice_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PinNoticeRequest {

 int get meetingId; int get noticeId;
/// Create a copy of PinNoticeRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PinNoticeRequestCopyWith<PinNoticeRequest> get copyWith => _$PinNoticeRequestCopyWithImpl<PinNoticeRequest>(this as PinNoticeRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PinNoticeRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.noticeId, noticeId) || other.noticeId == noticeId));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,noticeId);

@override
String toString() {
  return 'PinNoticeRequest(meetingId: $meetingId, noticeId: $noticeId)';
}


}

/// @nodoc
abstract mixin class $PinNoticeRequestCopyWith<$Res>  {
  factory $PinNoticeRequestCopyWith(PinNoticeRequest value, $Res Function(PinNoticeRequest) _then) = _$PinNoticeRequestCopyWithImpl;
@useResult
$Res call({
 int meetingId, int noticeId
});




}
/// @nodoc
class _$PinNoticeRequestCopyWithImpl<$Res>
    implements $PinNoticeRequestCopyWith<$Res> {
  _$PinNoticeRequestCopyWithImpl(this._self, this._then);

  final PinNoticeRequest _self;
  final $Res Function(PinNoticeRequest) _then;

/// Create a copy of PinNoticeRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingId = null,Object? noticeId = null,}) {
  return _then(PinNoticeRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,noticeId: null == noticeId ? _self.noticeId : noticeId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PinNoticeRequest].
extension PinNoticeRequestPatterns on PinNoticeRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PinNoticeRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PinNoticeRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PinNoticeRequest value)  $default,){
final _that = this;
switch (_that) {
case _PinNoticeRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PinNoticeRequest value)?  $default,){
final _that = this;
switch (_that) {
case _PinNoticeRequest() when $default != null:
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
case _PinNoticeRequest() when $default != null:
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
case _PinNoticeRequest():
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
case _PinNoticeRequest() when $default != null:
return $default(_that.meetingId,_that.noticeId);case _:
  return null;

}
}

}

/// @nodoc


class _PinNoticeRequest implements PinNoticeRequest {
  const _PinNoticeRequest({required this.meetingId, required this.noticeId});
  

@override final  int meetingId;
@override final  int noticeId;

/// Create a copy of PinNoticeRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PinNoticeRequestCopyWith<_PinNoticeRequest> get copyWith => __$PinNoticeRequestCopyWithImpl<_PinNoticeRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PinNoticeRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.noticeId, noticeId) || other.noticeId == noticeId));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,noticeId);

@override
String toString() {
  return 'PinNoticeRequest(meetingId: $meetingId, noticeId: $noticeId)';
}


}

/// @nodoc
abstract mixin class _$PinNoticeRequestCopyWith<$Res> implements $PinNoticeRequestCopyWith<$Res> {
  factory _$PinNoticeRequestCopyWith(_PinNoticeRequest value, $Res Function(_PinNoticeRequest) _then) = __$PinNoticeRequestCopyWithImpl;
@override @useResult
$Res call({
 int meetingId, int noticeId
});




}
/// @nodoc
class __$PinNoticeRequestCopyWithImpl<$Res>
    implements _$PinNoticeRequestCopyWith<$Res> {
  __$PinNoticeRequestCopyWithImpl(this._self, this._then);

  final _PinNoticeRequest _self;
  final $Res Function(_PinNoticeRequest) _then;

/// Create a copy of PinNoticeRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingId = null,Object? noticeId = null,}) {
  return _then(_PinNoticeRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,noticeId: null == noticeId ? _self.noticeId : noticeId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
