// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vote_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VoteModel {

 int get scheduleId; String get title;/// VOTING / CONFIRMED / CANCELED
 String get status;/// ISO-8601 (예: 2026-10-22T23:59:00+09:00)
 String get voteDeadlineAt; bool get votingOpen; int get memberCount; int get respondedCount; bool get myResponded; List<VoteCandidateModel> get candidates;
/// Create a copy of VoteModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoteModelCopyWith<VoteModel> get copyWith => _$VoteModelCopyWithImpl<VoteModel>(this as VoteModel, _$identity);

  /// Serializes this VoteModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoteModel&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.voteDeadlineAt, voteDeadlineAt) || other.voteDeadlineAt == voteDeadlineAt)&&(identical(other.votingOpen, votingOpen) || other.votingOpen == votingOpen)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.respondedCount, respondedCount) || other.respondedCount == respondedCount)&&(identical(other.myResponded, myResponded) || other.myResponded == myResponded)&&const DeepCollectionEquality().equals(other.candidates, candidates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scheduleId,title,status,voteDeadlineAt,votingOpen,memberCount,respondedCount,myResponded,const DeepCollectionEquality().hash(candidates));

@override
String toString() {
  return 'VoteModel(scheduleId: $scheduleId, title: $title, status: $status, voteDeadlineAt: $voteDeadlineAt, votingOpen: $votingOpen, memberCount: $memberCount, respondedCount: $respondedCount, myResponded: $myResponded, candidates: $candidates)';
}


}

/// @nodoc
abstract mixin class $VoteModelCopyWith<$Res>  {
  factory $VoteModelCopyWith(VoteModel value, $Res Function(VoteModel) _then) = _$VoteModelCopyWithImpl;
@useResult
$Res call({
 int scheduleId, String title, String status, String voteDeadlineAt, bool votingOpen, int memberCount, int respondedCount, bool myResponded, List<VoteCandidateModel> candidates
});




}
/// @nodoc
class _$VoteModelCopyWithImpl<$Res>
    implements $VoteModelCopyWith<$Res> {
  _$VoteModelCopyWithImpl(this._self, this._then);

  final VoteModel _self;
  final $Res Function(VoteModel) _then;

/// Create a copy of VoteModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scheduleId = null,Object? title = null,Object? status = null,Object? voteDeadlineAt = null,Object? votingOpen = null,Object? memberCount = null,Object? respondedCount = null,Object? myResponded = null,Object? candidates = null,}) {
  return _then(VoteModel(
scheduleId: null == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,voteDeadlineAt: null == voteDeadlineAt ? _self.voteDeadlineAt : voteDeadlineAt // ignore: cast_nullable_to_non_nullable
as String,votingOpen: null == votingOpen ? _self.votingOpen : votingOpen // ignore: cast_nullable_to_non_nullable
as bool,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,respondedCount: null == respondedCount ? _self.respondedCount : respondedCount // ignore: cast_nullable_to_non_nullable
as int,myResponded: null == myResponded ? _self.myResponded : myResponded // ignore: cast_nullable_to_non_nullable
as bool,candidates: null == candidates ? _self.candidates : candidates // ignore: cast_nullable_to_non_nullable
as List<VoteCandidateModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [VoteModel].
extension VoteModelPatterns on VoteModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoteModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoteModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoteModel value)  $default,){
final _that = this;
switch (_that) {
case _VoteModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoteModel value)?  $default,){
final _that = this;
switch (_that) {
case _VoteModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int scheduleId,  String title,  String status,  String voteDeadlineAt,  bool votingOpen,  int memberCount,  int respondedCount,  bool myResponded,  List<VoteCandidateModel> candidates)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoteModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int scheduleId,  String title,  String status,  String voteDeadlineAt,  bool votingOpen,  int memberCount,  int respondedCount,  bool myResponded,  List<VoteCandidateModel> candidates)  $default,) {final _that = this;
switch (_that) {
case _VoteModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int scheduleId,  String title,  String status,  String voteDeadlineAt,  bool votingOpen,  int memberCount,  int respondedCount,  bool myResponded,  List<VoteCandidateModel> candidates)?  $default,) {final _that = this;
switch (_that) {
case _VoteModel() when $default != null:
return $default(_that.scheduleId,_that.title,_that.status,_that.voteDeadlineAt,_that.votingOpen,_that.memberCount,_that.respondedCount,_that.myResponded,_that.candidates);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VoteModel implements VoteModel {
  const _VoteModel({required this.scheduleId, required this.title, required this.status, required this.voteDeadlineAt, required this.votingOpen, required this.memberCount, required this.respondedCount, required this.myResponded, required  List<VoteCandidateModel> candidates}): _candidates = candidates;
  factory _VoteModel.fromJson(Map<String, dynamic> json) => _$VoteModelFromJson(json);

@override final  int scheduleId;
@override final  String title;
/// VOTING / CONFIRMED / CANCELED
@override final  String status;
/// ISO-8601 (예: 2026-10-22T23:59:00+09:00)
@override final  String voteDeadlineAt;
@override final  bool votingOpen;
@override final  int memberCount;
@override final  int respondedCount;
@override final  bool myResponded;
 final  List<VoteCandidateModel> _candidates;
@override List<VoteCandidateModel> get candidates {
  if (_candidates is EqualUnmodifiableListView) return _candidates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_candidates);
}


/// Create a copy of VoteModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoteModelCopyWith<_VoteModel> get copyWith => __$VoteModelCopyWithImpl<_VoteModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoteModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoteModel&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.voteDeadlineAt, voteDeadlineAt) || other.voteDeadlineAt == voteDeadlineAt)&&(identical(other.votingOpen, votingOpen) || other.votingOpen == votingOpen)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.respondedCount, respondedCount) || other.respondedCount == respondedCount)&&(identical(other.myResponded, myResponded) || other.myResponded == myResponded)&&const DeepCollectionEquality().equals(other._candidates, _candidates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scheduleId,title,status,voteDeadlineAt,votingOpen,memberCount,respondedCount,myResponded,const DeepCollectionEquality().hash(_candidates));

@override
String toString() {
  return 'VoteModel(scheduleId: $scheduleId, title: $title, status: $status, voteDeadlineAt: $voteDeadlineAt, votingOpen: $votingOpen, memberCount: $memberCount, respondedCount: $respondedCount, myResponded: $myResponded, candidates: $candidates)';
}


}

/// @nodoc
abstract mixin class _$VoteModelCopyWith<$Res> implements $VoteModelCopyWith<$Res> {
  factory _$VoteModelCopyWith(_VoteModel value, $Res Function(_VoteModel) _then) = __$VoteModelCopyWithImpl;
@override @useResult
$Res call({
 int scheduleId, String title, String status, String voteDeadlineAt, bool votingOpen, int memberCount, int respondedCount, bool myResponded, List<VoteCandidateModel> candidates
});




}
/// @nodoc
class __$VoteModelCopyWithImpl<$Res>
    implements _$VoteModelCopyWith<$Res> {
  __$VoteModelCopyWithImpl(this._self, this._then);

  final _VoteModel _self;
  final $Res Function(_VoteModel) _then;

/// Create a copy of VoteModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scheduleId = null,Object? title = null,Object? status = null,Object? voteDeadlineAt = null,Object? votingOpen = null,Object? memberCount = null,Object? respondedCount = null,Object? myResponded = null,Object? candidates = null,}) {
  return _then(_VoteModel(
scheduleId: null == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,voteDeadlineAt: null == voteDeadlineAt ? _self.voteDeadlineAt : voteDeadlineAt // ignore: cast_nullable_to_non_nullable
as String,votingOpen: null == votingOpen ? _self.votingOpen : votingOpen // ignore: cast_nullable_to_non_nullable
as bool,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,respondedCount: null == respondedCount ? _self.respondedCount : respondedCount // ignore: cast_nullable_to_non_nullable
as int,myResponded: null == myResponded ? _self.myResponded : myResponded // ignore: cast_nullable_to_non_nullable
as bool,candidates: null == candidates ? _self._candidates : candidates // ignore: cast_nullable_to_non_nullable
as List<VoteCandidateModel>,
  ));
}


}

// dart format on
