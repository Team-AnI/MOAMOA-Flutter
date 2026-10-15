// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'created_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreatedSchedule {

 int get id; String get title; DateTime get startAt;
/// Create a copy of CreatedSchedule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatedScheduleCopyWith<CreatedSchedule> get copyWith => _$CreatedScheduleCopyWithImpl<CreatedSchedule>(this as CreatedSchedule, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatedSchedule&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startAt, startAt) || other.startAt == startAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,startAt);

@override
String toString() {
  return 'CreatedSchedule(id: $id, title: $title, startAt: $startAt)';
}


}

/// @nodoc
abstract mixin class $CreatedScheduleCopyWith<$Res>  {
  factory $CreatedScheduleCopyWith(CreatedSchedule value, $Res Function(CreatedSchedule) _then) = _$CreatedScheduleCopyWithImpl;
@useResult
$Res call({
 int id, String title, DateTime startAt
});




}
/// @nodoc
class _$CreatedScheduleCopyWithImpl<$Res>
    implements $CreatedScheduleCopyWith<$Res> {
  _$CreatedScheduleCopyWithImpl(this._self, this._then);

  final CreatedSchedule _self;
  final $Res Function(CreatedSchedule) _then;

/// Create a copy of CreatedSchedule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startAt = null,}) {
  return _then(CreatedSchedule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatedSchedule].
extension CreatedSchedulePatterns on CreatedSchedule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatedSchedule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatedSchedule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatedSchedule value)  $default,){
final _that = this;
switch (_that) {
case _CreatedSchedule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatedSchedule value)?  $default,){
final _that = this;
switch (_that) {
case _CreatedSchedule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  DateTime startAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatedSchedule() when $default != null:
return $default(_that.id,_that.title,_that.startAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  DateTime startAt)  $default,) {final _that = this;
switch (_that) {
case _CreatedSchedule():
return $default(_that.id,_that.title,_that.startAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  DateTime startAt)?  $default,) {final _that = this;
switch (_that) {
case _CreatedSchedule() when $default != null:
return $default(_that.id,_that.title,_that.startAt);case _:
  return null;

}
}

}

/// @nodoc


class _CreatedSchedule implements CreatedSchedule {
  const _CreatedSchedule({required this.id, required this.title, required this.startAt});
  

@override final  int id;
@override final  String title;
@override final  DateTime startAt;

/// Create a copy of CreatedSchedule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatedScheduleCopyWith<_CreatedSchedule> get copyWith => __$CreatedScheduleCopyWithImpl<_CreatedSchedule>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatedSchedule&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startAt, startAt) || other.startAt == startAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,startAt);

@override
String toString() {
  return 'CreatedSchedule(id: $id, title: $title, startAt: $startAt)';
}


}

/// @nodoc
abstract mixin class _$CreatedScheduleCopyWith<$Res> implements $CreatedScheduleCopyWith<$Res> {
  factory _$CreatedScheduleCopyWith(_CreatedSchedule value, $Res Function(_CreatedSchedule) _then) = __$CreatedScheduleCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, DateTime startAt
});




}
/// @nodoc
class __$CreatedScheduleCopyWithImpl<$Res>
    implements _$CreatedScheduleCopyWith<$Res> {
  __$CreatedScheduleCopyWithImpl(this._self, this._then);

  final _CreatedSchedule _self;
  final $Res Function(_CreatedSchedule) _then;

/// Create a copy of CreatedSchedule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startAt = null,}) {
  return _then(_CreatedSchedule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
