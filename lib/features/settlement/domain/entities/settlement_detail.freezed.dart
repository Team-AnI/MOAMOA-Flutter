// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementDetail {
  int get id;
  String get title;
  int? get scheduleId;
  String? get scheduleTitle;
  DateTime? get scheduleStartAt;
  int get totalAmount;
  String get bankName;
  String get accountNumber;
  String get accountHolder;
  DateTime get dueAt;
  SettlementStatus get status;
  int? get noticeId;
  DateTime? get canceledAt;
  String? get cancelReason;
  int? get replacesSettlementId;
  int? get replacedBySettlementId;
  SettlementPayment? get myPayment;
  SettlementSummary get summary;
  List<SettlementPayment> get payments;

  /// Create a copy of SettlementDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettlementDetailCopyWith<SettlementDetail> get copyWith =>
      _$SettlementDetailCopyWithImpl<SettlementDetail>(
        this as SettlementDetail,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettlementDetail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.scheduleId, scheduleId) ||
                other.scheduleId == scheduleId) &&
            (identical(other.scheduleTitle, scheduleTitle) ||
                other.scheduleTitle == scheduleTitle) &&
            (identical(other.scheduleStartAt, scheduleStartAt) ||
                other.scheduleStartAt == scheduleStartAt) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.accountHolder, accountHolder) ||
                other.accountHolder == accountHolder) &&
            (identical(other.dueAt, dueAt) || other.dueAt == dueAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.noticeId, noticeId) ||
                other.noticeId == noticeId) &&
            (identical(other.canceledAt, canceledAt) ||
                other.canceledAt == canceledAt) &&
            (identical(other.cancelReason, cancelReason) ||
                other.cancelReason == cancelReason) &&
            (identical(other.replacesSettlementId, replacesSettlementId) ||
                other.replacesSettlementId == replacesSettlementId) &&
            (identical(other.replacedBySettlementId, replacedBySettlementId) ||
                other.replacedBySettlementId == replacedBySettlementId) &&
            (identical(other.myPayment, myPayment) ||
                other.myPayment == myPayment) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(other.payments, payments));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    title,
    scheduleId,
    scheduleTitle,
    scheduleStartAt,
    totalAmount,
    bankName,
    accountNumber,
    accountHolder,
    dueAt,
    status,
    noticeId,
    canceledAt,
    cancelReason,
    replacesSettlementId,
    replacedBySettlementId,
    myPayment,
    summary,
    const DeepCollectionEquality().hash(payments),
  ]);

  @override
  String toString() {
    return 'SettlementDetail(id: $id, title: $title, scheduleId: $scheduleId, scheduleTitle: $scheduleTitle, scheduleStartAt: $scheduleStartAt, totalAmount: $totalAmount, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, dueAt: $dueAt, status: $status, noticeId: $noticeId, canceledAt: $canceledAt, cancelReason: $cancelReason, replacesSettlementId: $replacesSettlementId, replacedBySettlementId: $replacedBySettlementId, myPayment: $myPayment, summary: $summary, payments: $payments)';
  }
}

/// @nodoc
abstract mixin class $SettlementDetailCopyWith<$Res> {
  factory $SettlementDetailCopyWith(
    SettlementDetail value,
    $Res Function(SettlementDetail) _then,
  ) = _$SettlementDetailCopyWithImpl;
  @useResult
  $Res call({
    int id,
    String title,
    int? scheduleId,
    String? scheduleTitle,
    DateTime? scheduleStartAt,
    int totalAmount,
    String bankName,
    String accountNumber,
    String accountHolder,
    DateTime dueAt,
    SettlementStatus status,
    int? noticeId,
    DateTime? canceledAt,
    String? cancelReason,
    int? replacesSettlementId,
    int? replacedBySettlementId,
    SettlementPayment? myPayment,
    SettlementSummary summary,
    List<SettlementPayment> payments,
  });

  $SettlementPaymentCopyWith<$Res>? get myPayment;
  $SettlementSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class _$SettlementDetailCopyWithImpl<$Res>
    implements $SettlementDetailCopyWith<$Res> {
  _$SettlementDetailCopyWithImpl(this._self, this._then);

  final SettlementDetail _self;
  final $Res Function(SettlementDetail) _then;

  /// Create a copy of SettlementDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? scheduleId = freezed,
    Object? scheduleTitle = freezed,
    Object? scheduleStartAt = freezed,
    Object? totalAmount = null,
    Object? bankName = null,
    Object? accountNumber = null,
    Object? accountHolder = null,
    Object? dueAt = null,
    Object? status = null,
    Object? noticeId = freezed,
    Object? canceledAt = freezed,
    Object? cancelReason = freezed,
    Object? replacesSettlementId = freezed,
    Object? replacedBySettlementId = freezed,
    Object? myPayment = freezed,
    Object? summary = null,
    Object? payments = null,
  }) {
    return _then(
      SettlementDetail(
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
        scheduleTitle: freezed == scheduleTitle
            ? _self.scheduleTitle
            : scheduleTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        scheduleStartAt: freezed == scheduleStartAt
            ? _self.scheduleStartAt
            : scheduleStartAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        totalAmount: null == totalAmount
            ? _self.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        bankName: null == bankName
            ? _self.bankName
            : bankName // ignore: cast_nullable_to_non_nullable
                  as String,
        accountNumber: null == accountNumber
            ? _self.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        accountHolder: null == accountHolder
            ? _self.accountHolder
            : accountHolder // ignore: cast_nullable_to_non_nullable
                  as String,
        dueAt: null == dueAt
            ? _self.dueAt
            : dueAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as SettlementStatus,
        noticeId: freezed == noticeId
            ? _self.noticeId
            : noticeId // ignore: cast_nullable_to_non_nullable
                  as int?,
        canceledAt: freezed == canceledAt
            ? _self.canceledAt
            : canceledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        cancelReason: freezed == cancelReason
            ? _self.cancelReason
            : cancelReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        replacesSettlementId: freezed == replacesSettlementId
            ? _self.replacesSettlementId
            : replacesSettlementId // ignore: cast_nullable_to_non_nullable
                  as int?,
        replacedBySettlementId: freezed == replacedBySettlementId
            ? _self.replacedBySettlementId
            : replacedBySettlementId // ignore: cast_nullable_to_non_nullable
                  as int?,
        myPayment: freezed == myPayment
            ? _self.myPayment
            : myPayment // ignore: cast_nullable_to_non_nullable
                  as SettlementPayment?,
        summary: null == summary
            ? _self.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as SettlementSummary,
        payments: null == payments
            ? _self.payments
            : payments // ignore: cast_nullable_to_non_nullable
                  as List<SettlementPayment>,
      ),
    );
  }

  /// Create a copy of SettlementDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SettlementPaymentCopyWith<$Res>? get myPayment {
    if (_self.myPayment == null) {
      return null;
    }

    return $SettlementPaymentCopyWith<$Res>(_self.myPayment!, (value) {
      return _then(_self.copyWith(myPayment: value));
    });
  }

  /// Create a copy of SettlementDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SettlementSummaryCopyWith<$Res> get summary {
    return $SettlementSummaryCopyWith<$Res>(_self.summary, (value) {
      return _then(_self.copyWith(summary: value));
    });
  }
}

/// Adds pattern-matching-related methods to [SettlementDetail].
extension SettlementDetailPatterns on SettlementDetail {
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
    TResult Function(_SettlementDetail value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementDetail() when $default != null:
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
    TResult Function(_SettlementDetail value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementDetail():
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
    TResult? Function(_SettlementDetail value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementDetail() when $default != null:
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
      String? scheduleTitle,
      DateTime? scheduleStartAt,
      int totalAmount,
      String bankName,
      String accountNumber,
      String accountHolder,
      DateTime dueAt,
      SettlementStatus status,
      int? noticeId,
      DateTime? canceledAt,
      String? cancelReason,
      int? replacesSettlementId,
      int? replacedBySettlementId,
      SettlementPayment? myPayment,
      SettlementSummary summary,
      List<SettlementPayment> payments,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementDetail() when $default != null:
        return $default(
          _that.id,
          _that.title,
          _that.scheduleId,
          _that.scheduleTitle,
          _that.scheduleStartAt,
          _that.totalAmount,
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
          _that.dueAt,
          _that.status,
          _that.noticeId,
          _that.canceledAt,
          _that.cancelReason,
          _that.replacesSettlementId,
          _that.replacedBySettlementId,
          _that.myPayment,
          _that.summary,
          _that.payments,
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
      String? scheduleTitle,
      DateTime? scheduleStartAt,
      int totalAmount,
      String bankName,
      String accountNumber,
      String accountHolder,
      DateTime dueAt,
      SettlementStatus status,
      int? noticeId,
      DateTime? canceledAt,
      String? cancelReason,
      int? replacesSettlementId,
      int? replacedBySettlementId,
      SettlementPayment? myPayment,
      SettlementSummary summary,
      List<SettlementPayment> payments,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementDetail():
        return $default(
          _that.id,
          _that.title,
          _that.scheduleId,
          _that.scheduleTitle,
          _that.scheduleStartAt,
          _that.totalAmount,
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
          _that.dueAt,
          _that.status,
          _that.noticeId,
          _that.canceledAt,
          _that.cancelReason,
          _that.replacesSettlementId,
          _that.replacedBySettlementId,
          _that.myPayment,
          _that.summary,
          _that.payments,
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
      String? scheduleTitle,
      DateTime? scheduleStartAt,
      int totalAmount,
      String bankName,
      String accountNumber,
      String accountHolder,
      DateTime dueAt,
      SettlementStatus status,
      int? noticeId,
      DateTime? canceledAt,
      String? cancelReason,
      int? replacesSettlementId,
      int? replacedBySettlementId,
      SettlementPayment? myPayment,
      SettlementSummary summary,
      List<SettlementPayment> payments,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementDetail() when $default != null:
        return $default(
          _that.id,
          _that.title,
          _that.scheduleId,
          _that.scheduleTitle,
          _that.scheduleStartAt,
          _that.totalAmount,
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
          _that.dueAt,
          _that.status,
          _that.noticeId,
          _that.canceledAt,
          _that.cancelReason,
          _that.replacesSettlementId,
          _that.replacedBySettlementId,
          _that.myPayment,
          _that.summary,
          _that.payments,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SettlementDetail implements SettlementDetail {
  const _SettlementDetail({
    required this.id,
    required this.title,
    this.scheduleId,
    this.scheduleTitle,
    this.scheduleStartAt,
    required this.totalAmount,
    required this.bankName,
    required this.accountNumber,
    required this.accountHolder,
    required this.dueAt,
    required this.status,
    this.noticeId,
    this.canceledAt,
    this.cancelReason,
    this.replacesSettlementId,
    this.replacedBySettlementId,
    this.myPayment,
    required this.summary,
    required List<SettlementPayment> payments,
  }) : _payments = payments;

  @override
  final int id;
  @override
  final String title;
  @override
  final int? scheduleId;
  @override
  final String? scheduleTitle;
  @override
  final DateTime? scheduleStartAt;
  @override
  final int totalAmount;
  @override
  final String bankName;
  @override
  final String accountNumber;
  @override
  final String accountHolder;
  @override
  final DateTime dueAt;
  @override
  final SettlementStatus status;
  @override
  final int? noticeId;
  @override
  final DateTime? canceledAt;
  @override
  final String? cancelReason;
  @override
  final int? replacesSettlementId;
  @override
  final int? replacedBySettlementId;
  @override
  final SettlementPayment? myPayment;
  @override
  final SettlementSummary summary;
  final List<SettlementPayment> _payments;
  @override
  List<SettlementPayment> get payments {
    if (_payments is EqualUnmodifiableListView) return _payments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payments);
  }

  /// Create a copy of SettlementDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettlementDetailCopyWith<_SettlementDetail> get copyWith =>
      __$SettlementDetailCopyWithImpl<_SettlementDetail>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettlementDetail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.scheduleId, scheduleId) ||
                other.scheduleId == scheduleId) &&
            (identical(other.scheduleTitle, scheduleTitle) ||
                other.scheduleTitle == scheduleTitle) &&
            (identical(other.scheduleStartAt, scheduleStartAt) ||
                other.scheduleStartAt == scheduleStartAt) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.accountHolder, accountHolder) ||
                other.accountHolder == accountHolder) &&
            (identical(other.dueAt, dueAt) || other.dueAt == dueAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.noticeId, noticeId) ||
                other.noticeId == noticeId) &&
            (identical(other.canceledAt, canceledAt) ||
                other.canceledAt == canceledAt) &&
            (identical(other.cancelReason, cancelReason) ||
                other.cancelReason == cancelReason) &&
            (identical(other.replacesSettlementId, replacesSettlementId) ||
                other.replacesSettlementId == replacesSettlementId) &&
            (identical(other.replacedBySettlementId, replacedBySettlementId) ||
                other.replacedBySettlementId == replacedBySettlementId) &&
            (identical(other.myPayment, myPayment) ||
                other.myPayment == myPayment) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(other._payments, _payments));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    title,
    scheduleId,
    scheduleTitle,
    scheduleStartAt,
    totalAmount,
    bankName,
    accountNumber,
    accountHolder,
    dueAt,
    status,
    noticeId,
    canceledAt,
    cancelReason,
    replacesSettlementId,
    replacedBySettlementId,
    myPayment,
    summary,
    const DeepCollectionEquality().hash(_payments),
  ]);

  @override
  String toString() {
    return 'SettlementDetail(id: $id, title: $title, scheduleId: $scheduleId, scheduleTitle: $scheduleTitle, scheduleStartAt: $scheduleStartAt, totalAmount: $totalAmount, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, dueAt: $dueAt, status: $status, noticeId: $noticeId, canceledAt: $canceledAt, cancelReason: $cancelReason, replacesSettlementId: $replacesSettlementId, replacedBySettlementId: $replacedBySettlementId, myPayment: $myPayment, summary: $summary, payments: $payments)';
  }
}

/// @nodoc
abstract mixin class _$SettlementDetailCopyWith<$Res>
    implements $SettlementDetailCopyWith<$Res> {
  factory _$SettlementDetailCopyWith(
    _SettlementDetail value,
    $Res Function(_SettlementDetail) _then,
  ) = __$SettlementDetailCopyWithImpl;
  @override
  @useResult
  $Res call({
    int id,
    String title,
    int? scheduleId,
    String? scheduleTitle,
    DateTime? scheduleStartAt,
    int totalAmount,
    String bankName,
    String accountNumber,
    String accountHolder,
    DateTime dueAt,
    SettlementStatus status,
    int? noticeId,
    DateTime? canceledAt,
    String? cancelReason,
    int? replacesSettlementId,
    int? replacedBySettlementId,
    SettlementPayment? myPayment,
    SettlementSummary summary,
    List<SettlementPayment> payments,
  });

  @override
  $SettlementPaymentCopyWith<$Res>? get myPayment;
  @override
  $SettlementSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class __$SettlementDetailCopyWithImpl<$Res>
    implements _$SettlementDetailCopyWith<$Res> {
  __$SettlementDetailCopyWithImpl(this._self, this._then);

  final _SettlementDetail _self;
  final $Res Function(_SettlementDetail) _then;

  /// Create a copy of SettlementDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? scheduleId = freezed,
    Object? scheduleTitle = freezed,
    Object? scheduleStartAt = freezed,
    Object? totalAmount = null,
    Object? bankName = null,
    Object? accountNumber = null,
    Object? accountHolder = null,
    Object? dueAt = null,
    Object? status = null,
    Object? noticeId = freezed,
    Object? canceledAt = freezed,
    Object? cancelReason = freezed,
    Object? replacesSettlementId = freezed,
    Object? replacedBySettlementId = freezed,
    Object? myPayment = freezed,
    Object? summary = null,
    Object? payments = null,
  }) {
    return _then(
      _SettlementDetail(
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
        scheduleTitle: freezed == scheduleTitle
            ? _self.scheduleTitle
            : scheduleTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        scheduleStartAt: freezed == scheduleStartAt
            ? _self.scheduleStartAt
            : scheduleStartAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        totalAmount: null == totalAmount
            ? _self.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        bankName: null == bankName
            ? _self.bankName
            : bankName // ignore: cast_nullable_to_non_nullable
                  as String,
        accountNumber: null == accountNumber
            ? _self.accountNumber
            : accountNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        accountHolder: null == accountHolder
            ? _self.accountHolder
            : accountHolder // ignore: cast_nullable_to_non_nullable
                  as String,
        dueAt: null == dueAt
            ? _self.dueAt
            : dueAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as SettlementStatus,
        noticeId: freezed == noticeId
            ? _self.noticeId
            : noticeId // ignore: cast_nullable_to_non_nullable
                  as int?,
        canceledAt: freezed == canceledAt
            ? _self.canceledAt
            : canceledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        cancelReason: freezed == cancelReason
            ? _self.cancelReason
            : cancelReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        replacesSettlementId: freezed == replacesSettlementId
            ? _self.replacesSettlementId
            : replacesSettlementId // ignore: cast_nullable_to_non_nullable
                  as int?,
        replacedBySettlementId: freezed == replacedBySettlementId
            ? _self.replacedBySettlementId
            : replacedBySettlementId // ignore: cast_nullable_to_non_nullable
                  as int?,
        myPayment: freezed == myPayment
            ? _self.myPayment
            : myPayment // ignore: cast_nullable_to_non_nullable
                  as SettlementPayment?,
        summary: null == summary
            ? _self.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as SettlementSummary,
        payments: null == payments
            ? _self._payments
            : payments // ignore: cast_nullable_to_non_nullable
                  as List<SettlementPayment>,
      ),
    );
  }

  /// Create a copy of SettlementDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SettlementPaymentCopyWith<$Res>? get myPayment {
    if (_self.myPayment == null) {
      return null;
    }

    return $SettlementPaymentCopyWith<$Res>(_self.myPayment!, (value) {
      return _then(_self.copyWith(myPayment: value));
    });
  }

  /// Create a copy of SettlementDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SettlementSummaryCopyWith<$Res> get summary {
    return $SettlementSummaryCopyWith<$Res>(_self.summary, (value) {
      return _then(_self.copyWith(summary: value));
    });
  }
}
