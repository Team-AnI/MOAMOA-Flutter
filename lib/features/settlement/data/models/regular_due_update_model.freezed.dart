// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'regular_due_update_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegularDueUpdateModel {
  bool? get currentSettlementApplied;

  /// Create a copy of RegularDueUpdateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegularDueUpdateModelCopyWith<RegularDueUpdateModel> get copyWith =>
      _$RegularDueUpdateModelCopyWithImpl<RegularDueUpdateModel>(
        this as RegularDueUpdateModel,
        _$identity,
      );

  /// Serializes this RegularDueUpdateModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegularDueUpdateModel &&
            (identical(
                  other.currentSettlementApplied,
                  currentSettlementApplied,
                ) ||
                other.currentSettlementApplied == currentSettlementApplied));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, currentSettlementApplied);

  @override
  String toString() {
    return 'RegularDueUpdateModel(currentSettlementApplied: $currentSettlementApplied)';
  }
}

/// @nodoc
abstract mixin class $RegularDueUpdateModelCopyWith<$Res> {
  factory $RegularDueUpdateModelCopyWith(
    RegularDueUpdateModel value,
    $Res Function(RegularDueUpdateModel) _then,
  ) = _$RegularDueUpdateModelCopyWithImpl;
  @useResult
  $Res call({bool? currentSettlementApplied});
}

/// @nodoc
class _$RegularDueUpdateModelCopyWithImpl<$Res>
    implements $RegularDueUpdateModelCopyWith<$Res> {
  _$RegularDueUpdateModelCopyWithImpl(this._self, this._then);

  final RegularDueUpdateModel _self;
  final $Res Function(RegularDueUpdateModel) _then;

  /// Create a copy of RegularDueUpdateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? currentSettlementApplied = freezed}) {
    return _then(
      RegularDueUpdateModel(
        currentSettlementApplied: freezed == currentSettlementApplied
            ? _self.currentSettlementApplied
            : currentSettlementApplied // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [RegularDueUpdateModel].
extension RegularDueUpdateModelPatterns on RegularDueUpdateModel {
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
    TResult Function(_RegularDueUpdateModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegularDueUpdateModel() when $default != null:
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
    TResult Function(_RegularDueUpdateModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueUpdateModel():
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
    TResult? Function(_RegularDueUpdateModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueUpdateModel() when $default != null:
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
    TResult Function(bool? currentSettlementApplied)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegularDueUpdateModel() when $default != null:
        return $default(_that.currentSettlementApplied);
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
    TResult Function(bool? currentSettlementApplied) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueUpdateModel():
        return $default(_that.currentSettlementApplied);
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
    TResult? Function(bool? currentSettlementApplied)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueUpdateModel() when $default != null:
        return $default(_that.currentSettlementApplied);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RegularDueUpdateModel implements RegularDueUpdateModel {
  const _RegularDueUpdateModel({this.currentSettlementApplied});
  factory _RegularDueUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$RegularDueUpdateModelFromJson(json);

  @override
  final bool? currentSettlementApplied;

  /// Create a copy of RegularDueUpdateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RegularDueUpdateModelCopyWith<_RegularDueUpdateModel> get copyWith =>
      __$RegularDueUpdateModelCopyWithImpl<_RegularDueUpdateModel>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$RegularDueUpdateModelToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegularDueUpdateModel &&
            (identical(
                  other.currentSettlementApplied,
                  currentSettlementApplied,
                ) ||
                other.currentSettlementApplied == currentSettlementApplied));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, currentSettlementApplied);

  @override
  String toString() {
    return 'RegularDueUpdateModel(currentSettlementApplied: $currentSettlementApplied)';
  }
}

/// @nodoc
abstract mixin class _$RegularDueUpdateModelCopyWith<$Res>
    implements $RegularDueUpdateModelCopyWith<$Res> {
  factory _$RegularDueUpdateModelCopyWith(
    _RegularDueUpdateModel value,
    $Res Function(_RegularDueUpdateModel) _then,
  ) = __$RegularDueUpdateModelCopyWithImpl;
  @override
  @useResult
  $Res call({bool? currentSettlementApplied});
}

/// @nodoc
class __$RegularDueUpdateModelCopyWithImpl<$Res>
    implements _$RegularDueUpdateModelCopyWith<$Res> {
  __$RegularDueUpdateModelCopyWithImpl(this._self, this._then);

  final _RegularDueUpdateModel _self;
  final $Res Function(_RegularDueUpdateModel) _then;

  /// Create a copy of RegularDueUpdateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? currentSettlementApplied = freezed}) {
    return _then(
      _RegularDueUpdateModel(
        currentSettlementApplied: freezed == currentSettlementApplied
            ? _self.currentSettlementApplied
            : currentSettlementApplied // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}
