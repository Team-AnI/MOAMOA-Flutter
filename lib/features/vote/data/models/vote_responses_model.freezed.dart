// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vote_responses_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VoteResponsesModel {

 int get memberCount; int get respondedCount; List<VoteMemberResponseModel> get members;
/// Create a copy of VoteResponsesModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoteResponsesModelCopyWith<VoteResponsesModel> get copyWith => _$VoteResponsesModelCopyWithImpl<VoteResponsesModel>(this as VoteResponsesModel, _$identity);

  /// Serializes this VoteResponsesModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoteResponsesModel&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.respondedCount, respondedCount) || other.respondedCount == respondedCount)&&const DeepCollectionEquality().equals(other.members, members));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,memberCount,respondedCount,const DeepCollectionEquality().hash(members));

@override
String toString() {
  return 'VoteResponsesModel(memberCount: $memberCount, respondedCount: $respondedCount, members: $members)';
}


}

/// @nodoc
abstract mixin class $VoteResponsesModelCopyWith<$Res>  {
  factory $VoteResponsesModelCopyWith(VoteResponsesModel value, $Res Function(VoteResponsesModel) _then) = _$VoteResponsesModelCopyWithImpl;
@useResult
$Res call({
 int memberCount, int respondedCount, List<VoteMemberResponseModel> members
});




}
/// @nodoc
class _$VoteResponsesModelCopyWithImpl<$Res>
    implements $VoteResponsesModelCopyWith<$Res> {
  _$VoteResponsesModelCopyWithImpl(this._self, this._then);

  final VoteResponsesModel _self;
  final $Res Function(VoteResponsesModel) _then;

/// Create a copy of VoteResponsesModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? memberCount = null,Object? respondedCount = null,Object? members = null,}) {
  return _then(VoteResponsesModel(
memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,respondedCount: null == respondedCount ? _self.respondedCount : respondedCount // ignore: cast_nullable_to_non_nullable
as int,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<VoteMemberResponseModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [VoteResponsesModel].
extension VoteResponsesModelPatterns on VoteResponsesModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoteResponsesModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoteResponsesModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoteResponsesModel value)  $default,){
final _that = this;
switch (_that) {
case _VoteResponsesModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoteResponsesModel value)?  $default,){
final _that = this;
switch (_that) {
case _VoteResponsesModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int memberCount,  int respondedCount,  List<VoteMemberResponseModel> members)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoteResponsesModel() when $default != null:
return $default(_that.memberCount,_that.respondedCount,_that.members);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int memberCount,  int respondedCount,  List<VoteMemberResponseModel> members)  $default,) {final _that = this;
switch (_that) {
case _VoteResponsesModel():
return $default(_that.memberCount,_that.respondedCount,_that.members);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int memberCount,  int respondedCount,  List<VoteMemberResponseModel> members)?  $default,) {final _that = this;
switch (_that) {
case _VoteResponsesModel() when $default != null:
return $default(_that.memberCount,_that.respondedCount,_that.members);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VoteResponsesModel implements VoteResponsesModel {
  const _VoteResponsesModel({required this.memberCount, required this.respondedCount, required  List<VoteMemberResponseModel> members}): _members = members;
  factory _VoteResponsesModel.fromJson(Map<String, dynamic> json) => _$VoteResponsesModelFromJson(json);

@override final  int memberCount;
@override final  int respondedCount;
 final  List<VoteMemberResponseModel> _members;
@override List<VoteMemberResponseModel> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}


/// Create a copy of VoteResponsesModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoteResponsesModelCopyWith<_VoteResponsesModel> get copyWith => __$VoteResponsesModelCopyWithImpl<_VoteResponsesModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoteResponsesModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoteResponsesModel&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.respondedCount, respondedCount) || other.respondedCount == respondedCount)&&const DeepCollectionEquality().equals(other._members, _members));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,memberCount,respondedCount,const DeepCollectionEquality().hash(_members));

@override
String toString() {
  return 'VoteResponsesModel(memberCount: $memberCount, respondedCount: $respondedCount, members: $members)';
}


}

/// @nodoc
abstract mixin class _$VoteResponsesModelCopyWith<$Res> implements $VoteResponsesModelCopyWith<$Res> {
  factory _$VoteResponsesModelCopyWith(_VoteResponsesModel value, $Res Function(_VoteResponsesModel) _then) = __$VoteResponsesModelCopyWithImpl;
@override @useResult
$Res call({
 int memberCount, int respondedCount, List<VoteMemberResponseModel> members
});




}
/// @nodoc
class __$VoteResponsesModelCopyWithImpl<$Res>
    implements _$VoteResponsesModelCopyWith<$Res> {
  __$VoteResponsesModelCopyWithImpl(this._self, this._then);

  final _VoteResponsesModel _self;
  final $Res Function(_VoteResponsesModel) _then;

/// Create a copy of VoteResponsesModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? memberCount = null,Object? respondedCount = null,Object? members = null,}) {
  return _then(_VoteResponsesModel(
memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,respondedCount: null == respondedCount ? _self.respondedCount : respondedCount // ignore: cast_nullable_to_non_nullable
as int,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<VoteMemberResponseModel>,
  ));
}


}

// dart format on
