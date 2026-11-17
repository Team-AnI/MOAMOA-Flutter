// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vote_responses.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VoteResponses {

 int get memberCount; int get respondedCount; List<VoteMemberResponse> get members;
/// Create a copy of VoteResponses
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoteResponsesCopyWith<VoteResponses> get copyWith => _$VoteResponsesCopyWithImpl<VoteResponses>(this as VoteResponses, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoteResponses&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.respondedCount, respondedCount) || other.respondedCount == respondedCount)&&const DeepCollectionEquality().equals(other.members, members));
}


@override
int get hashCode => Object.hash(runtimeType,memberCount,respondedCount,const DeepCollectionEquality().hash(members));

@override
String toString() {
  return 'VoteResponses(memberCount: $memberCount, respondedCount: $respondedCount, members: $members)';
}


}

/// @nodoc
abstract mixin class $VoteResponsesCopyWith<$Res>  {
  factory $VoteResponsesCopyWith(VoteResponses value, $Res Function(VoteResponses) _then) = _$VoteResponsesCopyWithImpl;
@useResult
$Res call({
 int memberCount, int respondedCount, List<VoteMemberResponse> members
});




}
/// @nodoc
class _$VoteResponsesCopyWithImpl<$Res>
    implements $VoteResponsesCopyWith<$Res> {
  _$VoteResponsesCopyWithImpl(this._self, this._then);

  final VoteResponses _self;
  final $Res Function(VoteResponses) _then;

/// Create a copy of VoteResponses
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? memberCount = null,Object? respondedCount = null,Object? members = null,}) {
  return _then(VoteResponses(
memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,respondedCount: null == respondedCount ? _self.respondedCount : respondedCount // ignore: cast_nullable_to_non_nullable
as int,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<VoteMemberResponse>,
  ));
}

}


/// Adds pattern-matching-related methods to [VoteResponses].
extension VoteResponsesPatterns on VoteResponses {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoteResponses value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoteResponses() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoteResponses value)  $default,){
final _that = this;
switch (_that) {
case _VoteResponses():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoteResponses value)?  $default,){
final _that = this;
switch (_that) {
case _VoteResponses() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int memberCount,  int respondedCount,  List<VoteMemberResponse> members)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoteResponses() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int memberCount,  int respondedCount,  List<VoteMemberResponse> members)  $default,) {final _that = this;
switch (_that) {
case _VoteResponses():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int memberCount,  int respondedCount,  List<VoteMemberResponse> members)?  $default,) {final _that = this;
switch (_that) {
case _VoteResponses() when $default != null:
return $default(_that.memberCount,_that.respondedCount,_that.members);case _:
  return null;

}
}

}

/// @nodoc


class _VoteResponses implements VoteResponses {
  const _VoteResponses({required this.memberCount, required this.respondedCount, required  List<VoteMemberResponse> members}): _members = members;
  

@override final  int memberCount;
@override final  int respondedCount;
 final  List<VoteMemberResponse> _members;
@override List<VoteMemberResponse> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}


/// Create a copy of VoteResponses
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoteResponsesCopyWith<_VoteResponses> get copyWith => __$VoteResponsesCopyWithImpl<_VoteResponses>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoteResponses&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.respondedCount, respondedCount) || other.respondedCount == respondedCount)&&const DeepCollectionEquality().equals(other._members, _members));
}


@override
int get hashCode => Object.hash(runtimeType,memberCount,respondedCount,const DeepCollectionEquality().hash(_members));

@override
String toString() {
  return 'VoteResponses(memberCount: $memberCount, respondedCount: $respondedCount, members: $members)';
}


}

/// @nodoc
abstract mixin class _$VoteResponsesCopyWith<$Res> implements $VoteResponsesCopyWith<$Res> {
  factory _$VoteResponsesCopyWith(_VoteResponses value, $Res Function(_VoteResponses) _then) = __$VoteResponsesCopyWithImpl;
@override @useResult
$Res call({
 int memberCount, int respondedCount, List<VoteMemberResponse> members
});




}
/// @nodoc
class __$VoteResponsesCopyWithImpl<$Res>
    implements _$VoteResponsesCopyWith<$Res> {
  __$VoteResponsesCopyWithImpl(this._self, this._then);

  final _VoteResponses _self;
  final $Res Function(_VoteResponses) _then;

/// Create a copy of VoteResponses
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? memberCount = null,Object? respondedCount = null,Object? members = null,}) {
  return _then(_VoteResponses(
memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,respondedCount: null == respondedCount ? _self.respondedCount : respondedCount // ignore: cast_nullable_to_non_nullable
as int,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<VoteMemberResponse>,
  ));
}


}

// dart format on
