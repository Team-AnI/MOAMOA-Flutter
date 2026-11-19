// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'regular_due_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegularDueInput {
  String get title;
  int get amount;
  DuesCycle get cycle;
  String get cycleDay;
  String get sendTime;
  int get dueDays;
  String get bankName;
  String get accountNumber;
  String get accountHolder;
  bool get postNotice;
  bool get isActive;

  /// Create a copy of RegularDueInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegularDueInputCopyWith<RegularDueInput> get copyWith =>
      _$RegularDueInputCopyWithImpl<RegularDueInput>(
        this as RegularDueInput,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegularDueInput &&
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
            (identical(other.postNotice, postNotice) ||
                other.postNotice == postNotice) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
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
    postNotice,
    isActive,
  );

  @override
  String toString() {
    return 'RegularDueInput(title: $title, amount: $amount, cycle: $cycle, cycleDay: $cycleDay, sendTime: $sendTime, dueDays: $dueDays, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, postNotice: $postNotice, isActive: $isActive)';
  }
}

/// @nodoc
abstract mixin class $RegularDueInputCopyWith<$Res> {
  factory $RegularDueInputCopyWith(
    RegularDueInput value,
    $Res Function(RegularDueInput) _then,
  ) = _$RegularDueInputCopyWithImpl;
  @useResult
  $Res call({
    String title,
    int amount,
    DuesCycle cycle,
    String cycleDay,
    String sendTime,
    int dueDays,
    String bankName,
    String accountNumber,
    String accountHolder,
    bool postNotice,
    bool isActive,
  });
}

/// @nodoc
class _$RegularDueInputCopyWithImpl<$Res>
    implements $RegularDueInputCopyWith<$Res> {
  _$RegularDueInputCopyWithImpl(this._self, this._then);

  final RegularDueInput _self;
  final $Res Function(RegularDueInput) _then;

  /// Create a copy of RegularDueInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? amount = null,
    Object? cycle = null,
    Object? cycleDay = null,
    Object? sendTime = null,
    Object? dueDays = null,
    Object? bankName = null,
    Object? accountNumber = null,
    Object? accountHolder = null,
    Object? postNotice = null,
    Object? isActive = null,
  }) {
    return _then(
      RegularDueInput(
        title: null == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _self.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        cycle: null == cycle
            ? _self.cycle
            : cycle // ignore: cast_nullable_to_non_nullable
                  as DuesCycle,
        cycleDay: null == cycleDay
            ? _self.cycleDay
            : cycleDay // ignore: cast_nullable_to_non_nullable
                  as String,
        sendTime: null == sendTime
            ? _self.sendTime
            : sendTime // ignore: cast_nullable_to_non_nullable
                  as String,
        dueDays: null == dueDays
            ? _self.dueDays
            : dueDays // ignore: cast_nullable_to_non_nullable
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
        postNotice: null == postNotice
            ? _self.postNotice
            : postNotice // ignore: cast_nullable_to_non_nullable
                  as bool,
        isActive: null == isActive
            ? _self.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [RegularDueInput].
extension RegularDueInputPatterns on RegularDueInput {
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
    TResult Function(_RegularDueInput value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegularDueInput() when $default != null:
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
    TResult Function(_RegularDueInput value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueInput():
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
    TResult? Function(_RegularDueInput value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueInput() when $default != null:
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
      String title,
      int amount,
      DuesCycle cycle,
      String cycleDay,
      String sendTime,
      int dueDays,
      String bankName,
      String accountNumber,
      String accountHolder,
      bool postNotice,
      bool isActive,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegularDueInput() when $default != null:
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
          _that.postNotice,
          _that.isActive,
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
      String title,
      int amount,
      DuesCycle cycle,
      String cycleDay,
      String sendTime,
      int dueDays,
      String bankName,
      String accountNumber,
      String accountHolder,
      bool postNotice,
      bool isActive,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueInput():
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
          _that.postNotice,
          _that.isActive,
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
      String title,
      int amount,
      DuesCycle cycle,
      String cycleDay,
      String sendTime,
      int dueDays,
      String bankName,
      String accountNumber,
      String accountHolder,
      bool postNotice,
      bool isActive,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueInput() when $default != null:
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
          _that.postNotice,
          _that.isActive,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _RegularDueInput implements RegularDueInput {
  const _RegularDueInput({
    required this.title,
    required this.amount,
    required this.cycle,
    required this.cycleDay,
    required this.sendTime,
    required this.dueDays,
    required this.bankName,
    required this.accountNumber,
    required this.accountHolder,
    required this.postNotice,
    this.isActive = true,
  });

  @override
  final String title;
  @override
  final int amount;
  @override
  final DuesCycle cycle;
  @override
  final String cycleDay;
  @override
  final String sendTime;
  @override
  final int dueDays;
  @override
  final String bankName;
  @override
  final String accountNumber;
  @override
  final String accountHolder;
  @override
  final bool postNotice;
  @override
  @JsonKey()
  final bool isActive;

  /// Create a copy of RegularDueInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RegularDueInputCopyWith<_RegularDueInput> get copyWith =>
      __$RegularDueInputCopyWithImpl<_RegularDueInput>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegularDueInput &&
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
            (identical(other.postNotice, postNotice) ||
                other.postNotice == postNotice) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
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
    postNotice,
    isActive,
  );

  @override
  String toString() {
    return 'RegularDueInput(title: $title, amount: $amount, cycle: $cycle, cycleDay: $cycleDay, sendTime: $sendTime, dueDays: $dueDays, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, postNotice: $postNotice, isActive: $isActive)';
  }
}

/// @nodoc
abstract mixin class _$RegularDueInputCopyWith<$Res>
    implements $RegularDueInputCopyWith<$Res> {
  factory _$RegularDueInputCopyWith(
    _RegularDueInput value,
    $Res Function(_RegularDueInput) _then,
  ) = __$RegularDueInputCopyWithImpl;
  @override
  @useResult
  $Res call({
    String title,
    int amount,
    DuesCycle cycle,
    String cycleDay,
    String sendTime,
    int dueDays,
    String bankName,
    String accountNumber,
    String accountHolder,
    bool postNotice,
    bool isActive,
  });
}

/// @nodoc
class __$RegularDueInputCopyWithImpl<$Res>
    implements _$RegularDueInputCopyWith<$Res> {
  __$RegularDueInputCopyWithImpl(this._self, this._then);

  final _RegularDueInput _self;
  final $Res Function(_RegularDueInput) _then;

  /// Create a copy of RegularDueInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = null,
    Object? amount = null,
    Object? cycle = null,
    Object? cycleDay = null,
    Object? sendTime = null,
    Object? dueDays = null,
    Object? bankName = null,
    Object? accountNumber = null,
    Object? accountHolder = null,
    Object? postNotice = null,
    Object? isActive = null,
  }) {
    return _then(
      _RegularDueInput(
        title: null == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _self.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        cycle: null == cycle
            ? _self.cycle
            : cycle // ignore: cast_nullable_to_non_nullable
                  as DuesCycle,
        cycleDay: null == cycleDay
            ? _self.cycleDay
            : cycleDay // ignore: cast_nullable_to_non_nullable
                  as String,
        sendTime: null == sendTime
            ? _self.sendTime
            : sendTime // ignore: cast_nullable_to_non_nullable
                  as String,
        dueDays: null == dueDays
            ? _self.dueDays
            : dueDays // ignore: cast_nullable_to_non_nullable
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
        postNotice: null == postNotice
            ? _self.postNotice
            : postNotice // ignore: cast_nullable_to_non_nullable
                  as bool,
        isActive: null == isActive
            ? _self.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}
