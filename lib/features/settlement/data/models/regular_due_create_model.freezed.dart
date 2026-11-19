// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'regular_due_create_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegularDueCreateModel {
  int get regularDuesId;

  /// Create a copy of RegularDueCreateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegularDueCreateModelCopyWith<RegularDueCreateModel> get copyWith =>
      _$RegularDueCreateModelCopyWithImpl<RegularDueCreateModel>(
        this as RegularDueCreateModel,
        _$identity,
      );

  /// Serializes this RegularDueCreateModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegularDueCreateModel &&
            (identical(other.regularDuesId, regularDuesId) ||
                other.regularDuesId == regularDuesId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, regularDuesId);

  @override
  String toString() {
    return 'RegularDueCreateModel(regularDuesId: $regularDuesId)';
  }
}

/// @nodoc
abstract mixin class $RegularDueCreateModelCopyWith<$Res> {
  factory $RegularDueCreateModelCopyWith(
    RegularDueCreateModel value,
    $Res Function(RegularDueCreateModel) _then,
  ) = _$RegularDueCreateModelCopyWithImpl;
  @useResult
  $Res call({int regularDuesId});
}

/// @nodoc
class _$RegularDueCreateModelCopyWithImpl<$Res>
    implements $RegularDueCreateModelCopyWith<$Res> {
  _$RegularDueCreateModelCopyWithImpl(this._self, this._then);

  final RegularDueCreateModel _self;
  final $Res Function(RegularDueCreateModel) _then;

  /// Create a copy of RegularDueCreateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? regularDuesId = null}) {
    return _then(
      RegularDueCreateModel(
        regularDuesId: null == regularDuesId
            ? _self.regularDuesId
            : regularDuesId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [RegularDueCreateModel].
extension RegularDueCreateModelPatterns on RegularDueCreateModel {
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
    TResult Function(_RegularDueCreateModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegularDueCreateModel() when $default != null:
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
    TResult Function(_RegularDueCreateModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueCreateModel():
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
    TResult? Function(_RegularDueCreateModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueCreateModel() when $default != null:
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
    TResult Function(int regularDuesId)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegularDueCreateModel() when $default != null:
        return $default(_that.regularDuesId);
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
    TResult Function(int regularDuesId) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueCreateModel():
        return $default(_that.regularDuesId);
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
    TResult? Function(int regularDuesId)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDueCreateModel() when $default != null:
        return $default(_that.regularDuesId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RegularDueCreateModel implements RegularDueCreateModel {
  const _RegularDueCreateModel({required this.regularDuesId});
  factory _RegularDueCreateModel.fromJson(Map<String, dynamic> json) =>
      _$RegularDueCreateModelFromJson(json);

  @override
  final int regularDuesId;

  /// Create a copy of RegularDueCreateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RegularDueCreateModelCopyWith<_RegularDueCreateModel> get copyWith =>
      __$RegularDueCreateModelCopyWithImpl<_RegularDueCreateModel>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$RegularDueCreateModelToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegularDueCreateModel &&
            (identical(other.regularDuesId, regularDuesId) ||
                other.regularDuesId == regularDuesId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, regularDuesId);

  @override
  String toString() {
    return 'RegularDueCreateModel(regularDuesId: $regularDuesId)';
  }
}

/// @nodoc
abstract mixin class _$RegularDueCreateModelCopyWith<$Res>
    implements $RegularDueCreateModelCopyWith<$Res> {
  factory _$RegularDueCreateModelCopyWith(
    _RegularDueCreateModel value,
    $Res Function(_RegularDueCreateModel) _then,
  ) = __$RegularDueCreateModelCopyWithImpl;
  @override
  @useResult
  $Res call({int regularDuesId});
}

/// @nodoc
class __$RegularDueCreateModelCopyWithImpl<$Res>
    implements _$RegularDueCreateModelCopyWith<$Res> {
  __$RegularDueCreateModelCopyWithImpl(this._self, this._then);

  final _RegularDueCreateModel _self;
  final $Res Function(_RegularDueCreateModel) _then;

  /// Create a copy of RegularDueCreateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? regularDuesId = null}) {
    return _then(
      _RegularDueCreateModel(
        regularDuesId: null == regularDuesId
            ? _self.regularDuesId
            : regularDuesId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}
