// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementListModel {
  List<SettlementModel> get settlements;

  /// Create a copy of SettlementListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettlementListModelCopyWith<SettlementListModel> get copyWith =>
      _$SettlementListModelCopyWithImpl<SettlementListModel>(
        this as SettlementListModel,
        _$identity,
      );

  /// Serializes this SettlementListModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettlementListModel &&
            const DeepCollectionEquality().equals(
              other.settlements,
              settlements,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(settlements),
  );

  @override
  String toString() {
    return 'SettlementListModel(settlements: $settlements)';
  }
}

/// @nodoc
abstract mixin class $SettlementListModelCopyWith<$Res> {
  factory $SettlementListModelCopyWith(
    SettlementListModel value,
    $Res Function(SettlementListModel) _then,
  ) = _$SettlementListModelCopyWithImpl;
  @useResult
  $Res call({List<SettlementModel> settlements});
}

/// @nodoc
class _$SettlementListModelCopyWithImpl<$Res>
    implements $SettlementListModelCopyWith<$Res> {
  _$SettlementListModelCopyWithImpl(this._self, this._then);

  final SettlementListModel _self;
  final $Res Function(SettlementListModel) _then;

  /// Create a copy of SettlementListModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? settlements = null}) {
    return _then(
      SettlementListModel(
        settlements: null == settlements
            ? _self.settlements
            : settlements // ignore: cast_nullable_to_non_nullable
                  as List<SettlementModel>,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [SettlementListModel].
extension SettlementListModelPatterns on SettlementListModel {
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
    TResult Function(_SettlementListModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementListModel() when $default != null:
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
    TResult Function(_SettlementListModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementListModel():
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
    TResult? Function(_SettlementListModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementListModel() when $default != null:
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
    TResult Function(List<SettlementModel> settlements)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementListModel() when $default != null:
        return $default(_that.settlements);
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
    TResult Function(List<SettlementModel> settlements) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementListModel():
        return $default(_that.settlements);
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
    TResult? Function(List<SettlementModel> settlements)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementListModel() when $default != null:
        return $default(_that.settlements);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SettlementListModel implements SettlementListModel {
  const _SettlementListModel({required List<SettlementModel> settlements})
    : _settlements = settlements;
  factory _SettlementListModel.fromJson(Map<String, dynamic> json) =>
      _$SettlementListModelFromJson(json);

  final List<SettlementModel> _settlements;
  @override
  List<SettlementModel> get settlements {
    if (_settlements is EqualUnmodifiableListView) return _settlements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_settlements);
  }

  /// Create a copy of SettlementListModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettlementListModelCopyWith<_SettlementListModel> get copyWith =>
      __$SettlementListModelCopyWithImpl<_SettlementListModel>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$SettlementListModelToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettlementListModel &&
            const DeepCollectionEquality().equals(
              other._settlements,
              _settlements,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_settlements),
  );

  @override
  String toString() {
    return 'SettlementListModel(settlements: $settlements)';
  }
}

/// @nodoc
abstract mixin class _$SettlementListModelCopyWith<$Res>
    implements $SettlementListModelCopyWith<$Res> {
  factory _$SettlementListModelCopyWith(
    _SettlementListModel value,
    $Res Function(_SettlementListModel) _then,
  ) = __$SettlementListModelCopyWithImpl;
  @override
  @useResult
  $Res call({List<SettlementModel> settlements});
}

/// @nodoc
class __$SettlementListModelCopyWithImpl<$Res>
    implements _$SettlementListModelCopyWith<$Res> {
  __$SettlementListModelCopyWithImpl(this._self, this._then);

  final _SettlementListModel _self;
  final $Res Function(_SettlementListModel) _then;

  /// Create a copy of SettlementListModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? settlements = null}) {
    return _then(
      _SettlementListModel(
        settlements: null == settlements
            ? _self._settlements
            : settlements // ignore: cast_nullable_to_non_nullable
                  as List<SettlementModel>,
      ),
    );
  }
}
