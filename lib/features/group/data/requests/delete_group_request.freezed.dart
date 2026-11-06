// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_group_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeleteGroupRequest {

@JsonKey(includeToJson: false) int get meetingId;
/// Create a copy of DeleteGroupRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteGroupRequestCopyWith<DeleteGroupRequest> get copyWith => _$DeleteGroupRequestCopyWithImpl<DeleteGroupRequest>(this as DeleteGroupRequest, _$identity);

  /// Serializes this DeleteGroupRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteGroupRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meetingId);

@override
String toString() {
  return 'DeleteGroupRequest(meetingId: $meetingId)';
}


}

/// @nodoc
abstract mixin class $DeleteGroupRequestCopyWith<$Res>  {
  factory $DeleteGroupRequestCopyWith(DeleteGroupRequest value, $Res Function(DeleteGroupRequest) _then) = _$DeleteGroupRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false) int meetingId
});




}
/// @nodoc
class _$DeleteGroupRequestCopyWithImpl<$Res>
    implements $DeleteGroupRequestCopyWith<$Res> {
  _$DeleteGroupRequestCopyWithImpl(this._self, this._then);

  final DeleteGroupRequest _self;
  final $Res Function(DeleteGroupRequest) _then;

/// Create a copy of DeleteGroupRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingId = null,}) {
  return _then(DeleteGroupRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DeleteGroupRequest].
extension DeleteGroupRequestPatterns on DeleteGroupRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeleteGroupRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeleteGroupRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeleteGroupRequest value)  $default,){
final _that = this;
switch (_that) {
case _DeleteGroupRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeleteGroupRequest value)?  $default,){
final _that = this;
switch (_that) {
case _DeleteGroupRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  int meetingId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeleteGroupRequest() when $default != null:
return $default(_that.meetingId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  int meetingId)  $default,) {final _that = this;
switch (_that) {
case _DeleteGroupRequest():
return $default(_that.meetingId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false)  int meetingId)?  $default,) {final _that = this;
switch (_that) {
case _DeleteGroupRequest() when $default != null:
return $default(_that.meetingId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeleteGroupRequest implements DeleteGroupRequest {
  const _DeleteGroupRequest({@JsonKey(includeToJson: false) required this.meetingId});
  factory _DeleteGroupRequest.fromJson(Map<String, dynamic> json) => _$DeleteGroupRequestFromJson(json);

@override@JsonKey(includeToJson: false) final  int meetingId;

/// Create a copy of DeleteGroupRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteGroupRequestCopyWith<_DeleteGroupRequest> get copyWith => __$DeleteGroupRequestCopyWithImpl<_DeleteGroupRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeleteGroupRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteGroupRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meetingId);

@override
String toString() {
  return 'DeleteGroupRequest(meetingId: $meetingId)';
}


}

/// @nodoc
abstract mixin class _$DeleteGroupRequestCopyWith<$Res> implements $DeleteGroupRequestCopyWith<$Res> {
  factory _$DeleteGroupRequestCopyWith(_DeleteGroupRequest value, $Res Function(_DeleteGroupRequest) _then) = __$DeleteGroupRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false) int meetingId
});




}
/// @nodoc
class __$DeleteGroupRequestCopyWithImpl<$Res>
    implements _$DeleteGroupRequestCopyWith<$Res> {
  __$DeleteGroupRequestCopyWithImpl(this._self, this._then);

  final _DeleteGroupRequest _self;
  final $Res Function(_DeleteGroupRequest) _then;

/// Create a copy of DeleteGroupRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingId = null,}) {
  return _then(_DeleteGroupRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
