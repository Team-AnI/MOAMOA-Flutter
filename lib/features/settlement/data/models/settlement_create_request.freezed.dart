// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_create_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementCreateRequest {
  @JsonKey(includeToJson: false)
  int get meetingId;
  @JsonKey(includeIfNull: false)
  int? get scheduleId;
  String get title;
  int get totalAmount;
  List<int> get memberIds;
  String get bankName;
  String get accountNumber;
  String get accountHolder;
  DateTime get dueAt;
  bool get postNotice;
  @JsonKey(includeIfNull: false)
  int? get replacesSettlementId;

  /// Create a copy of SettlementCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettlementCreateRequestCopyWith<SettlementCreateRequest> get copyWith =>
      _$SettlementCreateRequestCopyWithImpl<SettlementCreateRequest>(
        this as SettlementCreateRequest,
        _$identity,
      );

  /// Serializes this SettlementCreateRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettlementCreateRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.scheduleId, scheduleId) ||
                other.scheduleId == scheduleId) &&
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
            (identical(other.dueAt, dueAt) || other.dueAt == dueAt) &&
            (identical(other.postNotice, postNotice) ||
                other.postNotice == postNotice) &&
            (identical(other.replacesSettlementId, replacesSettlementId) ||
                other.replacesSettlementId == replacesSettlementId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    meetingId,
    scheduleId,
    title,
    totalAmount,
    const DeepCollectionEquality().hash(memberIds),
    bankName,
    accountNumber,
    accountHolder,
    dueAt,
    postNotice,
    replacesSettlementId,
  );

  @override
  String toString() {
    return 'SettlementCreateRequest(meetingId: $meetingId, scheduleId: $scheduleId, title: $title, totalAmount: $totalAmount, memberIds: $memberIds, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, dueAt: $dueAt, postNotice: $postNotice, replacesSettlementId: $replacesSettlementId)';
  }
}

/// @nodoc
abstract mixin class $SettlementCreateRequestCopyWith<$Res> {
  factory $SettlementCreateRequestCopyWith(
    SettlementCreateRequest value,
    $Res Function(SettlementCreateRequest) _then,
  ) = _$SettlementCreateRequestCopyWithImpl;
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int meetingId,
    @JsonKey(includeIfNull: false) int? scheduleId,
    String title,
    int totalAmount,
    List<int> memberIds,
    String bankName,
    String accountNumber,
    String accountHolder,
    DateTime dueAt,
    bool postNotice,
    @JsonKey(includeIfNull: false) int? replacesSettlementId,
  });
}

/// @nodoc
class _$SettlementCreateRequestCopyWithImpl<$Res>
    implements $SettlementCreateRequestCopyWith<$Res> {
  _$SettlementCreateRequestCopyWithImpl(this._self, this._then);

  final SettlementCreateRequest _self;
  final $Res Function(SettlementCreateRequest) _then;

  /// Create a copy of SettlementCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetingId = null,
    Object? scheduleId = freezed,
    Object? title = null,
    Object? totalAmount = null,
    Object? memberIds = null,
    Object? bankName = null,
    Object? accountNumber = null,
    Object? accountHolder = null,
    Object? dueAt = null,
    Object? postNotice = null,
    Object? replacesSettlementId = freezed,
  }) {
    return _then(
      SettlementCreateRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
        scheduleId: freezed == scheduleId
            ? _self.scheduleId
            : scheduleId // ignore: cast_nullable_to_non_nullable
                  as int?,
        title: null == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        totalAmount: null == totalAmount
            ? _self.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        memberIds: null == memberIds
            ? _self.memberIds
            : memberIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
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
        postNotice: null == postNotice
            ? _self.postNotice
            : postNotice // ignore: cast_nullable_to_non_nullable
                  as bool,
        replacesSettlementId: freezed == replacesSettlementId
            ? _self.replacesSettlementId
            : replacesSettlementId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [SettlementCreateRequest].
extension SettlementCreateRequestPatterns on SettlementCreateRequest {
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
    TResult Function(_SettlementCreateRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementCreateRequest() when $default != null:
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
    TResult Function(_SettlementCreateRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementCreateRequest():
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
    TResult? Function(_SettlementCreateRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementCreateRequest() when $default != null:
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
      @JsonKey(includeIfNull: false) int? scheduleId,
      String title,
      int totalAmount,
      List<int> memberIds,
      String bankName,
      String accountNumber,
      String accountHolder,
      DateTime dueAt,
      bool postNotice,
      @JsonKey(includeIfNull: false) int? replacesSettlementId,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementCreateRequest() when $default != null:
        return $default(
          _that.meetingId,
          _that.scheduleId,
          _that.title,
          _that.totalAmount,
          _that.memberIds,
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
          _that.dueAt,
          _that.postNotice,
          _that.replacesSettlementId,
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
      @JsonKey(includeIfNull: false) int? scheduleId,
      String title,
      int totalAmount,
      List<int> memberIds,
      String bankName,
      String accountNumber,
      String accountHolder,
      DateTime dueAt,
      bool postNotice,
      @JsonKey(includeIfNull: false) int? replacesSettlementId,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementCreateRequest():
        return $default(
          _that.meetingId,
          _that.scheduleId,
          _that.title,
          _that.totalAmount,
          _that.memberIds,
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
          _that.dueAt,
          _that.postNotice,
          _that.replacesSettlementId,
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
      @JsonKey(includeIfNull: false) int? scheduleId,
      String title,
      int totalAmount,
      List<int> memberIds,
      String bankName,
      String accountNumber,
      String accountHolder,
      DateTime dueAt,
      bool postNotice,
      @JsonKey(includeIfNull: false) int? replacesSettlementId,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementCreateRequest() when $default != null:
        return $default(
          _that.meetingId,
          _that.scheduleId,
          _that.title,
          _that.totalAmount,
          _that.memberIds,
          _that.bankName,
          _that.accountNumber,
          _that.accountHolder,
          _that.dueAt,
          _that.postNotice,
          _that.replacesSettlementId,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SettlementCreateRequest implements SettlementCreateRequest {
  const _SettlementCreateRequest({
    @JsonKey(includeToJson: false) required this.meetingId,
    @JsonKey(includeIfNull: false) this.scheduleId,
    required this.title,
    required this.totalAmount,
    required List<int> memberIds,
    required this.bankName,
    required this.accountNumber,
    required this.accountHolder,
    required this.dueAt,
    required this.postNotice,
    @JsonKey(includeIfNull: false) this.replacesSettlementId,
  }) : _memberIds = memberIds;
  factory _SettlementCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$SettlementCreateRequestFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int meetingId;
  @override
  @JsonKey(includeIfNull: false)
  final int? scheduleId;
  @override
  final String title;
  @override
  final int totalAmount;
  final List<int> _memberIds;
  @override
  List<int> get memberIds {
    if (_memberIds is EqualUnmodifiableListView) return _memberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memberIds);
  }

  @override
  final String bankName;
  @override
  final String accountNumber;
  @override
  final String accountHolder;
  @override
  final DateTime dueAt;
  @override
  final bool postNotice;
  @override
  @JsonKey(includeIfNull: false)
  final int? replacesSettlementId;

  /// Create a copy of SettlementCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettlementCreateRequestCopyWith<_SettlementCreateRequest> get copyWith =>
      __$SettlementCreateRequestCopyWithImpl<_SettlementCreateRequest>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$SettlementCreateRequestToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettlementCreateRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.scheduleId, scheduleId) ||
                other.scheduleId == scheduleId) &&
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
            (identical(other.dueAt, dueAt) || other.dueAt == dueAt) &&
            (identical(other.postNotice, postNotice) ||
                other.postNotice == postNotice) &&
            (identical(other.replacesSettlementId, replacesSettlementId) ||
                other.replacesSettlementId == replacesSettlementId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    meetingId,
    scheduleId,
    title,
    totalAmount,
    const DeepCollectionEquality().hash(_memberIds),
    bankName,
    accountNumber,
    accountHolder,
    dueAt,
    postNotice,
    replacesSettlementId,
  );

  @override
  String toString() {
    return 'SettlementCreateRequest(meetingId: $meetingId, scheduleId: $scheduleId, title: $title, totalAmount: $totalAmount, memberIds: $memberIds, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, dueAt: $dueAt, postNotice: $postNotice, replacesSettlementId: $replacesSettlementId)';
  }
}

/// @nodoc
abstract mixin class _$SettlementCreateRequestCopyWith<$Res>
    implements $SettlementCreateRequestCopyWith<$Res> {
  factory _$SettlementCreateRequestCopyWith(
    _SettlementCreateRequest value,
    $Res Function(_SettlementCreateRequest) _then,
  ) = __$SettlementCreateRequestCopyWithImpl;
  @override
  @useResult
  $Res call({
    @JsonKey(includeToJson: false) int meetingId,
    @JsonKey(includeIfNull: false) int? scheduleId,
    String title,
    int totalAmount,
    List<int> memberIds,
    String bankName,
    String accountNumber,
    String accountHolder,
    DateTime dueAt,
    bool postNotice,
    @JsonKey(includeIfNull: false) int? replacesSettlementId,
  });
}

/// @nodoc
class __$SettlementCreateRequestCopyWithImpl<$Res>
    implements _$SettlementCreateRequestCopyWith<$Res> {
  __$SettlementCreateRequestCopyWithImpl(this._self, this._then);

  final _SettlementCreateRequest _self;
  final $Res Function(_SettlementCreateRequest) _then;

  /// Create a copy of SettlementCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? meetingId = null,
    Object? scheduleId = freezed,
    Object? title = null,
    Object? totalAmount = null,
    Object? memberIds = null,
    Object? bankName = null,
    Object? accountNumber = null,
    Object? accountHolder = null,
    Object? dueAt = null,
    Object? postNotice = null,
    Object? replacesSettlementId = freezed,
  }) {
    return _then(
      _SettlementCreateRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
        scheduleId: freezed == scheduleId
            ? _self.scheduleId
            : scheduleId // ignore: cast_nullable_to_non_nullable
                  as int?,
        title: null == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        totalAmount: null == totalAmount
            ? _self.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        memberIds: null == memberIds
            ? _self._memberIds
            : memberIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
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
        postNotice: null == postNotice
            ? _self.postNotice
            : postNotice // ignore: cast_nullable_to_non_nullable
                  as bool,
        replacesSettlementId: freezed == replacesSettlementId
            ? _self.replacesSettlementId
            : replacesSettlementId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}
