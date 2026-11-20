// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementResponseModel<T> {
  bool get success;
  T? get data;

  /// Create a copy of SettlementResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettlementResponseModelCopyWith<T, SettlementResponseModel<T>>
  get copyWith =>
      _$SettlementResponseModelCopyWithImpl<T, SettlementResponseModel<T>>(
        this as SettlementResponseModel<T>,
        _$identity,
      );

  /// Serializes this SettlementResponseModel to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettlementResponseModel<T> &&
            (identical(other.success, success) || other.success == success) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    const DeepCollectionEquality().hash(data),
  );

  @override
  String toString() {
    return 'SettlementResponseModel<$T>(success: $success, data: $data)';
  }
}

/// @nodoc
abstract mixin class $SettlementResponseModelCopyWith<T, $Res> {
  factory $SettlementResponseModelCopyWith(
    SettlementResponseModel<T> value,
    $Res Function(SettlementResponseModel<T>) _then,
  ) = _$SettlementResponseModelCopyWithImpl;
  @useResult
  $Res call({bool success, T? data});
}

/// @nodoc
class _$SettlementResponseModelCopyWithImpl<T, $Res>
    implements $SettlementResponseModelCopyWith<T, $Res> {
  _$SettlementResponseModelCopyWithImpl(this._self, this._then);

  final SettlementResponseModel<T> _self;
  final $Res Function(SettlementResponseModel<T>) _then;

  /// Create a copy of SettlementResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? success = null, Object? data = freezed}) {
    return _then(
      SettlementResponseModel(
        success: null == success
            ? _self.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        data: freezed == data
            ? _self.data
            : data // ignore: cast_nullable_to_non_nullable
                  as T?,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [SettlementResponseModel].
extension SettlementResponseModelPatterns<T> on SettlementResponseModel<T> {
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
    TResult Function(_SettlementResponseModel<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementResponseModel() when $default != null:
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
    TResult Function(_SettlementResponseModel<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementResponseModel():
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
    TResult? Function(_SettlementResponseModel<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementResponseModel() when $default != null:
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
    TResult Function(bool success, T? data)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementResponseModel() when $default != null:
        return $default(_that.success, _that.data);
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
    TResult Function(bool success, T? data) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementResponseModel():
        return $default(_that.success, _that.data);
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
    TResult? Function(bool success, T? data)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementResponseModel() when $default != null:
        return $default(_that.success, _that.data);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _SettlementResponseModel<T> implements SettlementResponseModel<T> {
  const _SettlementResponseModel({required this.success, this.data});
  factory _SettlementResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$SettlementResponseModelFromJson(json, fromJsonT);

  @override
  final bool success;
  @override
  final T? data;

  /// Create a copy of SettlementResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettlementResponseModelCopyWith<T, _SettlementResponseModel<T>>
  get copyWith =>
      __$SettlementResponseModelCopyWithImpl<T, _SettlementResponseModel<T>>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$SettlementResponseModelToJson<T>(this, toJsonT);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettlementResponseModel<T> &&
            (identical(other.success, success) || other.success == success) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    const DeepCollectionEquality().hash(data),
  );

  @override
  String toString() {
    return 'SettlementResponseModel<$T>(success: $success, data: $data)';
  }
}

/// @nodoc
abstract mixin class _$SettlementResponseModelCopyWith<T, $Res>
    implements $SettlementResponseModelCopyWith<T, $Res> {
  factory _$SettlementResponseModelCopyWith(
    _SettlementResponseModel<T> value,
    $Res Function(_SettlementResponseModel<T>) _then,
  ) = __$SettlementResponseModelCopyWithImpl;
  @override
  @useResult
  $Res call({bool success, T? data});
}

/// @nodoc
class __$SettlementResponseModelCopyWithImpl<T, $Res>
    implements _$SettlementResponseModelCopyWith<T, $Res> {
  __$SettlementResponseModelCopyWithImpl(this._self, this._then);

  final _SettlementResponseModel<T> _self;
  final $Res Function(_SettlementResponseModel<T>) _then;

  /// Create a copy of SettlementResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? success = null, Object? data = freezed}) {
    return _then(
      _SettlementResponseModel<T>(
        success: null == success
            ? _self.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        data: freezed == data
            ? _self.data
            : data // ignore: cast_nullable_to_non_nullable
                  as T?,
      ),
    );
  }
}
