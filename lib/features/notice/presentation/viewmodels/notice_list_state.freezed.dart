// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notice_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NoticeListState {

/// 지금까지 불러온 공지 (최신순)
 List<Notice> get notices;/// 마지막으로 불러온 페이지 번호 (0부터 시작)
 int get page; bool get hasNext;/// 다음 페이지를 불러오는 중인지
 bool get isLoadingMore;
/// Create a copy of NoticeListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoticeListStateCopyWith<NoticeListState> get copyWith => _$NoticeListStateCopyWithImpl<NoticeListState>(this as NoticeListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoticeListState&&const DeepCollectionEquality().equals(other.notices, notices)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(notices),page,hasNext,isLoadingMore);

@override
String toString() {
  return 'NoticeListState(notices: $notices, page: $page, hasNext: $hasNext, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class $NoticeListStateCopyWith<$Res>  {
  factory $NoticeListStateCopyWith(NoticeListState value, $Res Function(NoticeListState) _then) = _$NoticeListStateCopyWithImpl;
@useResult
$Res call({
 List<Notice> notices, int page, bool hasNext, bool isLoadingMore
});




}
/// @nodoc
class _$NoticeListStateCopyWithImpl<$Res>
    implements $NoticeListStateCopyWith<$Res> {
  _$NoticeListStateCopyWithImpl(this._self, this._then);

  final NoticeListState _self;
  final $Res Function(NoticeListState) _then;

/// Create a copy of NoticeListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notices = null,Object? page = null,Object? hasNext = null,Object? isLoadingMore = null,}) {
  return _then(NoticeListState(
notices: null == notices ? _self.notices : notices // ignore: cast_nullable_to_non_nullable
as List<Notice>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NoticeListState].
extension NoticeListStatePatterns on NoticeListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoticeListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoticeListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoticeListState value)  $default,){
final _that = this;
switch (_that) {
case _NoticeListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoticeListState value)?  $default,){
final _that = this;
switch (_that) {
case _NoticeListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Notice> notices,  int page,  bool hasNext,  bool isLoadingMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoticeListState() when $default != null:
return $default(_that.notices,_that.page,_that.hasNext,_that.isLoadingMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Notice> notices,  int page,  bool hasNext,  bool isLoadingMore)  $default,) {final _that = this;
switch (_that) {
case _NoticeListState():
return $default(_that.notices,_that.page,_that.hasNext,_that.isLoadingMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Notice> notices,  int page,  bool hasNext,  bool isLoadingMore)?  $default,) {final _that = this;
switch (_that) {
case _NoticeListState() when $default != null:
return $default(_that.notices,_that.page,_that.hasNext,_that.isLoadingMore);case _:
  return null;

}
}

}

/// @nodoc


class _NoticeListState implements NoticeListState {
  const _NoticeListState({required  List<Notice> notices, required this.page, required this.hasNext, this.isLoadingMore = false}): _notices = notices;
  

/// 지금까지 불러온 공지 (최신순)
 final  List<Notice> _notices;
/// 지금까지 불러온 공지 (최신순)
@override List<Notice> get notices {
  if (_notices is EqualUnmodifiableListView) return _notices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notices);
}

/// 마지막으로 불러온 페이지 번호 (0부터 시작)
@override final  int page;
@override final  bool hasNext;
/// 다음 페이지를 불러오는 중인지
@override@JsonKey() final  bool isLoadingMore;

/// Create a copy of NoticeListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoticeListStateCopyWith<_NoticeListState> get copyWith => __$NoticeListStateCopyWithImpl<_NoticeListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoticeListState&&const DeepCollectionEquality().equals(other._notices, _notices)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_notices),page,hasNext,isLoadingMore);

@override
String toString() {
  return 'NoticeListState(notices: $notices, page: $page, hasNext: $hasNext, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class _$NoticeListStateCopyWith<$Res> implements $NoticeListStateCopyWith<$Res> {
  factory _$NoticeListStateCopyWith(_NoticeListState value, $Res Function(_NoticeListState) _then) = __$NoticeListStateCopyWithImpl;
@override @useResult
$Res call({
 List<Notice> notices, int page, bool hasNext, bool isLoadingMore
});




}
/// @nodoc
class __$NoticeListStateCopyWithImpl<$Res>
    implements _$NoticeListStateCopyWith<$Res> {
  __$NoticeListStateCopyWithImpl(this._self, this._then);

  final _NoticeListState _self;
  final $Res Function(_NoticeListState) _then;

/// Create a copy of NoticeListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notices = null,Object? page = null,Object? hasNext = null,Object? isLoadingMore = null,}) {
  return _then(_NoticeListState(
notices: null == notices ? _self._notices : notices // ignore: cast_nullable_to_non_nullable
as List<Notice>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
