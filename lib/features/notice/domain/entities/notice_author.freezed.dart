// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notice_author.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NoticeAuthor {

 int get memberId; String? get userName; ProfileColor get profileColor;
/// Create a copy of NoticeAuthor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoticeAuthorCopyWith<NoticeAuthor> get copyWith => _$NoticeAuthorCopyWithImpl<NoticeAuthor>(this as NoticeAuthor, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoticeAuthor&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.profileColor, profileColor) || other.profileColor == profileColor));
}


@override
int get hashCode => Object.hash(runtimeType,memberId,userName,profileColor);

@override
String toString() {
  return 'NoticeAuthor(memberId: $memberId, userName: $userName, profileColor: $profileColor)';
}


}

/// @nodoc
abstract mixin class $NoticeAuthorCopyWith<$Res>  {
  factory $NoticeAuthorCopyWith(NoticeAuthor value, $Res Function(NoticeAuthor) _then) = _$NoticeAuthorCopyWithImpl;
@useResult
$Res call({
 int memberId, String? userName, ProfileColor profileColor
});




}
/// @nodoc
class _$NoticeAuthorCopyWithImpl<$Res>
    implements $NoticeAuthorCopyWith<$Res> {
  _$NoticeAuthorCopyWithImpl(this._self, this._then);

  final NoticeAuthor _self;
  final $Res Function(NoticeAuthor) _then;

/// Create a copy of NoticeAuthor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? memberId = null,Object? userName = freezed,Object? profileColor = null,}) {
  return _then(NoticeAuthor(
memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as int,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,profileColor: null == profileColor ? _self.profileColor : profileColor // ignore: cast_nullable_to_non_nullable
as ProfileColor,
  ));
}

}


/// Adds pattern-matching-related methods to [NoticeAuthor].
extension NoticeAuthorPatterns on NoticeAuthor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoticeAuthor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoticeAuthor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoticeAuthor value)  $default,){
final _that = this;
switch (_that) {
case _NoticeAuthor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoticeAuthor value)?  $default,){
final _that = this;
switch (_that) {
case _NoticeAuthor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int memberId,  String? userName,  ProfileColor profileColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoticeAuthor() when $default != null:
return $default(_that.memberId,_that.userName,_that.profileColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int memberId,  String? userName,  ProfileColor profileColor)  $default,) {final _that = this;
switch (_that) {
case _NoticeAuthor():
return $default(_that.memberId,_that.userName,_that.profileColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int memberId,  String? userName,  ProfileColor profileColor)?  $default,) {final _that = this;
switch (_that) {
case _NoticeAuthor() when $default != null:
return $default(_that.memberId,_that.userName,_that.profileColor);case _:
  return null;

}
}

}

/// @nodoc


class _NoticeAuthor implements NoticeAuthor {
  const _NoticeAuthor({required this.memberId, this.userName, this.profileColor = ProfileColor.lightBlue});
  

@override final  int memberId;
@override final  String? userName;
@override@JsonKey() final  ProfileColor profileColor;

/// Create a copy of NoticeAuthor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoticeAuthorCopyWith<_NoticeAuthor> get copyWith => __$NoticeAuthorCopyWithImpl<_NoticeAuthor>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoticeAuthor&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.profileColor, profileColor) || other.profileColor == profileColor));
}


@override
int get hashCode => Object.hash(runtimeType,memberId,userName,profileColor);

@override
String toString() {
  return 'NoticeAuthor(memberId: $memberId, userName: $userName, profileColor: $profileColor)';
}


}

/// @nodoc
abstract mixin class _$NoticeAuthorCopyWith<$Res> implements $NoticeAuthorCopyWith<$Res> {
  factory _$NoticeAuthorCopyWith(_NoticeAuthor value, $Res Function(_NoticeAuthor) _then) = __$NoticeAuthorCopyWithImpl;
@override @useResult
$Res call({
 int memberId, String? userName, ProfileColor profileColor
});




}
/// @nodoc
class __$NoticeAuthorCopyWithImpl<$Res>
    implements _$NoticeAuthorCopyWith<$Res> {
  __$NoticeAuthorCopyWithImpl(this._self, this._then);

  final _NoticeAuthor _self;
  final $Res Function(_NoticeAuthor) _then;

/// Create a copy of NoticeAuthor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? memberId = null,Object? userName = freezed,Object? profileColor = null,}) {
  return _then(_NoticeAuthor(
memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as int,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,profileColor: null == profileColor ? _self.profileColor : profileColor // ignore: cast_nullable_to_non_nullable
as ProfileColor,
  ));
}


}

// dart format on
