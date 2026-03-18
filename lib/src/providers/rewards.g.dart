// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rewards.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$rewardServiceHash() => r'2004dc49706473c4669cc12c931f1dd06f40a16c';

/// See also [rewardService].
@ProviderFor(rewardService)
final rewardServiceProvider = AutoDisposeProvider<RewardService>.internal(
  rewardService,
  name: r'rewardServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$rewardServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RewardServiceRef = AutoDisposeProviderRef<RewardService>;
String _$rewardsHash() => r'ada166e3ed7c52f8ac81752ce54def4afd93f991';

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
