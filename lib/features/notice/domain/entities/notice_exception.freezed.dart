// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notice_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NoticeException {

/// 사용자에게 보여줄 메시지
 String get message;/// 서버 오류 코드 (예: VALIDATION_ERROR, FORBIDDEN, NOT_FOUND)
 String? get code;
/// Create a copy of NoticeException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoticeExceptionCopyWith<NoticeException> get copyWith => _$NoticeExceptionCopyWithImpl<NoticeException>(this as NoticeException, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoticeException&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,message,code);

@override
String toString() {
  return 'NoticeException(message: $message, code: $code)';
}


}

/// @nodoc
abstract mixin class $NoticeExceptionCopyWith<$Res>  {
  factory $NoticeExceptionCopyWith(NoticeException value, $Res Function(NoticeException) _then) = _$NoticeExceptionCopyWithImpl;
@useResult
$Res call({
 String message, String? code
});




}
/// @nodoc
class _$NoticeExceptionCopyWithImpl<$Res>
    implements $NoticeExceptionCopyWith<$Res> {
  _$NoticeExceptionCopyWithImpl(this._self, this._then);

  final NoticeException _self;
  final $Res Function(NoticeException) _then;

/// Create a copy of NoticeException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? code = freezed,}) {
  return _then(NoticeException(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NoticeException].
extension NoticeExceptionPatterns on NoticeException {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoticeException value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoticeException() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoticeException value)  $default,){
final _that = this;
switch (_that) {
case _NoticeException():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoticeException value)?  $default,){
final _that = this;
switch (_that) {
case _NoticeException() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  String? code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoticeException() when $default != null:
return $default(_that.message,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  String? code)  $default,) {final _that = this;
switch (_that) {
case _NoticeException():
return $default(_that.message,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  String? code)?  $default,) {final _that = this;
switch (_that) {
case _NoticeException() when $default != null:
return $default(_that.message,_that.code);case _:
  return null;

}
}

}

/// @nodoc


class _NoticeException implements NoticeException {
  const _NoticeException(this.message, {this.code});
  

/// 사용자에게 보여줄 메시지
@override final  String message;
/// 서버 오류 코드 (예: VALIDATION_ERROR, FORBIDDEN, NOT_FOUND)
@override final  String? code;

/// Create a copy of NoticeException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoticeExceptionCopyWith<_NoticeException> get copyWith => __$NoticeExceptionCopyWithImpl<_NoticeException>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoticeException&&(identical(other.message, message) || other.message == message)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,message,code);

@override
String toString() {
  return 'NoticeException(message: $message, code: $code)';
}


}

/// @nodoc
abstract mixin class _$NoticeExceptionCopyWith<$Res> implements $NoticeExceptionCopyWith<$Res> {
  factory _$NoticeExceptionCopyWith(_NoticeException value, $Res Function(_NoticeException) _then) = __$NoticeExceptionCopyWithImpl;
@override @useResult
$Res call({
 String message, String? code
});




}
/// @nodoc
class __$NoticeExceptionCopyWithImpl<$Res>
    implements _$NoticeExceptionCopyWith<$Res> {
  __$NoticeExceptionCopyWithImpl(this._self, this._then);

  final _NoticeException _self;
  final $Res Function(_NoticeException) _then;

/// Create a copy of NoticeException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? code = freezed,}) {
  return _then(_NoticeException(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
