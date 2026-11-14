// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Settlement {

 int get id; String get title; int? get scheduleId; int get totalAmount; int get memberCount; DateTime get dueAt; DateTime get createdAt; SettlementStatus get status; DateTime? get canceledAt; int? get myAmount; PaymentStatus? get myPaymentStatus; DateTime? get myConfirmedAt;
/// Create a copy of Settlement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettlementCopyWith<Settlement> get copyWith => _$SettlementCopyWithImpl<Settlement>(this as Settlement, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Settlement&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.canceledAt, canceledAt) || other.canceledAt == canceledAt)&&(identical(other.myAmount, myAmount) || other.myAmount == myAmount)&&(identical(other.myPaymentStatus, myPaymentStatus) || other.myPaymentStatus == myPaymentStatus)&&(identical(other.myConfirmedAt, myConfirmedAt) || other.myConfirmedAt == myConfirmedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,scheduleId,totalAmount,memberCount,dueAt,createdAt,status,canceledAt,myAmount,myPaymentStatus,myConfirmedAt);

@override
String toString() {
  return 'Settlement(id: $id, title: $title, scheduleId: $scheduleId, totalAmount: $totalAmount, memberCount: $memberCount, dueAt: $dueAt, createdAt: $createdAt, status: $status, canceledAt: $canceledAt, myAmount: $myAmount, myPaymentStatus: $myPaymentStatus, myConfirmedAt: $myConfirmedAt)';
}


}

/// @nodoc
abstract mixin class $SettlementCopyWith<$Res>  {
  factory $SettlementCopyWith(Settlement value, $Res Function(Settlement) _then) = _$SettlementCopyWithImpl;
@useResult
$Res call({
 int id, String title, int? scheduleId, int totalAmount, int memberCount, DateTime dueAt, DateTime createdAt, SettlementStatus status, DateTime? canceledAt, int? myAmount, PaymentStatus? myPaymentStatus, DateTime? myConfirmedAt
});




}
/// @nodoc
class _$SettlementCopyWithImpl<$Res>
    implements $SettlementCopyWith<$Res> {
  _$SettlementCopyWithImpl(this._self, this._then);

  final Settlement _self;
  final $Res Function(Settlement) _then;

/// Create a copy of Settlement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? scheduleId = freezed,Object? totalAmount = null,Object? memberCount = null,Object? dueAt = null,Object? createdAt = null,Object? status = null,Object? canceledAt = freezed,Object? myAmount = freezed,Object? myPaymentStatus = freezed,Object? myConfirmedAt = freezed,}) {
  return _then(Settlement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,scheduleId: freezed == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as int?,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,dueAt: null == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SettlementStatus,canceledAt: freezed == canceledAt ? _self.canceledAt : canceledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,myAmount: freezed == myAmount ? _self.myAmount : myAmount // ignore: cast_nullable_to_non_nullable
as int?,myPaymentStatus: freezed == myPaymentStatus ? _self.myPaymentStatus : myPaymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus?,myConfirmedAt: freezed == myConfirmedAt ? _self.myConfirmedAt : myConfirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Settlement].
extension SettlementPatterns on Settlement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Settlement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Settlement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Settlement value)  $default,){
final _that = this;
switch (_that) {
case _Settlement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Settlement value)?  $default,){
final _that = this;
switch (_that) {
case _Settlement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  int? scheduleId,  int totalAmount,  int memberCount,  DateTime dueAt,  DateTime createdAt,  SettlementStatus status,  DateTime? canceledAt,  int? myAmount,  PaymentStatus? myPaymentStatus,  DateTime? myConfirmedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Settlement() when $default != null:
return $default(_that.id,_that.title,_that.scheduleId,_that.totalAmount,_that.memberCount,_that.dueAt,_that.createdAt,_that.status,_that.canceledAt,_that.myAmount,_that.myPaymentStatus,_that.myConfirmedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  int? scheduleId,  int totalAmount,  int memberCount,  DateTime dueAt,  DateTime createdAt,  SettlementStatus status,  DateTime? canceledAt,  int? myAmount,  PaymentStatus? myPaymentStatus,  DateTime? myConfirmedAt)  $default,) {final _that = this;
switch (_that) {
case _Settlement():
return $default(_that.id,_that.title,_that.scheduleId,_that.totalAmount,_that.memberCount,_that.dueAt,_that.createdAt,_that.status,_that.canceledAt,_that.myAmount,_that.myPaymentStatus,_that.myConfirmedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  int? scheduleId,  int totalAmount,  int memberCount,  DateTime dueAt,  DateTime createdAt,  SettlementStatus status,  DateTime? canceledAt,  int? myAmount,  PaymentStatus? myPaymentStatus,  DateTime? myConfirmedAt)?  $default,) {final _that = this;
switch (_that) {
case _Settlement() when $default != null:
return $default(_that.id,_that.title,_that.scheduleId,_that.totalAmount,_that.memberCount,_that.dueAt,_that.createdAt,_that.status,_that.canceledAt,_that.myAmount,_that.myPaymentStatus,_that.myConfirmedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Settlement implements Settlement {
  const _Settlement({required this.id, required this.title, this.scheduleId, required this.totalAmount, required this.memberCount, required this.dueAt, required this.createdAt, required this.status, this.canceledAt, this.myAmount, this.myPaymentStatus, this.myConfirmedAt});


@override final  int id;
@override final  String title;
@override final  int? scheduleId;
@override final  int totalAmount;
@override final  int memberCount;
@override final  DateTime dueAt;
@override final  DateTime createdAt;
@override final  SettlementStatus status;
@override final  DateTime? canceledAt;
@override final  int? myAmount;
@override final  PaymentStatus? myPaymentStatus;
@override final  DateTime? myConfirmedAt;

/// Create a copy of Settlement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettlementCopyWith<_Settlement> get copyWith => __$SettlementCopyWithImpl<_Settlement>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Settlement&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.canceledAt, canceledAt) || other.canceledAt == canceledAt)&&(identical(other.myAmount, myAmount) || other.myAmount == myAmount)&&(identical(other.myPaymentStatus, myPaymentStatus) || other.myPaymentStatus == myPaymentStatus)&&(identical(other.myConfirmedAt, myConfirmedAt) || other.myConfirmedAt == myConfirmedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,scheduleId,totalAmount,memberCount,dueAt,createdAt,status,canceledAt,myAmount,myPaymentStatus,myConfirmedAt);

@override
String toString() {
  return 'Settlement(id: $id, title: $title, scheduleId: $scheduleId, totalAmount: $totalAmount, memberCount: $memberCount, dueAt: $dueAt, createdAt: $createdAt, status: $status, canceledAt: $canceledAt, myAmount: $myAmount, myPaymentStatus: $myPaymentStatus, myConfirmedAt: $myConfirmedAt)';
}


}

/// @nodoc
abstract mixin class _$SettlementCopyWith<$Res> implements $SettlementCopyWith<$Res> {
  factory _$SettlementCopyWith(_Settlement value, $Res Function(_Settlement) _then) = __$SettlementCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, int? scheduleId, int totalAmount, int memberCount, DateTime dueAt, DateTime createdAt, SettlementStatus status, DateTime? canceledAt, int? myAmount, PaymentStatus? myPaymentStatus, DateTime? myConfirmedAt
});




}
/// @nodoc
class __$SettlementCopyWithImpl<$Res>
    implements _$SettlementCopyWith<$Res> {
  __$SettlementCopyWithImpl(this._self, this._then);

  final _Settlement _self;
  final $Res Function(_Settlement) _then;

/// Create a copy of Settlement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? scheduleId = freezed,Object? totalAmount = null,Object? memberCount = null,Object? dueAt = null,Object? createdAt = null,Object? status = null,Object? canceledAt = freezed,Object? myAmount = freezed,Object? myPaymentStatus = freezed,Object? myConfirmedAt = freezed,}) {
  return _then(_Settlement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,scheduleId: freezed == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as int?,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,dueAt: null == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SettlementStatus,canceledAt: freezed == canceledAt ? _self.canceledAt : canceledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,myAmount: freezed == myAmount ? _self.myAmount : myAmount // ignore: cast_nullable_to_non_nullable
as int?,myPaymentStatus: freezed == myPaymentStatus ? _self.myPaymentStatus : myPaymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus?,myConfirmedAt: freezed == myConfirmedAt ? _self.myConfirmedAt : myConfirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$SettlementPayment {

 int get id; int get amount; PaymentStatus get status; int? get memberId; String? get userName; DateTime? get submittedAt; DateTime? get refundedAt;
/// Create a copy of SettlementPayment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettlementPaymentCopyWith<SettlementPayment> get copyWith => _$SettlementPaymentCopyWithImpl<SettlementPayment>(this as SettlementPayment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettlementPayment&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.refundedAt, refundedAt) || other.refundedAt == refundedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,amount,status,memberId,userName,submittedAt,refundedAt);

@override
String toString() {
  return 'SettlementPayment(id: $id, amount: $amount, status: $status, memberId: $memberId, userName: $userName, submittedAt: $submittedAt, refundedAt: $refundedAt)';
}


}

/// @nodoc
abstract mixin class $SettlementPaymentCopyWith<$Res>  {
  factory $SettlementPaymentCopyWith(SettlementPayment value, $Res Function(SettlementPayment) _then) = _$SettlementPaymentCopyWithImpl;
@useResult
$Res call({
 int id, int amount, PaymentStatus status, int? memberId, String? userName, DateTime? submittedAt, DateTime? refundedAt
});




}
/// @nodoc
class _$SettlementPaymentCopyWithImpl<$Res>
    implements $SettlementPaymentCopyWith<$Res> {
  _$SettlementPaymentCopyWithImpl(this._self, this._then);

  final SettlementPayment _self;
  final $Res Function(SettlementPayment) _then;

/// Create a copy of SettlementPayment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? amount = null,Object? status = null,Object? memberId = freezed,Object? userName = freezed,Object? submittedAt = freezed,Object? refundedAt = freezed,}) {
  return _then(SettlementPayment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,memberId: freezed == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as int?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,refundedAt: freezed == refundedAt ? _self.refundedAt : refundedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SettlementPayment].
extension SettlementPaymentPatterns on SettlementPayment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettlementPayment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettlementPayment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettlementPayment value)  $default,){
final _that = this;
switch (_that) {
case _SettlementPayment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettlementPayment value)?  $default,){
final _that = this;
switch (_that) {
case _SettlementPayment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int amount,  PaymentStatus status,  int? memberId,  String? userName,  DateTime? submittedAt,  DateTime? refundedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettlementPayment() when $default != null:
return $default(_that.id,_that.amount,_that.status,_that.memberId,_that.userName,_that.submittedAt,_that.refundedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int amount,  PaymentStatus status,  int? memberId,  String? userName,  DateTime? submittedAt,  DateTime? refundedAt)  $default,) {final _that = this;
switch (_that) {
case _SettlementPayment():
return $default(_that.id,_that.amount,_that.status,_that.memberId,_that.userName,_that.submittedAt,_that.refundedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int amount,  PaymentStatus status,  int? memberId,  String? userName,  DateTime? submittedAt,  DateTime? refundedAt)?  $default,) {final _that = this;
switch (_that) {
case _SettlementPayment() when $default != null:
return $default(_that.id,_that.amount,_that.status,_that.memberId,_that.userName,_that.submittedAt,_that.refundedAt);case _:
  return null;

}
}

}

/// @nodoc


class _SettlementPayment implements SettlementPayment {
  const _SettlementPayment({required this.id, required this.amount, required this.status, this.memberId, this.userName, this.submittedAt, this.refundedAt});


@override final  int id;
@override final  int amount;
@override final  PaymentStatus status;
@override final  int? memberId;
@override final  String? userName;
@override final  DateTime? submittedAt;
@override final  DateTime? refundedAt;

/// Create a copy of SettlementPayment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettlementPaymentCopyWith<_SettlementPayment> get copyWith => __$SettlementPaymentCopyWithImpl<_SettlementPayment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettlementPayment&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.memberId, memberId) || other.memberId == memberId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.refundedAt, refundedAt) || other.refundedAt == refundedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,amount,status,memberId,userName,submittedAt,refundedAt);

@override
String toString() {
  return 'SettlementPayment(id: $id, amount: $amount, status: $status, memberId: $memberId, userName: $userName, submittedAt: $submittedAt, refundedAt: $refundedAt)';
}


}

/// @nodoc
abstract mixin class _$SettlementPaymentCopyWith<$Res> implements $SettlementPaymentCopyWith<$Res> {
  factory _$SettlementPaymentCopyWith(_SettlementPayment value, $Res Function(_SettlementPayment) _then) = __$SettlementPaymentCopyWithImpl;
@override @useResult
$Res call({
 int id, int amount, PaymentStatus status, int? memberId, String? userName, DateTime? submittedAt, DateTime? refundedAt
});




}
/// @nodoc
class __$SettlementPaymentCopyWithImpl<$Res>
    implements _$SettlementPaymentCopyWith<$Res> {
  __$SettlementPaymentCopyWithImpl(this._self, this._then);

  final _SettlementPayment _self;
  final $Res Function(_SettlementPayment) _then;

/// Create a copy of SettlementPayment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amount = null,Object? status = null,Object? memberId = freezed,Object? userName = freezed,Object? submittedAt = freezed,Object? refundedAt = freezed,}) {
  return _then(_SettlementPayment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,memberId: freezed == memberId ? _self.memberId : memberId // ignore: cast_nullable_to_non_nullable
as int?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,refundedAt: freezed == refundedAt ? _self.refundedAt : refundedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$SettlementSummary {

 int get totalCount; int get unpaidCount; int get pendingCount; int get paidCount; int get refundedCount; int get paidAmount;
/// Create a copy of SettlementSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettlementSummaryCopyWith<SettlementSummary> get copyWith => _$SettlementSummaryCopyWithImpl<SettlementSummary>(this as SettlementSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettlementSummary&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.unpaidCount, unpaidCount) || other.unpaidCount == unpaidCount)&&(identical(other.pendingCount, pendingCount) || other.pendingCount == pendingCount)&&(identical(other.paidCount, paidCount) || other.paidCount == paidCount)&&(identical(other.refundedCount, refundedCount) || other.refundedCount == refundedCount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount));
}


@override
int get hashCode => Object.hash(runtimeType,totalCount,unpaidCount,pendingCount,paidCount,refundedCount,paidAmount);

@override
String toString() {
  return 'SettlementSummary(totalCount: $totalCount, unpaidCount: $unpaidCount, pendingCount: $pendingCount, paidCount: $paidCount, refundedCount: $refundedCount, paidAmount: $paidAmount)';
}


}

/// @nodoc
abstract mixin class $SettlementSummaryCopyWith<$Res>  {
  factory $SettlementSummaryCopyWith(SettlementSummary value, $Res Function(SettlementSummary) _then) = _$SettlementSummaryCopyWithImpl;
@useResult
$Res call({
 int totalCount, int unpaidCount, int pendingCount, int paidCount, int refundedCount, int paidAmount
});




}
/// @nodoc
class _$SettlementSummaryCopyWithImpl<$Res>
    implements $SettlementSummaryCopyWith<$Res> {
  _$SettlementSummaryCopyWithImpl(this._self, this._then);

  final SettlementSummary _self;
  final $Res Function(SettlementSummary) _then;

/// Create a copy of SettlementSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalCount = null,Object? unpaidCount = null,Object? pendingCount = null,Object? paidCount = null,Object? refundedCount = null,Object? paidAmount = null,}) {
  return _then(SettlementSummary(
totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,unpaidCount: null == unpaidCount ? _self.unpaidCount : unpaidCount // ignore: cast_nullable_to_non_nullable
as int,pendingCount: null == pendingCount ? _self.pendingCount : pendingCount // ignore: cast_nullable_to_non_nullable
as int,paidCount: null == paidCount ? _self.paidCount : paidCount // ignore: cast_nullable_to_non_nullable
as int,refundedCount: null == refundedCount ? _self.refundedCount : refundedCount // ignore: cast_nullable_to_non_nullable
as int,paidAmount: null == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SettlementSummary].
extension SettlementSummaryPatterns on SettlementSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettlementSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettlementSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettlementSummary value)  $default,){
final _that = this;
switch (_that) {
case _SettlementSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettlementSummary value)?  $default,){
final _that = this;
switch (_that) {
case _SettlementSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalCount,  int unpaidCount,  int pendingCount,  int paidCount,  int refundedCount,  int paidAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettlementSummary() when $default != null:
return $default(_that.totalCount,_that.unpaidCount,_that.pendingCount,_that.paidCount,_that.refundedCount,_that.paidAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalCount,  int unpaidCount,  int pendingCount,  int paidCount,  int refundedCount,  int paidAmount)  $default,) {final _that = this;
switch (_that) {
case _SettlementSummary():
return $default(_that.totalCount,_that.unpaidCount,_that.pendingCount,_that.paidCount,_that.refundedCount,_that.paidAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalCount,  int unpaidCount,  int pendingCount,  int paidCount,  int refundedCount,  int paidAmount)?  $default,) {final _that = this;
switch (_that) {
case _SettlementSummary() when $default != null:
return $default(_that.totalCount,_that.unpaidCount,_that.pendingCount,_that.paidCount,_that.refundedCount,_that.paidAmount);case _:
  return null;

}
}

}

/// @nodoc


class _SettlementSummary implements SettlementSummary {
  const _SettlementSummary({required this.totalCount, required this.unpaidCount, required this.pendingCount, required this.paidCount, required this.refundedCount, required this.paidAmount});


@override final  int totalCount;
@override final  int unpaidCount;
@override final  int pendingCount;
@override final  int paidCount;
@override final  int refundedCount;
@override final  int paidAmount;

/// Create a copy of SettlementSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettlementSummaryCopyWith<_SettlementSummary> get copyWith => __$SettlementSummaryCopyWithImpl<_SettlementSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettlementSummary&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.unpaidCount, unpaidCount) || other.unpaidCount == unpaidCount)&&(identical(other.pendingCount, pendingCount) || other.pendingCount == pendingCount)&&(identical(other.paidCount, paidCount) || other.paidCount == paidCount)&&(identical(other.refundedCount, refundedCount) || other.refundedCount == refundedCount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount));
}


@override
int get hashCode => Object.hash(runtimeType,totalCount,unpaidCount,pendingCount,paidCount,refundedCount,paidAmount);

@override
String toString() {
  return 'SettlementSummary(totalCount: $totalCount, unpaidCount: $unpaidCount, pendingCount: $pendingCount, paidCount: $paidCount, refundedCount: $refundedCount, paidAmount: $paidAmount)';
}


}

/// @nodoc
abstract mixin class _$SettlementSummaryCopyWith<$Res> implements $SettlementSummaryCopyWith<$Res> {
  factory _$SettlementSummaryCopyWith(_SettlementSummary value, $Res Function(_SettlementSummary) _then) = __$SettlementSummaryCopyWithImpl;
@override @useResult
$Res call({
 int totalCount, int unpaidCount, int pendingCount, int paidCount, int refundedCount, int paidAmount
});




}
/// @nodoc
class __$SettlementSummaryCopyWithImpl<$Res>
    implements _$SettlementSummaryCopyWith<$Res> {
  __$SettlementSummaryCopyWithImpl(this._self, this._then);

  final _SettlementSummary _self;
  final $Res Function(_SettlementSummary) _then;

/// Create a copy of SettlementSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalCount = null,Object? unpaidCount = null,Object? pendingCount = null,Object? paidCount = null,Object? refundedCount = null,Object? paidAmount = null,}) {
  return _then(_SettlementSummary(
totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,unpaidCount: null == unpaidCount ? _self.unpaidCount : unpaidCount // ignore: cast_nullable_to_non_nullable
as int,pendingCount: null == pendingCount ? _self.pendingCount : pendingCount // ignore: cast_nullable_to_non_nullable
as int,paidCount: null == paidCount ? _self.paidCount : paidCount // ignore: cast_nullable_to_non_nullable
as int,refundedCount: null == refundedCount ? _self.refundedCount : refundedCount // ignore: cast_nullable_to_non_nullable
as int,paidAmount: null == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$SettlementDetail {

 int get id; String get title; int? get scheduleId; String? get scheduleTitle; DateTime? get scheduleStartAt; int get totalAmount; String get bankName; String get accountNumber; String get accountHolder; DateTime get dueAt; SettlementStatus get status; int? get noticeId; DateTime? get canceledAt; String? get cancelReason; int? get replacesSettlementId; int? get replacedBySettlementId; SettlementPayment? get myPayment; SettlementSummary get summary; List<SettlementPayment> get payments;
/// Create a copy of SettlementDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettlementDetailCopyWith<SettlementDetail> get copyWith => _$SettlementDetailCopyWithImpl<SettlementDetail>(this as SettlementDetail, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettlementDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId)&&(identical(other.scheduleTitle, scheduleTitle) || other.scheduleTitle == scheduleTitle)&&(identical(other.scheduleStartAt, scheduleStartAt) || other.scheduleStartAt == scheduleStartAt)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.accountHolder, accountHolder) || other.accountHolder == accountHolder)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.noticeId, noticeId) || other.noticeId == noticeId)&&(identical(other.canceledAt, canceledAt) || other.canceledAt == canceledAt)&&(identical(other.cancelReason, cancelReason) || other.cancelReason == cancelReason)&&(identical(other.replacesSettlementId, replacesSettlementId) || other.replacesSettlementId == replacesSettlementId)&&(identical(other.replacedBySettlementId, replacedBySettlementId) || other.replacedBySettlementId == replacedBySettlementId)&&(identical(other.myPayment, myPayment) || other.myPayment == myPayment)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.payments, payments));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,title,scheduleId,scheduleTitle,scheduleStartAt,totalAmount,bankName,accountNumber,accountHolder,dueAt,status,noticeId,canceledAt,cancelReason,replacesSettlementId,replacedBySettlementId,myPayment,summary,const DeepCollectionEquality().hash(payments)]);

@override
String toString() {
  return 'SettlementDetail(id: $id, title: $title, scheduleId: $scheduleId, scheduleTitle: $scheduleTitle, scheduleStartAt: $scheduleStartAt, totalAmount: $totalAmount, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, dueAt: $dueAt, status: $status, noticeId: $noticeId, canceledAt: $canceledAt, cancelReason: $cancelReason, replacesSettlementId: $replacesSettlementId, replacedBySettlementId: $replacedBySettlementId, myPayment: $myPayment, summary: $summary, payments: $payments)';
}


}

/// @nodoc
abstract mixin class $SettlementDetailCopyWith<$Res>  {
  factory $SettlementDetailCopyWith(SettlementDetail value, $Res Function(SettlementDetail) _then) = _$SettlementDetailCopyWithImpl;
@useResult
$Res call({
 int id, String title, int? scheduleId, String? scheduleTitle, DateTime? scheduleStartAt, int totalAmount, String bankName, String accountNumber, String accountHolder, DateTime dueAt, SettlementStatus status, int? noticeId, DateTime? canceledAt, String? cancelReason, int? replacesSettlementId, int? replacedBySettlementId, SettlementPayment? myPayment, SettlementSummary summary, List<SettlementPayment> payments
});


$SettlementPaymentCopyWith<$Res>? get myPayment;$SettlementSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class _$SettlementDetailCopyWithImpl<$Res>
    implements $SettlementDetailCopyWith<$Res> {
  _$SettlementDetailCopyWithImpl(this._self, this._then);

  final SettlementDetail _self;
  final $Res Function(SettlementDetail) _then;

/// Create a copy of SettlementDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? scheduleId = freezed,Object? scheduleTitle = freezed,Object? scheduleStartAt = freezed,Object? totalAmount = null,Object? bankName = null,Object? accountNumber = null,Object? accountHolder = null,Object? dueAt = null,Object? status = null,Object? noticeId = freezed,Object? canceledAt = freezed,Object? cancelReason = freezed,Object? replacesSettlementId = freezed,Object? replacedBySettlementId = freezed,Object? myPayment = freezed,Object? summary = null,Object? payments = null,}) {
  return _then(SettlementDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,scheduleId: freezed == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as int?,scheduleTitle: freezed == scheduleTitle ? _self.scheduleTitle : scheduleTitle // ignore: cast_nullable_to_non_nullable
as String?,scheduleStartAt: freezed == scheduleStartAt ? _self.scheduleStartAt : scheduleStartAt // ignore: cast_nullable_to_non_nullable
as DateTime?,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,bankName: null == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String,accountNumber: null == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String,accountHolder: null == accountHolder ? _self.accountHolder : accountHolder // ignore: cast_nullable_to_non_nullable
as String,dueAt: null == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SettlementStatus,noticeId: freezed == noticeId ? _self.noticeId : noticeId // ignore: cast_nullable_to_non_nullable
as int?,canceledAt: freezed == canceledAt ? _self.canceledAt : canceledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelReason: freezed == cancelReason ? _self.cancelReason : cancelReason // ignore: cast_nullable_to_non_nullable
as String?,replacesSettlementId: freezed == replacesSettlementId ? _self.replacesSettlementId : replacesSettlementId // ignore: cast_nullable_to_non_nullable
as int?,replacedBySettlementId: freezed == replacedBySettlementId ? _self.replacedBySettlementId : replacedBySettlementId // ignore: cast_nullable_to_non_nullable
as int?,myPayment: freezed == myPayment ? _self.myPayment : myPayment // ignore: cast_nullable_to_non_nullable
as SettlementPayment?,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as SettlementSummary,payments: null == payments ? _self.payments : payments // ignore: cast_nullable_to_non_nullable
as List<SettlementPayment>,
  ));
}
/// Create a copy of SettlementDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SettlementPaymentCopyWith<$Res>? get myPayment {
    if (_self.myPayment == null) {
    return null;
  }

  return $SettlementPaymentCopyWith<$Res>(_self.myPayment!, (value) {
    return _then(_self.copyWith(myPayment: value));
  });
}/// Create a copy of SettlementDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SettlementSummaryCopyWith<$Res> get summary {

  return $SettlementSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [SettlementDetail].
extension SettlementDetailPatterns on SettlementDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettlementDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettlementDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettlementDetail value)  $default,){
final _that = this;
switch (_that) {
case _SettlementDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettlementDetail value)?  $default,){
final _that = this;
switch (_that) {
case _SettlementDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  int? scheduleId,  String? scheduleTitle,  DateTime? scheduleStartAt,  int totalAmount,  String bankName,  String accountNumber,  String accountHolder,  DateTime dueAt,  SettlementStatus status,  int? noticeId,  DateTime? canceledAt,  String? cancelReason,  int? replacesSettlementId,  int? replacedBySettlementId,  SettlementPayment? myPayment,  SettlementSummary summary,  List<SettlementPayment> payments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettlementDetail() when $default != null:
return $default(_that.id,_that.title,_that.scheduleId,_that.scheduleTitle,_that.scheduleStartAt,_that.totalAmount,_that.bankName,_that.accountNumber,_that.accountHolder,_that.dueAt,_that.status,_that.noticeId,_that.canceledAt,_that.cancelReason,_that.replacesSettlementId,_that.replacedBySettlementId,_that.myPayment,_that.summary,_that.payments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  int? scheduleId,  String? scheduleTitle,  DateTime? scheduleStartAt,  int totalAmount,  String bankName,  String accountNumber,  String accountHolder,  DateTime dueAt,  SettlementStatus status,  int? noticeId,  DateTime? canceledAt,  String? cancelReason,  int? replacesSettlementId,  int? replacedBySettlementId,  SettlementPayment? myPayment,  SettlementSummary summary,  List<SettlementPayment> payments)  $default,) {final _that = this;
switch (_that) {
case _SettlementDetail():
return $default(_that.id,_that.title,_that.scheduleId,_that.scheduleTitle,_that.scheduleStartAt,_that.totalAmount,_that.bankName,_that.accountNumber,_that.accountHolder,_that.dueAt,_that.status,_that.noticeId,_that.canceledAt,_that.cancelReason,_that.replacesSettlementId,_that.replacedBySettlementId,_that.myPayment,_that.summary,_that.payments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  int? scheduleId,  String? scheduleTitle,  DateTime? scheduleStartAt,  int totalAmount,  String bankName,  String accountNumber,  String accountHolder,  DateTime dueAt,  SettlementStatus status,  int? noticeId,  DateTime? canceledAt,  String? cancelReason,  int? replacesSettlementId,  int? replacedBySettlementId,  SettlementPayment? myPayment,  SettlementSummary summary,  List<SettlementPayment> payments)?  $default,) {final _that = this;
switch (_that) {
case _SettlementDetail() when $default != null:
return $default(_that.id,_that.title,_that.scheduleId,_that.scheduleTitle,_that.scheduleStartAt,_that.totalAmount,_that.bankName,_that.accountNumber,_that.accountHolder,_that.dueAt,_that.status,_that.noticeId,_that.canceledAt,_that.cancelReason,_that.replacesSettlementId,_that.replacedBySettlementId,_that.myPayment,_that.summary,_that.payments);case _:
  return null;

}
}

}

/// @nodoc


class _SettlementDetail implements SettlementDetail {
  const _SettlementDetail({required this.id, required this.title, this.scheduleId, this.scheduleTitle, this.scheduleStartAt, required this.totalAmount, required this.bankName, required this.accountNumber, required this.accountHolder, required this.dueAt, required this.status, this.noticeId, this.canceledAt, this.cancelReason, this.replacesSettlementId, this.replacedBySettlementId, this.myPayment, required this.summary, required  List<SettlementPayment> payments}): _payments = payments;


@override final  int id;
@override final  String title;
@override final  int? scheduleId;
@override final  String? scheduleTitle;
@override final  DateTime? scheduleStartAt;
@override final  int totalAmount;
@override final  String bankName;
@override final  String accountNumber;
@override final  String accountHolder;
@override final  DateTime dueAt;
@override final  SettlementStatus status;
@override final  int? noticeId;
@override final  DateTime? canceledAt;
@override final  String? cancelReason;
@override final  int? replacesSettlementId;
@override final  int? replacedBySettlementId;
@override final  SettlementPayment? myPayment;
@override final  SettlementSummary summary;
 final  List<SettlementPayment> _payments;
@override List<SettlementPayment> get payments {
  if (_payments is EqualUnmodifiableListView) return _payments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payments);
}


/// Create a copy of SettlementDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettlementDetailCopyWith<_SettlementDetail> get copyWith => __$SettlementDetailCopyWithImpl<_SettlementDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettlementDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId)&&(identical(other.scheduleTitle, scheduleTitle) || other.scheduleTitle == scheduleTitle)&&(identical(other.scheduleStartAt, scheduleStartAt) || other.scheduleStartAt == scheduleStartAt)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.accountHolder, accountHolder) || other.accountHolder == accountHolder)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.noticeId, noticeId) || other.noticeId == noticeId)&&(identical(other.canceledAt, canceledAt) || other.canceledAt == canceledAt)&&(identical(other.cancelReason, cancelReason) || other.cancelReason == cancelReason)&&(identical(other.replacesSettlementId, replacesSettlementId) || other.replacesSettlementId == replacesSettlementId)&&(identical(other.replacedBySettlementId, replacedBySettlementId) || other.replacedBySettlementId == replacedBySettlementId)&&(identical(other.myPayment, myPayment) || other.myPayment == myPayment)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._payments, _payments));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,title,scheduleId,scheduleTitle,scheduleStartAt,totalAmount,bankName,accountNumber,accountHolder,dueAt,status,noticeId,canceledAt,cancelReason,replacesSettlementId,replacedBySettlementId,myPayment,summary,const DeepCollectionEquality().hash(_payments)]);

@override
String toString() {
  return 'SettlementDetail(id: $id, title: $title, scheduleId: $scheduleId, scheduleTitle: $scheduleTitle, scheduleStartAt: $scheduleStartAt, totalAmount: $totalAmount, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, dueAt: $dueAt, status: $status, noticeId: $noticeId, canceledAt: $canceledAt, cancelReason: $cancelReason, replacesSettlementId: $replacesSettlementId, replacedBySettlementId: $replacedBySettlementId, myPayment: $myPayment, summary: $summary, payments: $payments)';
}


}

/// @nodoc
abstract mixin class _$SettlementDetailCopyWith<$Res> implements $SettlementDetailCopyWith<$Res> {
  factory _$SettlementDetailCopyWith(_SettlementDetail value, $Res Function(_SettlementDetail) _then) = __$SettlementDetailCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, int? scheduleId, String? scheduleTitle, DateTime? scheduleStartAt, int totalAmount, String bankName, String accountNumber, String accountHolder, DateTime dueAt, SettlementStatus status, int? noticeId, DateTime? canceledAt, String? cancelReason, int? replacesSettlementId, int? replacedBySettlementId, SettlementPayment? myPayment, SettlementSummary summary, List<SettlementPayment> payments
});


@override $SettlementPaymentCopyWith<$Res>? get myPayment;@override $SettlementSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class __$SettlementDetailCopyWithImpl<$Res>
    implements _$SettlementDetailCopyWith<$Res> {
  __$SettlementDetailCopyWithImpl(this._self, this._then);

  final _SettlementDetail _self;
  final $Res Function(_SettlementDetail) _then;

/// Create a copy of SettlementDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? scheduleId = freezed,Object? scheduleTitle = freezed,Object? scheduleStartAt = freezed,Object? totalAmount = null,Object? bankName = null,Object? accountNumber = null,Object? accountHolder = null,Object? dueAt = null,Object? status = null,Object? noticeId = freezed,Object? canceledAt = freezed,Object? cancelReason = freezed,Object? replacesSettlementId = freezed,Object? replacedBySettlementId = freezed,Object? myPayment = freezed,Object? summary = null,Object? payments = null,}) {
  return _then(_SettlementDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,scheduleId: freezed == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as int?,scheduleTitle: freezed == scheduleTitle ? _self.scheduleTitle : scheduleTitle // ignore: cast_nullable_to_non_nullable
as String?,scheduleStartAt: freezed == scheduleStartAt ? _self.scheduleStartAt : scheduleStartAt // ignore: cast_nullable_to_non_nullable
as DateTime?,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,bankName: null == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String,accountNumber: null == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String,accountHolder: null == accountHolder ? _self.accountHolder : accountHolder // ignore: cast_nullable_to_non_nullable
as String,dueAt: null == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SettlementStatus,noticeId: freezed == noticeId ? _self.noticeId : noticeId // ignore: cast_nullable_to_non_nullable
as int?,canceledAt: freezed == canceledAt ? _self.canceledAt : canceledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelReason: freezed == cancelReason ? _self.cancelReason : cancelReason // ignore: cast_nullable_to_non_nullable
as String?,replacesSettlementId: freezed == replacesSettlementId ? _self.replacesSettlementId : replacesSettlementId // ignore: cast_nullable_to_non_nullable
as int?,replacedBySettlementId: freezed == replacedBySettlementId ? _self.replacedBySettlementId : replacedBySettlementId // ignore: cast_nullable_to_non_nullable
as int?,myPayment: freezed == myPayment ? _self.myPayment : myPayment // ignore: cast_nullable_to_non_nullable
as SettlementPayment?,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as SettlementSummary,payments: null == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<SettlementPayment>,
  ));
}

/// Create a copy of SettlementDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SettlementPaymentCopyWith<$Res>? get myPayment {
    if (_self.myPayment == null) {
    return null;
  }

  return $SettlementPaymentCopyWith<$Res>(_self.myPayment!, (value) {
    return _then(_self.copyWith(myPayment: value));
  });
}/// Create a copy of SettlementDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SettlementSummaryCopyWith<$Res> get summary {

  return $SettlementSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

/// @nodoc
mixin _$CreateSettlementInput {

 int get meetingId; int? get scheduleId; String get title; int get totalAmount; List<int> get memberIds; String get bankName; String get accountNumber; String get accountHolder; DateTime get dueAt; bool get postNotice; int? get replacesSettlementId;
/// Create a copy of CreateSettlementInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateSettlementInputCopyWith<CreateSettlementInput> get copyWith => _$CreateSettlementInputCopyWithImpl<CreateSettlementInput>(this as CreateSettlementInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateSettlementInput&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId)&&(identical(other.title, title) || other.title == title)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&const DeepCollectionEquality().equals(other.memberIds, memberIds)&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.accountHolder, accountHolder) || other.accountHolder == accountHolder)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.postNotice, postNotice) || other.postNotice == postNotice)&&(identical(other.replacesSettlementId, replacesSettlementId) || other.replacesSettlementId == replacesSettlementId));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,scheduleId,title,totalAmount,const DeepCollectionEquality().hash(memberIds),bankName,accountNumber,accountHolder,dueAt,postNotice,replacesSettlementId);

@override
String toString() {
  return 'CreateSettlementInput(meetingId: $meetingId, scheduleId: $scheduleId, title: $title, totalAmount: $totalAmount, memberIds: $memberIds, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, dueAt: $dueAt, postNotice: $postNotice, replacesSettlementId: $replacesSettlementId)';
}


}

/// @nodoc
abstract mixin class $CreateSettlementInputCopyWith<$Res>  {
  factory $CreateSettlementInputCopyWith(CreateSettlementInput value, $Res Function(CreateSettlementInput) _then) = _$CreateSettlementInputCopyWithImpl;
@useResult
$Res call({
 int meetingId, int? scheduleId, String title, int totalAmount, List<int> memberIds, String bankName, String accountNumber, String accountHolder, DateTime dueAt, bool postNotice, int? replacesSettlementId
});




}
/// @nodoc
class _$CreateSettlementInputCopyWithImpl<$Res>
    implements $CreateSettlementInputCopyWith<$Res> {
  _$CreateSettlementInputCopyWithImpl(this._self, this._then);

  final CreateSettlementInput _self;
  final $Res Function(CreateSettlementInput) _then;

/// Create a copy of CreateSettlementInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingId = null,Object? scheduleId = freezed,Object? title = null,Object? totalAmount = null,Object? memberIds = null,Object? bankName = null,Object? accountNumber = null,Object? accountHolder = null,Object? dueAt = null,Object? postNotice = null,Object? replacesSettlementId = freezed,}) {
  return _then(CreateSettlementInput(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,scheduleId: freezed == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as int?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,memberIds: null == memberIds ? _self.memberIds : memberIds // ignore: cast_nullable_to_non_nullable
as List<int>,bankName: null == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String,accountNumber: null == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String,accountHolder: null == accountHolder ? _self.accountHolder : accountHolder // ignore: cast_nullable_to_non_nullable
as String,dueAt: null == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime,postNotice: null == postNotice ? _self.postNotice : postNotice // ignore: cast_nullable_to_non_nullable
as bool,replacesSettlementId: freezed == replacesSettlementId ? _self.replacesSettlementId : replacesSettlementId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateSettlementInput].
extension CreateSettlementInputPatterns on CreateSettlementInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateSettlementInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateSettlementInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateSettlementInput value)  $default,){
final _that = this;
switch (_that) {
case _CreateSettlementInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateSettlementInput value)?  $default,){
final _that = this;
switch (_that) {
case _CreateSettlementInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int meetingId,  int? scheduleId,  String title,  int totalAmount,  List<int> memberIds,  String bankName,  String accountNumber,  String accountHolder,  DateTime dueAt,  bool postNotice,  int? replacesSettlementId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateSettlementInput() when $default != null:
return $default(_that.meetingId,_that.scheduleId,_that.title,_that.totalAmount,_that.memberIds,_that.bankName,_that.accountNumber,_that.accountHolder,_that.dueAt,_that.postNotice,_that.replacesSettlementId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int meetingId,  int? scheduleId,  String title,  int totalAmount,  List<int> memberIds,  String bankName,  String accountNumber,  String accountHolder,  DateTime dueAt,  bool postNotice,  int? replacesSettlementId)  $default,) {final _that = this;
switch (_that) {
case _CreateSettlementInput():
return $default(_that.meetingId,_that.scheduleId,_that.title,_that.totalAmount,_that.memberIds,_that.bankName,_that.accountNumber,_that.accountHolder,_that.dueAt,_that.postNotice,_that.replacesSettlementId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int meetingId,  int? scheduleId,  String title,  int totalAmount,  List<int> memberIds,  String bankName,  String accountNumber,  String accountHolder,  DateTime dueAt,  bool postNotice,  int? replacesSettlementId)?  $default,) {final _that = this;
switch (_that) {
case _CreateSettlementInput() when $default != null:
return $default(_that.meetingId,_that.scheduleId,_that.title,_that.totalAmount,_that.memberIds,_that.bankName,_that.accountNumber,_that.accountHolder,_that.dueAt,_that.postNotice,_that.replacesSettlementId);case _:
  return null;

}
}

}

/// @nodoc


class _CreateSettlementInput implements CreateSettlementInput {
  const _CreateSettlementInput({required this.meetingId, this.scheduleId, required this.title, required this.totalAmount, required  List<int> memberIds, required this.bankName, required this.accountNumber, required this.accountHolder, required this.dueAt, this.postNotice = false, this.replacesSettlementId}): _memberIds = memberIds;


@override final  int meetingId;
@override final  int? scheduleId;
@override final  String title;
@override final  int totalAmount;
 final  List<int> _memberIds;
@override List<int> get memberIds {
  if (_memberIds is EqualUnmodifiableListView) return _memberIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberIds);
}

@override final  String bankName;
@override final  String accountNumber;
@override final  String accountHolder;
@override final  DateTime dueAt;
@override@JsonKey() final  bool postNotice;
@override final  int? replacesSettlementId;

/// Create a copy of CreateSettlementInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateSettlementInputCopyWith<_CreateSettlementInput> get copyWith => __$CreateSettlementInputCopyWithImpl<_CreateSettlementInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateSettlementInput&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.scheduleId, scheduleId) || other.scheduleId == scheduleId)&&(identical(other.title, title) || other.title == title)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&const DeepCollectionEquality().equals(other._memberIds, _memberIds)&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.accountHolder, accountHolder) || other.accountHolder == accountHolder)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.postNotice, postNotice) || other.postNotice == postNotice)&&(identical(other.replacesSettlementId, replacesSettlementId) || other.replacesSettlementId == replacesSettlementId));
}


@override
int get hashCode => Object.hash(runtimeType,meetingId,scheduleId,title,totalAmount,const DeepCollectionEquality().hash(_memberIds),bankName,accountNumber,accountHolder,dueAt,postNotice,replacesSettlementId);

@override
String toString() {
  return 'CreateSettlementInput(meetingId: $meetingId, scheduleId: $scheduleId, title: $title, totalAmount: $totalAmount, memberIds: $memberIds, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, dueAt: $dueAt, postNotice: $postNotice, replacesSettlementId: $replacesSettlementId)';
}


}

/// @nodoc
abstract mixin class _$CreateSettlementInputCopyWith<$Res> implements $CreateSettlementInputCopyWith<$Res> {
  factory _$CreateSettlementInputCopyWith(_CreateSettlementInput value, $Res Function(_CreateSettlementInput) _then) = __$CreateSettlementInputCopyWithImpl;
@override @useResult
$Res call({
 int meetingId, int? scheduleId, String title, int totalAmount, List<int> memberIds, String bankName, String accountNumber, String accountHolder, DateTime dueAt, bool postNotice, int? replacesSettlementId
});




}
/// @nodoc
class __$CreateSettlementInputCopyWithImpl<$Res>
    implements _$CreateSettlementInputCopyWith<$Res> {
  __$CreateSettlementInputCopyWithImpl(this._self, this._then);

  final _CreateSettlementInput _self;
  final $Res Function(_CreateSettlementInput) _then;

/// Create a copy of CreateSettlementInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingId = null,Object? scheduleId = freezed,Object? title = null,Object? totalAmount = null,Object? memberIds = null,Object? bankName = null,Object? accountNumber = null,Object? accountHolder = null,Object? dueAt = null,Object? postNotice = null,Object? replacesSettlementId = freezed,}) {
  return _then(_CreateSettlementInput(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,scheduleId: freezed == scheduleId ? _self.scheduleId : scheduleId // ignore: cast_nullable_to_non_nullable
as int?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,memberIds: null == memberIds ? _self._memberIds : memberIds // ignore: cast_nullable_to_non_nullable
as List<int>,bankName: null == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String,accountNumber: null == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String,accountHolder: null == accountHolder ? _self.accountHolder : accountHolder // ignore: cast_nullable_to_non_nullable
as String,dueAt: null == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime,postNotice: null == postNotice ? _self.postNotice : postNotice // ignore: cast_nullable_to_non_nullable
as bool,replacesSettlementId: freezed == replacesSettlementId ? _self.replacesSettlementId : replacesSettlementId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$PaymentAction {

 int get paymentId; PaymentStatus get status; DateTime? get submittedAt; DateTime? get confirmedAt; String? get rejectionReason;
/// Create a copy of PaymentAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentActionCopyWith<PaymentAction> get copyWith => _$PaymentActionCopyWithImpl<PaymentAction>(this as PaymentAction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentAction&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.status, status) || other.status == status)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.confirmedAt, confirmedAt) || other.confirmedAt == confirmedAt)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason));
}


@override
int get hashCode => Object.hash(runtimeType,paymentId,status,submittedAt,confirmedAt,rejectionReason);

@override
String toString() {
  return 'PaymentAction(paymentId: $paymentId, status: $status, submittedAt: $submittedAt, confirmedAt: $confirmedAt, rejectionReason: $rejectionReason)';
}


}

/// @nodoc
abstract mixin class $PaymentActionCopyWith<$Res>  {
  factory $PaymentActionCopyWith(PaymentAction value, $Res Function(PaymentAction) _then) = _$PaymentActionCopyWithImpl;
@useResult
$Res call({
 int paymentId, PaymentStatus status, DateTime? submittedAt, DateTime? confirmedAt, String? rejectionReason
});




}
/// @nodoc
class _$PaymentActionCopyWithImpl<$Res>
    implements $PaymentActionCopyWith<$Res> {
  _$PaymentActionCopyWithImpl(this._self, this._then);

  final PaymentAction _self;
  final $Res Function(PaymentAction) _then;

/// Create a copy of PaymentAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentId = null,Object? status = null,Object? submittedAt = freezed,Object? confirmedAt = freezed,Object? rejectionReason = freezed,}) {
  return _then(PaymentAction(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,confirmedAt: freezed == confirmedAt ? _self.confirmedAt : confirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentAction].
extension PaymentActionPatterns on PaymentAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentAction value)  $default,){
final _that = this;
switch (_that) {
case _PaymentAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentAction value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int paymentId,  PaymentStatus status,  DateTime? submittedAt,  DateTime? confirmedAt,  String? rejectionReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentAction() when $default != null:
return $default(_that.paymentId,_that.status,_that.submittedAt,_that.confirmedAt,_that.rejectionReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int paymentId,  PaymentStatus status,  DateTime? submittedAt,  DateTime? confirmedAt,  String? rejectionReason)  $default,) {final _that = this;
switch (_that) {
case _PaymentAction():
return $default(_that.paymentId,_that.status,_that.submittedAt,_that.confirmedAt,_that.rejectionReason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int paymentId,  PaymentStatus status,  DateTime? submittedAt,  DateTime? confirmedAt,  String? rejectionReason)?  $default,) {final _that = this;
switch (_that) {
case _PaymentAction() when $default != null:
return $default(_that.paymentId,_that.status,_that.submittedAt,_that.confirmedAt,_that.rejectionReason);case _:
  return null;

}
}

}

/// @nodoc


class _PaymentAction implements PaymentAction {
  const _PaymentAction({required this.paymentId, required this.status, this.submittedAt, this.confirmedAt, this.rejectionReason});


@override final  int paymentId;
@override final  PaymentStatus status;
@override final  DateTime? submittedAt;
@override final  DateTime? confirmedAt;
@override final  String? rejectionReason;

/// Create a copy of PaymentAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentActionCopyWith<_PaymentAction> get copyWith => __$PaymentActionCopyWithImpl<_PaymentAction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentAction&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.status, status) || other.status == status)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.confirmedAt, confirmedAt) || other.confirmedAt == confirmedAt)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason));
}


@override
int get hashCode => Object.hash(runtimeType,paymentId,status,submittedAt,confirmedAt,rejectionReason);

@override
String toString() {
  return 'PaymentAction(paymentId: $paymentId, status: $status, submittedAt: $submittedAt, confirmedAt: $confirmedAt, rejectionReason: $rejectionReason)';
}


}

/// @nodoc
abstract mixin class _$PaymentActionCopyWith<$Res> implements $PaymentActionCopyWith<$Res> {
  factory _$PaymentActionCopyWith(_PaymentAction value, $Res Function(_PaymentAction) _then) = __$PaymentActionCopyWithImpl;
@override @useResult
$Res call({
 int paymentId, PaymentStatus status, DateTime? submittedAt, DateTime? confirmedAt, String? rejectionReason
});




}
/// @nodoc
class __$PaymentActionCopyWithImpl<$Res>
    implements _$PaymentActionCopyWith<$Res> {
  __$PaymentActionCopyWithImpl(this._self, this._then);

  final _PaymentAction _self;
  final $Res Function(_PaymentAction) _then;

/// Create a copy of PaymentAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentId = null,Object? status = null,Object? submittedAt = freezed,Object? confirmedAt = freezed,Object? rejectionReason = freezed,}) {
  return _then(_PaymentAction(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,confirmedAt: freezed == confirmedAt ? _self.confirmedAt : confirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
