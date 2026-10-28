// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fetch_notices_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FetchNoticesRequest {

@JsonKey(includeToJson: false) int get meetingId;/// 0부터 시작
 int get page; int get size;
/// Create a copy of FetchNoticesRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchNoticesRequestCopyWith<FetchNoticesRequest> get copyWith => _$FetchNoticesRequestCopyWithImpl<FetchNoticesRequest>(this as FetchNoticesRequest, _$identity);

  /// Serializes this FetchNoticesRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchNoticesRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.page, page) || other.page == page)&&(identical(other.size, size) || other.size == size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meetingId,page,size);

@override
String toString() {
  return 'FetchNoticesRequest(meetingId: $meetingId, page: $page, size: $size)';
}


}

/// @nodoc
abstract mixin class $FetchNoticesRequestCopyWith<$Res>  {
  factory $FetchNoticesRequestCopyWith(FetchNoticesRequest value, $Res Function(FetchNoticesRequest) _then) = _$FetchNoticesRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeToJson: false) int meetingId, int page, int size
});




}
/// @nodoc
class _$FetchNoticesRequestCopyWithImpl<$Res>
    implements $FetchNoticesRequestCopyWith<$Res> {
  _$FetchNoticesRequestCopyWithImpl(this._self, this._then);

  final FetchNoticesRequest _self;
  final $Res Function(FetchNoticesRequest) _then;

/// Create a copy of FetchNoticesRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingId = null,Object? page = null,Object? size = null,}) {
  return _then(FetchNoticesRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FetchNoticesRequest].
extension FetchNoticesRequestPatterns on FetchNoticesRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FetchNoticesRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchNoticesRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FetchNoticesRequest value)  $default,){
final _that = this;
switch (_that) {
case _FetchNoticesRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FetchNoticesRequest value)?  $default,){
final _that = this;
switch (_that) {
case _FetchNoticesRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  int meetingId,  int page,  int size)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchNoticesRequest() when $default != null:
return $default(_that.meetingId,_that.page,_that.size);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeToJson: false)  int meetingId,  int page,  int size)  $default,) {final _that = this;
switch (_that) {
case _FetchNoticesRequest():
return $default(_that.meetingId,_that.page,_that.size);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeToJson: false)  int meetingId,  int page,  int size)?  $default,) {final _that = this;
switch (_that) {
case _FetchNoticesRequest() when $default != null:
return $default(_that.meetingId,_that.page,_that.size);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FetchNoticesRequest implements FetchNoticesRequest {
  const _FetchNoticesRequest({@JsonKey(includeToJson: false) required this.meetingId, required this.page, required this.size});
  factory _FetchNoticesRequest.fromJson(Map<String, dynamic> json) => _$FetchNoticesRequestFromJson(json);

@override@JsonKey(includeToJson: false) final  int meetingId;
/// 0부터 시작
@override final  int page;
@override final  int size;

/// Create a copy of FetchNoticesRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchNoticesRequestCopyWith<_FetchNoticesRequest> get copyWith => __$FetchNoticesRequestCopyWithImpl<_FetchNoticesRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FetchNoticesRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchNoticesRequest&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.page, page) || other.page == page)&&(identical(other.size, size) || other.size == size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meetingId,page,size);

@override
String toString() {
  return 'FetchNoticesRequest(meetingId: $meetingId, page: $page, size: $size)';
}


}

/// @nodoc
abstract mixin class _$FetchNoticesRequestCopyWith<$Res> implements $FetchNoticesRequestCopyWith<$Res> {
  factory _$FetchNoticesRequestCopyWith(_FetchNoticesRequest value, $Res Function(_FetchNoticesRequest) _then) = __$FetchNoticesRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeToJson: false) int meetingId, int page, int size
});




}
/// @nodoc
class __$FetchNoticesRequestCopyWithImpl<$Res>
    implements _$FetchNoticesRequestCopyWith<$Res> {
  __$FetchNoticesRequestCopyWithImpl(this._self, this._then);

  final _FetchNoticesRequest _self;
  final $Res Function(_FetchNoticesRequest) _then;

/// Create a copy of FetchNoticesRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingId = null,Object? page = null,Object? size = null,}) {
  return _then(_FetchNoticesRequest(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
