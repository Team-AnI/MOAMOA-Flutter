// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'submit_my_vote_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubmitMyVoteRequest {

@JsonKey(includeToJson: false) int get meetingId;@JsonKey(includeToJson: false) int get scheduleId; List<String> get meetingTimes;
/// Create a copy of SubmitMyVoteRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmitMyVoteRequestCopyWith<SubmitMyVoteRequest> get copyWith => _$SubmitMyVoteRequestCopyWithImpl<SubmitMyVoteRequest>(this as SubmitMyVoteRequest, _$identity);

  /// Serializes this SubmitMyVoteRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitMyVoteRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId)&&const DeepCollectionEquality().equals(other.meetingTimes, meetingTimes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meetingId,scheduleId,const DeepCollectionEquality().hash(meetingTimes));

@override
String toString() {
  return 'SubmitMyVoteRequest(meetingId: $meetingId, scheduleId: $scheduleId, meetingTimes: $meetingTimes)';
}


}

/// @nodoc
abstract mixin class $SubmitMyVoteRequestCopyWith<$Res>  {
  factory $SubmitMyVoteRequestCopyWith(SubmitMyVoteRequest value, $Res Function(SubmitMyVoteRequest) _then) = _$SubmitMyVoteRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false) int meetingId,@JsonKey(includeToJson: false) int scheduleId, List<String> meetingTimes
});




}
/// @nodoc
class _$SubmitMyVoteRequestCopyWithImpl<$Res>
    implements $SubmitMyVoteRequestCopyWith<$Res> {
  _$SubmitMyVoteRequestCopyWithImpl(this._self, this._then);

  final SubmitMyVoteRequest _self;
  final $Res Function(SubmitMyVoteRequest) _then;

/// Create a copy of SubmitMyVoteRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingId = null,Object? scheduleId = null,Object? meetingTimes = null,}) {
  return _then(SubmitMyVoteRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,scheduleId: null == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as int,meetingTimes: null == meetingTimes ? _self.meetingTimes : meetingTimes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SubmitMyVoteRequest].
extension SubmitMyVoteRequestPatterns on SubmitMyVoteRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubmitMyVoteRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubmitMyVoteRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubmitMyVoteRequest value)  $default,){
final _that = this;
switch (_that) {
case _SubmitMyVoteRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubmitMyVoteRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SubmitMyVoteRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  int meetingId, @JsonKey(includeToJson: false)  int scheduleId,  List<String> meetingTimes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubmitMyVoteRequest() when $default != null:
return $default(_that.meetingId,_that.scheduleId,_that.meetingTimes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  int meetingId, @JsonKey(includeToJson: false)  int scheduleId,  List<String> meetingTimes)  $default,) {final _that = this;
switch (_that) {
case _SubmitMyVoteRequest():
return $default(_that.meetingId,_that.scheduleId,_that.meetingTimes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false)  int meetingId, @JsonKey(includeToJson: false)  int scheduleId,  List<String> meetingTimes)?  $default,) {final _that = this;
switch (_that) {
case _SubmitMyVoteRequest() when $default != null:
return $default(_that.meetingId,_that.scheduleId,_that.meetingTimes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubmitMyVoteRequest implements SubmitMyVoteRequest {
  const _SubmitMyVoteRequest({@JsonKey(includeToJson: false) required this.meetingId, @JsonKey(includeToJson: false) required this.scheduleId, required  List<String> meetingTimes}): _meetingTimes = meetingTimes;
  factory _SubmitMyVoteRequest.fromJson(Map<String, dynamic> json) => _$SubmitMyVoteRequestFromJson(json);

@override@JsonKey(includeToJson: false) final  int meetingId;
@override@JsonKey(includeToJson: false) final  int scheduleId;
 final  List<String> _meetingTimes;
@override List<String> get meetingTimes {
  if (_meetingTimes is EqualUnmodifiableListView) return _meetingTimes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_meetingTimes);
}


/// Create a copy of SubmitMyVoteRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitMyVoteRequestCopyWith<_SubmitMyVoteRequest> get copyWith => __$SubmitMyVoteRequestCopyWithImpl<_SubmitMyVoteRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubmitMyVoteRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitMyVoteRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId)&&const DeepCollectionEquality().equals(other._meetingTimes, _meetingTimes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meetingId,scheduleId,const DeepCollectionEquality().hash(_meetingTimes));

@override
String toString() {
  return 'SubmitMyVoteRequest(meetingId: $meetingId, scheduleId: $scheduleId, meetingTimes: $meetingTimes)';
}


}

/// @nodoc
abstract mixin class _$SubmitMyVoteRequestCopyWith<$Res> implements $SubmitMyVoteRequestCopyWith<$Res> {
  factory _$SubmitMyVoteRequestCopyWith(_SubmitMyVoteRequest value, $Res Function(_SubmitMyVoteRequest) _then) = __$SubmitMyVoteRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false) int meetingId,@JsonKey(includeToJson: false) int scheduleId, List<String> meetingTimes
});




}
/// @nodoc
class __$SubmitMyVoteRequestCopyWithImpl<$Res>
    implements _$SubmitMyVoteRequestCopyWith<$Res> {
  __$SubmitMyVoteRequestCopyWithImpl(this._self, this._then);

  final _SubmitMyVoteRequest _self;
  final $Res Function(_SubmitMyVoteRequest) _then;

/// Create a copy of SubmitMyVoteRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingId = null,Object? scheduleId = null,Object? meetingTimes = null,}) {
  return _then(_SubmitMyVoteRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,scheduleId: null == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as int,meetingTimes: null == meetingTimes ? _self._meetingTimes : meetingTimes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
