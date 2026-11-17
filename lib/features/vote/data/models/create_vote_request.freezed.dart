// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_vote_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateVoteRequest {

@JsonKey(includeToJson: false) int get meetingId; String get title; String get voteDeadlineAt; List<String> get meetingTimes;
/// Create a copy of CreateVoteRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateVoteRequestCopyWith<CreateVoteRequest> get copyWith => _$CreateVoteRequestCopyWithImpl<CreateVoteRequest>(this as CreateVoteRequest, _$identity);

  /// Serializes this CreateVoteRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateVoteRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.title, title) || other.title == title)&&(identical(other.voteDeadlineAt, voteDeadlineAt) || other.voteDeadlineAt == voteDeadlineAt)&&const DeepCollectionEquality().equals(other.meetingTimes, meetingTimes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meetingId,title,voteDeadlineAt,const DeepCollectionEquality().hash(meetingTimes));

@override
String toString() {
  return 'CreateVoteRequest(meetingId: $meetingId, title: $title, voteDeadlineAt: $voteDeadlineAt, meetingTimes: $meetingTimes)';
}


}

/// @nodoc
abstract mixin class $CreateVoteRequestCopyWith<$Res>  {
  factory $CreateVoteRequestCopyWith(CreateVoteRequest value, $Res Function(CreateVoteRequest) _then) = _$CreateVoteRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false) int meetingId, String title, String voteDeadlineAt, List<String> meetingTimes
});




}
/// @nodoc
class _$CreateVoteRequestCopyWithImpl<$Res>
    implements $CreateVoteRequestCopyWith<$Res> {
  _$CreateVoteRequestCopyWithImpl(this._self, this._then);

  final CreateVoteRequest _self;
  final $Res Function(CreateVoteRequest) _then;

/// Create a copy of CreateVoteRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingId = null,Object? title = null,Object? voteDeadlineAt = null,Object? meetingTimes = null,}) {
  return _then(CreateVoteRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,voteDeadlineAt: null == voteDeadlineAt ? _self.voteDeadlineAt : voteDeadlineAt // ignore: cast_nullable_to_non_nullable
as String,meetingTimes: null == meetingTimes ? _self.meetingTimes : meetingTimes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateVoteRequest].
extension CreateVoteRequestPatterns on CreateVoteRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateVoteRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateVoteRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateVoteRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateVoteRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateVoteRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateVoteRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  int meetingId,  String title,  String voteDeadlineAt,  List<String> meetingTimes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateVoteRequest() when $default != null:
return $default(_that.meetingId,_that.title,_that.voteDeadlineAt,_that.meetingTimes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  int meetingId,  String title,  String voteDeadlineAt,  List<String> meetingTimes)  $default,) {final _that = this;
switch (_that) {
case _CreateVoteRequest():
return $default(_that.meetingId,_that.title,_that.voteDeadlineAt,_that.meetingTimes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false)  int meetingId,  String title,  String voteDeadlineAt,  List<String> meetingTimes)?  $default,) {final _that = this;
switch (_that) {
case _CreateVoteRequest() when $default != null:
return $default(_that.meetingId,_that.title,_that.voteDeadlineAt,_that.meetingTimes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateVoteRequest implements CreateVoteRequest {
  const _CreateVoteRequest({@JsonKey(includeToJson: false) required this.meetingId, required this.title, required this.voteDeadlineAt, required  List<String> meetingTimes}): _meetingTimes = meetingTimes;
  factory _CreateVoteRequest.fromJson(Map<String, dynamic> json) => _$CreateVoteRequestFromJson(json);

@override@JsonKey(includeToJson: false) final  int meetingId;
@override final  String title;
@override final  String voteDeadlineAt;
 final  List<String> _meetingTimes;
@override List<String> get meetingTimes {
  if (_meetingTimes is EqualUnmodifiableListView) return _meetingTimes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_meetingTimes);
}


/// Create a copy of CreateVoteRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateVoteRequestCopyWith<_CreateVoteRequest> get copyWith => __$CreateVoteRequestCopyWithImpl<_CreateVoteRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateVoteRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateVoteRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.title, title) || other.title == title)&&(identical(other.voteDeadlineAt, voteDeadlineAt) || other.voteDeadlineAt == voteDeadlineAt)&&const DeepCollectionEquality().equals(other._meetingTimes, _meetingTimes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meetingId,title,voteDeadlineAt,const DeepCollectionEquality().hash(_meetingTimes));

@override
String toString() {
  return 'CreateVoteRequest(meetingId: $meetingId, title: $title, voteDeadlineAt: $voteDeadlineAt, meetingTimes: $meetingTimes)';
}


}

/// @nodoc
abstract mixin class _$CreateVoteRequestCopyWith<$Res> implements $CreateVoteRequestCopyWith<$Res> {
  factory _$CreateVoteRequestCopyWith(_CreateVoteRequest value, $Res Function(_CreateVoteRequest) _then) = __$CreateVoteRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false) int meetingId, String title, String voteDeadlineAt, List<String> meetingTimes
});




}
/// @nodoc
class __$CreateVoteRequestCopyWithImpl<$Res>
    implements _$CreateVoteRequestCopyWith<$Res> {
  __$CreateVoteRequestCopyWithImpl(this._self, this._then);

  final _CreateVoteRequest _self;
  final $Res Function(_CreateVoteRequest) _then;

/// Create a copy of CreateVoteRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingId = null,Object? title = null,Object? voteDeadlineAt = null,Object? meetingTimes = null,}) {
  return _then(_CreateVoteRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,voteDeadlineAt: null == voteDeadlineAt ? _self.voteDeadlineAt : voteDeadlineAt // ignore: cast_nullable_to_non_nullable
as String,meetingTimes: null == meetingTimes ? _self._meetingTimes : meetingTimes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
