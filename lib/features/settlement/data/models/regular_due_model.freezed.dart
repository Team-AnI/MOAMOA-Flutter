// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'regular_due_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegularDueModel {
  int get regularDuesId;
  String get title;
  int get amount;
  String get cycleType;
  String get cycleDay;
  String get sendTime;
  int get dueDays;
  String get bankName;
  String get accountNumber;
  String get accountHolder;
  bool get isActive;
  bool get postNotice;

  /// Create a copy of RegularDueModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegularDueModelCopyWith<RegularDueModel> get copyWith =>
      _$RegularDueModelCopyWithImpl<RegularDueModel>(
        this as RegularDueModel,
        _$identity,
      );

  /// Serializes this RegularDueModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegularDueModel &&
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
                other.postNotice == postNotice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
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
  );

  @override
  String toString() {
    return 'RegularDueModel(regularDuesId: $regularDuesId, title: $title, amount: $amount, cycleType: $cycleType, cycleDay: $cycleDay, sendTime: $sendTime, dueDays: $dueDays, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, isActive: $isActive, postNotice: $postNotice)';
  }
}

/// @nodoc
abstract mixin class $RegularDueModelCopyWith<$Res> {
  factory $RegularDueModelCopyWith(
    RegularDueModel value,
    $Res Function(RegularDueModel) _then,
  ) = _$RegularDueModelCopyWithImpl;
  @useResult
  $Res call({
    int regularDuesId,
    String title,
    int amount,
    String cycleType,
    String cycleDay,
    String sendTime,
    int dueDays,
    String bankName,
    String accountNumber,
    String accountHolder,
    bool isActive,
    bool postNotice,
  });
}

/// @nodoc
class _$RegularDueModelCopyWithImpl<$Res>
    implements $RegularDueModelCopyWith<$Res> {
  _$RegularDueModelCopyWithImpl(this._self, this._then);

  final RegularDueModel _self;
  final $Res Function(RegularDueModel) _then;

  /// Create a copy of RegularDueModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regularDuesId = null,
    Object? title = null,
    Object? amount = null,
    Object? cycleType = null,
    Object? cycleDay = null,
    Object? sendTime = null,
    Object? dueDays = null,
    Object? bankName = null,
    Object? accountNumber = null,
    Object? accountHolder = null,
    Object? isActive = null,
    Object? postNotice = null,
  }) {
    return _then(
      RegularDueModel(
        regularDuesId: null == regularDuesId
            ? _self.regularDuesId
            : regularDuesId // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _self.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        cycleType: null == cycleType
            ? _self.cycleType
            : cycleType // ignore: cast_nullable_to_non_nullable
                  as String,
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
        isActive: null == isActive
            ? _self.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        postNotice: null == postNotice
            ? _self.postNotice
            : postNotice // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [RegularDueModel].
extension RegularDueModelPatterns on RegularDueModel {
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
    TResult Function(_RegularDueModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegularDueModel() when $default != null:
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
    TResult Function(_RegularDueModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueModel():
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
    TResult? Function(_RegularDueModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueModel() when $default != null:
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
      int regularDuesId,
      String title,
      int amount,
      String cycleType,
      String cycleDay,
      String sendTime,
      int dueDays,
      String bankName,
      String accountNumber,
      String accountHolder,
      bool isActive,
      bool postNotice,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegularDueModel() when $default != null:
        return $default(
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
      int regularDuesId,
      String title,
      int amount,
      String cycleType,
      String cycleDay,
      String sendTime,
      int dueDays,
      String bankName,
      String accountNumber,
      String accountHolder,
      bool isActive,
      bool postNotice,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueModel():
        return $default(
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
      int regularDuesId,
      String title,
      int amount,
      String cycleType,
      String cycleDay,
      String sendTime,
      int dueDays,
      String bankName,
      String accountNumber,
      String accountHolder,
      bool isActive,
      bool postNotice,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueModel() when $default != null:
        return $default(
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
        );
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RegularDueModel implements RegularDueModel {
  const _RegularDueModel({
    required this.regularDuesId,
    required this.title,
    required this.amount,
    required this.cycleType,
    required this.cycleDay,
    required this.sendTime,
    required this.dueDays,
    required this.bankName,
    required this.accountNumber,
    required this.accountHolder,
    required this.isActive,
    required this.postNotice,
  });
  factory _RegularDueModel.fromJson(Map<String, dynamic> json) =>
      _$RegularDueModelFromJson(json);

  @override
  final int regularDuesId;
  @override
  final String title;
  @override
  final int amount;
  @override
  final String cycleType;
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
  final bool isActive;
  @override
  final bool postNotice;

  /// Create a copy of RegularDueModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RegularDueModelCopyWith<_RegularDueModel> get copyWith =>
      __$RegularDueModelCopyWithImpl<_RegularDueModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RegularDueModelToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegularDueModel &&
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
                other.postNotice == postNotice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
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
  );

  @override
  String toString() {
    return 'RegularDueModel(regularDuesId: $regularDuesId, title: $title, amount: $amount, cycleType: $cycleType, cycleDay: $cycleDay, sendTime: $sendTime, dueDays: $dueDays, bankName: $bankName, accountNumber: $accountNumber, accountHolder: $accountHolder, isActive: $isActive, postNotice: $postNotice)';
  }
}

/// @nodoc
abstract mixin class _$RegularDueModelCopyWith<$Res>
    implements $RegularDueModelCopyWith<$Res> {
  factory _$RegularDueModelCopyWith(
    _RegularDueModel value,
    $Res Function(_RegularDueModel) _then,
  ) = __$RegularDueModelCopyWithImpl;
  @override
  @useResult
  $Res call({
    int regularDuesId,
    String title,
    int amount,
    String cycleType,
    String cycleDay,
    String sendTime,
    int dueDays,
    String bankName,
    String accountNumber,
    String accountHolder,
    bool isActive,
    bool postNotice,
  });
}

/// @nodoc
class __$RegularDueModelCopyWithImpl<$Res>
    implements _$RegularDueModelCopyWith<$Res> {
  __$RegularDueModelCopyWithImpl(this._self, this._then);

  final _RegularDueModel _self;
  final $Res Function(_RegularDueModel) _then;

  /// Create a copy of RegularDueModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? regularDuesId = null,
    Object? title = null,
    Object? amount = null,
    Object? cycleType = null,
    Object? cycleDay = null,
    Object? sendTime = null,
    Object? dueDays = null,
    Object? bankName = null,
    Object? accountNumber = null,
    Object? accountHolder = null,
    Object? isActive = null,
    Object? postNotice = null,
  }) {
    return _then(
      _RegularDueModel(
        regularDuesId: null == regularDuesId
            ? _self.regularDuesId
            : regularDuesId // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _self.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _self.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        cycleType: null == cycleType
            ? _self.cycleType
            : cycleType // ignore: cast_nullable_to_non_nullable
                  as String,
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
        isActive: null == isActive
            ? _self.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        postNotice: null == postNotice
            ? _self.postNotice
            : postNotice // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}
