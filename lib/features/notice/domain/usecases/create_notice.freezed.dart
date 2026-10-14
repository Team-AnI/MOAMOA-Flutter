// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_notice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateNoticeParams {

 int get meetingId; String get title; String get content;
/// Create a copy of CreateNoticeParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateNoticeParamsCopyWith<CreateNoticeParams> get copyWith => _$CreateNoticeParamsCopyWithImpl<CreateNoticeParams>(this as CreateNoticeParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateNoticeParams&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,title,content);

@override
String toString() {
  return 'CreateNoticeParams(meetingId: $meetingId, title: $title, content: $content)';
}


}

/// @nodoc
abstract mixin class $CreateNoticeParamsCopyWith<$Res>  {
  factory $CreateNoticeParamsCopyWith(CreateNoticeParams value, $Res Function(CreateNoticeParams) _then) = _$CreateNoticeParamsCopyWithImpl;
@useResult
$Res call({
 int meetingId, String title, String content
});




}
/// @nodoc
class _$CreateNoticeParamsCopyWithImpl<$Res>
    implements $CreateNoticeParamsCopyWith<$Res> {
  _$CreateNoticeParamsCopyWithImpl(this._self, this._then);

  final CreateNoticeParams _self;
  final $Res Function(CreateNoticeParams) _then;

/// Create a copy of CreateNoticeParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingId = null,Object? title = null,Object? content = null,}) {
  return _then(CreateNoticeParams(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateNoticeParams].
extension CreateNoticeParamsPatterns on CreateNoticeParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateNoticeParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateNoticeParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateNoticeParams value)  $default,){
final _that = this;
switch (_that) {
case _CreateNoticeParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateNoticeParams value)?  $default,){
final _that = this;
switch (_that) {
case _CreateNoticeParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int meetingId,  String title,  String content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateNoticeParams() when $default != null:
return $default(_that.meetingId,_that.title,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int meetingId,  String title,  String content)  $default,) {final _that = this;
switch (_that) {
case _CreateNoticeParams():
return $default(_that.meetingId,_that.title,_that.content);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int meetingId,  String title,  String content)?  $default,) {final _that = this;
switch (_that) {
case _CreateNoticeParams() when $default != null:
return $default(_that.meetingId,_that.title,_that.content);case _:
  return null;

}
}

}

/// @nodoc


class _CreateNoticeParams extends CreateNoticeParams {
  const _CreateNoticeParams({required this.meetingId, required this.title, required this.content}): super._();
  

@override final  int meetingId;
@override final  String title;
@override final  String content;

/// Create a copy of CreateNoticeParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateNoticeParamsCopyWith<_CreateNoticeParams> get copyWith => __$CreateNoticeParamsCopyWithImpl<_CreateNoticeParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateNoticeParams&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,title,content);

@override
String toString() {
  return 'CreateNoticeParams(meetingId: $meetingId, title: $title, content: $content)';
}


}

/// @nodoc
abstract mixin class _$CreateNoticeParamsCopyWith<$Res> implements $CreateNoticeParamsCopyWith<$Res> {
  factory _$CreateNoticeParamsCopyWith(_CreateNoticeParams value, $Res Function(_CreateNoticeParams) _then) = __$CreateNoticeParamsCopyWithImpl;
@override @useResult
$Res call({
 int meetingId, String title, String content
});




}
/// @nodoc
class __$CreateNoticeParamsCopyWithImpl<$Res>
    implements _$CreateNoticeParamsCopyWith<$Res> {
  __$CreateNoticeParamsCopyWithImpl(this._self, this._then);

  final _CreateNoticeParams _self;
  final $Res Function(_CreateNoticeParams) _then;

/// Create a copy of CreateNoticeParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingId = null,Object? title = null,Object? content = null,}) {
  return _then(_CreateNoticeParams(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
