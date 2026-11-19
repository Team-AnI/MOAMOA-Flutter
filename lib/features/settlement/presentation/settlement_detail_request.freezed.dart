// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_detail_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementDetailRequest {
  int get meetingId;
  int get settlementId;

  /// Create a copy of SettlementDetailRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettlementDetailRequestCopyWith<SettlementDetailRequest> get copyWith =>
      _$SettlementDetailRequestCopyWithImpl<SettlementDetailRequest>(
        this as SettlementDetailRequest,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettlementDetailRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.settlementId, settlementId) ||
                other.settlementId == settlementId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, meetingId, settlementId);

  @override
  String toString() {
    return 'SettlementDetailRequest(meetingId: $meetingId, settlementId: $settlementId)';
  }
}

/// @nodoc
abstract mixin class $SettlementDetailRequestCopyWith<$Res> {
  factory $SettlementDetailRequestCopyWith(
    SettlementDetailRequest value,
    $Res Function(SettlementDetailRequest) _then,
  ) = _$SettlementDetailRequestCopyWithImpl;
  @useResult
  $Res call({int meetingId, int settlementId});
}

/// @nodoc
class _$SettlementDetailRequestCopyWithImpl<$Res>
    implements $SettlementDetailRequestCopyWith<$Res> {
  _$SettlementDetailRequestCopyWithImpl(this._self, this._then);

  final SettlementDetailRequest _self;
  final $Res Function(SettlementDetailRequest) _then;

  /// Create a copy of SettlementDetailRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? meetingId = null, Object? settlementId = null}) {
    return _then(
      SettlementDetailRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
        settlementId: null == settlementId
            ? _self.settlementId
            : settlementId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// Adds pattern-matching-related methods to [SettlementDetailRequest].
extension SettlementDetailRequestPatterns on SettlementDetailRequest {
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
    TResult Function(_SettlementDetailRequest value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementDetailRequest() when $default != null:
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
    TResult Function(_SettlementDetailRequest value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementDetailRequest():
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
    TResult? Function(_SettlementDetailRequest value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementDetailRequest() when $default != null:
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
    TResult Function(int meetingId, int settlementId)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettlementDetailRequest() when $default != null:
        return $default(_that.meetingId, _that.settlementId);
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
    TResult Function(int meetingId, int settlementId) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementDetailRequest():
        return $default(_that.meetingId, _that.settlementId);
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
    TResult? Function(int meetingId, int settlementId)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettlementDetailRequest() when $default != null:
        return $default(_that.meetingId, _that.settlementId);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SettlementDetailRequest implements SettlementDetailRequest {
  const _SettlementDetailRequest({
    required this.meetingId,
    required this.settlementId,
  });

  @override
  final int meetingId;
  @override
  final int settlementId;

  /// Create a copy of SettlementDetailRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettlementDetailRequestCopyWith<_SettlementDetailRequest> get copyWith =>
      __$SettlementDetailRequestCopyWithImpl<_SettlementDetailRequest>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettlementDetailRequest &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.settlementId, settlementId) ||
                other.settlementId == settlementId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, meetingId, settlementId);

  @override
  String toString() {
    return 'SettlementDetailRequest(meetingId: $meetingId, settlementId: $settlementId)';
  }
}

/// @nodoc
abstract mixin class _$SettlementDetailRequestCopyWith<$Res>
    implements $SettlementDetailRequestCopyWith<$Res> {
  factory _$SettlementDetailRequestCopyWith(
    _SettlementDetailRequest value,
    $Res Function(_SettlementDetailRequest) _then,
  ) = __$SettlementDetailRequestCopyWithImpl;
  @override
  @useResult
  $Res call({int meetingId, int settlementId});
}

/// @nodoc
class __$SettlementDetailRequestCopyWithImpl<$Res>
    implements _$SettlementDetailRequestCopyWith<$Res> {
  __$SettlementDetailRequestCopyWithImpl(this._self, this._then);

  final _SettlementDetailRequest _self;
  final $Res Function(_SettlementDetailRequest) _then;

  /// Create a copy of SettlementDetailRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? meetingId = null, Object? settlementId = null}) {
    return _then(
      _SettlementDetailRequest(
        meetingId: null == meetingId
            ? _self.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as int,
        settlementId: null == settlementId
            ? _self.settlementId
            : settlementId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}
