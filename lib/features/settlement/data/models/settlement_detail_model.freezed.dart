// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementDetailModel {
  int get settlementId;
  String get title;
  int? get scheduleId;
  String? get scheduleTitle;
  DateTime? get scheduleStartAt;
  int get totalAmount;
  String get bankName;
  String get accountNumber;
  String get accountHolder;
  DateTime get dueAt;
  String get status;
  int? get noticeId;
  DateTime? get canceledAt;
  String? get cancelReason;
  int? get replacesSettlementId;
  int? get replacedBySettlementId;
  SettlementPaymentModel? get myPayment;
  SettlementSummaryModel get summary;
  List<SettlementPaymentModel> get payments;

  /// Create a copy of SettlementDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettlementDetailModelCopyWith<SettlementDetailModel> get copyWith =>
      _$SettlementDetailModelCopyWithImpl<SettlementDetailModel>(
        this as SettlementDetailModel,
        _$identity,
      );

  /// Serializes this SettlementDetailModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettlementDetailModel &&
            (identical(other.settlementId, settlementId) ||
                other.settlementId == settlementId) &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    settlementId,
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
    return 'SettlementDetailModel(settlementId: $settlementId, title: $title, scheduleId: $scheduleId, scheduleTitle: $scheduleTitle, scheduleStartAt: $scheduleStartAt, totalAmount: $totalAmount, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, dueAt: $dueAt, status: $status, noticeId: $noticeId, canceledAt: $canceledAt, cancelReason: $cancelReason, replacesSettlementId: $replacesSettlementId, replacedBySettlementId: $replacedBySettlementId, myPayment: $myPayment, summary: $summary, payments: $payments)';
  }
}

/// @nodoc
abstract mixin class $SettlementDetailModelCopyWith<$Res> {
  factory $SettlementDetailModelCopyWith(
    SettlementDetailModel value,
    $Res Function(SettlementDetailModel) _then,
  ) = _$SettlementDetailModelCopyWithImpl;
  @useResult
  $Res call({
    int settlementId,
    String title,
    int? scheduleId,
    String? scheduleTitle,
    DateTime? scheduleStartAt,
    int totalAmount,
    String bankName,
    String accountNumber,
    String accountHolder,
    DateTime dueAt,
    String status,
    int? noticeId,
    DateTime? canceledAt,
    String? cancelReason,
    int? replacesSettlementId,
    int? replacedBySettlementId,
    SettlementPaymentModel? myPayment,
    SettlementSummaryModel summary,
    List<SettlementPaymentModel> payments,
  });

  $SettlementPaymentModelCopyWith<$Res>? get myPayment;
  $SettlementSummaryModelCopyWith<$Res> get summary;
}

/// @nodoc
class _$SettlementDetailModelCopyWithImpl<$Res>
    implements $SettlementDetailModelCopyWith<$Res> {
  _$SettlementDetailModelCopyWithImpl(this._self, this._then);

  final SettlementDetailModel _self;
  final $Res Function(SettlementDetailModel) _then;

  /// Create a copy of SettlementDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? settlementId = null,
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
      SettlementDetailModel(
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
                  as String,
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
                  as SettlementPaymentModel?,
        summary: null == summary
            ? _self.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as SettlementSummaryModel,
        payments: null == payments
            ? _self.payments
            : payments // ignore: cast_nullable_to_non_nullable
                  as List<SettlementPaymentModel>,
      ),
    );
  }

  /// Create a copy of SettlementDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SettlementPaymentModelCopyWith<$Res>? get myPayment {
    if (_self.myPayment == null) {
      return null;
    }

    return $SettlementPaymentModelCopyWith<$Res>(_self.myPayment!, (value) {
      return _then(_self.copyWith(myPayment: value));
    });
  }

  /// Create a copy of SettlementDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SettlementSummaryModelCopyWith<$Res> get summary {
    return $SettlementSummaryModelCopyWith<$Res>(_self.summary, (value) {
      return _then(_self.copyWith(summary: value));
    });
  }
}

/// Adds pattern-matching-related methods to [SettlementDetailModel].
extension SettlementDetailModelPatterns on SettlementDetailModel {
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
    TResult Function(_SettlementDetailModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementDetailModel() when $default != null:
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
    TResult Function(_SettlementDetailModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementDetailModel():
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
    TResult? Function(_SettlementDetailModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementDetailModel() when $default != null:
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
      String? scheduleTitle,
      DateTime? scheduleStartAt,
      int totalAmount,
      String bankName,
      String accountNumber,
      String accountHolder,
      DateTime dueAt,
      String status,
      int? noticeId,
      DateTime? canceledAt,
      String? cancelReason,
      int? replacesSettlementId,
      int? replacedBySettlementId,
      SettlementPaymentModel? myPayment,
      SettlementSummaryModel summary,
      List<SettlementPaymentModel> payments,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementDetailModel() when $default != null:
        return $default(
          _that.settlementId,
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
      int settlementId,
      String title,
      int? scheduleId,
      String? scheduleTitle,
      DateTime? scheduleStartAt,
      int totalAmount,
      String bankName,
      String accountNumber,
      String accountHolder,
      DateTime dueAt,
      String status,
      int? noticeId,
      DateTime? canceledAt,
      String? cancelReason,
      int? replacesSettlementId,
      int? replacedBySettlementId,
      SettlementPaymentModel? myPayment,
      SettlementSummaryModel summary,
      List<SettlementPaymentModel> payments,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementDetailModel():
        return $default(
          _that.settlementId,
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
      int settlementId,
      String title,
      int? scheduleId,
      String? scheduleTitle,
      DateTime? scheduleStartAt,
      int totalAmount,
      String bankName,
      String accountNumber,
      String accountHolder,
      DateTime dueAt,
      String status,
      int? noticeId,
      DateTime? canceledAt,
      String? cancelReason,
      int? replacesSettlementId,
      int? replacedBySettlementId,
      SettlementPaymentModel? myPayment,
      SettlementSummaryModel summary,
      List<SettlementPaymentModel> payments,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementDetailModel() when $default != null:
        return $default(
          _that.settlementId,
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
@JsonSerializable()
class _SettlementDetailModel implements SettlementDetailModel {
  const _SettlementDetailModel({
    required this.settlementId,
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
    List<SettlementPaymentModel> payments = const <SettlementPaymentModel>[],
  }) : _payments = payments;
  factory _SettlementDetailModel.fromJson(Map<String, dynamic> json) =>
      _$SettlementDetailModelFromJson(json);

  @override
  final int settlementId;
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
  final String status;
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
  final SettlementPaymentModel? myPayment;
  @override
  final SettlementSummaryModel summary;
  final List<SettlementPaymentModel> _payments;
  @override
  @JsonKey()
  List<SettlementPaymentModel> get payments {
    if (_payments is EqualUnmodifiableListView) return _payments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payments);
  }

  /// Create a copy of SettlementDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettlementDetailModelCopyWith<_SettlementDetailModel> get copyWith =>
      __$SettlementDetailModelCopyWithImpl<_SettlementDetailModel>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$SettlementDetailModelToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettlementDetailModel &&
            (identical(other.settlementId, settlementId) ||
                other.settlementId == settlementId) &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    settlementId,
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
    return 'SettlementDetailModel(settlementId: $settlementId, title: $title, scheduleId: $scheduleId, scheduleTitle: $scheduleTitle, scheduleStartAt: $scheduleStartAt, totalAmount: $totalAmount, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, dueAt: $dueAt, status: $status, noticeId: $noticeId, canceledAt: $canceledAt, cancelReason: $cancelReason, replacesSettlementId: $replacesSettlementId, replacedBySettlementId: $replacedBySettlementId, myPayment: $myPayment, summary: $summary, payments: $payments)';
  }
}

/// @nodoc
abstract mixin class _$SettlementDetailModelCopyWith<$Res>
    implements $SettlementDetailModelCopyWith<$Res> {
  factory _$SettlementDetailModelCopyWith(
    _SettlementDetailModel value,
    $Res Function(_SettlementDetailModel) _then,
  ) = __$SettlementDetailModelCopyWithImpl;
  @override
  @useResult
  $Res call({
    int settlementId,
    String title,
    int? scheduleId,
    String? scheduleTitle,
    DateTime? scheduleStartAt,
    int totalAmount,
    String bankName,
    String accountNumber,
    String accountHolder,
    DateTime dueAt,
    String status,
    int? noticeId,
    DateTime? canceledAt,
    String? cancelReason,
    int? replacesSettlementId,
    int? replacedBySettlementId,
    SettlementPaymentModel? myPayment,
    SettlementSummaryModel summary,
    List<SettlementPaymentModel> payments,
  });

  @override
  $SettlementPaymentModelCopyWith<$Res>? get myPayment;
  @override
  $SettlementSummaryModelCopyWith<$Res> get summary;
}

/// @nodoc
class __$SettlementDetailModelCopyWithImpl<$Res>
    implements _$SettlementDetailModelCopyWith<$Res> {
  __$SettlementDetailModelCopyWithImpl(this._self, this._then);

  final _SettlementDetailModel _self;
  final $Res Function(_SettlementDetailModel) _then;

  /// Create a copy of SettlementDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? settlementId = null,
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
      _SettlementDetailModel(
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
                  as String,
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
                  as SettlementPaymentModel?,
        summary: null == summary
            ? _self.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as SettlementSummaryModel,
        payments: null == payments
            ? _self._payments
            : payments // ignore: cast_nullable_to_non_nullable
                  as List<SettlementPaymentModel>,
      ),
    );
  }

  /// Create a copy of SettlementDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SettlementPaymentModelCopyWith<$Res>? get myPayment {
    if (_self.myPayment == null) {
      return null;
    }

    return $SettlementPaymentModelCopyWith<$Res>(_self.myPayment!, (value) {
      return _then(_self.copyWith(myPayment: value));
    });
  }

  /// Create a copy of SettlementDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SettlementSummaryModelCopyWith<$Res> get summary {
    return $SettlementSummaryModelCopyWith<$Res>(_self.summary, (value) {
      return _then(_self.copyWith(summary: value));
    });
  }
}
