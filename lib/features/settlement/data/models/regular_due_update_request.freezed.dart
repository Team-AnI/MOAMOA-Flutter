// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'regular_due_update_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegularDueUpdateRequest {
  @JsonKey(includeToJson: false)
  int get meetingId;
  @JsonKey(includeToJson: false)
  int get regularDuesId;
  @JsonKey(includeIfNull: false)
  String? get title;
  @JsonKey(includeIfNull: false)
  int? get amount;
  @JsonKey(includeIfNull: false)
  String? get cycleType;
  @JsonKey(includeIfNull: false)
  String? get cycleDay;
  @JsonKey(includeIfNull: false)
  String? get sendTime;
  @JsonKey(includeIfNull: false)
  int? get dueDays;
  @JsonKey(includeIfNull: false)
  String? get bankName;
  @JsonKey(includeIfNull: false)
  String? get accountNumber;
  @JsonKey(includeIfNull: false)
  String? get accountHolder;
  @JsonKey(includeIfNull: false)
  bool? get isActive;
  @JsonKey(includeIfNull: false)
  bool? get postNotice;
  @JsonKey(includeIfNull: false)
  bool? get applyToCurrentSettlement;

  /// Create a copy of RegularDueUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegularDueUpdateRequestCopyWith<RegularDueUpdateRequest> get copyWith =>
      _$RegularDueUpdateRequestCopyWithImpl<RegularDueUpdateRequest>(
        this as RegularDueUpdateRequest,
        _$identity,
      );

  /// Serializes this RegularDueUpdateRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegularDueUpdateRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.regularDuesId, regularDuesId) ||
                other.regularDuesId == regularDuesId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.cycleType, cycleType) ||
                other.cycleType == cycleType) &&
            (identical(other.cycleDay, cycleDay) ||
                other.cycleDay == cycleDay) &&
            (identical(other.sendTime, sendTime) ||
                other.sendTime == sendTime) &&
            (identical(other.dueDays, dueDays) || other.dueDays == dueDays) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.accountHolder, accountHolder) ||
                other.accountHolder == accountHolder) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.postNotice, postNotice) ||
                other.postNotice == postNotice) &&
            (identical(
                  other.applyToCurrentSettlement,
                  applyToCurrentSettlement,
                ) ||
                other.applyToCurrentSettlement == applyToCurrentSettlement));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    meetingId,
    regularDuesId,
    title,
    amount,
    cycleType,
    cycleDay,
    sendTime,
    dueDays,
    bankName,
    accountNumber,
    accountHolder,
    isActive,
    postNotice,
    applyToCurrentSettlement,
  );

  @override
  String toString() {
    return 'RegularDueUpdateRequest(meetingId: $meetingId, regularDuesId: $regularDuesId, title: $title, amount: $amount, cycleType: $cycleType, cycleDay: $cycleDay, sendTime: $sendTime, dueDays: $dueDays, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, isActive: $isActive, postNotice: $postNotice, applyToCurrentSettlement: $applyToCurrentSettlement)';
  }
}

/// @nodoc
abstract mixin class $RegularDueUpdateRequestCopyWith<$Res> {
  factory $RegularDueUpdateRequestCopyWith(
    RegularDueUpdateRequest value,
    $Res Function(RegularDueUpdateRequest) _then,
  ) = _$RegularDueUpdateRequestCopyWithImpl;
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int meetingId,
    @JsonKey(includeToJson: false) int regularDuesId,
    @JsonKey(includeIfNull: false) String? title,
    @JsonKey(includeIfNull: false) int? amount,
    @JsonKey(includeIfNull: false) String? cycleType,
    @JsonKey(includeIfNull: false) String? cycleDay,
    @JsonKey(includeIfNull: false) String? sendTime,
    @JsonKey(includeIfNull: false) int? dueDays,
    @JsonKey(includeIfNull: false) String? bankName,
    @JsonKey(includeIfNull: false) String? accountNumber,
    @JsonKey(includeIfNull: false) String? accountHolder,
    @JsonKey(includeIfNull: false) bool? isActive,
    @JsonKey(includeIfNull: false) bool? postNotice,
    @JsonKey(includeIfNull: false) bool? applyToCurrentSettlement,
  });
}

/// @nodoc
class _$RegularDueUpdateRequestCopyWithImpl<$Res>
    implements $RegularDueUpdateRequestCopyWith<$Res> {
  _$RegularDueUpdateRequestCopyWithImpl(this._self, this._then);

  final RegularDueUpdateRequest _self;
  final $Res Function(RegularDueUpdateRequest) _then;

  /// Create a copy of RegularDueUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetingId = null,
    Object? regularDuesId = null,
    Object? title = freezed,
    Object? amount = freezed,
    Object? cycleType = freezed,
    Object? cycleDay = freezed,
    Object? sendTime = freezed,
    Object? dueDays = freezed,
    Object? bankName = freezed,
    Object? accountNumber = freezed,
    Object? accountHolder = freezed,
    Object? isActive = freezed,
    Object? postNotice = freezed,
    Object? applyToCurrentSettlement = freezed,
  }) {
    return _then(
      RegularDueUpdateRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
        regularDuesId: null == regularDuesId
            ? _self.regularDuesId
            : regularDuesId // ignore: cast_nullable_to_non_nullable
                  as int,
        title: freezed == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        amount: freezed == amount
            ? _self.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int?,
        cycleType: freezed == cycleType
            ? _self.cycleType
            : cycleType // ignore: cast_nullable_to_non_nullable
                  as String?,
        cycleDay: freezed == cycleDay
            ? _self.cycleDay
            : cycleDay // ignore: cast_nullable_to_non_nullable
                  as String?,
        sendTime: freezed == sendTime
            ? _self.sendTime
            : sendTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        dueDays: freezed == dueDays
            ? _self.dueDays
            : dueDays // ignore: cast_nullable_to_non_nullable
                  as int?,
        bankName: freezed == bankName
            ? _self.bankName
            : bankName // ignore: cast_nullable_to_non_nullable
                  as String?,
        accountNumber: freezed == accountNumber
            ? _self.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        accountHolder: freezed == accountHolder
            ? _self.accountHolder
            : accountHolder // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: freezed == isActive
            ? _self.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool?,
        postNotice: freezed == postNotice
            ? _self.postNotice
            : postNotice // ignore: cast_nullable_to_non_nullable
                  as bool?,
        applyToCurrentSettlement: freezed == applyToCurrentSettlement
            ? _self.applyToCurrentSettlement
            : applyToCurrentSettlement // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [RegularDueUpdateRequest].
extension RegularDueUpdateRequestPatterns on RegularDueUpdateRequest {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_RegularDueUpdateRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegularDueUpdateRequest() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_RegularDueUpdateRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueUpdateRequest():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_RegularDueUpdateRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueUpdateRequest() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
      @JsonKey(includeToJson: false) int meetingId,
      @JsonKey(includeToJson: false) int regularDuesId,
      @JsonKey(includeIfNull: false) String? title,
      @JsonKey(includeIfNull: false) int? amount,
      @JsonKey(includeIfNull: false) String? cycleType,
      @JsonKey(includeIfNull: false) String? cycleDay,
      @JsonKey(includeIfNull: false) String? sendTime,
      @JsonKey(includeIfNull: false) int? dueDays,
      @JsonKey(includeIfNull: false) String? bankName,
      @JsonKey(includeIfNull: false) String? accountNumber,
      @JsonKey(includeIfNull: false) String? accountHolder,
      @JsonKey(includeIfNull: false) bool? isActive,
      @JsonKey(includeIfNull: false) bool? postNotice,
      @JsonKey(includeIfNull: false) bool? applyToCurrentSettlement,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegularDueUpdateRequest() when $default != null:
        return $default(
          _that.meetingId,
          _that.regularDuesId,
          _that.title,
          _that.amount,
          _that.cycleType,
          _that.cycleDay,
          _that.sendTime,
          _that.dueDays,
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
          _that.isActive,
          _that.postNotice,
          _that.applyToCurrentSettlement,
        );
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
      @JsonKey(includeToJson: false) int meetingId,
      @JsonKey(includeToJson: false) int regularDuesId,
      @JsonKey(includeIfNull: false) String? title,
      @JsonKey(includeIfNull: false) int? amount,
      @JsonKey(includeIfNull: false) String? cycleType,
      @JsonKey(includeIfNull: false) String? cycleDay,
      @JsonKey(includeIfNull: false) String? sendTime,
      @JsonKey(includeIfNull: false) int? dueDays,
      @JsonKey(includeIfNull: false) String? bankName,
      @JsonKey(includeIfNull: false) String? accountNumber,
      @JsonKey(includeIfNull: false) String? accountHolder,
      @JsonKey(includeIfNull: false) bool? isActive,
      @JsonKey(includeIfNull: false) bool? postNotice,
      @JsonKey(includeIfNull: false) bool? applyToCurrentSettlement,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueUpdateRequest():
        return $default(
          _that.meetingId,
          _that.regularDuesId,
          _that.title,
          _that.amount,
          _that.cycleType,
          _that.cycleDay,
          _that.sendTime,
          _that.dueDays,
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
          _that.isActive,
          _that.postNotice,
          _that.applyToCurrentSettlement,
        );
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
      @JsonKey(includeToJson: false) int meetingId,
      @JsonKey(includeToJson: false) int regularDuesId,
      @JsonKey(includeIfNull: false) String? title,
      @JsonKey(includeIfNull: false) int? amount,
      @JsonKey(includeIfNull: false) String? cycleType,
      @JsonKey(includeIfNull: false) String? cycleDay,
      @JsonKey(includeIfNull: false) String? sendTime,
      @JsonKey(includeIfNull: false) int? dueDays,
      @JsonKey(includeIfNull: false) String? bankName,
      @JsonKey(includeIfNull: false) String? accountNumber,
      @JsonKey(includeIfNull: false) String? accountHolder,
      @JsonKey(includeIfNull: false) bool? isActive,
      @JsonKey(includeIfNull: false) bool? postNotice,
      @JsonKey(includeIfNull: false) bool? applyToCurrentSettlement,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueUpdateRequest() when $default != null:
        return $default(
          _that.meetingId,
          _that.regularDuesId,
          _that.title,
          _that.amount,
          _that.cycleType,
          _that.cycleDay,
          _that.sendTime,
          _that.dueDays,
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
          _that.isActive,
          _that.postNotice,
          _that.applyToCurrentSettlement,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RegularDueUpdateRequest implements RegularDueUpdateRequest {
  const _RegularDueUpdateRequest({
    @JsonKey(includeToJson: false) required this.meetingId,
    @JsonKey(includeToJson: false) required this.regularDuesId,
    @JsonKey(includeIfNull: false) this.title,
    @JsonKey(includeIfNull: false) this.amount,
    @JsonKey(includeIfNull: false) this.cycleType,
    @JsonKey(includeIfNull: false) this.cycleDay,
    @JsonKey(includeIfNull: false) this.sendTime,
    @JsonKey(includeIfNull: false) this.dueDays,
    @JsonKey(includeIfNull: false) this.bankName,
    @JsonKey(includeIfNull: false) this.accountNumber,
    @JsonKey(includeIfNull: false) this.accountHolder,
    @JsonKey(includeIfNull: false) this.isActive,
    @JsonKey(includeIfNull: false) this.postNotice,
    @JsonKey(includeIfNull: false) this.applyToCurrentSettlement,
  });
  factory _RegularDueUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$RegularDueUpdateRequestFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int meetingId;
  @override
  @JsonKey(includeToJson: false)
  final int regularDuesId;
  @override
  @JsonKey(includeIfNull: false)
  final String? title;
  @override
  @JsonKey(includeIfNull: false)
  final int? amount;
  @override
  @JsonKey(includeIfNull: false)
  final String? cycleType;
  @override
  @JsonKey(includeIfNull: false)
  final String? cycleDay;
  @override
  @JsonKey(includeIfNull: false)
  final String? sendTime;
  @override
  @JsonKey(includeIfNull: false)
  final int? dueDays;
  @override
  @JsonKey(includeIfNull: false)
  final String? bankName;
  @override
  @JsonKey(includeIfNull: false)
  final String? accountNumber;
  @override
  @JsonKey(includeIfNull: false)
  final String? accountHolder;
  @override
  @JsonKey(includeIfNull: false)
  final bool? isActive;
  @override
  @JsonKey(includeIfNull: false)
  final bool? postNotice;
  @override
  @JsonKey(includeIfNull: false)
  final bool? applyToCurrentSettlement;

  /// Create a copy of RegularDueUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RegularDueUpdateRequestCopyWith<_RegularDueUpdateRequest> get copyWith =>
      __$RegularDueUpdateRequestCopyWithImpl<_RegularDueUpdateRequest>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$RegularDueUpdateRequestToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegularDueUpdateRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.regularDuesId, regularDuesId) ||
                other.regularDuesId == regularDuesId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.cycleType, cycleType) ||
                other.cycleType == cycleType) &&
            (identical(other.cycleDay, cycleDay) ||
                other.cycleDay == cycleDay) &&
            (identical(other.sendTime, sendTime) ||
                other.sendTime == sendTime) &&
            (identical(other.dueDays, dueDays) || other.dueDays == dueDays) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.accountHolder, accountHolder) ||
                other.accountHolder == accountHolder) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.postNotice, postNotice) ||
                other.postNotice == postNotice) &&
            (identical(
                  other.applyToCurrentSettlement,
                  applyToCurrentSettlement,
                ) ||
                other.applyToCurrentSettlement == applyToCurrentSettlement));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    meetingId,
    regularDuesId,
    title,
    amount,
    cycleType,
    cycleDay,
    sendTime,
    dueDays,
    bankName,
    accountNumber,
    accountHolder,
    isActive,
    postNotice,
    applyToCurrentSettlement,
  );

  @override
  String toString() {
    return 'RegularDueUpdateRequest(meetingId: $meetingId, regularDuesId: $regularDuesId, title: $title, amount: $amount, cycleType: $cycleType, cycleDay: $cycleDay, sendTime: $sendTime, dueDays: $dueDays, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, isActive: $isActive, postNotice: $postNotice, applyToCurrentSettlement: $applyToCurrentSettlement)';
  }
}

/// @nodoc
abstract mixin class _$RegularDueUpdateRequestCopyWith<$Res>
    implements $RegularDueUpdateRequestCopyWith<$Res> {
  factory _$RegularDueUpdateRequestCopyWith(
    _RegularDueUpdateRequest value,
    $Res Function(_RegularDueUpdateRequest) _then,
  ) = __$RegularDueUpdateRequestCopyWithImpl;
  @override
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int meetingId,
    @JsonKey(includeToJson: false) int regularDuesId,
    @JsonKey(includeIfNull: false) String? title,
    @JsonKey(includeIfNull: false) int? amount,
    @JsonKey(includeIfNull: false) String? cycleType,
    @JsonKey(includeIfNull: false) String? cycleDay,
    @JsonKey(includeIfNull: false) String? sendTime,
    @JsonKey(includeIfNull: false) int? dueDays,
    @JsonKey(includeIfNull: false) String? bankName,
    @JsonKey(includeIfNull: false) String? accountNumber,
    @JsonKey(includeIfNull: false) String? accountHolder,
    @JsonKey(includeIfNull: false) bool? isActive,
    @JsonKey(includeIfNull: false) bool? postNotice,
    @JsonKey(includeIfNull: false) bool? applyToCurrentSettlement,
  });
}

/// @nodoc
class __$RegularDueUpdateRequestCopyWithImpl<$Res>
    implements _$RegularDueUpdateRequestCopyWith<$Res> {
  __$RegularDueUpdateRequestCopyWithImpl(this._self, this._then);

  final _RegularDueUpdateRequest _self;
  final $Res Function(_RegularDueUpdateRequest) _then;

  /// Create a copy of RegularDueUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? meetingId = null,
    Object? regularDuesId = null,
    Object? title = freezed,
    Object? amount = freezed,
    Object? cycleType = freezed,
    Object? cycleDay = freezed,
    Object? sendTime = freezed,
    Object? dueDays = freezed,
    Object? bankName = freezed,
    Object? accountNumber = freezed,
    Object? accountHolder = freezed,
    Object? isActive = freezed,
    Object? postNotice = freezed,
    Object? applyToCurrentSettlement = freezed,
  }) {
    return _then(
      _RegularDueUpdateRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
        regularDuesId: null == regularDuesId
            ? _self.regularDuesId
            : regularDuesId // ignore: cast_nullable_to_non_nullable
                  as int,
        title: freezed == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        amount: freezed == amount
            ? _self.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int?,
        cycleType: freezed == cycleType
            ? _self.cycleType
            : cycleType // ignore: cast_nullable_to_non_nullable
                  as String?,
        cycleDay: freezed == cycleDay
            ? _self.cycleDay
            : cycleDay // ignore: cast_nullable_to_non_nullable
                  as String?,
        sendTime: freezed == sendTime
            ? _self.sendTime
            : sendTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        dueDays: freezed == dueDays
            ? _self.dueDays
            : dueDays // ignore: cast_nullable_to_non_nullable
                  as int?,
        bankName: freezed == bankName
            ? _self.bankName
            : bankName // ignore: cast_nullable_to_non_nullable
                  as String?,
        accountNumber: freezed == accountNumber
            ? _self.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        accountHolder: freezed == accountHolder
            ? _self.accountHolder
            : accountHolder // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: freezed == isActive
            ? _self.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool?,
        postNotice: freezed == postNotice
            ? _self.postNotice
            : postNotice // ignore: cast_nullable_to_non_nullable
                  as bool?,
        applyToCurrentSettlement: freezed == applyToCurrentSettlement
            ? _self.applyToCurrentSettlement
            : applyToCurrentSettlement // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}
