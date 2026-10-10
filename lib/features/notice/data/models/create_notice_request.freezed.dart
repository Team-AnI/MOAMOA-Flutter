// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_notice_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateNoticeRequest {

@JsonKey(includeToJson: false) int get meetingId; String get title; String get content; bool get isImportant;
/// Create a copy of CreateNoticeRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateNoticeRequestCopyWith<CreateNoticeRequest> get copyWith => _$CreateNoticeRequestCopyWithImpl<CreateNoticeRequest>(this as CreateNoticeRequest, _$identity);

  /// Serializes this CreateNoticeRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateNoticeRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meetingId,title,content,isImportant);

@override
String toString() {
  return 'CreateNoticeRequest(meetingId: $meetingId, title: $title, content: $content, isImportant: $isImportant)';
}


}

/// @nodoc
abstract mixin class $CreateNoticeRequestCopyWith<$Res>  {
  factory $CreateNoticeRequestCopyWith(CreateNoticeRequest value, $Res Function(CreateNoticeRequest) _then) = _$CreateNoticeRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false) int meetingId, String title, String content, bool isImportant
});




}
/// @nodoc
class _$CreateNoticeRequestCopyWithImpl<$Res>
    implements $CreateNoticeRequestCopyWith<$Res> {
  _$CreateNoticeRequestCopyWithImpl(this._self, this._then);

  final CreateNoticeRequest _self;
  final $Res Function(CreateNoticeRequest) _then;

/// Create a copy of CreateNoticeRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingId = null,Object? title = null,Object? content = null,Object? isImportant = null,}) {
  return _then(CreateNoticeRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,isImportant: null == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateNoticeRequest].
extension CreateNoticeRequestPatterns on CreateNoticeRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateNoticeRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateNoticeRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateNoticeRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateNoticeRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateNoticeRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateNoticeRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  int meetingId,  String title,  String content,  bool isImportant)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateNoticeRequest() when $default != null:
return $default(_that.meetingId,_that.title,_that.content,_that.isImportant);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  int meetingId,  String title,  String content,  bool isImportant)  $default,) {final _that = this;
switch (_that) {
case _CreateNoticeRequest():
return $default(_that.meetingId,_that.title,_that.content,_that.isImportant);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false)  int meetingId,  String title,  String content,  bool isImportant)?  $default,) {final _that = this;
switch (_that) {
case _CreateNoticeRequest() when $default != null:
return $default(_that.meetingId,_that.title,_that.content,_that.isImportant);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateNoticeRequest implements CreateNoticeRequest {
  const _CreateNoticeRequest({@JsonKey(includeToJson: false) required this.meetingId, required this.title, required this.content, this.isImportant = false});
  factory _CreateNoticeRequest.fromJson(Map<String, dynamic> json) => _$CreateNoticeRequestFromJson(json);

@override@JsonKey(includeToJson: false) final  int meetingId;
@override final  String title;
@override final  String content;
@override@JsonKey() final  bool isImportant;

/// Create a copy of CreateNoticeRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateNoticeRequestCopyWith<_CreateNoticeRequest> get copyWith => __$CreateNoticeRequestCopyWithImpl<_CreateNoticeRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateNoticeRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateNoticeRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.isImportant, isImportant) || other.isImportant == isImportant));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meetingId,title,content,isImportant);

@override
String toString() {
  return 'CreateNoticeRequest(meetingId: $meetingId, title: $title, content: $content, isImportant: $isImportant)';
}


}

/// @nodoc
abstract mixin class _$CreateNoticeRequestCopyWith<$Res> implements $CreateNoticeRequestCopyWith<$Res> {
  factory _$CreateNoticeRequestCopyWith(_CreateNoticeRequest value, $Res Function(_CreateNoticeRequest) _then) = __$CreateNoticeRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false) int meetingId, String title, String content, bool isImportant
});




}
/// @nodoc
class __$CreateNoticeRequestCopyWithImpl<$Res>
    implements _$CreateNoticeRequestCopyWith<$Res> {
  __$CreateNoticeRequestCopyWithImpl(this._self, this._then);

  final _CreateNoticeRequest _self;
  final $Res Function(_CreateNoticeRequest) _then;

/// Create a copy of CreateNoticeRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingId = null,Object? title = null,Object? content = null,Object? isImportant = null,}) {
  return _then(_CreateNoticeRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,isImportant: null == isImportant ? _self.isImportant : isImportant // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
