// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vote_create_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VoteCreateState {

 String get title;/// 후보 날짜(시각 없음). 오름차순입니다.
 List<DateTime> get dates; VoteTimeRange get timeRange; DateTime? get voteDeadlineAt;/// 마지막으로 확인했을 때(고를 때·제출할 때) [voteDeadlineAt] 이 지금 이전이었으면 true 입니다.
 bool get deadlinePassed;/// 빈 항목이 있는데 시작 버튼을 누르면 true 가 되어 항목마다 오류 문구를 보여줍니다.
 bool get showErrors; VoteCreateStatus get status;/// [status] 가 success 일 때만 값이 있습니다. 투표로 만든 일정의 id 입니다.
 int? get createdScheduleId;/// [status] 가 failure 일 때 보여줄 문구입니다.
 String? get errorMessage;
/// Create a copy of VoteCreateState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoteCreateStateCopyWith<VoteCreateState> get copyWith => _$VoteCreateStateCopyWithImpl<VoteCreateState>(this as VoteCreateState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoteCreateState&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.dates, dates)&&(identical(other.timeRange, timeRange) || other.timeRange == timeRange)&&(identical(other.voteDeadlineAt, voteDeadlineAt) || other.voteDeadlineAt == voteDeadlineAt)&&(identical(other.deadlinePassed, deadlinePassed) || other.deadlinePassed == deadlinePassed)&&(identical(other.showErrors, showErrors) || other.showErrors == showErrors)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdScheduleId, createdScheduleId) || other.createdScheduleId == createdScheduleId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(dates),timeRange,voteDeadlineAt,deadlinePassed,showErrors,status,createdScheduleId,errorMessage);

@override
String toString() {
  return 'VoteCreateState(title: $title, dates: $dates, timeRange: $timeRange, voteDeadlineAt: $voteDeadlineAt, deadlinePassed: $deadlinePassed, showErrors: $showErrors, status: $status, createdScheduleId: $createdScheduleId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $VoteCreateStateCopyWith<$Res>  {
  factory $VoteCreateStateCopyWith(VoteCreateState value, $Res Function(VoteCreateState) _then) = _$VoteCreateStateCopyWithImpl;
@useResult
$Res call({
 String title, List<DateTime> dates, VoteTimeRange timeRange, DateTime? voteDeadlineAt, bool deadlinePassed, bool showErrors, VoteCreateStatus status, int? createdScheduleId, String? errorMessage
});


$VoteTimeRangeCopyWith<$Res> get timeRange;

}
/// @nodoc
class _$VoteCreateStateCopyWithImpl<$Res>
    implements $VoteCreateStateCopyWith<$Res> {
  _$VoteCreateStateCopyWithImpl(this._self, this._then);

  final VoteCreateState _self;
  final $Res Function(VoteCreateState) _then;

/// Create a copy of VoteCreateState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? dates = null,Object? timeRange = null,Object? voteDeadlineAt = freezed,Object? deadlinePassed = null,Object? showErrors = null,Object? status = null,Object? createdScheduleId = freezed,Object? errorMessage = freezed,}) {
  return _then(VoteCreateState(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,dates: null == dates ? _self.dates : dates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,timeRange: null == timeRange ? _self.timeRange : timeRange // ignore: cast_nullable_to_non_nullable
as VoteTimeRange,voteDeadlineAt: freezed == voteDeadlineAt ? _self.voteDeadlineAt : voteDeadlineAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deadlinePassed: null == deadlinePassed ? _self.deadlinePassed : deadlinePassed // ignore: cast_nullable_to_non_nullable
as bool,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VoteCreateStatus,createdScheduleId: freezed == createdScheduleId ? _self.createdScheduleId : createdScheduleId // ignore: cast_nullable_to_non_nullable
as int?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of VoteCreateState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VoteTimeRangeCopyWith<$Res> get timeRange {
  
  return $VoteTimeRangeCopyWith<$Res>(_self.timeRange, (value) {
    return _then(_self.copyWith(timeRange: value));
  });
}
}


/// Adds pattern-matching-related methods to [VoteCreateState].
extension VoteCreateStatePatterns on VoteCreateState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoteCreateState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoteCreateState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoteCreateState value)  $default,){
final _that = this;
switch (_that) {
case _VoteCreateState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoteCreateState value)?  $default,){
final _that = this;
switch (_that) {
case _VoteCreateState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  List<DateTime> dates,  VoteTimeRange timeRange,  DateTime? voteDeadlineAt,  bool deadlinePassed,  bool showErrors,  VoteCreateStatus status,  int? createdScheduleId,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoteCreateState() when $default != null:
return $default(_that.title,_that.dates,_that.timeRange,_that.voteDeadlineAt,_that.deadlinePassed,_that.showErrors,_that.status,_that.createdScheduleId,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  List<DateTime> dates,  VoteTimeRange timeRange,  DateTime? voteDeadlineAt,  bool deadlinePassed,  bool showErrors,  VoteCreateStatus status,  int? createdScheduleId,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _VoteCreateState():
return $default(_that.title,_that.dates,_that.timeRange,_that.voteDeadlineAt,_that.deadlinePassed,_that.showErrors,_that.status,_that.createdScheduleId,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  List<DateTime> dates,  VoteTimeRange timeRange,  DateTime? voteDeadlineAt,  bool deadlinePassed,  bool showErrors,  VoteCreateStatus status,  int? createdScheduleId,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _VoteCreateState() when $default != null:
return $default(_that.title,_that.dates,_that.timeRange,_that.voteDeadlineAt,_that.deadlinePassed,_that.showErrors,_that.status,_that.createdScheduleId,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _VoteCreateState implements VoteCreateState {
  const _VoteCreateState({this.title = '',  List<DateTime> dates = const <DateTime>[], this.timeRange = const VoteTimeRange(), this.voteDeadlineAt, this.deadlinePassed = false, this.showErrors = false, this.status = VoteCreateStatus.initial, this.createdScheduleId, this.errorMessage}): _dates = dates;
  

@override@JsonKey() final  String title;
/// 후보 날짜(시각 없음). 오름차순입니다.
 final  List<DateTime> _dates;
/// 후보 날짜(시각 없음). 오름차순입니다.
@override@JsonKey() List<DateTime> get dates {
  if (_dates is EqualUnmodifiableListView) return _dates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dates);
}

@override@JsonKey() final  VoteTimeRange timeRange;
@override final  DateTime? voteDeadlineAt;
/// 마지막으로 확인했을 때(고를 때·제출할 때) [voteDeadlineAt] 이 지금 이전이었으면 true 입니다.
@override@JsonKey() final  bool deadlinePassed;
/// 빈 항목이 있는데 시작 버튼을 누르면 true 가 되어 항목마다 오류 문구를 보여줍니다.
@override@JsonKey() final  bool showErrors;
@override@JsonKey() final  VoteCreateStatus status;
/// [status] 가 success 일 때만 값이 있습니다. 투표로 만든 일정의 id 입니다.
@override final  int? createdScheduleId;
/// [status] 가 failure 일 때 보여줄 문구입니다.
@override final  String? errorMessage;

/// Create a copy of VoteCreateState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoteCreateStateCopyWith<_VoteCreateState> get copyWith => __$VoteCreateStateCopyWithImpl<_VoteCreateState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoteCreateState&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._dates, _dates)&&(identical(other.timeRange, timeRange) || other.timeRange == timeRange)&&(identical(other.voteDeadlineAt, voteDeadlineAt) || other.voteDeadlineAt == voteDeadlineAt)&&(identical(other.deadlinePassed, deadlinePassed) || other.deadlinePassed == deadlinePassed)&&(identical(other.showErrors, showErrors) || other.showErrors == showErrors)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdScheduleId, createdScheduleId) || other.createdScheduleId == createdScheduleId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(_dates),timeRange,voteDeadlineAt,deadlinePassed,showErrors,status,createdScheduleId,errorMessage);

@override
String toString() {
  return 'VoteCreateState(title: $title, dates: $dates, timeRange: $timeRange, voteDeadlineAt: $voteDeadlineAt, deadlinePassed: $deadlinePassed, showErrors: $showErrors, status: $status, createdScheduleId: $createdScheduleId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$VoteCreateStateCopyWith<$Res> implements $VoteCreateStateCopyWith<$Res> {
  factory _$VoteCreateStateCopyWith(_VoteCreateState value, $Res Function(_VoteCreateState) _then) = __$VoteCreateStateCopyWithImpl;
@override @useResult
$Res call({
 String title, List<DateTime> dates, VoteTimeRange timeRange, DateTime? voteDeadlineAt, bool deadlinePassed, bool showErrors, VoteCreateStatus status, int? createdScheduleId, String? errorMessage
});


@override $VoteTimeRangeCopyWith<$Res> get timeRange;

}
/// @nodoc
class __$VoteCreateStateCopyWithImpl<$Res>
    implements _$VoteCreateStateCopyWith<$Res> {
  __$VoteCreateStateCopyWithImpl(this._self, this._then);

  final _VoteCreateState _self;
  final $Res Function(_VoteCreateState) _then;

/// Create a copy of VoteCreateState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? dates = null,Object? timeRange = null,Object? voteDeadlineAt = freezed,Object? deadlinePassed = null,Object? showErrors = null,Object? status = null,Object? createdScheduleId = freezed,Object? errorMessage = freezed,}) {
  return _then(_VoteCreateState(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,dates: null == dates ? _self._dates : dates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,timeRange: null == timeRange ? _self.timeRange : timeRange // ignore: cast_nullable_to_non_nullable
as VoteTimeRange,voteDeadlineAt: freezed == voteDeadlineAt ? _self.voteDeadlineAt : voteDeadlineAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deadlinePassed: null == deadlinePassed ? _self.deadlinePassed : deadlinePassed // ignore: cast_nullable_to_non_nullable
as bool,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VoteCreateStatus,createdScheduleId: freezed == createdScheduleId ? _self.createdScheduleId : createdScheduleId // ignore: cast_nullable_to_non_nullable
as int?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of VoteCreateState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VoteTimeRangeCopyWith<$Res> get timeRange {
  
  return $VoteTimeRangeCopyWith<$Res>(_self.timeRange, (value) {
    return _then(_self.copyWith(timeRange: value));
  });
}
}

// dart format on
