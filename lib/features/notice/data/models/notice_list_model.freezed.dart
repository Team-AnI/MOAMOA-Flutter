// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notice_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NoticeListModel {

 List<NoticeModel> get notices; int get page; int get size; bool get hasNext;
/// Create a copy of NoticeListModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoticeListModelCopyWith<NoticeListModel> get copyWith => _$NoticeListModelCopyWithImpl<NoticeListModel>(this as NoticeListModel, _$identity);

  /// Serializes this NoticeListModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoticeListModel&&const DeepCollectionEquality().equals(other.notices, notices)&&(identical(other.page, page) || other.page == page)&&(identical(other.size, size) || other.size == size)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(notices),page,size,hasNext);

@override
String toString() {
  return 'NoticeListModel(notices: $notices, page: $page, size: $size, hasNext: $hasNext)';
}


}

/// @nodoc
abstract mixin class $NoticeListModelCopyWith<$Res>  {
  factory $NoticeListModelCopyWith(NoticeListModel value, $Res Function(NoticeListModel) _then) = _$NoticeListModelCopyWithImpl;
@useResult
$Res call({
 List<NoticeModel> notices, int page, int size, bool hasNext
});




}
/// @nodoc
class _$NoticeListModelCopyWithImpl<$Res>
    implements $NoticeListModelCopyWith<$Res> {
  _$NoticeListModelCopyWithImpl(this._self, this._then);

  final NoticeListModel _self;
  final $Res Function(NoticeListModel) _then;

/// Create a copy of NoticeListModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notices = null,Object? page = null,Object? size = null,Object? hasNext = null,}) {
  return _then(NoticeListModel(
notices: null == notices ? _self.notices : notices // ignore: cast_nullable_to_non_nullable
as List<NoticeModel>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NoticeListModel].
extension NoticeListModelPatterns on NoticeListModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoticeListModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoticeListModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoticeListModel value)  $default,){
final _that = this;
switch (_that) {
case _NoticeListModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoticeListModel value)?  $default,){
final _that = this;
switch (_that) {
case _NoticeListModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<NoticeModel> notices,  int page,  int size,  bool hasNext)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoticeListModel() when $default != null:
return $default(_that.notices,_that.page,_that.size,_that.hasNext);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<NoticeModel> notices,  int page,  int size,  bool hasNext)  $default,) {final _that = this;
switch (_that) {
case _NoticeListModel():
return $default(_that.notices,_that.page,_that.size,_that.hasNext);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<NoticeModel> notices,  int page,  int size,  bool hasNext)?  $default,) {final _that = this;
switch (_that) {
case _NoticeListModel() when $default != null:
return $default(_that.notices,_that.page,_that.size,_that.hasNext);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NoticeListModel extends NoticeListModel {
  const _NoticeListModel({required  List<NoticeModel> notices, required this.page, required this.size, required this.hasNext}): _notices = notices,super._();
  factory _NoticeListModel.fromJson(Map<String, dynamic> json) => _$NoticeListModelFromJson(json);

 final  List<NoticeModel> _notices;
@override List<NoticeModel> get notices {
  if (_notices is EqualUnmodifiableListView) return _notices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notices);
}

@override final  int page;
@override final  int size;
@override final  bool hasNext;

/// Create a copy of NoticeListModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoticeListModelCopyWith<_NoticeListModel> get copyWith => __$NoticeListModelCopyWithImpl<_NoticeListModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NoticeListModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoticeListModel&&const DeepCollectionEquality().equals(other._notices, _notices)&&(identical(other.page, page) || other.page == page)&&(identical(other.size, size) || other.size == size)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_notices),page,size,hasNext);

@override
String toString() {
  return 'NoticeListModel(notices: $notices, page: $page, size: $size, hasNext: $hasNext)';
}


}

/// @nodoc
abstract mixin class _$NoticeListModelCopyWith<$Res> implements $NoticeListModelCopyWith<$Res> {
  factory _$NoticeListModelCopyWith(_NoticeListModel value, $Res Function(_NoticeListModel) _then) = __$NoticeListModelCopyWithImpl;
@override @useResult
$Res call({
 List<NoticeModel> notices, int page, int size, bool hasNext
});




}
/// @nodoc
class __$NoticeListModelCopyWithImpl<$Res>
    implements _$NoticeListModelCopyWith<$Res> {
  __$NoticeListModelCopyWithImpl(this._self, this._then);

  final _NoticeListModel _self;
  final $Res Function(_NoticeListModel) _then;

/// Create a copy of NoticeListModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notices = null,Object? page = null,Object? size = null,Object? hasNext = null,}) {
  return _then(_NoticeListModel(
notices: null == notices ? _self._notices : notices // ignore: cast_nullable_to_non_nullable
as List<NoticeModel>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
