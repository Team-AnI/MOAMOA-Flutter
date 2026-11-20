// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_canceled_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementCanceledModel {
  int get settlementId;
  String get status;

  /// Create a copy of SettlementCanceledModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettlementCanceledModelCopyWith<SettlementCanceledModel> get copyWith =>
      _$SettlementCanceledModelCopyWithImpl<SettlementCanceledModel>(
        this as SettlementCanceledModel,
        _$identity,
      );

  /// Serializes this SettlementCanceledModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettlementCanceledModel &&
            (identical(other.settlementId, settlementId) ||
                other.settlementId == settlementId) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, settlementId, status);

  @override
  String toString() {
    return 'SettlementCanceledModel(settlementId: $settlementId, status: $status)';
  }
}

/// @nodoc
abstract mixin class $SettlementCanceledModelCopyWith<$Res> {
  factory $SettlementCanceledModelCopyWith(
    SettlementCanceledModel value,
    $Res Function(SettlementCanceledModel) _then,
  ) = _$SettlementCanceledModelCopyWithImpl;
  @useResult
  $Res call({int settlementId, String status});
}

/// @nodoc
class _$SettlementCanceledModelCopyWithImpl<$Res>
    implements $SettlementCanceledModelCopyWith<$Res> {
  _$SettlementCanceledModelCopyWithImpl(this._self, this._then);

  final SettlementCanceledModel _self;
  final $Res Function(SettlementCanceledModel) _then;

  /// Create a copy of SettlementCanceledModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? settlementId = null, Object? status = null}) {
    return _then(
      SettlementCanceledModel(
        settlementId: null == settlementId
            ? _self.settlementId
            : settlementId // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [SettlementCanceledModel].
extension SettlementCanceledModelPatterns on SettlementCanceledModel {
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
    TResult Function(_SettlementCanceledModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementCanceledModel() when $default != null:
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
    TResult Function(_SettlementCanceledModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementCanceledModel():
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
    TResult? Function(_SettlementCanceledModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementCanceledModel() when $default != null:
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
    TResult Function(int settlementId, String status)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementCanceledModel() when $default != null:
        return $default(_that.settlementId, _that.status);
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
    TResult Function(int settlementId, String status) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementCanceledModel():
        return $default(_that.settlementId, _that.status);
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
    TResult? Function(int settlementId, String status)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementCanceledModel() when $default != null:
        return $default(_that.settlementId, _that.status);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SettlementCanceledModel implements SettlementCanceledModel {
  const _SettlementCanceledModel({
    required this.settlementId,
    required this.status,
  });
  factory _SettlementCanceledModel.fromJson(Map<String, dynamic> json) =>
      _$SettlementCanceledModelFromJson(json);

  @override
  final int settlementId;
  @override
  final String status;

  /// Create a copy of SettlementCanceledModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettlementCanceledModelCopyWith<_SettlementCanceledModel> get copyWith =>
      __$SettlementCanceledModelCopyWithImpl<_SettlementCanceledModel>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$SettlementCanceledModelToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettlementCanceledModel &&
            (identical(other.settlementId, settlementId) ||
                other.settlementId == settlementId) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, settlementId, status);

  @override
  String toString() {
    return 'SettlementCanceledModel(settlementId: $settlementId, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$SettlementCanceledModelCopyWith<$Res>
    implements $SettlementCanceledModelCopyWith<$Res> {
  factory _$SettlementCanceledModelCopyWith(
    _SettlementCanceledModel value,
    $Res Function(_SettlementCanceledModel) _then,
  ) = __$SettlementCanceledModelCopyWithImpl;
  @override
  @useResult
  $Res call({int settlementId, String status});
}

/// @nodoc
class __$SettlementCanceledModelCopyWithImpl<$Res>
    implements _$SettlementCanceledModelCopyWith<$Res> {
  __$SettlementCanceledModelCopyWithImpl(this._self, this._then);

  final _SettlementCanceledModel _self;
  final $Res Function(_SettlementCanceledModel) _then;

  /// Create a copy of SettlementCanceledModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? settlementId = null, Object? status = null}) {
    return _then(
      _SettlementCanceledModel(
        settlementId: null == settlementId
            ? _self.settlementId
            : settlementId // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}
