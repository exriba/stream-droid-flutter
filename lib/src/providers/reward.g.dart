// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$rewardHash() => r'd0c6c9fa74922c9399df63022d965fd48d88b61d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$Reward
    extends BuildlessAutoDisposeAsyncNotifier<RewardResponse> {
  late final String rewardId;

  FutureOr<RewardResponse> build(
    String rewardId,
  );
}

/// See also [Reward].
@ProviderFor(Reward)
const rewardProvider = RewardFamily();

/// See also [Reward].
class RewardFamily extends Family<AsyncValue<RewardResponse>> {
  /// See also [Reward].
  const RewardFamily();

  /// See also [Reward].
  RewardProvider call(
    String rewardId,
  ) {
    return RewardProvider(
      rewardId,
    );
  }

  @override
  RewardProvider getProviderOverride(
    covariant RewardProvider provider,
  ) {
    return call(
      provider.rewardId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'rewardProvider';
}

/// See also [Reward].
class RewardProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Reward, RewardResponse> {
  /// See also [Reward].
  RewardProvider(
    String rewardId,
  ) : this._internal(
          () => Reward()..rewardId = rewardId,
          from: rewardProvider,
          name: r'rewardProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$rewardHash,
          dependencies: RewardFamily._dependencies,
          allTransitiveDependencies: RewardFamily._allTransitiveDependencies,
          rewardId: rewardId,
        );

  RewardProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.rewardId,
  }) : super.internal();

  final String rewardId;

  @override
  FutureOr<RewardResponse> runNotifierBuild(
    covariant Reward notifier,
  ) {
    return notifier.build(
      rewardId,
    );
  }

  @override
  Override overrideWith(Reward Function() create) {
    return ProviderOverride(
      origin: this,
      override: RewardProvider._internal(
        () => create()..rewardId = rewardId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        rewardId: rewardId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Reward, RewardResponse>
      createElement() {
    return _RewardProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RewardProvider && other.rewardId == rewardId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, rewardId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RewardRef on AutoDisposeAsyncNotifierProviderRef<RewardResponse> {
  /// The parameter `rewardId` of this provider.
  String get rewardId;
}

class _RewardProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Reward, RewardResponse>
    with RewardRef {
  _RewardProviderElement(super.provider);

  @override
  String get rewardId => (origin as RewardProvider).rewardId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
