// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notice_read_member_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NoticeReadMemberModel {

 int get memberId; String? get userName;/// LIGHT_BLUE · GRAY · BLUE · DARK
 String? get profileColor;/// ISO-8601 (KST). unreadMembers 항목에는 없습니다.
 String? get readAt;
/// Create a copy of NoticeReadMemberModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoticeReadMemberModelCopyWith<NoticeReadMemberModel> get copyWith => _$NoticeReadMemberModelCopyWithImpl<NoticeReadMemberModel>(this as NoticeReadMemberModel, _$identity);

  /// Serializes this NoticeReadMemberModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoticeReadMemberModel&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.profileColor, profileColor) || other.profileColor == profileColor)&&(identical(other.readAt, readAt) || other.readAt == readAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,memberId,userName,profileColor,readAt);

@override
String toString() {
  return 'NoticeReadMemberModel(memberId: $memberId, userName: $userName, profileColor: $profileColor, readAt: $readAt)';
}


}

/// @nodoc
abstract mixin class $NoticeReadMemberModelCopyWith<$Res>  {
  factory $NoticeReadMemberModelCopyWith(NoticeReadMemberModel value, $Res Function(NoticeReadMemberModel) _then) = _$NoticeReadMemberModelCopyWithImpl;
@useResult
$Res call({
 int memberId, String? userName, String? profileColor, String? readAt
});




}
/// @nodoc
class _$NoticeReadMemberModelCopyWithImpl<$Res>
    implements $NoticeReadMemberModelCopyWith<$Res> {
  _$NoticeReadMemberModelCopyWithImpl(this._self, this._then);

  final NoticeReadMemberModel _self;
  final $Res Function(NoticeReadMemberModel) _then;

/// Create a copy of NoticeReadMemberModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? memberId = null,Object? userName = freezed,Object? profileColor = freezed,Object? readAt = freezed,}) {
  return _then(NoticeReadMemberModel(
memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as int,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,profileColor: freezed == profileColor ? _self.profileColor : profileColor // ignore: cast_nullable_to_non_nullable
as String?,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NoticeReadMemberModel].
extension NoticeReadMemberModelPatterns on NoticeReadMemberModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoticeReadMemberModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoticeReadMemberModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoticeReadMemberModel value)  $default,){
final _that = this;
switch (_that) {
case _NoticeReadMemberModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoticeReadMemberModel value)?  $default,){
final _that = this;
switch (_that) {
case _NoticeReadMemberModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int memberId,  String? userName,  String? profileColor,  String? readAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoticeReadMemberModel() when $default != null:
return $default(_that.memberId,_that.userName,_that.profileColor,_that.readAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int memberId,  String? userName,  String? profileColor,  String? readAt)  $default,) {final _that = this;
switch (_that) {
case _NoticeReadMemberModel():
return $default(_that.memberId,_that.userName,_that.profileColor,_that.readAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int memberId,  String? userName,  String? profileColor,  String? readAt)?  $default,) {final _that = this;
switch (_that) {
case _NoticeReadMemberModel() when $default != null:
return $default(_that.memberId,_that.userName,_that.profileColor,_that.readAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NoticeReadMemberModel implements NoticeReadMemberModel {
  const _NoticeReadMemberModel({required this.memberId, this.userName, this.profileColor, this.readAt});
  factory _NoticeReadMemberModel.fromJson(Map<String, dynamic> json) => _$NoticeReadMemberModelFromJson(json);

@override final  int memberId;
@override final  String? userName;
/// LIGHT_BLUE · GRAY · BLUE · DARK
@override final  String? profileColor;
/// ISO-8601 (KST). unreadMembers 항목에는 없습니다.
@override final  String? readAt;

/// Create a copy of NoticeReadMemberModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoticeReadMemberModelCopyWith<_NoticeReadMemberModel> get copyWith => __$NoticeReadMemberModelCopyWithImpl<_NoticeReadMemberModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NoticeReadMemberModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoticeReadMemberModel&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.profileColor, profileColor) || other.profileColor == profileColor)&&(identical(other.readAt, readAt) || other.readAt == readAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,memberId,userName,profileColor,readAt);

@override
String toString() {
  return 'NoticeReadMemberModel(memberId: $memberId, userName: $userName, profileColor: $profileColor, readAt: $readAt)';
}


}

/// @nodoc
abstract mixin class _$NoticeReadMemberModelCopyWith<$Res> implements $NoticeReadMemberModelCopyWith<$Res> {
  factory _$NoticeReadMemberModelCopyWith(_NoticeReadMemberModel value, $Res Function(_NoticeReadMemberModel) _then) = __$NoticeReadMemberModelCopyWithImpl;
@override @useResult
$Res call({
 int memberId, String? userName, String? profileColor, String? readAt
});




}
/// @nodoc
class __$NoticeReadMemberModelCopyWithImpl<$Res>
    implements _$NoticeReadMemberModelCopyWith<$Res> {
  __$NoticeReadMemberModelCopyWithImpl(this._self, this._then);

  final _NoticeReadMemberModel _self;
  final $Res Function(_NoticeReadMemberModel) _then;

/// Create a copy of NoticeReadMemberModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? memberId = null,Object? userName = freezed,Object? profileColor = freezed,Object? readAt = freezed,}) {
  return _then(_NoticeReadMemberModel(
memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as int,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,profileColor: freezed == profileColor ? _self.profileColor : profileColor // ignore: cast_nullable_to_non_nullable
as String?,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
