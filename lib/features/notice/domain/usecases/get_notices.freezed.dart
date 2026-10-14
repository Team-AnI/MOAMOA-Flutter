// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_notices.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GetNoticesParams {

 int get meetingId;/// 0부터 시작
 int get page; int get size;
/// Create a copy of GetNoticesParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetNoticesParamsCopyWith<GetNoticesParams> get copyWith => _$GetNoticesParamsCopyWithImpl<GetNoticesParams>(this as GetNoticesParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetNoticesParams&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.page, page) || other.page == page)&&(identical(other.size, size) || other.size == size));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,page,size);

@override
String toString() {
  return 'GetNoticesParams(meetingId: $meetingId, page: $page, size: $size)';
}


}

/// @nodoc
abstract mixin class $GetNoticesParamsCopyWith<$Res>  {
  factory $GetNoticesParamsCopyWith(GetNoticesParams value, $Res Function(GetNoticesParams) _then) = _$GetNoticesParamsCopyWithImpl;
@useResult
$Res call({
 int meetingId, int page, int size
});




}
/// @nodoc
class _$GetNoticesParamsCopyWithImpl<$Res>
    implements $GetNoticesParamsCopyWith<$Res> {
  _$GetNoticesParamsCopyWithImpl(this._self, this._then);

  final GetNoticesParams _self;
  final $Res Function(GetNoticesParams) _then;

/// Create a copy of GetNoticesParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingId = null,Object? page = null,Object? size = null,}) {
  return _then(GetNoticesParams(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GetNoticesParams].
extension GetNoticesParamsPatterns on GetNoticesParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetNoticesParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetNoticesParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetNoticesParams value)  $default,){
final _that = this;
switch (_that) {
case _GetNoticesParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetNoticesParams value)?  $default,){
final _that = this;
switch (_that) {
case _GetNoticesParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int meetingId,  int page,  int size)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetNoticesParams() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int meetingId,  int page,  int size)  $default,) {final _that = this;
switch (_that) {
case _GetNoticesParams():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int meetingId,  int page,  int size)?  $default,) {final _that = this;
switch (_that) {
case _GetNoticesParams() when $default != null:
return $default(_that.meetingId,_that.page,_that.size);case _:
  return null;

}
}

}

/// @nodoc


class _GetNoticesParams extends GetNoticesParams {
  const _GetNoticesParams({required this.meetingId, this.page = 0, this.size = 20}): super._();
  

@override final  int meetingId;
/// 0부터 시작
@override@JsonKey() final  int page;
@override@JsonKey() final  int size;

/// Create a copy of GetNoticesParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetNoticesParamsCopyWith<_GetNoticesParams> get copyWith => __$GetNoticesParamsCopyWithImpl<_GetNoticesParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetNoticesParams&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.page, page) || other.page == page)&&(identical(other.size, size) || other.size == size));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,page,size);

@override
String toString() {
  return 'GetNoticesParams(meetingId: $meetingId, page: $page, size: $size)';
}


}

/// @nodoc
abstract mixin class _$GetNoticesParamsCopyWith<$Res> implements $GetNoticesParamsCopyWith<$Res> {
  factory _$GetNoticesParamsCopyWith(_GetNoticesParams value, $Res Function(_GetNoticesParams) _then) = __$GetNoticesParamsCopyWithImpl;
@override @useResult
$Res call({
 int meetingId, int page, int size
});




}
/// @nodoc
class __$GetNoticesParamsCopyWithImpl<$Res>
    implements _$GetNoticesParamsCopyWith<$Res> {
  __$GetNoticesParamsCopyWithImpl(this._self, this._then);

  final _GetNoticesParams _self;
  final $Res Function(_GetNoticesParams) _then;

/// Create a copy of GetNoticesParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingId = null,Object? page = null,Object? size = null,}) {
  return _then(_GetNoticesParams(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
