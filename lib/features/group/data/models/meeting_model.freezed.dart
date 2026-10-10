// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MeetingModel {

 int get id; String get name; String? get description; MemberRole get role; int? get memberCount;
/// Create a copy of MeetingModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingModelCopyWith<MeetingModel> get copyWith => _$MeetingModelCopyWithImpl<MeetingModel>(this as MeetingModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetingModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.role, role) || other.role == role)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,role,memberCount);

@override
String toString() {
  return 'MeetingModel(id: $id, name: $name, description: $description, role: $role, memberCount: $memberCount)';
}


}

/// @nodoc
abstract mixin class $MeetingModelCopyWith<$Res>  {
  factory $MeetingModelCopyWith(MeetingModel value, $Res Function(MeetingModel) _then) = _$MeetingModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? description, MemberRole role, int? memberCount
});




}
/// @nodoc
class _$MeetingModelCopyWithImpl<$Res>
    implements $MeetingModelCopyWith<$Res> {
  _$MeetingModelCopyWithImpl(this._self, this._then);

  final MeetingModel _self;
  final $Res Function(MeetingModel) _then;

/// Create a copy of MeetingModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? role = null,Object? memberCount = freezed,}) {
  return _then(MeetingModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as MemberRole,memberCount: freezed == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [MeetingModel].
extension MeetingModelPatterns on MeetingModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetingModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetingModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetingModel value)  $default,){
final _that = this;
switch (_that) {
case _MeetingModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetingModel value)?  $default,){
final _that = this;
switch (_that) {
case _MeetingModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  MemberRole role,  int? memberCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetingModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.role,_that.memberCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  MemberRole role,  int? memberCount)  $default,) {final _that = this;
switch (_that) {
case _MeetingModel():
return $default(_that.id,_that.name,_that.description,_that.role,_that.memberCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? description,  MemberRole role,  int? memberCount)?  $default,) {final _that = this;
switch (_that) {
case _MeetingModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.role,_that.memberCount);case _:
  return null;

}
}

}

/// @nodoc


class _MeetingModel implements MeetingModel {
  const _MeetingModel({required this.id, required this.name, this.description, required this.role, this.memberCount});
  

@override final  int id;
@override final  String name;
@override final  String? description;
@override final  MemberRole role;
@override final  int? memberCount;

/// Create a copy of MeetingModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingModelCopyWith<_MeetingModel> get copyWith => __$MeetingModelCopyWithImpl<_MeetingModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetingModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.role, role) || other.role == role)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,role,memberCount);

@override
String toString() {
  return 'MeetingModel(id: $id, name: $name, description: $description, role: $role, memberCount: $memberCount)';
}


}

/// @nodoc
abstract mixin class _$MeetingModelCopyWith<$Res> implements $MeetingModelCopyWith<$Res> {
  factory _$MeetingModelCopyWith(_MeetingModel value, $Res Function(_MeetingModel) _then) = __$MeetingModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? description, MemberRole role, int? memberCount
});




}
/// @nodoc
class __$MeetingModelCopyWithImpl<$Res>
    implements _$MeetingModelCopyWith<$Res> {
  __$MeetingModelCopyWithImpl(this._self, this._then);

  final _MeetingModel _self;
  final $Res Function(_MeetingModel) _then;

/// Create a copy of MeetingModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? role = null,Object? memberCount = freezed,}) {
  return _then(_MeetingModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as MemberRole,memberCount: freezed == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
