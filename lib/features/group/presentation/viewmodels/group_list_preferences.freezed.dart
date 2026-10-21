// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_list_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GroupListPreferences {

 List<int> get pinnedIds; List<int> get archivedIds; List<int> get orderedIds;
/// Create a copy of GroupListPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupListPreferencesCopyWith<GroupListPreferences> get copyWith => _$GroupListPreferencesCopyWithImpl<GroupListPreferences>(this as GroupListPreferences, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupListPreferences&&const DeepCollectionEquality().equals(other.pinnedIds, pinnedIds)&&const DeepCollectionEquality().equals(other.archivedIds, archivedIds)&&const DeepCollectionEquality().equals(other.orderedIds, orderedIds));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(pinnedIds),const DeepCollectionEquality().hash(archivedIds),const DeepCollectionEquality().hash(orderedIds));

@override
String toString() {
  return 'GroupListPreferences(pinnedIds: $pinnedIds, archivedIds: $archivedIds, orderedIds: $orderedIds)';
}


}

/// @nodoc
abstract mixin class $GroupListPreferencesCopyWith<$Res>  {
  factory $GroupListPreferencesCopyWith(GroupListPreferences value, $Res Function(GroupListPreferences) _then) = _$GroupListPreferencesCopyWithImpl;
@useResult
$Res call({
 List<int> pinnedIds, List<int> archivedIds, List<int> orderedIds
});




}
/// @nodoc
class _$GroupListPreferencesCopyWithImpl<$Res>
    implements $GroupListPreferencesCopyWith<$Res> {
  _$GroupListPreferencesCopyWithImpl(this._self, this._then);

  final GroupListPreferences _self;
  final $Res Function(GroupListPreferences) _then;

/// Create a copy of GroupListPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pinnedIds = null,Object? archivedIds = null,Object? orderedIds = null,}) {
  return _then(GroupListPreferences(
pinnedIds: null == pinnedIds ? _self.pinnedIds : pinnedIds // ignore: cast_nullable_to_non_nullable
as List<int>,archivedIds: null == archivedIds ? _self.archivedIds : archivedIds // ignore: cast_nullable_to_non_nullable
as List<int>,orderedIds: null == orderedIds ? _self.orderedIds : orderedIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupListPreferences].
extension GroupListPreferencesPatterns on GroupListPreferences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupListPreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupListPreferences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupListPreferences value)  $default,){
final _that = this;
switch (_that) {
case _GroupListPreferences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupListPreferences value)?  $default,){
final _that = this;
switch (_that) {
case _GroupListPreferences() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<int> pinnedIds,  List<int> archivedIds,  List<int> orderedIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupListPreferences() when $default != null:
return $default(_that.pinnedIds,_that.archivedIds,_that.orderedIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<int> pinnedIds,  List<int> archivedIds,  List<int> orderedIds)  $default,) {final _that = this;
switch (_that) {
case _GroupListPreferences():
return $default(_that.pinnedIds,_that.archivedIds,_that.orderedIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<int> pinnedIds,  List<int> archivedIds,  List<int> orderedIds)?  $default,) {final _that = this;
switch (_that) {
case _GroupListPreferences() when $default != null:
return $default(_that.pinnedIds,_that.archivedIds,_that.orderedIds);case _:
  return null;

}
}

}

/// @nodoc


class _GroupListPreferences implements GroupListPreferences {
  const _GroupListPreferences({ List<int> pinnedIds = const [],  List<int> archivedIds = const [],  List<int> orderedIds = const []}): _pinnedIds = pinnedIds,_archivedIds = archivedIds,_orderedIds = orderedIds;
  

 final  List<int> _pinnedIds;
@override@JsonKey() List<int> get pinnedIds {
  if (_pinnedIds is EqualUnmodifiableListView) return _pinnedIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pinnedIds);
}

 final  List<int> _archivedIds;
@override@JsonKey() List<int> get archivedIds {
  if (_archivedIds is EqualUnmodifiableListView) return _archivedIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_archivedIds);
}

 final  List<int> _orderedIds;
@override@JsonKey() List<int> get orderedIds {
  if (_orderedIds is EqualUnmodifiableListView) return _orderedIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orderedIds);
}


/// Create a copy of GroupListPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupListPreferencesCopyWith<_GroupListPreferences> get copyWith => __$GroupListPreferencesCopyWithImpl<_GroupListPreferences>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupListPreferences&&const DeepCollectionEquality().equals(other._pinnedIds, _pinnedIds)&&const DeepCollectionEquality().equals(other._archivedIds, _archivedIds)&&const DeepCollectionEquality().equals(other._orderedIds, _orderedIds));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_pinnedIds),const DeepCollectionEquality().hash(_archivedIds),const DeepCollectionEquality().hash(_orderedIds));

@override
String toString() {
  return 'GroupListPreferences(pinnedIds: $pinnedIds, archivedIds: $archivedIds, orderedIds: $orderedIds)';
}


}

/// @nodoc
abstract mixin class _$GroupListPreferencesCopyWith<$Res> implements $GroupListPreferencesCopyWith<$Res> {
  factory _$GroupListPreferencesCopyWith(_GroupListPreferences value, $Res Function(_GroupListPreferences) _then) = __$GroupListPreferencesCopyWithImpl;
@override @useResult
$Res call({
 List<int> pinnedIds, List<int> archivedIds, List<int> orderedIds
});




}
/// @nodoc
class __$GroupListPreferencesCopyWithImpl<$Res>
    implements _$GroupListPreferencesCopyWith<$Res> {
  __$GroupListPreferencesCopyWithImpl(this._self, this._then);

  final _GroupListPreferences _self;
  final $Res Function(_GroupListPreferences) _then;

/// Create a copy of GroupListPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pinnedIds = null,Object? archivedIds = null,Object? orderedIds = null,}) {
  return _then(_GroupListPreferences(
pinnedIds: null == pinnedIds ? _self._pinnedIds : pinnedIds // ignore: cast_nullable_to_non_nullable
as List<int>,archivedIds: null == archivedIds ? _self._archivedIds : archivedIds // ignore: cast_nullable_to_non_nullable
as List<int>,orderedIds: null == orderedIds ? _self._orderedIds : orderedIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
