// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementModel {
  int get settlementId;
  String get title;
  int? get scheduleId;
  int get totalAmount;
  int get memberCount;
  DateTime get dueAt;
  DateTime get createdAt;
  String get status;
  DateTime? get canceledAt;
  int? get myAmount;
  String? get myPaymentStatus;
  DateTime? get myConfirmedAt;

  /// Create a copy of SettlementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettlementModelCopyWith<SettlementModel> get copyWith =>
      _$SettlementModelCopyWithImpl<SettlementModel>(
        this as SettlementModel,
        _$identity,
      );

  /// Serializes this SettlementModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettlementModel &&
            (identical(other.settlementId, settlementId) ||
                other.settlementId == settlementId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.scheduleId, scheduleId) ||
                other.scheduleId == scheduleId) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.memberCount, memberCount) ||
                other.memberCount == memberCount) &&
            (identical(other.dueAt, dueAt) || other.dueAt == dueAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.canceledAt, canceledAt) ||
                other.canceledAt == canceledAt) &&
            (identical(other.myAmount, myAmount) ||
                other.myAmount == myAmount) &&
            (identical(other.myPaymentStatus, myPaymentStatus) ||
                other.myPaymentStatus == myPaymentStatus) &&
            (identical(other.myConfirmedAt, myConfirmedAt) ||
                other.myConfirmedAt == myConfirmedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    settlementId,
    title,
    scheduleId,
    totalAmount,
    memberCount,
    dueAt,
    createdAt,
    status,
    canceledAt,
    myAmount,
    myPaymentStatus,
    myConfirmedAt,
  );

  @override
  String toString() {
    return 'SettlementModel(settlementId: $settlementId, title: $title, scheduleId: $scheduleId, totalAmount: $totalAmount, memberCount: $memberCount, dueAt: $dueAt, createdAt: $createdAt, status: $status, canceledAt: $canceledAt, myAmount: $myAmount, myPaymentStatus: $myPaymentStatus, myConfirmedAt: $myConfirmedAt)';
  }
}

/// @nodoc
abstract mixin class $SettlementModelCopyWith<$Res> {
  factory $SettlementModelCopyWith(
    SettlementModel value,
    $Res Function(SettlementModel) _then,
  ) = _$SettlementModelCopyWithImpl;
  @useResult
  $Res call({
    int settlementId,
    String title,
    int? scheduleId,
    int totalAmount,
    int memberCount,
    DateTime dueAt,
    DateTime createdAt,
    String status,
    DateTime? canceledAt,
    int? myAmount,
    String? myPaymentStatus,
    DateTime? myConfirmedAt,
  });
}

/// @nodoc
class _$SettlementModelCopyWithImpl<$Res>
    implements $SettlementModelCopyWith<$Res> {
  _$SettlementModelCopyWithImpl(this._self, this._then);

  final SettlementModel _self;
  final $Res Function(SettlementModel) _then;

  /// Create a copy of SettlementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? settlementId = null,
    Object? title = null,
    Object? scheduleId = freezed,
    Object? totalAmount = null,
    Object? memberCount = null,
    Object? dueAt = null,
    Object? createdAt = null,
    Object? status = null,
    Object? canceledAt = freezed,
    Object? myAmount = freezed,
    Object? myPaymentStatus = freezed,
    Object? myConfirmedAt = freezed,
  }) {
    return _then(
      SettlementModel(
        settlementId: null == settlementId
            ? _self.settlementId
            : settlementId // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        scheduleId: freezed == scheduleId
            ? _self.scheduleId
            : scheduleId // ignore: cast_nullable_to_non_nullable
                  as int?,
        totalAmount: null == totalAmount
            ? _self.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        memberCount: null == memberCount
            ? _self.memberCount
            : memberCount // ignore: cast_nullable_to_non_nullable
                  as int,
        dueAt: null == dueAt
            ? _self.dueAt
            : dueAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        createdAt: null == createdAt
            ? _self.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        canceledAt: freezed == canceledAt
            ? _self.canceledAt
            : canceledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        myAmount: freezed == myAmount
            ? _self.myAmount
            : myAmount // ignore: cast_nullable_to_non_nullable
                  as int?,
        myPaymentStatus: freezed == myPaymentStatus
            ? _self.myPaymentStatus
            : myPaymentStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        myConfirmedAt: freezed == myConfirmedAt
            ? _self.myConfirmedAt
            : myConfirmedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [SettlementModel].
extension SettlementModelPatterns on SettlementModel {
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
    TResult Function(_SettlementModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementModel() when $default != null:
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
    TResult Function(_SettlementModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementModel():
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
    TResult? Function(_SettlementModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementModel() when $default != null:
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
      int settlementId,
      String title,
      int? scheduleId,
      int totalAmount,
      int memberCount,
      DateTime dueAt,
      DateTime createdAt,
      String status,
      DateTime? canceledAt,
      int? myAmount,
      String? myPaymentStatus,
      DateTime? myConfirmedAt,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementModel() when $default != null:
        return $default(
          _that.settlementId,
          _that.title,
          _that.scheduleId,
          _that.totalAmount,
          _that.memberCount,
          _that.dueAt,
          _that.createdAt,
          _that.status,
          _that.canceledAt,
          _that.myAmount,
          _that.myPaymentStatus,
          _that.myConfirmedAt,
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
      int settlementId,
      String title,
      int? scheduleId,
      int totalAmount,
      int memberCount,
      DateTime dueAt,
      DateTime createdAt,
      String status,
      DateTime? canceledAt,
      int? myAmount,
      String? myPaymentStatus,
      DateTime? myConfirmedAt,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementModel():
        return $default(
          _that.settlementId,
          _that.title,
          _that.scheduleId,
          _that.totalAmount,
          _that.memberCount,
          _that.dueAt,
          _that.createdAt,
          _that.status,
          _that.canceledAt,
          _that.myAmount,
          _that.myPaymentStatus,
          _that.myConfirmedAt,
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
      int settlementId,
      String title,
      int? scheduleId,
      int totalAmount,
      int memberCount,
      DateTime dueAt,
      DateTime createdAt,
      String status,
      DateTime? canceledAt,
      int? myAmount,
      String? myPaymentStatus,
      DateTime? myConfirmedAt,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementModel() when $default != null:
        return $default(
          _that.settlementId,
          _that.title,
          _that.scheduleId,
          _that.totalAmount,
          _that.memberCount,
          _that.dueAt,
          _that.createdAt,
          _that.status,
          _that.canceledAt,
          _that.myAmount,
          _that.myPaymentStatus,
          _that.myConfirmedAt,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SettlementModel implements SettlementModel {
  const _SettlementModel({
    required this.settlementId,
    required this.title,
    this.scheduleId,
    required this.totalAmount,
    required this.memberCount,
    required this.dueAt,
    required this.createdAt,
    required this.status,
    this.canceledAt,
    this.myAmount,
    this.myPaymentStatus,
    this.myConfirmedAt,
  });
  factory _SettlementModel.fromJson(Map<String, dynamic> json) =>
      _$SettlementModelFromJson(json);

  @override
  final int settlementId;
  @override
  final String title;
  @override
  final int? scheduleId;
  @override
  final int totalAmount;
  @override
  final int memberCount;
  @override
  final DateTime dueAt;
  @override
  final DateTime createdAt;
  @override
  final String status;
  @override
  final DateTime? canceledAt;
  @override
  final int? myAmount;
  @override
  final String? myPaymentStatus;
  @override
  final DateTime? myConfirmedAt;

  /// Create a copy of SettlementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettlementModelCopyWith<_SettlementModel> get copyWith =>
      __$SettlementModelCopyWithImpl<_SettlementModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SettlementModelToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettlementModel &&
            (identical(other.settlementId, settlementId) ||
                other.settlementId == settlementId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.scheduleId, scheduleId) ||
                other.scheduleId == scheduleId) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.memberCount, memberCount) ||
                other.memberCount == memberCount) &&
            (identical(other.dueAt, dueAt) || other.dueAt == dueAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.canceledAt, canceledAt) ||
                other.canceledAt == canceledAt) &&
            (identical(other.myAmount, myAmount) ||
                other.myAmount == myAmount) &&
            (identical(other.myPaymentStatus, myPaymentStatus) ||
                other.myPaymentStatus == myPaymentStatus) &&
            (identical(other.myConfirmedAt, myConfirmedAt) ||
                other.myConfirmedAt == myConfirmedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    settlementId,
    title,
    scheduleId,
    totalAmount,
    memberCount,
    dueAt,
    createdAt,
    status,
    canceledAt,
    myAmount,
    myPaymentStatus,
    myConfirmedAt,
  );

  @override
  String toString() {
    return 'SettlementModel(settlementId: $settlementId, title: $title, scheduleId: $scheduleId, totalAmount: $totalAmount, memberCount: $memberCount, dueAt: $dueAt, createdAt: $createdAt, status: $status, canceledAt: $canceledAt, myAmount: $myAmount, myPaymentStatus: $myPaymentStatus, myConfirmedAt: $myConfirmedAt)';
  }
}

/// @nodoc
abstract mixin class _$SettlementModelCopyWith<$Res>
    implements $SettlementModelCopyWith<$Res> {
  factory _$SettlementModelCopyWith(
    _SettlementModel value,
    $Res Function(_SettlementModel) _then,
  ) = __$SettlementModelCopyWithImpl;
  @override
  @useResult
  $Res call({
    int settlementId,
    String title,
    int? scheduleId,
    int totalAmount,
    int memberCount,
    DateTime dueAt,
    DateTime createdAt,
    String status,
    DateTime? canceledAt,
    int? myAmount,
    String? myPaymentStatus,
    DateTime? myConfirmedAt,
  });
}

/// @nodoc
class __$SettlementModelCopyWithImpl<$Res>
    implements _$SettlementModelCopyWith<$Res> {
  __$SettlementModelCopyWithImpl(this._self, this._then);

  final _SettlementModel _self;
  final $Res Function(_SettlementModel) _then;

  /// Create a copy of SettlementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? settlementId = null,
    Object? title = null,
    Object? scheduleId = freezed,
    Object? totalAmount = null,
    Object? memberCount = null,
    Object? dueAt = null,
    Object? createdAt = null,
    Object? status = null,
    Object? canceledAt = freezed,
    Object? myAmount = freezed,
    Object? myPaymentStatus = freezed,
    Object? myConfirmedAt = freezed,
  }) {
    return _then(
      _SettlementModel(
        settlementId: null == settlementId
            ? _self.settlementId
            : settlementId // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        scheduleId: freezed == scheduleId
            ? _self.scheduleId
            : scheduleId // ignore: cast_nullable_to_non_nullable
                  as int?,
        totalAmount: null == totalAmount
            ? _self.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        memberCount: null == memberCount
            ? _self.memberCount
            : memberCount // ignore: cast_nullable_to_non_nullable
                  as int,
        dueAt: null == dueAt
            ? _self.dueAt
            : dueAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        createdAt: null == createdAt
            ? _self.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        canceledAt: freezed == canceledAt
            ? _self.canceledAt
            : canceledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        myAmount: freezed == myAmount
            ? _self.myAmount
            : myAmount // ignore: cast_nullable_to_non_nullable
                  as int?,
        myPaymentStatus: freezed == myPaymentStatus
            ? _self.myPaymentStatus
            : myPaymentStatus // ignore: cast_nullable_to_non_nullable
                  as String?,
        myConfirmedAt: freezed == myConfirmedAt
            ? _self.myConfirmedAt
            : myConfirmedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}
