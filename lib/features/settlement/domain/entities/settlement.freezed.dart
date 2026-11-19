// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Settlement {
  int get id;
  String get title;
  int? get scheduleId;
  int get totalAmount;
  int get memberCount;
  DateTime get dueAt;
  DateTime get createdAt;
  SettlementStatus get status;
  DateTime? get canceledAt;
  int? get myAmount;
  PaymentStatus? get myPaymentStatus;
  DateTime? get myConfirmedAt;

  /// Create a copy of Settlement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettlementCopyWith<Settlement> get copyWith =>
      _$SettlementCopyWithImpl<Settlement>(this as Settlement, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Settlement &&
            (identical(other.id, id) || other.id == id) &&
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

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
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
    return 'Settlement(id: $id, title: $title, scheduleId: $scheduleId, totalAmount: $totalAmount, memberCount: $memberCount, dueAt: $dueAt, createdAt: $createdAt, status: $status, canceledAt: $canceledAt, myAmount: $myAmount, myPaymentStatus: $myPaymentStatus, myConfirmedAt: $myConfirmedAt)';
  }
}

/// @nodoc
abstract mixin class $SettlementCopyWith<$Res> {
  factory $SettlementCopyWith(
    Settlement value,
    $Res Function(Settlement) _then,
  ) = _$SettlementCopyWithImpl;
  @useResult
  $Res call({
    int id,
    String title,
    int? scheduleId,
    int totalAmount,
    int memberCount,
    DateTime dueAt,
    DateTime createdAt,
    SettlementStatus status,
    DateTime? canceledAt,
    int? myAmount,
    PaymentStatus? myPaymentStatus,
    DateTime? myConfirmedAt,
  });
}

/// @nodoc
class _$SettlementCopyWithImpl<$Res> implements $SettlementCopyWith<$Res> {
  _$SettlementCopyWithImpl(this._self, this._then);

  final Settlement _self;
  final $Res Function(Settlement) _then;

  /// Create a copy of Settlement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
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
      Settlement(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
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
                  as SettlementStatus,
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
                  as PaymentStatus?,
        myConfirmedAt: freezed == myConfirmedAt
            ? _self.myConfirmedAt
            : myConfirmedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [Settlement].
extension SettlementPatterns on Settlement {
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
    TResult Function(_Settlement value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Settlement() when $default != null:
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
    TResult Function(_Settlement value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Settlement():
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
    TResult? Function(_Settlement value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Settlement() when $default != null:
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
      int id,
      String title,
      int? scheduleId,
      int totalAmount,
      int memberCount,
      DateTime dueAt,
      DateTime createdAt,
      SettlementStatus status,
      DateTime? canceledAt,
      int? myAmount,
      PaymentStatus? myPaymentStatus,
      DateTime? myConfirmedAt,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Settlement() when $default != null:
        return $default(
          _that.id,
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
      int id,
      String title,
      int? scheduleId,
      int totalAmount,
      int memberCount,
      DateTime dueAt,
      DateTime createdAt,
      SettlementStatus status,
      DateTime? canceledAt,
      int? myAmount,
      PaymentStatus? myPaymentStatus,
      DateTime? myConfirmedAt,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Settlement():
        return $default(
          _that.id,
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
      int id,
      String title,
      int? scheduleId,
      int totalAmount,
      int memberCount,
      DateTime dueAt,
      DateTime createdAt,
      SettlementStatus status,
      DateTime? canceledAt,
      int? myAmount,
      PaymentStatus? myPaymentStatus,
      DateTime? myConfirmedAt,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Settlement() when $default != null:
        return $default(
          _that.id,
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

class _Settlement implements Settlement {
  const _Settlement({
    required this.id,
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

  @override
  final int id;
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
  final SettlementStatus status;
  @override
  final DateTime? canceledAt;
  @override
  final int? myAmount;
  @override
  final PaymentStatus? myPaymentStatus;
  @override
  final DateTime? myConfirmedAt;

  /// Create a copy of Settlement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettlementCopyWith<_Settlement> get copyWith =>
      __$SettlementCopyWithImpl<_Settlement>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Settlement &&
            (identical(other.id, id) || other.id == id) &&
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

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
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
    return 'Settlement(id: $id, title: $title, scheduleId: $scheduleId, totalAmount: $totalAmount, memberCount: $memberCount, dueAt: $dueAt, createdAt: $createdAt, status: $status, canceledAt: $canceledAt, myAmount: $myAmount, myPaymentStatus: $myPaymentStatus, myConfirmedAt: $myConfirmedAt)';
  }
}

/// @nodoc
abstract mixin class _$SettlementCopyWith<$Res>
    implements $SettlementCopyWith<$Res> {
  factory _$SettlementCopyWith(
    _Settlement value,
    $Res Function(_Settlement) _then,
  ) = __$SettlementCopyWithImpl;
  @override
  @useResult
  $Res call({
    int id,
    String title,
    int? scheduleId,
    int totalAmount,
    int memberCount,
    DateTime dueAt,
    DateTime createdAt,
    SettlementStatus status,
    DateTime? canceledAt,
    int? myAmount,
    PaymentStatus? myPaymentStatus,
    DateTime? myConfirmedAt,
  });
}

/// @nodoc
class __$SettlementCopyWithImpl<$Res> implements _$SettlementCopyWith<$Res> {
  __$SettlementCopyWithImpl(this._self, this._then);

  final _Settlement _self;
  final $Res Function(_Settlement) _then;

  /// Create a copy of Settlement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
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
      _Settlement(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
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
                  as SettlementStatus,
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
                  as PaymentStatus?,
        myConfirmedAt: freezed == myConfirmedAt
            ? _self.myConfirmedAt
            : myConfirmedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}
