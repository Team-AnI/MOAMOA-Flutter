// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_edit_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementEditRequest {
  @JsonKey(includeToJson: false)
  int get meetingId;
  @JsonKey(includeToJson: false)
  int get settlementId;
  @JsonKey(includeIfNull: false)
  String? get title;
  @JsonKey(includeIfNull: false)
  int? get totalAmount;
  @JsonKey(includeIfNull: false)
  List<int>? get memberIds;
  @JsonKey(includeIfNull: false)
  String? get bankName;
  @JsonKey(includeIfNull: false)
  String? get accountNumber;
  @JsonKey(includeIfNull: false)
  String? get accountHolder;
  @JsonKey(includeIfNull: false)
  DateTime? get dueAt;

  /// Create a copy of SettlementEditRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettlementEditRequestCopyWith<SettlementEditRequest> get copyWith =>
      _$SettlementEditRequestCopyWithImpl<SettlementEditRequest>(
        this as SettlementEditRequest,
        _$identity,
      );

  /// Serializes this SettlementEditRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettlementEditRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.settlementId, settlementId) ||
                other.settlementId == settlementId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            const DeepCollectionEquality().equals(other.memberIds, memberIds) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.accountHolder, accountHolder) ||
                other.accountHolder == accountHolder) &&
            (identical(other.dueAt, dueAt) || other.dueAt == dueAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    meetingId,
    settlementId,
    title,
    totalAmount,
    const DeepCollectionEquality().hash(memberIds),
    bankName,
    accountNumber,
    accountHolder,
    dueAt,
  );

  @override
  String toString() {
    return 'SettlementEditRequest(meetingId: $meetingId, settlementId: $settlementId, title: $title, totalAmount: $totalAmount, memberIds: $memberIds, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, dueAt: $dueAt)';
  }
}

/// @nodoc
abstract mixin class $SettlementEditRequestCopyWith<$Res> {
  factory $SettlementEditRequestCopyWith(
    SettlementEditRequest value,
    $Res Function(SettlementEditRequest) _then,
  ) = _$SettlementEditRequestCopyWithImpl;
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int meetingId,
    @JsonKey(includeToJson: false) int settlementId,
    @JsonKey(includeIfNull: false) String? title,
    @JsonKey(includeIfNull: false) int? totalAmount,
    @JsonKey(includeIfNull: false) List<int>? memberIds,
    @JsonKey(includeIfNull: false) String? bankName,
    @JsonKey(includeIfNull: false) String? accountNumber,
    @JsonKey(includeIfNull: false) String? accountHolder,
    @JsonKey(includeIfNull: false) DateTime? dueAt,
  });
}

/// @nodoc
class _$SettlementEditRequestCopyWithImpl<$Res>
    implements $SettlementEditRequestCopyWith<$Res> {
  _$SettlementEditRequestCopyWithImpl(this._self, this._then);

  final SettlementEditRequest _self;
  final $Res Function(SettlementEditRequest) _then;

  /// Create a copy of SettlementEditRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetingId = null,
    Object? settlementId = null,
    Object? title = freezed,
    Object? totalAmount = freezed,
    Object? memberIds = freezed,
    Object? bankName = freezed,
    Object? accountNumber = freezed,
    Object? accountHolder = freezed,
    Object? dueAt = freezed,
  }) {
    return _then(
      SettlementEditRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
        settlementId: null == settlementId
            ? _self.settlementId
            : settlementId // ignore: cast_nullable_to_non_nullable
                  as int,
        title: freezed == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalAmount: freezed == totalAmount
            ? _self.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as int?,
        memberIds: freezed == memberIds
            ? _self.memberIds
            : memberIds // ignore: cast_nullable_to_non_nullable
                  as List<int>?,
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
        dueAt: freezed == dueAt
            ? _self.dueAt
            : dueAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [SettlementEditRequest].
extension SettlementEditRequestPatterns on SettlementEditRequest {
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
    TResult Function(_SettlementEditRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementEditRequest() when $default != null:
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
    TResult Function(_SettlementEditRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementEditRequest():
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
    TResult? Function(_SettlementEditRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementEditRequest() when $default != null:
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
      @JsonKey(includeToJson: false) int settlementId,
      @JsonKey(includeIfNull: false) String? title,
      @JsonKey(includeIfNull: false) int? totalAmount,
      @JsonKey(includeIfNull: false) List<int>? memberIds,
      @JsonKey(includeIfNull: false) String? bankName,
      @JsonKey(includeIfNull: false) String? accountNumber,
      @JsonKey(includeIfNull: false) String? accountHolder,
      @JsonKey(includeIfNull: false) DateTime? dueAt,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementEditRequest() when $default != null:
        return $default(
          _that.meetingId,
          _that.settlementId,
          _that.title,
          _that.totalAmount,
          _that.memberIds,
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
          _that.dueAt,
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
      @JsonKey(includeToJson: false) int settlementId,
      @JsonKey(includeIfNull: false) String? title,
      @JsonKey(includeIfNull: false) int? totalAmount,
      @JsonKey(includeIfNull: false) List<int>? memberIds,
      @JsonKey(includeIfNull: false) String? bankName,
      @JsonKey(includeIfNull: false) String? accountNumber,
      @JsonKey(includeIfNull: false) String? accountHolder,
      @JsonKey(includeIfNull: false) DateTime? dueAt,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementEditRequest():
        return $default(
          _that.meetingId,
          _that.settlementId,
          _that.title,
          _that.totalAmount,
          _that.memberIds,
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
          _that.dueAt,
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
      @JsonKey(includeToJson: false) int settlementId,
      @JsonKey(includeIfNull: false) String? title,
      @JsonKey(includeIfNull: false) int? totalAmount,
      @JsonKey(includeIfNull: false) List<int>? memberIds,
      @JsonKey(includeIfNull: false) String? bankName,
      @JsonKey(includeIfNull: false) String? accountNumber,
      @JsonKey(includeIfNull: false) String? accountHolder,
      @JsonKey(includeIfNull: false) DateTime? dueAt,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementEditRequest() when $default != null:
        return $default(
          _that.meetingId,
          _that.settlementId,
          _that.title,
          _that.totalAmount,
          _that.memberIds,
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
          _that.dueAt,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SettlementEditRequest extends SettlementEditRequest {
  const _SettlementEditRequest({
    @JsonKey(includeToJson: false) required this.meetingId,
    @JsonKey(includeToJson: false) required this.settlementId,
    @JsonKey(includeIfNull: false) this.title,
    @JsonKey(includeIfNull: false) this.totalAmount,
    @JsonKey(includeIfNull: false) List<int>? memberIds,
    @JsonKey(includeIfNull: false) this.bankName,
    @JsonKey(includeIfNull: false) this.accountNumber,
    @JsonKey(includeIfNull: false) this.accountHolder,
    @JsonKey(includeIfNull: false) this.dueAt,
  }) : _memberIds = memberIds,
       super._();
  factory _SettlementEditRequest.fromJson(Map<String, dynamic> json) =>
      _$SettlementEditRequestFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int meetingId;
  @override
  @JsonKey(includeToJson: false)
  final int settlementId;
  @override
  @JsonKey(includeIfNull: false)
  final String? title;
  @override
  @JsonKey(includeIfNull: false)
  final int? totalAmount;
  final List<int>? _memberIds;
  @override
  @JsonKey(includeIfNull: false)
  List<int>? get memberIds {
    final value = _memberIds;
    if (value == null) return null;
    if (_memberIds is EqualUnmodifiableListView) return _memberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

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
  final DateTime? dueAt;

  /// Create a copy of SettlementEditRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettlementEditRequestCopyWith<_SettlementEditRequest> get copyWith =>
      __$SettlementEditRequestCopyWithImpl<_SettlementEditRequest>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$SettlementEditRequestToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettlementEditRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.settlementId, settlementId) ||
                other.settlementId == settlementId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            const DeepCollectionEquality().equals(
              other._memberIds,
              _memberIds,
            ) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.accountHolder, accountHolder) ||
                other.accountHolder == accountHolder) &&
            (identical(other.dueAt, dueAt) || other.dueAt == dueAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    meetingId,
    settlementId,
    title,
    totalAmount,
    const DeepCollectionEquality().hash(_memberIds),
    bankName,
    accountNumber,
    accountHolder,
    dueAt,
  );

  @override
  String toString() {
    return 'SettlementEditRequest(meetingId: $meetingId, settlementId: $settlementId, title: $title, totalAmount: $totalAmount, memberIds: $memberIds, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, dueAt: $dueAt)';
  }
}

/// @nodoc
abstract mixin class _$SettlementEditRequestCopyWith<$Res>
    implements $SettlementEditRequestCopyWith<$Res> {
  factory _$SettlementEditRequestCopyWith(
    _SettlementEditRequest value,
    $Res Function(_SettlementEditRequest) _then,
  ) = __$SettlementEditRequestCopyWithImpl;
  @override
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int meetingId,
    @JsonKey(includeToJson: false) int settlementId,
    @JsonKey(includeIfNull: false) String? title,
    @JsonKey(includeIfNull: false) int? totalAmount,
    @JsonKey(includeIfNull: false) List<int>? memberIds,
    @JsonKey(includeIfNull: false) String? bankName,
    @JsonKey(includeIfNull: false) String? accountNumber,
    @JsonKey(includeIfNull: false) String? accountHolder,
    @JsonKey(includeIfNull: false) DateTime? dueAt,
  });
}

/// @nodoc
class __$SettlementEditRequestCopyWithImpl<$Res>
    implements _$SettlementEditRequestCopyWith<$Res> {
  __$SettlementEditRequestCopyWithImpl(this._self, this._then);

  final _SettlementEditRequest _self;
  final $Res Function(_SettlementEditRequest) _then;

  /// Create a copy of SettlementEditRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? meetingId = null,
    Object? settlementId = null,
    Object? title = freezed,
    Object? totalAmount = freezed,
    Object? memberIds = freezed,
    Object? bankName = freezed,
    Object? accountNumber = freezed,
    Object? accountHolder = freezed,
    Object? dueAt = freezed,
  }) {
    return _then(
      _SettlementEditRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
        settlementId: null == settlementId
            ? _self.settlementId
            : settlementId // ignore: cast_nullable_to_non_nullable
                  as int,
        title: freezed == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalAmount: freezed == totalAmount
            ? _self.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as int?,
        memberIds: freezed == memberIds
            ? _self._memberIds
            : memberIds // ignore: cast_nullable_to_non_nullable
                  as List<int>?,
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
        dueAt: freezed == dueAt
            ? _self.dueAt
            : dueAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}
