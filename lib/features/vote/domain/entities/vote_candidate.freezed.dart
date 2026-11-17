// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vote_candidate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VoteCandidate {

 DateTime get meetingTime; int get availableCount; bool get selectedByMe;
/// Create a copy of VoteCandidate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoteCandidateCopyWith<VoteCandidate> get copyWith => _$VoteCandidateCopyWithImpl<VoteCandidate>(this as VoteCandidate, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoteCandidate&&(identical(other.meetingTime, meetingTime) || other.meetingTime == meetingTime)&&(identical(other.availableCount, availableCount) || other.availableCount == availableCount)&&(identical(other.selectedByMe, selectedByMe) || other.selectedByMe == selectedByMe));
}


@override
int get hashCode => Object.hash(runtimeType,meetingTime,availableCount,selectedByMe);

@override
String toString() {
  return 'VoteCandidate(meetingTime: $meetingTime, availableCount: $availableCount, selectedByMe: $selectedByMe)';
}


}

/// @nodoc
abstract mixin class $VoteCandidateCopyWith<$Res>  {
  factory $VoteCandidateCopyWith(VoteCandidate value, $Res Function(VoteCandidate) _then) = _$VoteCandidateCopyWithImpl;
@useResult
$Res call({
 DateTime meetingTime, int availableCount, bool selectedByMe
});




}
/// @nodoc
class _$VoteCandidateCopyWithImpl<$Res>
    implements $VoteCandidateCopyWith<$Res> {
  _$VoteCandidateCopyWithImpl(this._self, this._then);

  final VoteCandidate _self;
  final $Res Function(VoteCandidate) _then;

/// Create a copy of VoteCandidate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingTime = null,Object? availableCount = null,Object? selectedByMe = null,}) {
  return _then(VoteCandidate(
meetingTime: null == meetingTime ? _self.meetingTime : meetingTime // ignore: cast_nullable_to_non_nullable
as DateTime,availableCount: null == availableCount ? _self.availableCount : availableCount // ignore: cast_nullable_to_non_nullable
as int,selectedByMe: null == selectedByMe ? _self.selectedByMe : selectedByMe // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VoteCandidate].
extension VoteCandidatePatterns on VoteCandidate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoteCandidate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoteCandidate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoteCandidate value)  $default,){
final _that = this;
switch (_that) {
case _VoteCandidate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoteCandidate value)?  $default,){
final _that = this;
switch (_that) {
case _VoteCandidate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime meetingTime,  int availableCount,  bool selectedByMe)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoteCandidate() when $default != null:
return $default(_that.meetingTime,_that.availableCount,_that.selectedByMe);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime meetingTime,  int availableCount,  bool selectedByMe)  $default,) {final _that = this;
switch (_that) {
case _VoteCandidate():
return $default(_that.meetingTime,_that.availableCount,_that.selectedByMe);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime meetingTime,  int availableCount,  bool selectedByMe)?  $default,) {final _that = this;
switch (_that) {
case _VoteCandidate() when $default != null:
return $default(_that.meetingTime,_that.availableCount,_that.selectedByMe);case _:
  return null;

}
}

}

/// @nodoc


class _VoteCandidate implements VoteCandidate {
  const _VoteCandidate({required this.meetingTime, required this.availableCount, required this.selectedByMe});
  

@override final  DateTime meetingTime;
@override final  int availableCount;
@override final  bool selectedByMe;

/// Create a copy of VoteCandidate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoteCandidateCopyWith<_VoteCandidate> get copyWith => __$VoteCandidateCopyWithImpl<_VoteCandidate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoteCandidate&&(identical(other.meetingTime, meetingTime) || other.meetingTime == meetingTime)&&(identical(other.availableCount, availableCount) || other.availableCount == availableCount)&&(identical(other.selectedByMe, selectedByMe) || other.selectedByMe == selectedByMe));
}


@override
int get hashCode => Object.hash(runtimeType,meetingTime,availableCount,selectedByMe);

@override
String toString() {
  return 'VoteCandidate(meetingTime: $meetingTime, availableCount: $availableCount, selectedByMe: $selectedByMe)';
}


}

/// @nodoc
abstract mixin class _$VoteCandidateCopyWith<$Res> implements $VoteCandidateCopyWith<$Res> {
  factory _$VoteCandidateCopyWith(_VoteCandidate value, $Res Function(_VoteCandidate) _then) = __$VoteCandidateCopyWithImpl;
@override @useResult
$Res call({
 DateTime meetingTime, int availableCount, bool selectedByMe
});




}
/// @nodoc
class __$VoteCandidateCopyWithImpl<$Res>
    implements _$VoteCandidateCopyWith<$Res> {
  __$VoteCandidateCopyWithImpl(this._self, this._then);

  final _VoteCandidate _self;
  final $Res Function(_VoteCandidate) _then;

/// Create a copy of VoteCandidate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingTime = null,Object? availableCount = null,Object? selectedByMe = null,}) {
  return _then(_VoteCandidate(
meetingTime: null == meetingTime ? _self.meetingTime : meetingTime // ignore: cast_nullable_to_non_nullable
as DateTime,availableCount: null == availableCount ? _self.availableCount : availableCount // ignore: cast_nullable_to_non_nullable
as int,selectedByMe: null == selectedByMe ? _self.selectedByMe : selectedByMe // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
