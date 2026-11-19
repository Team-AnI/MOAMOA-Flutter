// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'regular_due_update.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegularDueUpdate {
  String? get title;
  int? get amount;
  DuesCycle? get cycle;
  String? get cycleDay;
  String? get sendTime;
  int? get dueDays;
  String? get bankName;
  String? get accountNumber;
  String? get accountHolder;
  bool? get isActive;
  bool? get postNotice;
  bool get applyToCurrentSettlement;

  /// Create a copy of RegularDueUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegularDueUpdateCopyWith<RegularDueUpdate> get copyWith =>
      _$RegularDueUpdateCopyWithImpl<RegularDueUpdate>(
        this as RegularDueUpdate,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegularDueUpdate &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.cycle, cycle) || other.cycle == cycle) &&
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

  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    amount,
    cycle,
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
    return 'RegularDueUpdate(title: $title, amount: $amount, cycle: $cycle, cycleDay: $cycleDay, sendTime: $sendTime, dueDays: $dueDays, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, isActive: $isActive, postNotice: $postNotice, applyToCurrentSettlement: $applyToCurrentSettlement)';
  }
}

/// @nodoc
abstract mixin class $RegularDueUpdateCopyWith<$Res> {
  factory $RegularDueUpdateCopyWith(
    RegularDueUpdate value,
    $Res Function(RegularDueUpdate) _then,
  ) = _$RegularDueUpdateCopyWithImpl;
  @useResult
  $Res call({
    String? title,
    int? amount,
    DuesCycle? cycle,
    String? cycleDay,
    String? sendTime,
    int? dueDays,
    String? bankName,
    String? accountNumber,
    String? accountHolder,
    bool? isActive,
    bool? postNotice,
    bool applyToCurrentSettlement,
  });
}

/// @nodoc
class _$RegularDueUpdateCopyWithImpl<$Res>
    implements $RegularDueUpdateCopyWith<$Res> {
  _$RegularDueUpdateCopyWithImpl(this._self, this._then);

  final RegularDueUpdate _self;
  final $Res Function(RegularDueUpdate) _then;

  /// Create a copy of RegularDueUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? amount = freezed,
    Object? cycle = freezed,
    Object? cycleDay = freezed,
    Object? sendTime = freezed,
    Object? dueDays = freezed,
    Object? bankName = freezed,
    Object? accountNumber = freezed,
    Object? accountHolder = freezed,
    Object? isActive = freezed,
    Object? postNotice = freezed,
    Object? applyToCurrentSettlement = null,
  }) {
    return _then(
      RegularDueUpdate(
        title: freezed == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        amount: freezed == amount
            ? _self.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int?,
        cycle: freezed == cycle
            ? _self.cycle
            : cycle // ignore: cast_nullable_to_non_nullable
                  as DuesCycle?,
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
        applyToCurrentSettlement: null == applyToCurrentSettlement
            ? _self.applyToCurrentSettlement
            : applyToCurrentSettlement // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [RegularDueUpdate].
extension RegularDueUpdatePatterns on RegularDueUpdate {
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
    TResult Function(_RegularDueUpdate value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegularDueUpdate() when $default != null:
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
    TResult Function(_RegularDueUpdate value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueUpdate():
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
    TResult? Function(_RegularDueUpdate value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueUpdate() when $default != null:
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
      String? title,
      int? amount,
      DuesCycle? cycle,
      String? cycleDay,
      String? sendTime,
      int? dueDays,
      String? bankName,
      String? accountNumber,
      String? accountHolder,
      bool? isActive,
      bool? postNotice,
      bool applyToCurrentSettlement,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegularDueUpdate() when $default != null:
        return $default(
          _that.title,
          _that.amount,
          _that.cycle,
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
      String? title,
      int? amount,
      DuesCycle? cycle,
      String? cycleDay,
      String? sendTime,
      int? dueDays,
      String? bankName,
      String? accountNumber,
      String? accountHolder,
      bool? isActive,
      bool? postNotice,
      bool applyToCurrentSettlement,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueUpdate():
        return $default(
          _that.title,
          _that.amount,
          _that.cycle,
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
      String? title,
      int? amount,
      DuesCycle? cycle,
      String? cycleDay,
      String? sendTime,
      int? dueDays,
      String? bankName,
      String? accountNumber,
      String? accountHolder,
      bool? isActive,
      bool? postNotice,
      bool applyToCurrentSettlement,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueUpdate() when $default != null:
        return $default(
          _that.title,
          _that.amount,
          _that.cycle,
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

class _RegularDueUpdate extends RegularDueUpdate {
  const _RegularDueUpdate({
    this.title,
    this.amount,
    this.cycle,
    this.cycleDay,
    this.sendTime,
    this.dueDays,
    this.bankName,
    this.accountNumber,
    this.accountHolder,
    this.isActive,
    this.postNotice,
    this.applyToCurrentSettlement = false,
  }) : super._();

  @override
  final String? title;
  @override
  final int? amount;
  @override
  final DuesCycle? cycle;
  @override
  final String? cycleDay;
  @override
  final String? sendTime;
  @override
  final int? dueDays;
  @override
  final String? bankName;
  @override
  final String? accountNumber;
  @override
  final String? accountHolder;
  @override
  final bool? isActive;
  @override
  final bool? postNotice;
  @override
  @JsonKey()
  final bool applyToCurrentSettlement;

  /// Create a copy of RegularDueUpdate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RegularDueUpdateCopyWith<_RegularDueUpdate> get copyWith =>
      __$RegularDueUpdateCopyWithImpl<_RegularDueUpdate>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegularDueUpdate &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.cycle, cycle) || other.cycle == cycle) &&
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

  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    amount,
    cycle,
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
    return 'RegularDueUpdate(title: $title, amount: $amount, cycle: $cycle, cycleDay: $cycleDay, sendTime: $sendTime, dueDays: $dueDays, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, isActive: $isActive, postNotice: $postNotice, applyToCurrentSettlement: $applyToCurrentSettlement)';
  }
}

/// @nodoc
abstract mixin class _$RegularDueUpdateCopyWith<$Res>
    implements $RegularDueUpdateCopyWith<$Res> {
  factory _$RegularDueUpdateCopyWith(
    _RegularDueUpdate value,
    $Res Function(_RegularDueUpdate) _then,
  ) = __$RegularDueUpdateCopyWithImpl;
  @override
  @useResult
  $Res call({
    String? title,
    int? amount,
    DuesCycle? cycle,
    String? cycleDay,
    String? sendTime,
    int? dueDays,
    String? bankName,
    String? accountNumber,
    String? accountHolder,
    bool? isActive,
    bool? postNotice,
    bool applyToCurrentSettlement,
  });
}

/// @nodoc
class __$RegularDueUpdateCopyWithImpl<$Res>
    implements _$RegularDueUpdateCopyWith<$Res> {
  __$RegularDueUpdateCopyWithImpl(this._self, this._then);

  final _RegularDueUpdate _self;
  final $Res Function(_RegularDueUpdate) _then;

  /// Create a copy of RegularDueUpdate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = freezed,
    Object? amount = freezed,
    Object? cycle = freezed,
    Object? cycleDay = freezed,
    Object? sendTime = freezed,
    Object? dueDays = freezed,
    Object? bankName = freezed,
    Object? accountNumber = freezed,
    Object? accountHolder = freezed,
    Object? isActive = freezed,
    Object? postNotice = freezed,
    Object? applyToCurrentSettlement = null,
  }) {
    return _then(
      _RegularDueUpdate(
        title: freezed == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        amount: freezed == amount
            ? _self.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int?,
        cycle: freezed == cycle
            ? _self.cycle
            : cycle // ignore: cast_nullable_to_non_nullable
                  as DuesCycle?,
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
        applyToCurrentSettlement: null == applyToCurrentSettlement
            ? _self.applyToCurrentSettlement
            : applyToCurrentSettlement // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}
