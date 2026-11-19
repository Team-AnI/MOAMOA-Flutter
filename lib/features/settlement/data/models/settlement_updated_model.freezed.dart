// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_updated_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementUpdatedModel {
  int get settlementId;

  /// Create a copy of SettlementUpdatedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettlementUpdatedModelCopyWith<SettlementUpdatedModel> get copyWith =>
      _$SettlementUpdatedModelCopyWithImpl<SettlementUpdatedModel>(
        this as SettlementUpdatedModel,
        _$identity,
      );

  /// Serializes this SettlementUpdatedModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettlementUpdatedModel &&
            (identical(other.settlementId, settlementId) ||
                other.settlementId == settlementId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, settlementId);

  @override
  String toString() {
    return 'SettlementUpdatedModel(settlementId: $settlementId)';
  }
}

/// @nodoc
abstract mixin class $SettlementUpdatedModelCopyWith<$Res> {
  factory $SettlementUpdatedModelCopyWith(
    SettlementUpdatedModel value,
    $Res Function(SettlementUpdatedModel) _then,
  ) = _$SettlementUpdatedModelCopyWithImpl;
  @useResult
  $Res call({int settlementId});
}

/// @nodoc
class _$SettlementUpdatedModelCopyWithImpl<$Res>
    implements $SettlementUpdatedModelCopyWith<$Res> {
  _$SettlementUpdatedModelCopyWithImpl(this._self, this._then);

  final SettlementUpdatedModel _self;
  final $Res Function(SettlementUpdatedModel) _then;

  /// Create a copy of SettlementUpdatedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? settlementId = null}) {
    return _then(
      SettlementUpdatedModel(
        settlementId: null == settlementId
            ? _self.settlementId
            : settlementId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [SettlementUpdatedModel].
extension SettlementUpdatedModelPatterns on SettlementUpdatedModel {
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
    TResult Function(_SettlementUpdatedModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementUpdatedModel() when $default != null:
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
    TResult Function(_SettlementUpdatedModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementUpdatedModel():
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
    TResult? Function(_SettlementUpdatedModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementUpdatedModel() when $default != null:
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
    TResult Function(int settlementId)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementUpdatedModel() when $default != null:
        return $default(_that.settlementId);
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
    TResult Function(int settlementId) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementUpdatedModel():
        return $default(_that.settlementId);
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
    TResult? Function(int settlementId)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementUpdatedModel() when $default != null:
        return $default(_that.settlementId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SettlementUpdatedModel implements SettlementUpdatedModel {
  const _SettlementUpdatedModel({required this.settlementId});
  factory _SettlementUpdatedModel.fromJson(Map<String, dynamic> json) =>
      _$SettlementUpdatedModelFromJson(json);

  @override
  final int settlementId;

  /// Create a copy of SettlementUpdatedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettlementUpdatedModelCopyWith<_SettlementUpdatedModel> get copyWith =>
      __$SettlementUpdatedModelCopyWithImpl<_SettlementUpdatedModel>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$SettlementUpdatedModelToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettlementUpdatedModel &&
            (identical(other.settlementId, settlementId) ||
                other.settlementId == settlementId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, settlementId);

  @override
  String toString() {
    return 'SettlementUpdatedModel(settlementId: $settlementId)';
  }
}

/// @nodoc
abstract mixin class _$SettlementUpdatedModelCopyWith<$Res>
    implements $SettlementUpdatedModelCopyWith<$Res> {
  factory _$SettlementUpdatedModelCopyWith(
    _SettlementUpdatedModel value,
    $Res Function(_SettlementUpdatedModel) _then,
  ) = __$SettlementUpdatedModelCopyWithImpl;
  @override
  @useResult
  $Res call({int settlementId});
}

/// @nodoc
class __$SettlementUpdatedModelCopyWithImpl<$Res>
    implements _$SettlementUpdatedModelCopyWith<$Res> {
  __$SettlementUpdatedModelCopyWithImpl(this._self, this._then);

  final _SettlementUpdatedModel _self;
  final $Res Function(_SettlementUpdatedModel) _then;

  /// Create a copy of SettlementUpdatedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? settlementId = null}) {
    return _then(
      _SettlementUpdatedModel(
        settlementId: null == settlementId
            ? _self.settlementId
            : settlementId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}
