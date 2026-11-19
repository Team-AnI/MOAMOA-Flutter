// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'withdrawal_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WithdrawalRequest {

 String get password;
/// Create a copy of WithdrawalRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WithdrawalRequestCopyWith<WithdrawalRequest> get copyWith => _$WithdrawalRequestCopyWithImpl<WithdrawalRequest>(this as WithdrawalRequest, _$identity);

  /// Serializes this WithdrawalRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WithdrawalRequest&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,password);

@override
String toString() {
  return 'WithdrawalRequest(password: $password)';
}


}

/// @nodoc
abstract mixin class $WithdrawalRequestCopyWith<$Res>  {
  factory $WithdrawalRequestCopyWith(WithdrawalRequest value, $Res Function(WithdrawalRequest) _then) = _$WithdrawalRequestCopyWithImpl;
@useResult
$Res call({
 String password
});




}
/// @nodoc
class _$WithdrawalRequestCopyWithImpl<$Res>
    implements $WithdrawalRequestCopyWith<$Res> {
  _$WithdrawalRequestCopyWithImpl(this._self, this._then);

  final WithdrawalRequest _self;
  final $Res Function(WithdrawalRequest) _then;

/// Create a copy of WithdrawalRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? password = null,}) {
  return _then(WithdrawalRequest(
password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WithdrawalRequest].
extension WithdrawalRequestPatterns on WithdrawalRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WithdrawalRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WithdrawalRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WithdrawalRequest value)  $default,){
final _that = this;
switch (_that) {
case _WithdrawalRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WithdrawalRequest value)?  $default,){
final _that = this;
switch (_that) {
case _WithdrawalRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WithdrawalRequest() when $default != null:
return $default(_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String password)  $default,) {final _that = this;
switch (_that) {
case _WithdrawalRequest():
return $default(_that.password);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String password)?  $default,) {final _that = this;
switch (_that) {
case _WithdrawalRequest() when $default != null:
return $default(_that.password);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WithdrawalRequest implements WithdrawalRequest {
  const _WithdrawalRequest({required this.password});
  factory _WithdrawalRequest.fromJson(Map<String, dynamic> json) => _$WithdrawalRequestFromJson(json);

@override final  String password;

/// Create a copy of WithdrawalRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WithdrawalRequestCopyWith<_WithdrawalRequest> get copyWith => __$WithdrawalRequestCopyWithImpl<_WithdrawalRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WithdrawalRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WithdrawalRequest&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,password);

@override
String toString() {
  return 'WithdrawalRequest(password: $password)';
}


}

/// @nodoc
abstract mixin class _$WithdrawalRequestCopyWith<$Res> implements $WithdrawalRequestCopyWith<$Res> {
  factory _$WithdrawalRequestCopyWith(_WithdrawalRequest value, $Res Function(_WithdrawalRequest) _then) = __$WithdrawalRequestCopyWithImpl;
@override @useResult
$Res call({
 String password
});




}
/// @nodoc
class __$WithdrawalRequestCopyWithImpl<$Res>
    implements _$WithdrawalRequestCopyWith<$Res> {
  __$WithdrawalRequestCopyWithImpl(this._self, this._then);

  final _WithdrawalRequest _self;
  final $Res Function(_WithdrawalRequest) _then;

/// Create a copy of WithdrawalRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? password = null,}) {
  return _then(_WithdrawalRequest(
password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
