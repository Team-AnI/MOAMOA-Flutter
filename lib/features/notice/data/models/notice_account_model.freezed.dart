// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notice_account_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NoticeAccountModel {

 String get bankName; String get accountNumber; String get holderName;
/// Create a copy of NoticeAccountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoticeAccountModelCopyWith<NoticeAccountModel> get copyWith => _$NoticeAccountModelCopyWithImpl<NoticeAccountModel>(this as NoticeAccountModel, _$identity);

  /// Serializes this NoticeAccountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoticeAccountModel&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.holderName, holderName) || other.holderName == holderName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bankName,accountNumber,holderName);

@override
String toString() {
  return 'NoticeAccountModel(bankName: $bankName, accountNumber: $accountNumber, holderName: $holderName)';
}


}

/// @nodoc
abstract mixin class $NoticeAccountModelCopyWith<$Res>  {
  factory $NoticeAccountModelCopyWith(NoticeAccountModel value, $Res Function(NoticeAccountModel) _then) = _$NoticeAccountModelCopyWithImpl;
@useResult
$Res call({
 String bankName, String accountNumber, String holderName
});




}
/// @nodoc
class _$NoticeAccountModelCopyWithImpl<$Res>
    implements $NoticeAccountModelCopyWith<$Res> {
  _$NoticeAccountModelCopyWithImpl(this._self, this._then);

  final NoticeAccountModel _self;
  final $Res Function(NoticeAccountModel) _then;

/// Create a copy of NoticeAccountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bankName = null,Object? accountNumber = null,Object? holderName = null,}) {
  return _then(NoticeAccountModel(
bankName: null == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String,accountNumber: null == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String,holderName: null == holderName ? _self.holderName : holderName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NoticeAccountModel].
extension NoticeAccountModelPatterns on NoticeAccountModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoticeAccountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoticeAccountModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoticeAccountModel value)  $default,){
final _that = this;
switch (_that) {
case _NoticeAccountModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoticeAccountModel value)?  $default,){
final _that = this;
switch (_that) {
case _NoticeAccountModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String bankName,  String accountNumber,  String holderName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoticeAccountModel() when $default != null:
return $default(_that.bankName,_that.accountNumber,_that.holderName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String bankName,  String accountNumber,  String holderName)  $default,) {final _that = this;
switch (_that) {
case _NoticeAccountModel():
return $default(_that.bankName,_that.accountNumber,_that.holderName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String bankName,  String accountNumber,  String holderName)?  $default,) {final _that = this;
switch (_that) {
case _NoticeAccountModel() when $default != null:
return $default(_that.bankName,_that.accountNumber,_that.holderName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NoticeAccountModel extends NoticeAccountModel {
  const _NoticeAccountModel({required this.bankName, required this.accountNumber, required this.holderName}): super._();
  factory _NoticeAccountModel.fromJson(Map<String, dynamic> json) => _$NoticeAccountModelFromJson(json);

@override final  String bankName;
@override final  String accountNumber;
@override final  String holderName;

/// Create a copy of NoticeAccountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoticeAccountModelCopyWith<_NoticeAccountModel> get copyWith => __$NoticeAccountModelCopyWithImpl<_NoticeAccountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NoticeAccountModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoticeAccountModel&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.holderName, holderName) || other.holderName == holderName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bankName,accountNumber,holderName);

@override
String toString() {
  return 'NoticeAccountModel(bankName: $bankName, accountNumber: $accountNumber, holderName: $holderName)';
}


}

/// @nodoc
abstract mixin class _$NoticeAccountModelCopyWith<$Res> implements $NoticeAccountModelCopyWith<$Res> {
  factory _$NoticeAccountModelCopyWith(_NoticeAccountModel value, $Res Function(_NoticeAccountModel) _then) = __$NoticeAccountModelCopyWithImpl;
@override @useResult
$Res call({
 String bankName, String accountNumber, String holderName
});




}
/// @nodoc
class __$NoticeAccountModelCopyWithImpl<$Res>
    implements _$NoticeAccountModelCopyWith<$Res> {
  __$NoticeAccountModelCopyWithImpl(this._self, this._then);

  final _NoticeAccountModel _self;
  final $Res Function(_NoticeAccountModel) _then;

/// Create a copy of NoticeAccountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bankName = null,Object? accountNumber = null,Object? holderName = null,}) {
  return _then(_NoticeAccountModel(
bankName: null == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String,accountNumber: null == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String,holderName: null == holderName ? _self.holderName : holderName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
