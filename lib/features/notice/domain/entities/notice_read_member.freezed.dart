// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notice_read_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NoticeReadMember {

 int get memberId;/// 회원 기능이 생기기 전까지 null 일 수 있습니다.
 String? get userName; ProfileColor get profileColor;/// 처음 읽은 시각. 읽지 않은 구성원은 null 입니다.
 DateTime? get readAt;
/// Create a copy of NoticeReadMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoticeReadMemberCopyWith<NoticeReadMember> get copyWith => _$NoticeReadMemberCopyWithImpl<NoticeReadMember>(this as NoticeReadMember, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoticeReadMember&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.profileColor, profileColor) || other.profileColor == profileColor)&&(identical(other.readAt, readAt) || other.readAt == readAt));
}


@override
int get hashCode => Object.hash(runtimeType,memberId,userName,profileColor,readAt);

@override
String toString() {
  return 'NoticeReadMember(memberId: $memberId, userName: $userName, profileColor: $profileColor, readAt: $readAt)';
}


}

/// @nodoc
abstract mixin class $NoticeReadMemberCopyWith<$Res>  {
  factory $NoticeReadMemberCopyWith(NoticeReadMember value, $Res Function(NoticeReadMember) _then) = _$NoticeReadMemberCopyWithImpl;
@useResult
$Res call({
 int memberId, String? userName, ProfileColor profileColor, DateTime? readAt
});




}
/// @nodoc
class _$NoticeReadMemberCopyWithImpl<$Res>
    implements $NoticeReadMemberCopyWith<$Res> {
  _$NoticeReadMemberCopyWithImpl(this._self, this._then);

  final NoticeReadMember _self;
  final $Res Function(NoticeReadMember) _then;

/// Create a copy of NoticeReadMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? memberId = null,Object? userName = freezed,Object? profileColor = null,Object? readAt = freezed,}) {
  return _then(NoticeReadMember(
memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as int,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,profileColor: null == profileColor ? _self.profileColor : profileColor // ignore: cast_nullable_to_non_nullable
as ProfileColor,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [NoticeReadMember].
extension NoticeReadMemberPatterns on NoticeReadMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoticeReadMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoticeReadMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoticeReadMember value)  $default,){
final _that = this;
switch (_that) {
case _NoticeReadMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoticeReadMember value)?  $default,){
final _that = this;
switch (_that) {
case _NoticeReadMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int memberId,  String? userName,  ProfileColor profileColor,  DateTime? readAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoticeReadMember() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int memberId,  String? userName,  ProfileColor profileColor,  DateTime? readAt)  $default,) {final _that = this;
switch (_that) {
case _NoticeReadMember():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int memberId,  String? userName,  ProfileColor profileColor,  DateTime? readAt)?  $default,) {final _that = this;
switch (_that) {
case _NoticeReadMember() when $default != null:
return $default(_that.memberId,_that.userName,_that.profileColor,_that.readAt);case _:
  return null;

}
}

}

/// @nodoc


class _NoticeReadMember implements NoticeReadMember {
  const _NoticeReadMember({required this.memberId, this.userName, this.profileColor = ProfileColor.lightBlue, this.readAt});
  

@override final  int memberId;
/// 회원 기능이 생기기 전까지 null 일 수 있습니다.
@override final  String? userName;
@override@JsonKey() final  ProfileColor profileColor;
/// 처음 읽은 시각. 읽지 않은 구성원은 null 입니다.
@override final  DateTime? readAt;

/// Create a copy of NoticeReadMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoticeReadMemberCopyWith<_NoticeReadMember> get copyWith => __$NoticeReadMemberCopyWithImpl<_NoticeReadMember>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoticeReadMember&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.profileColor, profileColor) || other.profileColor == profileColor)&&(identical(other.readAt, readAt) || other.readAt == readAt));
}


@override
int get hashCode => Object.hash(runtimeType,memberId,userName,profileColor,readAt);

@override
String toString() {
  return 'NoticeReadMember(memberId: $memberId, userName: $userName, profileColor: $profileColor, readAt: $readAt)';
}


}

/// @nodoc
abstract mixin class _$NoticeReadMemberCopyWith<$Res> implements $NoticeReadMemberCopyWith<$Res> {
  factory _$NoticeReadMemberCopyWith(_NoticeReadMember value, $Res Function(_NoticeReadMember) _then) = __$NoticeReadMemberCopyWithImpl;
@override @useResult
$Res call({
 int memberId, String? userName, ProfileColor profileColor, DateTime? readAt
});




}
/// @nodoc
class __$NoticeReadMemberCopyWithImpl<$Res>
    implements _$NoticeReadMemberCopyWith<$Res> {
  __$NoticeReadMemberCopyWithImpl(this._self, this._then);

  final _NoticeReadMember _self;
  final $Res Function(_NoticeReadMember) _then;

/// Create a copy of NoticeReadMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? memberId = null,Object? userName = freezed,Object? profileColor = null,Object? readAt = freezed,}) {
  return _then(_NoticeReadMember(
memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as int,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,profileColor: null == profileColor ? _self.profileColor : profileColor // ignore: cast_nullable_to_non_nullable
as ProfileColor,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
