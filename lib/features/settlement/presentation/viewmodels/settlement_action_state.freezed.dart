// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_action_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementActionState {
  bool get isSubmitting;
  SettlementAction? get action;
  int? get settlementId;
  int? get createdSettlementId;
  ApiException? get failure;

  /// Create a copy of SettlementActionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettlementActionStateCopyWith<SettlementActionState> get copyWith =>
      _$SettlementActionStateCopyWithImpl<SettlementActionState>(
        this as SettlementActionState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettlementActionState &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.settlementId, settlementId) ||
                other.settlementId == settlementId) &&
            (identical(other.createdSettlementId, createdSettlementId) ||
                other.createdSettlementId == createdSettlementId) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isSubmitting,
    action,
    settlementId,
    createdSettlementId,
    failure,
  );

  @override
  String toString() {
    return 'SettlementActionState(isSubmitting: $isSubmitting, action: $action, settlementId: $settlementId, createdSettlementId: $createdSettlementId, failure: $failure)';
  }
}

/// @nodoc
abstract mixin class $SettlementActionStateCopyWith<$Res> {
  factory $SettlementActionStateCopyWith(
    SettlementActionState value,
    $Res Function(SettlementActionState) _then,
  ) = _$SettlementActionStateCopyWithImpl;
  @useResult
  $Res call({
    bool isSubmitting,
    SettlementAction? action,
    int? settlementId,
    int? createdSettlementId,
    ApiException? failure,
  });

  $ApiExceptionCopyWith<$Res>? get failure;
}

/// @nodoc
class _$SettlementActionStateCopyWithImpl<$Res>
    implements $SettlementActionStateCopyWith<$Res> {
  _$SettlementActionStateCopyWithImpl(this._self, this._then);

  final SettlementActionState _self;
  final $Res Function(SettlementActionState) _then;

  /// Create a copy of SettlementActionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSubmitting = null,
    Object? action = freezed,
    Object? settlementId = freezed,
    Object? createdSettlementId = freezed,
    Object? failure = freezed,
  }) {
    return _then(
      SettlementActionState(
        isSubmitting: null == isSubmitting
            ? _self.isSubmitting
            : isSubmitting // ignore: cast_nullable_to_non_nullable
                  as bool,
        action: freezed == action
            ? _self.action
            : action // ignore: cast_nullable_to_non_nullable
                  as SettlementAction?,
        settlementId: freezed == settlementId
            ? _self.settlementId
            : settlementId // ignore: cast_nullable_to_non_nullable
                  as int?,
        createdSettlementId: freezed == createdSettlementId
            ? _self.createdSettlementId
            : createdSettlementId // ignore: cast_nullable_to_non_nullable
                  as int?,
        failure: freezed == failure
            ? _self.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as ApiException?,
      ),
    );
  }

  /// Create a copy of SettlementActionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiExceptionCopyWith<$Res>? get failure {
    if (_self.failure == null) {
      return null;
    }

    return $ApiExceptionCopyWith<$Res>(_self.failure!, (value) {
      return _then(_self.copyWith(failure: value));
    });
  }
}

/// Adds pattern-matching-related methods to [SettlementActionState].
extension SettlementActionStatePatterns on SettlementActionState {
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
    TResult Function(_SettlementActionState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementActionState() when $default != null:
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
    TResult Function(_SettlementActionState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementActionState():
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
    TResult? Function(_SettlementActionState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementActionState() when $default != null:
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
      bool isSubmitting,
      SettlementAction? action,
      int? settlementId,
      int? createdSettlementId,
      ApiException? failure,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementActionState() when $default != null:
        return $default(
          _that.isSubmitting,
          _that.action,
          _that.settlementId,
          _that.createdSettlementId,
          _that.failure,
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
      bool isSubmitting,
      SettlementAction? action,
      int? settlementId,
      int? createdSettlementId,
      ApiException? failure,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementActionState():
        return $default(
          _that.isSubmitting,
          _that.action,
          _that.settlementId,
          _that.createdSettlementId,
          _that.failure,
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
      bool isSubmitting,
      SettlementAction? action,
      int? settlementId,
      int? createdSettlementId,
      ApiException? failure,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementActionState() when $default != null:
        return $default(
          _that.isSubmitting,
          _that.action,
          _that.settlementId,
          _that.createdSettlementId,
          _that.failure,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SettlementActionState implements SettlementActionState {
  const _SettlementActionState({
    this.isSubmitting = false,
    this.action,
    this.settlementId,
    this.createdSettlementId,
    this.failure,
  });

  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  final SettlementAction? action;
  @override
  final int? settlementId;
  @override
  final int? createdSettlementId;
  @override
  final ApiException? failure;

  /// Create a copy of SettlementActionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettlementActionStateCopyWith<_SettlementActionState> get copyWith =>
      __$SettlementActionStateCopyWithImpl<_SettlementActionState>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettlementActionState &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.settlementId, settlementId) ||
                other.settlementId == settlementId) &&
            (identical(other.createdSettlementId, createdSettlementId) ||
                other.createdSettlementId == createdSettlementId) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isSubmitting,
    action,
    settlementId,
    createdSettlementId,
    failure,
  );

  @override
  String toString() {
    return 'SettlementActionState(isSubmitting: $isSubmitting, action: $action, settlementId: $settlementId, createdSettlementId: $createdSettlementId, failure: $failure)';
  }
}

/// @nodoc
abstract mixin class _$SettlementActionStateCopyWith<$Res>
    implements $SettlementActionStateCopyWith<$Res> {
  factory _$SettlementActionStateCopyWith(
    _SettlementActionState value,
    $Res Function(_SettlementActionState) _then,
  ) = __$SettlementActionStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    bool isSubmitting,
    SettlementAction? action,
    int? settlementId,
    int? createdSettlementId,
    ApiException? failure,
  });

  @override
  $ApiExceptionCopyWith<$Res>? get failure;
}

/// @nodoc
class __$SettlementActionStateCopyWithImpl<$Res>
    implements _$SettlementActionStateCopyWith<$Res> {
  __$SettlementActionStateCopyWithImpl(this._self, this._then);

  final _SettlementActionState _self;
  final $Res Function(_SettlementActionState) _then;

  /// Create a copy of SettlementActionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isSubmitting = null,
    Object? action = freezed,
    Object? settlementId = freezed,
    Object? createdSettlementId = freezed,
    Object? failure = freezed,
  }) {
    return _then(
      _SettlementActionState(
        isSubmitting: null == isSubmitting
            ? _self.isSubmitting
            : isSubmitting // ignore: cast_nullable_to_non_nullable
                  as bool,
        action: freezed == action
            ? _self.action
            : action // ignore: cast_nullable_to_non_nullable
                  as SettlementAction?,
        settlementId: freezed == settlementId
            ? _self.settlementId
            : settlementId // ignore: cast_nullable_to_non_nullable
                  as int?,
        createdSettlementId: freezed == createdSettlementId
            ? _self.createdSettlementId
            : createdSettlementId // ignore: cast_nullable_to_non_nullable
                  as int?,
        failure: freezed == failure
            ? _self.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as ApiException?,
      ),
    );
  }

  /// Create a copy of SettlementActionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ApiExceptionCopyWith<$Res>? get failure {
    if (_self.failure == null) {
      return null;
    }

    return $ApiExceptionCopyWith<$Res>(_self.failure!, (value) {
      return _then(_self.copyWith(failure: value));
    });
  }
}
