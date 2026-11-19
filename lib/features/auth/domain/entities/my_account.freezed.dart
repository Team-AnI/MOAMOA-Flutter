// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MyAccount {

 String get name; String get email;/// 선택 입력이라 없으면 null 입니다.
 String? get phone; ProfileColor get profileColor;
/// Create a copy of MyAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyAccountCopyWith<MyAccount> get copyWith => _$MyAccountCopyWithImpl<MyAccount>(this as MyAccount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyAccount&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.profileColor, profileColor) || other.profileColor == profileColor));
}


@override
int get hashCode => Object.hash(runtimeType,name,email,phone,profileColor);

@override
String toString() {
  return 'MyAccount(name: $name, email: $email, phone: $phone, profileColor: $profileColor)';
}


}

/// @nodoc
abstract mixin class $MyAccountCopyWith<$Res>  {
  factory $MyAccountCopyWith(MyAccount value, $Res Function(MyAccount) _then) = _$MyAccountCopyWithImpl;
@useResult
$Res call({
 String name, String email, String? phone, ProfileColor profileColor
});




}
/// @nodoc
class _$MyAccountCopyWithImpl<$Res>
    implements $MyAccountCopyWith<$Res> {
  _$MyAccountCopyWithImpl(this._self, this._then);

  final MyAccount _self;
  final $Res Function(MyAccount) _then;

/// Create a copy of MyAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? email = null,Object? phone = freezed,Object? profileColor = null,}) {
  return _then(MyAccount(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,profileColor: null == profileColor ? _self.profileColor : profileColor // ignore: cast_nullable_to_non_nullable
as ProfileColor,
  ));
}

}


/// Adds pattern-matching-related methods to [MyAccount].
extension MyAccountPatterns on MyAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyAccount value)  $default,){
final _that = this;
switch (_that) {
case _MyAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyAccount value)?  $default,){
final _that = this;
switch (_that) {
case _MyAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String email,  String? phone,  ProfileColor profileColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyAccount() when $default != null:
return $default(_that.name,_that.email,_that.phone,_that.profileColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String email,  String? phone,  ProfileColor profileColor)  $default,) {final _that = this;
switch (_that) {
case _MyAccount():
return $default(_that.name,_that.email,_that.phone,_that.profileColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String email,  String? phone,  ProfileColor profileColor)?  $default,) {final _that = this;
switch (_that) {
case _MyAccount() when $default != null:
return $default(_that.name,_that.email,_that.phone,_that.profileColor);case _:
  return null;

}
}

}

/// @nodoc


class _MyAccount implements MyAccount {
  const _MyAccount({required this.name, required this.email, this.phone, required this.profileColor});
  

@override final  String name;
@override final  String email;
/// 선택 입력이라 없으면 null 입니다.
@override final  String? phone;
@override final  ProfileColor profileColor;

/// Create a copy of MyAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyAccountCopyWith<_MyAccount> get copyWith => __$MyAccountCopyWithImpl<_MyAccount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyAccount&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.profileColor, profileColor) || other.profileColor == profileColor));
}


@override
int get hashCode => Object.hash(runtimeType,name,email,phone,profileColor);

@override
String toString() {
  return 'MyAccount(name: $name, email: $email, phone: $phone, profileColor: $profileColor)';
}


}

/// @nodoc
abstract mixin class _$MyAccountCopyWith<$Res> implements $MyAccountCopyWith<$Res> {
  factory _$MyAccountCopyWith(_MyAccount value, $Res Function(_MyAccount) _then) = __$MyAccountCopyWithImpl;
@override @useResult
$Res call({
 String name, String email, String? phone, ProfileColor profileColor
});




}
/// @nodoc
class __$MyAccountCopyWithImpl<$Res>
    implements _$MyAccountCopyWith<$Res> {
  __$MyAccountCopyWithImpl(this._self, this._then);

  final _MyAccount _self;
  final $Res Function(_MyAccount) _then;

/// Create a copy of MyAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? email = null,Object? phone = freezed,Object? profileColor = null,}) {
  return _then(_MyAccount(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,profileColor: null == profileColor ? _self.profileColor : profileColor // ignore: cast_nullable_to_non_nullable
as ProfileColor,
  ));
}


}

// dart format on
