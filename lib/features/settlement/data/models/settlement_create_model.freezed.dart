// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_create_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementCreateModel {
  int get settlementId;

  /// Create a copy of SettlementCreateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettlementCreateModelCopyWith<SettlementCreateModel> get copyWith =>
      _$SettlementCreateModelCopyWithImpl<SettlementCreateModel>(
        this as SettlementCreateModel,
        _$identity,
      );

  /// Serializes this SettlementCreateModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettlementCreateModel &&
            (identical(other.settlementId, settlementId) ||
                other.settlementId == settlementId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, settlementId);

  @override
  String toString() {
    return 'SettlementCreateModel(settlementId: $settlementId)';
  }
}

/// @nodoc
abstract mixin class $SettlementCreateModelCopyWith<$Res> {
  factory $SettlementCreateModelCopyWith(
    SettlementCreateModel value,
    $Res Function(SettlementCreateModel) _then,
  ) = _$SettlementCreateModelCopyWithImpl;
  @useResult
  $Res call({int settlementId});
}

/// @nodoc
class _$SettlementCreateModelCopyWithImpl<$Res>
    implements $SettlementCreateModelCopyWith<$Res> {
  _$SettlementCreateModelCopyWithImpl(this._self, this._then);

  final SettlementCreateModel _self;
  final $Res Function(SettlementCreateModel) _then;

  /// Create a copy of SettlementCreateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? settlementId = null}) {
    return _then(
      SettlementCreateModel(
        settlementId: null == settlementId
            ? _self.settlementId
            : settlementId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [SettlementCreateModel].
extension SettlementCreateModelPatterns on SettlementCreateModel {
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
    TResult Function(_SettlementCreateModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementCreateModel() when $default != null:
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
    TResult Function(_SettlementCreateModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementCreateModel():
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
    TResult? Function(_SettlementCreateModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementCreateModel() when $default != null:
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
      case _SettlementCreateModel() when $default != null:
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
      case _SettlementCreateModel():
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
      case _SettlementCreateModel() when $default != null:
        return $default(_that.settlementId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SettlementCreateModel implements SettlementCreateModel {
  const _SettlementCreateModel({required this.settlementId});
  factory _SettlementCreateModel.fromJson(Map<String, dynamic> json) =>
      _$SettlementCreateModelFromJson(json);

  @override
  final int settlementId;

  /// Create a copy of SettlementCreateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettlementCreateModelCopyWith<_SettlementCreateModel> get copyWith =>
      __$SettlementCreateModelCopyWithImpl<_SettlementCreateModel>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$SettlementCreateModelToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettlementCreateModel &&
            (identical(other.settlementId, settlementId) ||
                other.settlementId == settlementId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, settlementId);

  @override
  String toString() {
    return 'SettlementCreateModel(settlementId: $settlementId)';
  }
}

/// @nodoc
abstract mixin class _$SettlementCreateModelCopyWith<$Res>
    implements $SettlementCreateModelCopyWith<$Res> {
  factory _$SettlementCreateModelCopyWith(
    _SettlementCreateModel value,
    $Res Function(_SettlementCreateModel) _then,
  ) = __$SettlementCreateModelCopyWithImpl;
  @override
  @useResult
  $Res call({int settlementId});
}

/// @nodoc
class __$SettlementCreateModelCopyWithImpl<$Res>
    implements _$SettlementCreateModelCopyWith<$Res> {
  __$SettlementCreateModelCopyWithImpl(this._self, this._then);

  final _SettlementCreateModel _self;
  final $Res Function(_SettlementCreateModel) _then;

  /// Create a copy of SettlementCreateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? settlementId = null}) {
    return _then(
      _SettlementCreateModel(
        settlementId: null == settlementId
            ? _self.settlementId
            : settlementId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}
