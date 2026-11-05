// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notice_author_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NoticeAuthorModel {

 int get memberId; String? get userName;
/// Create a copy of NoticeAuthorModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoticeAuthorModelCopyWith<NoticeAuthorModel> get copyWith => _$NoticeAuthorModelCopyWithImpl<NoticeAuthorModel>(this as NoticeAuthorModel, _$identity);

  /// Serializes this NoticeAuthorModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoticeAuthorModel&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.userName, userName) || other.userName == userName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,memberId,userName);

@override
String toString() {
  return 'NoticeAuthorModel(memberId: $memberId, userName: $userName)';
}


}

/// @nodoc
abstract mixin class $NoticeAuthorModelCopyWith<$Res>  {
  factory $NoticeAuthorModelCopyWith(NoticeAuthorModel value, $Res Function(NoticeAuthorModel) _then) = _$NoticeAuthorModelCopyWithImpl;
@useResult
$Res call({
 int memberId, String? userName
});




}
/// @nodoc
class _$NoticeAuthorModelCopyWithImpl<$Res>
    implements $NoticeAuthorModelCopyWith<$Res> {
  _$NoticeAuthorModelCopyWithImpl(this._self, this._then);

  final NoticeAuthorModel _self;
  final $Res Function(NoticeAuthorModel) _then;

/// Create a copy of NoticeAuthorModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? memberId = null,Object? userName = freezed,}) {
  return _then(NoticeAuthorModel(
memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as int,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NoticeAuthorModel].
extension NoticeAuthorModelPatterns on NoticeAuthorModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoticeAuthorModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoticeAuthorModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoticeAuthorModel value)  $default,){
final _that = this;
switch (_that) {
case _NoticeAuthorModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoticeAuthorModel value)?  $default,){
final _that = this;
switch (_that) {
case _NoticeAuthorModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int memberId,  String? userName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoticeAuthorModel() when $default != null:
return $default(_that.memberId,_that.userName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int memberId,  String? userName)  $default,) {final _that = this;
switch (_that) {
case _NoticeAuthorModel():
return $default(_that.memberId,_that.userName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int memberId,  String? userName)?  $default,) {final _that = this;
switch (_that) {
case _NoticeAuthorModel() when $default != null:
return $default(_that.memberId,_that.userName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NoticeAuthorModel implements NoticeAuthorModel {
  const _NoticeAuthorModel({required this.memberId, this.userName});
  factory _NoticeAuthorModel.fromJson(Map<String, dynamic> json) => _$NoticeAuthorModelFromJson(json);

@override final  int memberId;
@override final  String? userName;

/// Create a copy of NoticeAuthorModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoticeAuthorModelCopyWith<_NoticeAuthorModel> get copyWith => __$NoticeAuthorModelCopyWithImpl<_NoticeAuthorModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NoticeAuthorModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoticeAuthorModel&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.userName, userName) || other.userName == userName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,memberId,userName);

@override
String toString() {
  return 'NoticeAuthorModel(memberId: $memberId, userName: $userName)';
}


}

/// @nodoc
abstract mixin class _$NoticeAuthorModelCopyWith<$Res> implements $NoticeAuthorModelCopyWith<$Res> {
  factory _$NoticeAuthorModelCopyWith(_NoticeAuthorModel value, $Res Function(_NoticeAuthorModel) _then) = __$NoticeAuthorModelCopyWithImpl;
@override @useResult
$Res call({
 int memberId, String? userName
});




}
/// @nodoc
class __$NoticeAuthorModelCopyWithImpl<$Res>
    implements _$NoticeAuthorModelCopyWith<$Res> {
  __$NoticeAuthorModelCopyWithImpl(this._self, this._then);

  final _NoticeAuthorModel _self;
  final $Res Function(_NoticeAuthorModel) _then;

/// Create a copy of NoticeAuthorModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? memberId = null,Object? userName = freezed,}) {
  return _then(_NoticeAuthorModel(
memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as int,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
