// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementSummaryModel {
  int get totalCount;
  int get unpaidCount;
  int get pendingCount;
  int get paidCount;
  int? get refundedCount;
  int get paidAmount;

  /// Create a copy of SettlementSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettlementSummaryModelCopyWith<SettlementSummaryModel> get copyWith =>
      _$SettlementSummaryModelCopyWithImpl<SettlementSummaryModel>(
        this as SettlementSummaryModel,
        _$identity,
      );

  /// Serializes this SettlementSummaryModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettlementSummaryModel &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.unpaidCount, unpaidCount) ||
                other.unpaidCount == unpaidCount) &&
            (identical(other.pendingCount, pendingCount) ||
                other.pendingCount == pendingCount) &&
            (identical(other.paidCount, paidCount) ||
                other.paidCount == paidCount) &&
            (identical(other.refundedCount, refundedCount) ||
                other.refundedCount == refundedCount) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalCount,
    unpaidCount,
    pendingCount,
    paidCount,
    refundedCount,
    paidAmount,
  );

  @override
  String toString() {
    return 'SettlementSummaryModel(totalCount: $totalCount, unpaidCount: $unpaidCount, pendingCount: $pendingCount, paidCount: $paidCount, refundedCount: $refundedCount, paidAmount: $paidAmount)';
  }
}

/// @nodoc
abstract mixin class $SettlementSummaryModelCopyWith<$Res> {
  factory $SettlementSummaryModelCopyWith(
    SettlementSummaryModel value,
    $Res Function(SettlementSummaryModel) _then,
  ) = _$SettlementSummaryModelCopyWithImpl;
  @useResult
  $Res call({
    int totalCount,
    int unpaidCount,
    int pendingCount,
    int paidCount,
    int? refundedCount,
    int paidAmount,
  });
}

/// @nodoc
class _$SettlementSummaryModelCopyWithImpl<$Res>
    implements $SettlementSummaryModelCopyWith<$Res> {
  _$SettlementSummaryModelCopyWithImpl(this._self, this._then);

  final SettlementSummaryModel _self;
  final $Res Function(SettlementSummaryModel) _then;

  /// Create a copy of SettlementSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? unpaidCount = null,
    Object? pendingCount = null,
    Object? paidCount = null,
    Object? refundedCount = freezed,
    Object? paidAmount = null,
  }) {
    return _then(
      SettlementSummaryModel(
        totalCount: null == totalCount
            ? _self.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        unpaidCount: null == unpaidCount
            ? _self.unpaidCount
            : unpaidCount // ignore: cast_nullable_to_non_nullable
                  as int,
        pendingCount: null == pendingCount
            ? _self.pendingCount
            : pendingCount // ignore: cast_nullable_to_non_nullable
                  as int,
        paidCount: null == paidCount
            ? _self.paidCount
            : paidCount // ignore: cast_nullable_to_non_nullable
                  as int,
        refundedCount: freezed == refundedCount
            ? _self.refundedCount
            : refundedCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        paidAmount: null == paidAmount
            ? _self.paidAmount
            : paidAmount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [SettlementSummaryModel].
extension SettlementSummaryModelPatterns on SettlementSummaryModel {
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
    TResult Function(_SettlementSummaryModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementSummaryModel() when $default != null:
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
    TResult Function(_SettlementSummaryModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementSummaryModel():
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
    TResult? Function(_SettlementSummaryModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementSummaryModel() when $default != null:
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
      int totalCount,
      int unpaidCount,
      int pendingCount,
      int paidCount,
      int? refundedCount,
      int paidAmount,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementSummaryModel() when $default != null:
        return $default(
          _that.totalCount,
          _that.unpaidCount,
          _that.pendingCount,
          _that.paidCount,
          _that.refundedCount,
          _that.paidAmount,
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
      int totalCount,
      int unpaidCount,
      int pendingCount,
      int paidCount,
      int? refundedCount,
      int paidAmount,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementSummaryModel():
        return $default(
          _that.totalCount,
          _that.unpaidCount,
          _that.pendingCount,
          _that.paidCount,
          _that.refundedCount,
          _that.paidAmount,
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
      int totalCount,
      int unpaidCount,
      int pendingCount,
      int paidCount,
      int? refundedCount,
      int paidAmount,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementSummaryModel() when $default != null:
        return $default(
          _that.totalCount,
          _that.unpaidCount,
          _that.pendingCount,
          _that.paidCount,
          _that.refundedCount,
          _that.paidAmount,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SettlementSummaryModel implements SettlementSummaryModel {
  const _SettlementSummaryModel({
    required this.totalCount,
    required this.unpaidCount,
    required this.pendingCount,
    required this.paidCount,
    this.refundedCount,
    required this.paidAmount,
  });
  factory _SettlementSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$SettlementSummaryModelFromJson(json);

  @override
  final int totalCount;
  @override
  final int unpaidCount;
  @override
  final int pendingCount;
  @override
  final int paidCount;
  @override
  final int? refundedCount;
  @override
  final int paidAmount;

  /// Create a copy of SettlementSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettlementSummaryModelCopyWith<_SettlementSummaryModel> get copyWith =>
      __$SettlementSummaryModelCopyWithImpl<_SettlementSummaryModel>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$SettlementSummaryModelToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettlementSummaryModel &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.unpaidCount, unpaidCount) ||
                other.unpaidCount == unpaidCount) &&
            (identical(other.pendingCount, pendingCount) ||
                other.pendingCount == pendingCount) &&
            (identical(other.paidCount, paidCount) ||
                other.paidCount == paidCount) &&
            (identical(other.refundedCount, refundedCount) ||
                other.refundedCount == refundedCount) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalCount,
    unpaidCount,
    pendingCount,
    paidCount,
    refundedCount,
    paidAmount,
  );

  @override
  String toString() {
    return 'SettlementSummaryModel(totalCount: $totalCount, unpaidCount: $unpaidCount, pendingCount: $pendingCount, paidCount: $paidCount, refundedCount: $refundedCount, paidAmount: $paidAmount)';
  }
}

/// @nodoc
abstract mixin class _$SettlementSummaryModelCopyWith<$Res>
    implements $SettlementSummaryModelCopyWith<$Res> {
  factory _$SettlementSummaryModelCopyWith(
    _SettlementSummaryModel value,
    $Res Function(_SettlementSummaryModel) _then,
  ) = __$SettlementSummaryModelCopyWithImpl;
  @override
  @useResult
  $Res call({
    int totalCount,
    int unpaidCount,
    int pendingCount,
    int paidCount,
    int? refundedCount,
    int paidAmount,
  });
}

/// @nodoc
class __$SettlementSummaryModelCopyWithImpl<$Res>
    implements _$SettlementSummaryModelCopyWith<$Res> {
  __$SettlementSummaryModelCopyWithImpl(this._self, this._then);

  final _SettlementSummaryModel _self;
  final $Res Function(_SettlementSummaryModel) _then;

  /// Create a copy of SettlementSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? totalCount = null,
    Object? unpaidCount = null,
    Object? pendingCount = null,
    Object? paidCount = null,
    Object? refundedCount = freezed,
    Object? paidAmount = null,
  }) {
    return _then(
      _SettlementSummaryModel(
        totalCount: null == totalCount
            ? _self.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        unpaidCount: null == unpaidCount
            ? _self.unpaidCount
            : unpaidCount // ignore: cast_nullable_to_non_nullable
                  as int,
        pendingCount: null == pendingCount
            ? _self.pendingCount
            : pendingCount // ignore: cast_nullable_to_non_nullable
                  as int,
        paidCount: null == paidCount
            ? _self.paidCount
            : paidCount // ignore: cast_nullable_to_non_nullable
                  as int,
        refundedCount: freezed == refundedCount
            ? _self.refundedCount
            : refundedCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        paidAmount: null == paidAmount
            ? _self.paidAmount
            : paidAmount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}
