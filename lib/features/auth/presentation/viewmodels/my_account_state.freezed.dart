// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_account_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MyAccountState {

 MyAccountStatus get status;/// [status] 가 loaded 일 때만 값이 있습니다.
 MyAccount? get account;/// [status] 가 failure 일 때만 값이 있습니다.
 Object? get error;/// 로그아웃 요청 중이면 true. 중복 요청을 막습니다.
 bool get isLoggingOut;/// 이 기기의 로그인 정보를 지우지 못해 로그아웃하지 못했으면 true. 다시 시도할 수 있습니다.
 bool get logoutFailed;
/// Create a copy of MyAccountState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyAccountStateCopyWith<MyAccountState> get copyWith => _$MyAccountStateCopyWithImpl<MyAccountState>(this as MyAccountState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyAccountState&&(identical(other.status, status) || other.status == status)&&(identical(other.account, account) || other.account == account)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.isLoggingOut, isLoggingOut) || other.isLoggingOut == isLoggingOut)&&(identical(other.logoutFailed, logoutFailed) || other.logoutFailed == logoutFailed));
}


@override
int get hashCode => Object.hash(runtimeType,status,account,const DeepCollectionEquality().hash(error),isLoggingOut,logoutFailed);

@override
String toString() {
  return 'MyAccountState(status: $status, account: $account, error: $error, isLoggingOut: $isLoggingOut, logoutFailed: $logoutFailed)';
}


}

/// @nodoc
abstract mixin class $MyAccountStateCopyWith<$Res>  {
  factory $MyAccountStateCopyWith(MyAccountState value, $Res Function(MyAccountState) _then) = _$MyAccountStateCopyWithImpl;
@useResult
$Res call({
 MyAccountStatus status, MyAccount? account, Object? error, bool isLoggingOut, bool logoutFailed
});


$MyAccountCopyWith<$Res>? get account;

}
/// @nodoc
class _$MyAccountStateCopyWithImpl<$Res>
    implements $MyAccountStateCopyWith<$Res> {
  _$MyAccountStateCopyWithImpl(this._self, this._then);

  final MyAccountState _self;
  final $Res Function(MyAccountState) _then;

/// Create a copy of MyAccountState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? account = freezed,Object? error = freezed,Object? isLoggingOut = null,Object? logoutFailed = null,}) {
  return _then(MyAccountState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MyAccountStatus,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as MyAccount?,error: freezed == error ? _self.error : error ,isLoggingOut: null == isLoggingOut ? _self.isLoggingOut : isLoggingOut // ignore: cast_nullable_to_non_nullable
as bool,logoutFailed: null == logoutFailed ? _self.logoutFailed : logoutFailed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of MyAccountState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MyAccountCopyWith<$Res>? get account {
    if (_self.account == null) {
    return null;
  }

  return $MyAccountCopyWith<$Res>(_self.account!, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}


/// Adds pattern-matching-related methods to [MyAccountState].
extension MyAccountStatePatterns on MyAccountState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyAccountState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyAccountState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyAccountState value)  $default,){
final _that = this;
switch (_that) {
case _MyAccountState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyAccountState value)?  $default,){
final _that = this;
switch (_that) {
case _MyAccountState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MyAccountStatus status,  MyAccount? account,  Object? error,  bool isLoggingOut,  bool logoutFailed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyAccountState() when $default != null:
return $default(_that.status,_that.account,_that.error,_that.isLoggingOut,_that.logoutFailed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MyAccountStatus status,  MyAccount? account,  Object? error,  bool isLoggingOut,  bool logoutFailed)  $default,) {final _that = this;
switch (_that) {
case _MyAccountState():
return $default(_that.status,_that.account,_that.error,_that.isLoggingOut,_that.logoutFailed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MyAccountStatus status,  MyAccount? account,  Object? error,  bool isLoggingOut,  bool logoutFailed)?  $default,) {final _that = this;
switch (_that) {
case _MyAccountState() when $default != null:
return $default(_that.status,_that.account,_that.error,_that.isLoggingOut,_that.logoutFailed);case _:
  return null;

}
}

}

/// @nodoc


class _MyAccountState implements MyAccountState {
  const _MyAccountState({this.status = MyAccountStatus.loading, this.account, this.error, this.isLoggingOut = false, this.logoutFailed = false});
  

@override@JsonKey() final  MyAccountStatus status;
/// [status] 가 loaded 일 때만 값이 있습니다.
@override final  MyAccount? account;
/// [status] 가 failure 일 때만 값이 있습니다.
@override final  Object? error;
/// 로그아웃 요청 중이면 true. 중복 요청을 막습니다.
@override@JsonKey() final  bool isLoggingOut;
/// 이 기기의 로그인 정보를 지우지 못해 로그아웃하지 못했으면 true. 다시 시도할 수 있습니다.
@override@JsonKey() final  bool logoutFailed;

/// Create a copy of MyAccountState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyAccountStateCopyWith<_MyAccountState> get copyWith => __$MyAccountStateCopyWithImpl<_MyAccountState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyAccountState&&(identical(other.status, status) || other.status == status)&&(identical(other.account, account) || other.account == account)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.isLoggingOut, isLoggingOut) || other.isLoggingOut == isLoggingOut)&&(identical(other.logoutFailed, logoutFailed) || other.logoutFailed == logoutFailed));
}


@override
int get hashCode => Object.hash(runtimeType,status,account,const DeepCollectionEquality().hash(error),isLoggingOut,logoutFailed);

@override
String toString() {
  return 'MyAccountState(status: $status, account: $account, error: $error, isLoggingOut: $isLoggingOut, logoutFailed: $logoutFailed)';
}


}

/// @nodoc
abstract mixin class _$MyAccountStateCopyWith<$Res> implements $MyAccountStateCopyWith<$Res> {
  factory _$MyAccountStateCopyWith(_MyAccountState value, $Res Function(_MyAccountState) _then) = __$MyAccountStateCopyWithImpl;
@override @useResult
$Res call({
 MyAccountStatus status, MyAccount? account, Object? error, bool isLoggingOut, bool logoutFailed
});


@override $MyAccountCopyWith<$Res>? get account;

}
/// @nodoc
class __$MyAccountStateCopyWithImpl<$Res>
    implements _$MyAccountStateCopyWith<$Res> {
  __$MyAccountStateCopyWithImpl(this._self, this._then);

  final _MyAccountState _self;
  final $Res Function(_MyAccountState) _then;

/// Create a copy of MyAccountState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? account = freezed,Object? error = freezed,Object? isLoggingOut = null,Object? logoutFailed = null,}) {
  return _then(_MyAccountState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MyAccountStatus,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as MyAccount?,error: freezed == error ? _self.error : error ,isLoggingOut: null == isLoggingOut ? _self.isLoggingOut : isLoggingOut // ignore: cast_nullable_to_non_nullable
as bool,logoutFailed: null == logoutFailed ? _self.logoutFailed : logoutFailed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of MyAccountState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MyAccountCopyWith<$Res>? get account {
    if (_self.account == null) {
    return null;
  }

  return $MyAccountCopyWith<$Res>(_self.account!, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}

// dart format on
