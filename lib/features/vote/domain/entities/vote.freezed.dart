// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vote.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Vote {

 int get scheduleId; String get title; VoteStatus get status; DateTime get voteDeadlineAt; bool get votingOpen; int get memberCount; int get respondedCount; bool get myResponded; List<VoteCandidate> get candidates;
/// Create a copy of Vote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoteCopyWith<Vote> get copyWith => _$VoteCopyWithImpl<Vote>(this as Vote, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Vote&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.voteDeadlineAt, voteDeadlineAt) || other.voteDeadlineAt == voteDeadlineAt)&&(identical(other.votingOpen, votingOpen) || other.votingOpen == votingOpen)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.respondedCount, respondedCount) || other.respondedCount == respondedCount)&&(identical(other.myResponded, myResponded) || other.myResponded == myResponded)&&const DeepCollectionEquality().equals(other.candidates, candidates));
}


@override
int get hashCode => Object.hash(runtimeType,scheduleId,title,status,voteDeadlineAt,votingOpen,memberCount,respondedCount,myResponded,const DeepCollectionEquality().hash(candidates));

@override
String toString() {
  return 'Vote(scheduleId: $scheduleId, title: $title, status: $status, voteDeadlineAt: $voteDeadlineAt, votingOpen: $votingOpen, memberCount: $memberCount, respondedCount: $respondedCount, myResponded: $myResponded, candidates: $candidates)';
}


}

/// @nodoc
abstract mixin class $VoteCopyWith<$Res>  {
  factory $VoteCopyWith(Vote value, $Res Function(Vote) _then) = _$VoteCopyWithImpl;
@useResult
$Res call({
 int scheduleId, String title, VoteStatus status, DateTime voteDeadlineAt, bool votingOpen, int memberCount, int respondedCount, bool myResponded, List<VoteCandidate> candidates
});




}
/// @nodoc
class _$VoteCopyWithImpl<$Res>
    implements $VoteCopyWith<$Res> {
  _$VoteCopyWithImpl(this._self, this._then);

  final Vote _self;
  final $Res Function(Vote) _then;

/// Create a copy of Vote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scheduleId = null,Object? title = null,Object? status = null,Object? voteDeadlineAt = null,Object? votingOpen = null,Object? memberCount = null,Object? respondedCount = null,Object? myResponded = null,Object? candidates = null,}) {
  return _then(Vote(
scheduleId: null == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VoteStatus,voteDeadlineAt: null == voteDeadlineAt ? _self.voteDeadlineAt : voteDeadlineAt // ignore: cast_nullable_to_non_nullable
as DateTime,votingOpen: null == votingOpen ? _self.votingOpen : votingOpen // ignore: cast_nullable_to_non_nullable
as bool,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,respondedCount: null == respondedCount ? _self.respondedCount : respondedCount // ignore: cast_nullable_to_non_nullable
as int,myResponded: null == myResponded ? _self.myResponded : myResponded // ignore: cast_nullable_to_non_nullable
as bool,candidates: null == candidates ? _self.candidates : candidates // ignore: cast_nullable_to_non_nullable
as List<VoteCandidate>,
  ));
}

}


/// Adds pattern-matching-related methods to [Vote].
extension VotePatterns on Vote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Vote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Vote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Vote value)  $default,){
final _that = this;
switch (_that) {
case _Vote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Vote value)?  $default,){
final _that = this;
switch (_that) {
case _Vote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int scheduleId,  String title,  VoteStatus status,  DateTime voteDeadlineAt,  bool votingOpen,  int memberCount,  int respondedCount,  bool myResponded,  List<VoteCandidate> candidates)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Vote() when $default != null:
return $default(_that.scheduleId,_that.title,_that.status,_that.voteDeadlineAt,_that.votingOpen,_that.memberCount,_that.respondedCount,_that.myResponded,_that.candidates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int scheduleId,  String title,  VoteStatus status,  DateTime voteDeadlineAt,  bool votingOpen,  int memberCount,  int respondedCount,  bool myResponded,  List<VoteCandidate> candidates)  $default,) {final _that = this;
switch (_that) {
case _Vote():
return $default(_that.scheduleId,_that.title,_that.status,_that.voteDeadlineAt,_that.votingOpen,_that.memberCount,_that.respondedCount,_that.myResponded,_that.candidates);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int scheduleId,  String title,  VoteStatus status,  DateTime voteDeadlineAt,  bool votingOpen,  int memberCount,  int respondedCount,  bool myResponded,  List<VoteCandidate> candidates)?  $default,) {final _that = this;
switch (_that) {
case _Vote() when $default != null:
return $default(_that.scheduleId,_that.title,_that.status,_that.voteDeadlineAt,_that.votingOpen,_that.memberCount,_that.respondedCount,_that.myResponded,_that.candidates);case _:
  return null;

}
}

}

/// @nodoc


class _Vote implements Vote {
  const _Vote({required this.scheduleId, required this.title, required this.status, required this.voteDeadlineAt, required this.votingOpen, required this.memberCount, required this.respondedCount, required this.myResponded, required  List<VoteCandidate> candidates}): _candidates = candidates;
  

@override final  int scheduleId;
@override final  String title;
@override final  VoteStatus status;
@override final  DateTime voteDeadlineAt;
@override final  bool votingOpen;
@override final  int memberCount;
@override final  int respondedCount;
@override final  bool myResponded;
 final  List<VoteCandidate> _candidates;
@override List<VoteCandidate> get candidates {
  if (_candidates is EqualUnmodifiableListView) return _candidates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_candidates);
}


/// Create a copy of Vote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoteCopyWith<_Vote> get copyWith => __$VoteCopyWithImpl<_Vote>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Vote&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.voteDeadlineAt, voteDeadlineAt) || other.voteDeadlineAt == voteDeadlineAt)&&(identical(other.votingOpen, votingOpen) || other.votingOpen == votingOpen)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.respondedCount, respondedCount) || other.respondedCount == respondedCount)&&(identical(other.myResponded, myResponded) || other.myResponded == myResponded)&&const DeepCollectionEquality().equals(other._candidates, _candidates));
}


@override
int get hashCode => Object.hash(runtimeType,scheduleId,title,status,voteDeadlineAt,votingOpen,memberCount,respondedCount,myResponded,const DeepCollectionEquality().hash(_candidates));

@override
String toString() {
  return 'Vote(scheduleId: $scheduleId, title: $title, status: $status, voteDeadlineAt: $voteDeadlineAt, votingOpen: $votingOpen, memberCount: $memberCount, respondedCount: $respondedCount, myResponded: $myResponded, candidates: $candidates)';
}


}

/// @nodoc
abstract mixin class _$VoteCopyWith<$Res> implements $VoteCopyWith<$Res> {
  factory _$VoteCopyWith(_Vote value, $Res Function(_Vote) _then) = __$VoteCopyWithImpl;
@override @useResult
$Res call({
 int scheduleId, String title, VoteStatus status, DateTime voteDeadlineAt, bool votingOpen, int memberCount, int respondedCount, bool myResponded, List<VoteCandidate> candidates
});




}
/// @nodoc
class __$VoteCopyWithImpl<$Res>
    implements _$VoteCopyWith<$Res> {
  __$VoteCopyWithImpl(this._self, this._then);

  final _Vote _self;
  final $Res Function(_Vote) _then;

/// Create a copy of Vote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scheduleId = null,Object? title = null,Object? status = null,Object? voteDeadlineAt = null,Object? votingOpen = null,Object? memberCount = null,Object? respondedCount = null,Object? myResponded = null,Object? candidates = null,}) {
  return _then(_Vote(
scheduleId: null == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VoteStatus,voteDeadlineAt: null == voteDeadlineAt ? _self.voteDeadlineAt : voteDeadlineAt // ignore: cast_nullable_to_non_nullable
as DateTime,votingOpen: null == votingOpen ? _self.votingOpen : votingOpen // ignore: cast_nullable_to_non_nullable
as bool,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,respondedCount: null == respondedCount ? _self.respondedCount : respondedCount // ignore: cast_nullable_to_non_nullable
as int,myResponded: null == myResponded ? _self.myResponded : myResponded // ignore: cast_nullable_to_non_nullable
as bool,candidates: null == candidates ? _self._candidates : candidates // ignore: cast_nullable_to_non_nullable
as List<VoteCandidate>,
  ));
}


}

// dart format on
