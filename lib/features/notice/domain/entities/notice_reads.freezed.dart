// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notice_reads.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NoticeReads {

 int get readCount; int get totalCount;/// 읽은 시각 순서
 List<NoticeReadMember> get readMembers;/// memberId 오름차순 (모임 가입 순)
 List<NoticeReadMember> get unreadMembers;
/// Create a copy of NoticeReads
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoticeReadsCopyWith<NoticeReads> get copyWith => _$NoticeReadsCopyWithImpl<NoticeReads>(this as NoticeReads, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoticeReads&&(identical(other.readCount, readCount) || other.readCount == readCount)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&const DeepCollectionEquality().equals(other.readMembers, readMembers)&&const DeepCollectionEquality().equals(other.unreadMembers, unreadMembers));
}


@override
int get hashCode => Object.hash(runtimeType,readCount,totalCount,const DeepCollectionEquality().hash(readMembers),const DeepCollectionEquality().hash(unreadMembers));

@override
String toString() {
  return 'NoticeReads(readCount: $readCount, totalCount: $totalCount, readMembers: $readMembers, unreadMembers: $unreadMembers)';
}


}

/// @nodoc
abstract mixin class $NoticeReadsCopyWith<$Res>  {
  factory $NoticeReadsCopyWith(NoticeReads value, $Res Function(NoticeReads) _then) = _$NoticeReadsCopyWithImpl;
@useResult
$Res call({
 int readCount, int totalCount, List<NoticeReadMember> readMembers, List<NoticeReadMember> unreadMembers
});




}
/// @nodoc
class _$NoticeReadsCopyWithImpl<$Res>
    implements $NoticeReadsCopyWith<$Res> {
  _$NoticeReadsCopyWithImpl(this._self, this._then);

  final NoticeReads _self;
  final $Res Function(NoticeReads) _then;

/// Create a copy of NoticeReads
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? readCount = null,Object? totalCount = null,Object? readMembers = null,Object? unreadMembers = null,}) {
  return _then(NoticeReads(
readCount: null == readCount ? _self.readCount : readCount // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,readMembers: null == readMembers ? _self.readMembers : readMembers // ignore: cast_nullable_to_non_nullable
as List<NoticeReadMember>,unreadMembers: null == unreadMembers ? _self.unreadMembers : unreadMembers // ignore: cast_nullable_to_non_nullable
as List<NoticeReadMember>,
  ));
}

}


/// Adds pattern-matching-related methods to [NoticeReads].
extension NoticeReadsPatterns on NoticeReads {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoticeReads value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoticeReads() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoticeReads value)  $default,){
final _that = this;
switch (_that) {
case _NoticeReads():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoticeReads value)?  $default,){
final _that = this;
switch (_that) {
case _NoticeReads() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int readCount,  int totalCount,  List<NoticeReadMember> readMembers,  List<NoticeReadMember> unreadMembers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoticeReads() when $default != null:
return $default(_that.readCount,_that.totalCount,_that.readMembers,_that.unreadMembers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int readCount,  int totalCount,  List<NoticeReadMember> readMembers,  List<NoticeReadMember> unreadMembers)  $default,) {final _that = this;
switch (_that) {
case _NoticeReads():
return $default(_that.readCount,_that.totalCount,_that.readMembers,_that.unreadMembers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int readCount,  int totalCount,  List<NoticeReadMember> readMembers,  List<NoticeReadMember> unreadMembers)?  $default,) {final _that = this;
switch (_that) {
case _NoticeReads() when $default != null:
return $default(_that.readCount,_that.totalCount,_that.readMembers,_that.unreadMembers);case _:
  return null;

}
}

}

/// @nodoc


class _NoticeReads implements NoticeReads {
  const _NoticeReads({required this.readCount, required this.totalCount, required  List<NoticeReadMember> readMembers, required  List<NoticeReadMember> unreadMembers}): _readMembers = readMembers,_unreadMembers = unreadMembers;
  

@override final  int readCount;
@override final  int totalCount;
/// 읽은 시각 순서
 final  List<NoticeReadMember> _readMembers;
/// 읽은 시각 순서
@override List<NoticeReadMember> get readMembers {
  if (_readMembers is EqualUnmodifiableListView) return _readMembers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_readMembers);
}

/// memberId 오름차순 (모임 가입 순)
 final  List<NoticeReadMember> _unreadMembers;
/// memberId 오름차순 (모임 가입 순)
@override List<NoticeReadMember> get unreadMembers {
  if (_unreadMembers is EqualUnmodifiableListView) return _unreadMembers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_unreadMembers);
}


/// Create a copy of NoticeReads
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoticeReadsCopyWith<_NoticeReads> get copyWith => __$NoticeReadsCopyWithImpl<_NoticeReads>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoticeReads&&(identical(other.readCount, readCount) || other.readCount == readCount)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&const DeepCollectionEquality().equals(other._readMembers, _readMembers)&&const DeepCollectionEquality().equals(other._unreadMembers, _unreadMembers));
}


@override
int get hashCode => Object.hash(runtimeType,readCount,totalCount,const DeepCollectionEquality().hash(_readMembers),const DeepCollectionEquality().hash(_unreadMembers));

@override
String toString() {
  return 'NoticeReads(readCount: $readCount, totalCount: $totalCount, readMembers: $readMembers, unreadMembers: $unreadMembers)';
}


}

/// @nodoc
abstract mixin class _$NoticeReadsCopyWith<$Res> implements $NoticeReadsCopyWith<$Res> {
  factory _$NoticeReadsCopyWith(_NoticeReads value, $Res Function(_NoticeReads) _then) = __$NoticeReadsCopyWithImpl;
@override @useResult
$Res call({
 int readCount, int totalCount, List<NoticeReadMember> readMembers, List<NoticeReadMember> unreadMembers
});




}
/// @nodoc
class __$NoticeReadsCopyWithImpl<$Res>
    implements _$NoticeReadsCopyWith<$Res> {
  __$NoticeReadsCopyWithImpl(this._self, this._then);

  final _NoticeReads _self;
  final $Res Function(_NoticeReads) _then;

/// Create a copy of NoticeReads
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? readCount = null,Object? totalCount = null,Object? readMembers = null,Object? unreadMembers = null,}) {
  return _then(_NoticeReads(
readCount: null == readCount ? _self.readCount : readCount // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,readMembers: null == readMembers ? _self._readMembers : readMembers // ignore: cast_nullable_to_non_nullable
as List<NoticeReadMember>,unreadMembers: null == unreadMembers ? _self._unreadMembers : unreadMembers // ignore: cast_nullable_to_non_nullable
as List<NoticeReadMember>,
  ));
}


}

// dart format on
