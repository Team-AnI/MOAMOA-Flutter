// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notice_list_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NoticeListResult {

 List<Notice> get notices; int get page; int get size; bool get hasNext;
/// Create a copy of NoticeListResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoticeListResultCopyWith<NoticeListResult> get copyWith => _$NoticeListResultCopyWithImpl<NoticeListResult>(this as NoticeListResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoticeListResult&&const DeepCollectionEquality().equals(other.notices, notices)&&(identical(other.page, page) || other.page == page)&&(identical(other.size, size) || other.size == size)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(notices),page,size,hasNext);

@override
String toString() {
  return 'NoticeListResult(notices: $notices, page: $page, size: $size, hasNext: $hasNext)';
}


}

/// @nodoc
abstract mixin class $NoticeListResultCopyWith<$Res>  {
  factory $NoticeListResultCopyWith(NoticeListResult value, $Res Function(NoticeListResult) _then) = _$NoticeListResultCopyWithImpl;
@useResult
$Res call({
 List<Notice> notices, int page, int size, bool hasNext
});




}
/// @nodoc
class _$NoticeListResultCopyWithImpl<$Res>
    implements $NoticeListResultCopyWith<$Res> {
  _$NoticeListResultCopyWithImpl(this._self, this._then);

  final NoticeListResult _self;
  final $Res Function(NoticeListResult) _then;

/// Create a copy of NoticeListResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notices = null,Object? page = null,Object? size = null,Object? hasNext = null,}) {
  return _then(NoticeListResult(
notices: null == notices ? _self.notices : notices // ignore: cast_nullable_to_non_nullable
as List<Notice>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NoticeListResult].
extension NoticeListResultPatterns on NoticeListResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoticeListResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoticeListResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoticeListResult value)  $default,){
final _that = this;
switch (_that) {
case _NoticeListResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoticeListResult value)?  $default,){
final _that = this;
switch (_that) {
case _NoticeListResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Notice> notices,  int page,  int size,  bool hasNext)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoticeListResult() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Notice> notices,  int page,  int size,  bool hasNext)  $default,) {final _that = this;
switch (_that) {
case _NoticeListResult():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Notice> notices,  int page,  int size,  bool hasNext)?  $default,) {final _that = this;
switch (_that) {
case _NoticeListResult() when $default != null:
return $default(_that.notices,_that.page,_that.size,_that.hasNext);case _:
  return null;

}
}

}

/// @nodoc


class _NoticeListResult implements NoticeListResult {
  const _NoticeListResult({required  List<Notice> notices, required this.page, required this.size, required this.hasNext}): _notices = notices;
  

 final  List<Notice> _notices;
@override List<Notice> get notices {
  if (_notices is EqualUnmodifiableListView) return _notices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notices);
}

@override final  int page;
@override final  int size;
@override final  bool hasNext;

/// Create a copy of NoticeListResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoticeListResultCopyWith<_NoticeListResult> get copyWith => __$NoticeListResultCopyWithImpl<_NoticeListResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoticeListResult&&const DeepCollectionEquality().equals(other._notices, _notices)&&(identical(other.page, page) || other.page == page)&&(identical(other.size, size) || other.size == size)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_notices),page,size,hasNext);

@override
String toString() {
  return 'NoticeListResult(notices: $notices, page: $page, size: $size, hasNext: $hasNext)';
}


}

/// @nodoc
abstract mixin class _$NoticeListResultCopyWith<$Res> implements $NoticeListResultCopyWith<$Res> {
  factory _$NoticeListResultCopyWith(_NoticeListResult value, $Res Function(_NoticeListResult) _then) = __$NoticeListResultCopyWithImpl;
@override @useResult
$Res call({
 List<Notice> notices, int page, int size, bool hasNext
});




}
/// @nodoc
class __$NoticeListResultCopyWithImpl<$Res>
    implements _$NoticeListResultCopyWith<$Res> {
  __$NoticeListResultCopyWithImpl(this._self, this._then);

  final _NoticeListResult _self;
  final $Res Function(_NoticeListResult) _then;

/// Create a copy of NoticeListResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notices = null,Object? page = null,Object? size = null,Object? hasNext = null,}) {
  return _then(_NoticeListResult(
notices: null == notices ? _self._notices : notices // ignore: cast_nullable_to_non_nullable
as List<Notice>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
