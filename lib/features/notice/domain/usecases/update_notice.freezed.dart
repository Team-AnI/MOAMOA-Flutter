// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_notice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UpdateNoticeParams {

 int get meetingId; int get noticeId; String? get title; String? get content;
/// Create a copy of UpdateNoticeParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateNoticeParamsCopyWith<UpdateNoticeParams> get copyWith => _$UpdateNoticeParamsCopyWithImpl<UpdateNoticeParams>(this as UpdateNoticeParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateNoticeParams&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.noticeId, noticeId) || other.noticeId == noticeId)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,noticeId,title,content);

@override
String toString() {
  return 'UpdateNoticeParams(meetingId: $meetingId, noticeId: $noticeId, title: $title, content: $content)';
}


}

/// @nodoc
abstract mixin class $UpdateNoticeParamsCopyWith<$Res>  {
  factory $UpdateNoticeParamsCopyWith(UpdateNoticeParams value, $Res Function(UpdateNoticeParams) _then) = _$UpdateNoticeParamsCopyWithImpl;
@useResult
$Res call({
 int meetingId, int noticeId, String? title, String? content
});




}
/// @nodoc
class _$UpdateNoticeParamsCopyWithImpl<$Res>
    implements $UpdateNoticeParamsCopyWith<$Res> {
  _$UpdateNoticeParamsCopyWithImpl(this._self, this._then);

  final UpdateNoticeParams _self;
  final $Res Function(UpdateNoticeParams) _then;

/// Create a copy of UpdateNoticeParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingId = null,Object? noticeId = null,Object? title = freezed,Object? content = freezed,}) {
  return _then(UpdateNoticeParams(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,noticeId: null == noticeId ? _self.noticeId : noticeId // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateNoticeParams].
extension UpdateNoticeParamsPatterns on UpdateNoticeParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateNoticeParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateNoticeParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateNoticeParams value)  $default,){
final _that = this;
switch (_that) {
case _UpdateNoticeParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateNoticeParams value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateNoticeParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int meetingId,  int noticeId,  String? title,  String? content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateNoticeParams() when $default != null:
return $default(_that.meetingId,_that.noticeId,_that.title,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int meetingId,  int noticeId,  String? title,  String? content)  $default,) {final _that = this;
switch (_that) {
case _UpdateNoticeParams():
return $default(_that.meetingId,_that.noticeId,_that.title,_that.content);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int meetingId,  int noticeId,  String? title,  String? content)?  $default,) {final _that = this;
switch (_that) {
case _UpdateNoticeParams() when $default != null:
return $default(_that.meetingId,_that.noticeId,_that.title,_that.content);case _:
  return null;

}
}

}

/// @nodoc


class _UpdateNoticeParams extends UpdateNoticeParams {
  const _UpdateNoticeParams({required this.meetingId, required this.noticeId, this.title, this.content}): super._();
  

@override final  int meetingId;
@override final  int noticeId;
@override final  String? title;
@override final  String? content;

/// Create a copy of UpdateNoticeParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateNoticeParamsCopyWith<_UpdateNoticeParams> get copyWith => __$UpdateNoticeParamsCopyWithImpl<_UpdateNoticeParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateNoticeParams&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.noticeId, noticeId) || other.noticeId == noticeId)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,noticeId,title,content);

@override
String toString() {
  return 'UpdateNoticeParams(meetingId: $meetingId, noticeId: $noticeId, title: $title, content: $content)';
}


}

/// @nodoc
abstract mixin class _$UpdateNoticeParamsCopyWith<$Res> implements $UpdateNoticeParamsCopyWith<$Res> {
  factory _$UpdateNoticeParamsCopyWith(_UpdateNoticeParams value, $Res Function(_UpdateNoticeParams) _then) = __$UpdateNoticeParamsCopyWithImpl;
@override @useResult
$Res call({
 int meetingId, int noticeId, String? title, String? content
});




}
/// @nodoc
class __$UpdateNoticeParamsCopyWithImpl<$Res>
    implements _$UpdateNoticeParamsCopyWith<$Res> {
  __$UpdateNoticeParamsCopyWithImpl(this._self, this._then);

  final _UpdateNoticeParams _self;
  final $Res Function(_UpdateNoticeParams) _then;

/// Create a copy of UpdateNoticeParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingId = null,Object? noticeId = null,Object? title = freezed,Object? content = freezed,}) {
  return _then(_UpdateNoticeParams(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,noticeId: null == noticeId ? _self.noticeId : noticeId // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
