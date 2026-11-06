// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Notice {

 int get id; String get title; DateTime get createdAt; String? get content;
/// Create a copy of Notice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoticeCopyWith<Notice> get copyWith => _$NoticeCopyWithImpl<Notice>(this as Notice, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Notice&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.content, content) || other.content == content));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,createdAt,content);

@override
String toString() {
  return 'Notice(id: $id, title: $title, createdAt: $createdAt, content: $content)';
}


}

/// @nodoc
abstract mixin class $NoticeCopyWith<$Res>  {
  factory $NoticeCopyWith(Notice value, $Res Function(Notice) _then) = _$NoticeCopyWithImpl;
@useResult
$Res call({
 int id, String title, DateTime createdAt, String? content
});




}
/// @nodoc
class _$NoticeCopyWithImpl<$Res>
    implements $NoticeCopyWith<$Res> {
  _$NoticeCopyWithImpl(this._self, this._then);

  final Notice _self;
  final $Res Function(Notice) _then;

/// Create a copy of Notice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? createdAt = null,Object? content = freezed,}) {
  return _then(Notice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Notice].
extension NoticePatterns on Notice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Notice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Notice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Notice value)  $default,){
final _that = this;
switch (_that) {
case _Notice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Notice value)?  $default,){
final _that = this;
switch (_that) {
case _Notice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  DateTime createdAt,  String? content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Notice() when $default != null:
return $default(_that.id,_that.title,_that.createdAt,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  DateTime createdAt,  String? content)  $default,) {final _that = this;
switch (_that) {
case _Notice():
return $default(_that.id,_that.title,_that.createdAt,_that.content);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  DateTime createdAt,  String? content)?  $default,) {final _that = this;
switch (_that) {
case _Notice() when $default != null:
return $default(_that.id,_that.title,_that.createdAt,_that.content);case _:
  return null;

}
}

}

/// @nodoc


class _Notice implements Notice {
  const _Notice({required this.id, required this.title, required this.createdAt, this.content});
  

@override final  int id;
@override final  String title;
@override final  DateTime createdAt;
@override final  String? content;

/// Create a copy of Notice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoticeCopyWith<_Notice> get copyWith => __$NoticeCopyWithImpl<_Notice>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Notice&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.content, content) || other.content == content));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,createdAt,content);

@override
String toString() {
  return 'Notice(id: $id, title: $title, createdAt: $createdAt, content: $content)';
}


}

/// @nodoc
abstract mixin class _$NoticeCopyWith<$Res> implements $NoticeCopyWith<$Res> {
  factory _$NoticeCopyWith(_Notice value, $Res Function(_Notice) _then) = __$NoticeCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, DateTime createdAt, String? content
});




}
/// @nodoc
class __$NoticeCopyWithImpl<$Res>
    implements _$NoticeCopyWith<$Res> {
  __$NoticeCopyWithImpl(this._self, this._then);

  final _Notice _self;
  final $Res Function(_Notice) _then;

/// Create a copy of Notice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? createdAt = null,Object? content = freezed,}) {
  return _then(_Notice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
