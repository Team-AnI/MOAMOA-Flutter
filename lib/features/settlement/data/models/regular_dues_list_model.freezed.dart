// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'regular_dues_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegularDuesListModel {
  List<RegularDueModel> get regularDues;

  /// Create a copy of RegularDuesListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegularDuesListModelCopyWith<RegularDuesListModel> get copyWith =>
      _$RegularDuesListModelCopyWithImpl<RegularDuesListModel>(
        this as RegularDuesListModel,
        _$identity,
      );

  /// Serializes this RegularDuesListModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegularDuesListModel &&
            const DeepCollectionEquality().equals(
              other.regularDues,
              regularDues,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(regularDues),
  );

  @override
  String toString() {
    return 'RegularDuesListModel(regularDues: $regularDues)';
  }
}

/// @nodoc
abstract mixin class $RegularDuesListModelCopyWith<$Res> {
  factory $RegularDuesListModelCopyWith(
    RegularDuesListModel value,
    $Res Function(RegularDuesListModel) _then,
  ) = _$RegularDuesListModelCopyWithImpl;
  @useResult
  $Res call({List<RegularDueModel> regularDues});
}

/// @nodoc
class _$RegularDuesListModelCopyWithImpl<$Res>
    implements $RegularDuesListModelCopyWith<$Res> {
  _$RegularDuesListModelCopyWithImpl(this._self, this._then);

  final RegularDuesListModel _self;
  final $Res Function(RegularDuesListModel) _then;

  /// Create a copy of RegularDuesListModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? regularDues = null}) {
    return _then(
      RegularDuesListModel(
        regularDues: null == regularDues
            ? _self.regularDues
            : regularDues // ignore: cast_nullable_to_non_nullable
                  as List<RegularDueModel>,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [RegularDuesListModel].
extension RegularDuesListModelPatterns on RegularDuesListModel {
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
    TResult Function(_RegularDuesListModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegularDuesListModel() when $default != null:
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
    TResult Function(_RegularDuesListModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDuesListModel():
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
    TResult? Function(_RegularDuesListModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDuesListModel() when $default != null:
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
    TResult Function(List<RegularDueModel> regularDues)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RegularDuesListModel() when $default != null:
        return $default(_that.regularDues);
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
    TResult Function(List<RegularDueModel> regularDues) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDuesListModel():
        return $default(_that.regularDues);
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
    TResult? Function(List<RegularDueModel> regularDues)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RegularDuesListModel() when $default != null:
        return $default(_that.regularDues);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RegularDuesListModel implements RegularDuesListModel {
  const _RegularDuesListModel({required List<RegularDueModel> regularDues})
    : _regularDues = regularDues;
  factory _RegularDuesListModel.fromJson(Map<String, dynamic> json) =>
      _$RegularDuesListModelFromJson(json);

  final List<RegularDueModel> _regularDues;
  @override
  List<RegularDueModel> get regularDues {
    if (_regularDues is EqualUnmodifiableListView) return _regularDues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_regularDues);
  }

  /// Create a copy of RegularDuesListModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RegularDuesListModelCopyWith<_RegularDuesListModel> get copyWith =>
      __$RegularDuesListModelCopyWithImpl<_RegularDuesListModel>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$RegularDuesListModelToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegularDuesListModel &&
            const DeepCollectionEquality().equals(
              other._regularDues,
              _regularDues,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_regularDues),
  );

  @override
  String toString() {
    return 'RegularDuesListModel(regularDues: $regularDues)';
  }
}

/// @nodoc
abstract mixin class _$RegularDuesListModelCopyWith<$Res>
    implements $RegularDuesListModelCopyWith<$Res> {
  factory _$RegularDuesListModelCopyWith(
    _RegularDuesListModel value,
    $Res Function(_RegularDuesListModel) _then,
  ) = __$RegularDuesListModelCopyWithImpl;
  @override
  @useResult
  $Res call({List<RegularDueModel> regularDues});
}

/// @nodoc
class __$RegularDuesListModelCopyWithImpl<$Res>
    implements _$RegularDuesListModelCopyWith<$Res> {
  __$RegularDuesListModelCopyWithImpl(this._self, this._then);

  final _RegularDuesListModel _self;
  final $Res Function(_RegularDuesListModel) _then;

  /// Create a copy of RegularDuesListModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? regularDues = null}) {
    return _then(
      _RegularDuesListModel(
        regularDues: null == regularDues
            ? _self._regularDues
            : regularDues // ignore: cast_nullable_to_non_nullable
                  as List<RegularDueModel>,
      ),
    );
  }
}
