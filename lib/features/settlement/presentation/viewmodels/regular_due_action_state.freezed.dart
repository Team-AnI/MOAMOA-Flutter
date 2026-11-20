// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'regular_due_action_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegularDueActionState {
  bool get isSubmitting;
  RegularDueAction? get action;
  CurrentSettlementApplication get application;
  ApiException? get failure;

  /// Create a copy of RegularDueActionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegularDueActionStateCopyWith<RegularDueActionState> get copyWith =>
      _$RegularDueActionStateCopyWithImpl<RegularDueActionState>(
        this as RegularDueActionState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegularDueActionState &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.application, application) ||
                other.application == application) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isSubmitting, action, application, failure);

  @override
  String toString() {
    return 'RegularDueActionState(isSubmitting: $isSubmitting, action: $action, application: $application, failure: $failure)';
  }
}

/// @nodoc
abstract mixin class $RegularDueActionStateCopyWith<$Res> {
  factory $RegularDueActionStateCopyWith(
    RegularDueActionState value,
    $Res Function(RegularDueActionState) _then,
  ) = _$RegularDueActionStateCopyWithImpl;
  @useResult
  $Res call({
    bool isSubmitting,
    RegularDueAction? action,
    CurrentSettlementApplication application,
    ApiException? failure,
  });

  $ApiExceptionCopyWith<$Res>? get failure;
}

/// @nodoc
class _$RegularDueActionStateCopyWithImpl<$Res>
    implements $RegularDueActionStateCopyWith<$Res> {
  _$RegularDueActionStateCopyWithImpl(this._self, this._then);

  final RegularDueActionState _self;
  final $Res Function(RegularDueActionState) _then;

  /// Create a copy of RegularDueActionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSubmitting = null,
    Object? action = freezed,
    Object? application = null,
    Object? failure = freezed,
  }) {
    return _then(
      RegularDueActionState(
        isSubmitting: null == isSubmitting
            ? _self.isSubmitting
            : isSubmitting // ignore: cast_nullable_to_non_nullable
                  as bool,
        action: freezed == action
            ? _self.action
            : action // ignore: cast_nullable_to_non_nullable
                  as RegularDueAction?,
        application: null == application
            ? _self.application
            : application // ignore: cast_nullable_to_non_nullable
                  as CurrentSettlementApplication,
        failure: freezed == failure
            ? _self.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as ApiException?,
      ),
    );
  }

  /// Create a copy of RegularDueActionState
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

/// Adds pattern-matching-related methods to [RegularDueActionState].
extension RegularDueActionStatePatterns on RegularDueActionState {
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
    TResult Function(_RegularDueActionState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegularDueActionState() when $default != null:
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
    TResult Function(_RegularDueActionState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueActionState():
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
    TResult? Function(_RegularDueActionState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueActionState() when $default != null:
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
      RegularDueAction? action,
      CurrentSettlementApplication application,
      ApiException? failure,
    )?
    $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegularDueActionState() when $default != null:
        return $default(
          _that.isSubmitting,
          _that.action,
          _that.application,
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
      RegularDueAction? action,
      CurrentSettlementApplication application,
      ApiException? failure,
    )
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueActionState():
        return $default(
          _that.isSubmitting,
          _that.action,
          _that.application,
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
      RegularDueAction? action,
      CurrentSettlementApplication application,
      ApiException? failure,
    )?
    $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueActionState() when $default != null:
        return $default(
          _that.isSubmitting,
          _that.action,
          _that.application,
          _that.failure,
        );
      case _:
        return null;
    }
  }
}

/// @nodoc

class _RegularDueActionState implements RegularDueActionState {
  const _RegularDueActionState({
    this.isSubmitting = false,
    this.action,
    this.application = CurrentSettlementApplication.notRequested,
    this.failure,
  });

  @override
  @JsonKey()
  final bool isSubmitting;
  @override
  final RegularDueAction? action;
  @override
  @JsonKey()
  final CurrentSettlementApplication application;
  @override
  final ApiException? failure;

  /// Create a copy of RegularDueActionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RegularDueActionStateCopyWith<_RegularDueActionState> get copyWith =>
      __$RegularDueActionStateCopyWithImpl<_RegularDueActionState>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegularDueActionState &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.application, application) ||
                other.application == application) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isSubmitting, action, application, failure);

  @override
  String toString() {
    return 'RegularDueActionState(isSubmitting: $isSubmitting, action: $action, application: $application, failure: $failure)';
  }
}

/// @nodoc
abstract mixin class _$RegularDueActionStateCopyWith<$Res>
    implements $RegularDueActionStateCopyWith<$Res> {
  factory _$RegularDueActionStateCopyWith(
    _RegularDueActionState value,
    $Res Function(_RegularDueActionState) _then,
  ) = __$RegularDueActionStateCopyWithImpl;
  @override
  @useResult
  $Res call({
    bool isSubmitting,
    RegularDueAction? action,
    CurrentSettlementApplication application,
    ApiException? failure,
  });

  @override
  $ApiExceptionCopyWith<$Res>? get failure;
}

/// @nodoc
class __$RegularDueActionStateCopyWithImpl<$Res>
    implements _$RegularDueActionStateCopyWith<$Res> {
  __$RegularDueActionStateCopyWithImpl(this._self, this._then);

  final _RegularDueActionState _self;
  final $Res Function(_RegularDueActionState) _then;

  /// Create a copy of RegularDueActionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isSubmitting = null,
    Object? action = freezed,
    Object? application = null,
    Object? failure = freezed,
  }) {
    return _then(
      _RegularDueActionState(
        isSubmitting: null == isSubmitting
            ? _self.isSubmitting
            : isSubmitting // ignore: cast_nullable_to_non_nullable
                  as bool,
        action: freezed == action
            ? _self.action
            : action // ignore: cast_nullable_to_non_nullable
                  as RegularDueAction?,
        application: null == application
            ? _self.application
            : application // ignore: cast_nullable_to_non_nullable
                  as CurrentSettlementApplication,
        failure: freezed == failure
            ? _self.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as ApiException?,
      ),
    );
  }

  /// Create a copy of RegularDueActionState
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
