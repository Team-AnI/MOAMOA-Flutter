// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notice_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NoticeModel {

 int get noticeId; String get title;/// ISO-8601 (KST, 예: 2026-10-07T10:00:00+09:00)
 String get createdAt; String? get content; String? get authorNickname; bool? get isPinned; NoticeAccountModel? get account;
/// Create a copy of NoticeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoticeModelCopyWith<NoticeModel> get copyWith => _$NoticeModelCopyWithImpl<NoticeModel>(this as NoticeModel, _$identity);

  /// Serializes this NoticeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoticeModel&&(identical(other.noticeId, noticeId) || other.noticeId == noticeId)&&(identical(other.title, title) || other.title == title)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.content, content) || other.content == content)&&(identical(other.authorNickname, authorNickname) || other.authorNickname == authorNickname)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.account, account) || other.account == account));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,noticeId,title,createdAt,content,authorNickname,isPinned,account);

@override
String toString() {
  return 'NoticeModel(noticeId: $noticeId, title: $title, createdAt: $createdAt, content: $content, authorNickname: $authorNickname, isPinned: $isPinned, account: $account)';
}


}

/// @nodoc
abstract mixin class $NoticeModelCopyWith<$Res>  {
  factory $NoticeModelCopyWith(NoticeModel value, $Res Function(NoticeModel) _then) = _$NoticeModelCopyWithImpl;
@useResult
$Res call({
 int noticeId, String title, String createdAt, String? content, String? authorNickname, bool? isPinned, NoticeAccountModel? account
});


$NoticeAccountModelCopyWith<$Res>? get account;

}
/// @nodoc
class _$NoticeModelCopyWithImpl<$Res>
    implements $NoticeModelCopyWith<$Res> {
  _$NoticeModelCopyWithImpl(this._self, this._then);

  final NoticeModel _self;
  final $Res Function(NoticeModel) _then;

/// Create a copy of NoticeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? noticeId = null,Object? title = null,Object? createdAt = null,Object? content = freezed,Object? authorNickname = freezed,Object? isPinned = freezed,Object? account = freezed,}) {
  return _then(NoticeModel(
noticeId: null == noticeId ? _self.noticeId : noticeId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,authorNickname: freezed == authorNickname ? _self.authorNickname : authorNickname // ignore: cast_nullable_to_non_nullable
as String?,isPinned: freezed == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool?,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as NoticeAccountModel?,
  ));
}
/// Create a copy of NoticeModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NoticeAccountModelCopyWith<$Res>? get account {
    if (_self.account == null) {
    return null;
  }

  return $NoticeAccountModelCopyWith<$Res>(_self.account!, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}


/// Adds pattern-matching-related methods to [NoticeModel].
extension NoticeModelPatterns on NoticeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoticeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoticeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoticeModel value)  $default,){
final _that = this;
switch (_that) {
case _NoticeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoticeModel value)?  $default,){
final _that = this;
switch (_that) {
case _NoticeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int noticeId,  String title,  String createdAt,  String? content,  String? authorNickname,  bool? isPinned,  NoticeAccountModel? account)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoticeModel() when $default != null:
return $default(_that.noticeId,_that.title,_that.createdAt,_that.content,_that.authorNickname,_that.isPinned,_that.account);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int noticeId,  String title,  String createdAt,  String? content,  String? authorNickname,  bool? isPinned,  NoticeAccountModel? account)  $default,) {final _that = this;
switch (_that) {
case _NoticeModel():
return $default(_that.noticeId,_that.title,_that.createdAt,_that.content,_that.authorNickname,_that.isPinned,_that.account);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int noticeId,  String title,  String createdAt,  String? content,  String? authorNickname,  bool? isPinned,  NoticeAccountModel? account)?  $default,) {final _that = this;
switch (_that) {
case _NoticeModel() when $default != null:
return $default(_that.noticeId,_that.title,_that.createdAt,_that.content,_that.authorNickname,_that.isPinned,_that.account);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NoticeModel extends NoticeModel {
  const _NoticeModel({required this.noticeId, required this.title, required this.createdAt, this.content, this.authorNickname, this.isPinned, this.account}): super._();
  factory _NoticeModel.fromJson(Map<String, dynamic> json) => _$NoticeModelFromJson(json);

@override final  int noticeId;
@override final  String title;
/// ISO-8601 (KST, 예: 2026-10-07T10:00:00+09:00)
@override final  String createdAt;
@override final  String? content;
@override final  String? authorNickname;
@override final  bool? isPinned;
@override final  NoticeAccountModel? account;

/// Create a copy of NoticeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoticeModelCopyWith<_NoticeModel> get copyWith => __$NoticeModelCopyWithImpl<_NoticeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NoticeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoticeModel&&(identical(other.noticeId, noticeId) || other.noticeId == noticeId)&&(identical(other.title, title) || other.title == title)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.content, content) || other.content == content)&&(identical(other.authorNickname, authorNickname) || other.authorNickname == authorNickname)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.account, account) || other.account == account));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,noticeId,title,createdAt,content,authorNickname,isPinned,account);

@override
String toString() {
  return 'NoticeModel(noticeId: $noticeId, title: $title, createdAt: $createdAt, content: $content, authorNickname: $authorNickname, isPinned: $isPinned, account: $account)';
}


}

/// @nodoc
abstract mixin class _$NoticeModelCopyWith<$Res> implements $NoticeModelCopyWith<$Res> {
  factory _$NoticeModelCopyWith(_NoticeModel value, $Res Function(_NoticeModel) _then) = __$NoticeModelCopyWithImpl;
@override @useResult
$Res call({
 int noticeId, String title, String createdAt, String? content, String? authorNickname, bool? isPinned, NoticeAccountModel? account
});


@override $NoticeAccountModelCopyWith<$Res>? get account;

}
/// @nodoc
class __$NoticeModelCopyWithImpl<$Res>
    implements _$NoticeModelCopyWith<$Res> {
  __$NoticeModelCopyWithImpl(this._self, this._then);

  final _NoticeModel _self;
  final $Res Function(_NoticeModel) _then;

/// Create a copy of NoticeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? noticeId = null,Object? title = null,Object? createdAt = null,Object? content = freezed,Object? authorNickname = freezed,Object? isPinned = freezed,Object? account = freezed,}) {
  return _then(_NoticeModel(
noticeId: null == noticeId ? _self.noticeId : noticeId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,authorNickname: freezed == authorNickname ? _self.authorNickname : authorNickname // ignore: cast_nullable_to_non_nullable
as String?,isPinned: freezed == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool?,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as NoticeAccountModel?,
  ));
}

/// Create a copy of NoticeModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NoticeAccountModelCopyWith<$Res>? get account {
    if (_self.account == null) {
    return null;
  }

  return $NoticeAccountModelCopyWith<$Res>(_self.account!, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}

// dart format on
