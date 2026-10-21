// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_update_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GroupUpdateModel {

 int get meetingId; String get name; String? get description;
/// Create a copy of GroupUpdateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupUpdateModelCopyWith<GroupUpdateModel> get copyWith => _$GroupUpdateModelCopyWithImpl<GroupUpdateModel>(this as GroupUpdateModel, _$identity);

  /// Serializes this GroupUpdateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupUpdateModel&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meetingId,name,description);

@override
String toString() {
  return 'GroupUpdateModel(meetingId: $meetingId, name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class $GroupUpdateModelCopyWith<$Res>  {
  factory $GroupUpdateModelCopyWith(GroupUpdateModel value, $Res Function(GroupUpdateModel) _then) = _$GroupUpdateModelCopyWithImpl;
@useResult
$Res call({
 int meetingId, String name, String? description
});




}
/// @nodoc
class _$GroupUpdateModelCopyWithImpl<$Res>
    implements $GroupUpdateModelCopyWith<$Res> {
  _$GroupUpdateModelCopyWithImpl(this._self, this._then);

  final GroupUpdateModel _self;
  final $Res Function(GroupUpdateModel) _then;

/// Create a copy of GroupUpdateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingId = null,Object? name = null,Object? description = freezed,}) {
  return _then(GroupUpdateModel(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupUpdateModel].
extension GroupUpdateModelPatterns on GroupUpdateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupUpdateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupUpdateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupUpdateModel value)  $default,){
final _that = this;
switch (_that) {
case _GroupUpdateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupUpdateModel value)?  $default,){
final _that = this;
switch (_that) {
case _GroupUpdateModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int meetingId,  String name,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupUpdateModel() when $default != null:
return $default(_that.meetingId,_that.name,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int meetingId,  String name,  String? description)  $default,) {final _that = this;
switch (_that) {
case _GroupUpdateModel():
return $default(_that.meetingId,_that.name,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int meetingId,  String name,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _GroupUpdateModel() when $default != null:
return $default(_that.meetingId,_that.name,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GroupUpdateModel implements GroupUpdateModel {
  const _GroupUpdateModel({required this.meetingId, required this.name, this.description});
  factory _GroupUpdateModel.fromJson(Map<String, dynamic> json) => _$GroupUpdateModelFromJson(json);

@override final  int meetingId;
@override final  String name;
@override final  String? description;

/// Create a copy of GroupUpdateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupUpdateModelCopyWith<_GroupUpdateModel> get copyWith => __$GroupUpdateModelCopyWithImpl<_GroupUpdateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupUpdateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupUpdateModel&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meetingId,name,description);

@override
String toString() {
  return 'GroupUpdateModel(meetingId: $meetingId, name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class _$GroupUpdateModelCopyWith<$Res> implements $GroupUpdateModelCopyWith<$Res> {
  factory _$GroupUpdateModelCopyWith(_GroupUpdateModel value, $Res Function(_GroupUpdateModel) _then) = __$GroupUpdateModelCopyWithImpl;
@override @useResult
$Res call({
 int meetingId, String name, String? description
});




}
/// @nodoc
class __$GroupUpdateModelCopyWithImpl<$Res>
    implements _$GroupUpdateModelCopyWith<$Res> {
  __$GroupUpdateModelCopyWithImpl(this._self, this._then);

  final _GroupUpdateModel _self;
  final $Res Function(_GroupUpdateModel) _then;

/// Create a copy of GroupUpdateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingId = null,Object? name = null,Object? description = freezed,}) {
  return _then(_GroupUpdateModel(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
