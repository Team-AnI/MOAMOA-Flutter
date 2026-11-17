// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vote_member_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VoteMemberResponseModel {

 int get memberId;@JsonKey(readValue: _readUserName) String? get userName; bool get responded;/// ISO-8601. 제출하지 않았으면 null 입니다.
 String? get submittedAt;
/// Create a copy of VoteMemberResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoteMemberResponseModelCopyWith<VoteMemberResponseModel> get copyWith => _$VoteMemberResponseModelCopyWithImpl<VoteMemberResponseModel>(this as VoteMemberResponseModel, _$identity);

  /// Serializes this VoteMemberResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoteMemberResponseModel&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.responded, responded) || other.responded == responded)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,memberId,userName,responded,submittedAt);

@override
String toString() {
  return 'VoteMemberResponseModel(memberId: $memberId, userName: $userName, responded: $responded, submittedAt: $submittedAt)';
}


}

/// @nodoc
abstract mixin class $VoteMemberResponseModelCopyWith<$Res>  {
  factory $VoteMemberResponseModelCopyWith(VoteMemberResponseModel value, $Res Function(VoteMemberResponseModel) _then) = _$VoteMemberResponseModelCopyWithImpl;
@useResult
$Res call({
 int memberId,@JsonKey(readValue: _readUserName) String? userName, bool responded, String? submittedAt
});




}
/// @nodoc
class _$VoteMemberResponseModelCopyWithImpl<$Res>
    implements $VoteMemberResponseModelCopyWith<$Res> {
  _$VoteMemberResponseModelCopyWithImpl(this._self, this._then);

  final VoteMemberResponseModel _self;
  final $Res Function(VoteMemberResponseModel) _then;

/// Create a copy of VoteMemberResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? memberId = null,Object? userName = freezed,Object? responded = null,Object? submittedAt = freezed,}) {
  return _then(VoteMemberResponseModel(
memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as int,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,responded: null == responded ? _self.responded : responded // ignore: cast_nullable_to_non_nullable
as bool,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VoteMemberResponseModel].
extension VoteMemberResponseModelPatterns on VoteMemberResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoteMemberResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoteMemberResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoteMemberResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _VoteMemberResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoteMemberResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _VoteMemberResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int memberId, @JsonKey(readValue: _readUserName)  String? userName,  bool responded,  String? submittedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoteMemberResponseModel() when $default != null:
return $default(_that.memberId,_that.userName,_that.responded,_that.submittedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int memberId, @JsonKey(readValue: _readUserName)  String? userName,  bool responded,  String? submittedAt)  $default,) {final _that = this;
switch (_that) {
case _VoteMemberResponseModel():
return $default(_that.memberId,_that.userName,_that.responded,_that.submittedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int memberId, @JsonKey(readValue: _readUserName)  String? userName,  bool responded,  String? submittedAt)?  $default,) {final _that = this;
switch (_that) {
case _VoteMemberResponseModel() when $default != null:
return $default(_that.memberId,_that.userName,_that.responded,_that.submittedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VoteMemberResponseModel implements VoteMemberResponseModel {
  const _VoteMemberResponseModel({required this.memberId, @JsonKey(readValue: _readUserName) this.userName, required this.responded, this.submittedAt});
  factory _VoteMemberResponseModel.fromJson(Map<String, dynamic> json) => _$VoteMemberResponseModelFromJson(json);

@override final  int memberId;
@override@JsonKey(readValue: _readUserName) final  String? userName;
@override final  bool responded;
/// ISO-8601. 제출하지 않았으면 null 입니다.
@override final  String? submittedAt;

/// Create a copy of VoteMemberResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoteMemberResponseModelCopyWith<_VoteMemberResponseModel> get copyWith => __$VoteMemberResponseModelCopyWithImpl<_VoteMemberResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoteMemberResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoteMemberResponseModel&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.responded, responded) || other.responded == responded)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,memberId,userName,responded,submittedAt);

@override
String toString() {
  return 'VoteMemberResponseModel(memberId: $memberId, userName: $userName, responded: $responded, submittedAt: $submittedAt)';
}


}

/// @nodoc
abstract mixin class _$VoteMemberResponseModelCopyWith<$Res> implements $VoteMemberResponseModelCopyWith<$Res> {
  factory _$VoteMemberResponseModelCopyWith(_VoteMemberResponseModel value, $Res Function(_VoteMemberResponseModel) _then) = __$VoteMemberResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int memberId,@JsonKey(readValue: _readUserName) String? userName, bool responded, String? submittedAt
});




}
/// @nodoc
class __$VoteMemberResponseModelCopyWithImpl<$Res>
    implements _$VoteMemberResponseModelCopyWith<$Res> {
  __$VoteMemberResponseModelCopyWithImpl(this._self, this._then);

  final _VoteMemberResponseModel _self;
  final $Res Function(_VoteMemberResponseModel) _then;

/// Create a copy of VoteMemberResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? memberId = null,Object? userName = freezed,Object? responded = null,Object? submittedAt = freezed,}) {
  return _then(_VoteMemberResponseModel(
memberId: null == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as int,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,responded: null == responded ? _self.responded : responded // ignore: cast_nullable_to_non_nullable
as bool,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
