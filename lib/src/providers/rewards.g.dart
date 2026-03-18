// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rewards.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$rewardServiceHash() => r'd75a704e25e14757d7b5962cefb51eaa75948c08';

/// See also [rewardService].
@ProviderFor(rewardService)
final rewardServiceProvider = Provider<RewardService>.internal(
  rewardService,
  name: r'rewardServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$rewardServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RewardServiceRef = ProviderRef<RewardService>;
String _$rewardControllerHash() => r'e3c4c8c696ab27ecafe3cd08f8108662dad71404';

/// See also [rewardController].
@ProviderFor(rewardController)
final rewardControllerProvider = AutoDisposeProvider<RewardController>.internal(
  rewardController,
  name: r'rewardControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$rewardControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RewardControllerRef = AutoDisposeProviderRef<RewardController>;
String _$rewardsHash() => r'fc7abc7dfe94eebfaf1fdf7ca3d587bb10dcf70d';

/// See also [Rewards].
@ProviderFor(Rewards)
final rewardsProvider =
    AutoDisposeAsyncNotifierProvider<Rewards, List<Reward>>.internal(
  Rewards.new,
  name: r'rewardsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$rewardsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Rewards = AutoDisposeAsyncNotifier<List<Reward>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
