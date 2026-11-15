// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vote_candidate_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VoteCandidateModel {

/// ISO-8601 (예: 2026-10-24T19:00:00+09:00)
 String get meetingTime; int get availableCount; bool get selectedByMe;
/// Create a copy of VoteCandidateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoteCandidateModelCopyWith<VoteCandidateModel> get copyWith => _$VoteCandidateModelCopyWithImpl<VoteCandidateModel>(this as VoteCandidateModel, _$identity);

  /// Serializes this VoteCandidateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoteCandidateModel&&(identical(other.meetingTime, meetingTime) || other.meetingTime == meetingTime)&&(identical(other.availableCount, availableCount) || other.availableCount == availableCount)&&(identical(other.selectedByMe, selectedByMe) || other.selectedByMe == selectedByMe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meetingTime,availableCount,selectedByMe);

@override
String toString() {
  return 'VoteCandidateModel(meetingTime: $meetingTime, availableCount: $availableCount, selectedByMe: $selectedByMe)';
}


}

/// @nodoc
abstract mixin class $VoteCandidateModelCopyWith<$Res>  {
  factory $VoteCandidateModelCopyWith(VoteCandidateModel value, $Res Function(VoteCandidateModel) _then) = _$VoteCandidateModelCopyWithImpl;
@useResult
$Res call({
 String meetingTime, int availableCount, bool selectedByMe
});




}
/// @nodoc
class _$VoteCandidateModelCopyWithImpl<$Res>
    implements $VoteCandidateModelCopyWith<$Res> {
  _$VoteCandidateModelCopyWithImpl(this._self, this._then);

  final VoteCandidateModel _self;
  final $Res Function(VoteCandidateModel) _then;

/// Create a copy of VoteCandidateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingTime = null,Object? availableCount = null,Object? selectedByMe = null,}) {
  return _then(VoteCandidateModel(
meetingTime: null == meetingTime ? _self.meetingTime : meetingTime // ignore: cast_nullable_to_non_nullable
as String,availableCount: null == availableCount ? _self.availableCount : availableCount // ignore: cast_nullable_to_non_nullable
as int,selectedByMe: null == selectedByMe ? _self.selectedByMe : selectedByMe // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VoteCandidateModel].
extension VoteCandidateModelPatterns on VoteCandidateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoteCandidateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoteCandidateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoteCandidateModel value)  $default,){
final _that = this;
switch (_that) {
case _VoteCandidateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoteCandidateModel value)?  $default,){
final _that = this;
switch (_that) {
case _VoteCandidateModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String meetingTime,  int availableCount,  bool selectedByMe)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoteCandidateModel() when $default != null:
return $default(_that.meetingTime,_that.availableCount,_that.selectedByMe);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String meetingTime,  int availableCount,  bool selectedByMe)  $default,) {final _that = this;
switch (_that) {
case _VoteCandidateModel():
return $default(_that.meetingTime,_that.availableCount,_that.selectedByMe);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String meetingTime,  int availableCount,  bool selectedByMe)?  $default,) {final _that = this;
switch (_that) {
case _VoteCandidateModel() when $default != null:
return $default(_that.meetingTime,_that.availableCount,_that.selectedByMe);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VoteCandidateModel implements VoteCandidateModel {
  const _VoteCandidateModel({required this.meetingTime, required this.availableCount, required this.selectedByMe});
  factory _VoteCandidateModel.fromJson(Map<String, dynamic> json) => _$VoteCandidateModelFromJson(json);

/// ISO-8601 (예: 2026-10-24T19:00:00+09:00)
@override final  String meetingTime;
@override final  int availableCount;
@override final  bool selectedByMe;

/// Create a copy of VoteCandidateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoteCandidateModelCopyWith<_VoteCandidateModel> get copyWith => __$VoteCandidateModelCopyWithImpl<_VoteCandidateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoteCandidateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoteCandidateModel&&(identical(other.meetingTime, meetingTime) || other.meetingTime == meetingTime)&&(identical(other.availableCount, availableCount) || other.availableCount == availableCount)&&(identical(other.selectedByMe, selectedByMe) || other.selectedByMe == selectedByMe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meetingTime,availableCount,selectedByMe);

@override
String toString() {
  return 'VoteCandidateModel(meetingTime: $meetingTime, availableCount: $availableCount, selectedByMe: $selectedByMe)';
}


}

/// @nodoc
abstract mixin class _$VoteCandidateModelCopyWith<$Res> implements $VoteCandidateModelCopyWith<$Res> {
  factory _$VoteCandidateModelCopyWith(_VoteCandidateModel value, $Res Function(_VoteCandidateModel) _then) = __$VoteCandidateModelCopyWithImpl;
@override @useResult
$Res call({
 String meetingTime, int availableCount, bool selectedByMe
});




}
/// @nodoc
class __$VoteCandidateModelCopyWithImpl<$Res>
    implements _$VoteCandidateModelCopyWith<$Res> {
  __$VoteCandidateModelCopyWithImpl(this._self, this._then);

  final _VoteCandidateModel _self;
  final $Res Function(_VoteCandidateModel) _then;

/// Create a copy of VoteCandidateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingTime = null,Object? availableCount = null,Object? selectedByMe = null,}) {
  return _then(_VoteCandidateModel(
meetingTime: null == meetingTime ? _self.meetingTime : meetingTime // ignore: cast_nullable_to_non_nullable
as String,availableCount: null == availableCount ? _self.availableCount : availableCount // ignore: cast_nullable_to_non_nullable
as int,selectedByMe: null == selectedByMe ? _self.selectedByMe : selectedByMe // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
