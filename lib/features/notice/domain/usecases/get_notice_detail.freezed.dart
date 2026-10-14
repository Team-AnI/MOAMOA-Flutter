// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_notice_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GetNoticeDetailParams {

 int get meetingId; int get noticeId;
/// Create a copy of GetNoticeDetailParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetNoticeDetailParamsCopyWith<GetNoticeDetailParams> get copyWith => _$GetNoticeDetailParamsCopyWithImpl<GetNoticeDetailParams>(this as GetNoticeDetailParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetNoticeDetailParams&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.noticeId, noticeId) || other.noticeId == noticeId));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,noticeId);

@override
String toString() {
  return 'GetNoticeDetailParams(meetingId: $meetingId, noticeId: $noticeId)';
}


}

/// @nodoc
abstract mixin class $GetNoticeDetailParamsCopyWith<$Res>  {
  factory $GetNoticeDetailParamsCopyWith(GetNoticeDetailParams value, $Res Function(GetNoticeDetailParams) _then) = _$GetNoticeDetailParamsCopyWithImpl;
@useResult
$Res call({
 int meetingId, int noticeId
});




}
/// @nodoc
class _$GetNoticeDetailParamsCopyWithImpl<$Res>
    implements $GetNoticeDetailParamsCopyWith<$Res> {
  _$GetNoticeDetailParamsCopyWithImpl(this._self, this._then);

  final GetNoticeDetailParams _self;
  final $Res Function(GetNoticeDetailParams) _then;

/// Create a copy of GetNoticeDetailParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingId = null,Object? noticeId = null,}) {
  return _then(GetNoticeDetailParams(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,noticeId: null == noticeId ? _self.noticeId : noticeId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GetNoticeDetailParams].
extension GetNoticeDetailParamsPatterns on GetNoticeDetailParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetNoticeDetailParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetNoticeDetailParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetNoticeDetailParams value)  $default,){
final _that = this;
switch (_that) {
case _GetNoticeDetailParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetNoticeDetailParams value)?  $default,){
final _that = this;
switch (_that) {
case _GetNoticeDetailParams() when $default != null:
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
case _GetNoticeDetailParams() when $default != null:
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
case _GetNoticeDetailParams():
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
case _GetNoticeDetailParams() when $default != null:
return $default(_that.meetingId,_that.noticeId);case _:
  return null;

}
}

}

/// @nodoc


class _GetNoticeDetailParams extends GetNoticeDetailParams {
  const _GetNoticeDetailParams({required this.meetingId, required this.noticeId}): super._();
  

@override final  int meetingId;
@override final  int noticeId;

/// Create a copy of GetNoticeDetailParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetNoticeDetailParamsCopyWith<_GetNoticeDetailParams> get copyWith => __$GetNoticeDetailParamsCopyWithImpl<_GetNoticeDetailParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetNoticeDetailParams&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.noticeId, noticeId) || other.noticeId == noticeId));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,noticeId);

@override
String toString() {
  return 'GetNoticeDetailParams(meetingId: $meetingId, noticeId: $noticeId)';
}


}

/// @nodoc
abstract mixin class _$GetNoticeDetailParamsCopyWith<$Res> implements $GetNoticeDetailParamsCopyWith<$Res> {
  factory _$GetNoticeDetailParamsCopyWith(_GetNoticeDetailParams value, $Res Function(_GetNoticeDetailParams) _then) = __$GetNoticeDetailParamsCopyWithImpl;
@override @useResult
$Res call({
 int meetingId, int noticeId
});




}
/// @nodoc
class __$GetNoticeDetailParamsCopyWithImpl<$Res>
    implements _$GetNoticeDetailParamsCopyWith<$Res> {
  __$GetNoticeDetailParamsCopyWithImpl(this._self, this._then);

  final _GetNoticeDetailParams _self;
  final $Res Function(_GetNoticeDetailParams) _then;

/// Create a copy of GetNoticeDetailParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingId = null,Object? noticeId = null,}) {
  return _then(_GetNoticeDetailParams(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,noticeId: null == noticeId ? _self.noticeId : noticeId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
