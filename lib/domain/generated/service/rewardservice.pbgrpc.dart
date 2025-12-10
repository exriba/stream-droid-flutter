// This is a generated file - do not edit.
//
// Generated from service/rewardservice.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:stream_droid_app/domain/generated/google/protobuf/empty.pb.dart'
    as $1;

import 'rewardservice.pb.dart' as $0;

export 'rewardservice.pb.dart';

@$pb.GrpcServiceName('GrpcRewardService')
class GrpcRewardServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  GrpcRewardServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.RewardResponse> findReward(
    $0.RewardRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$findReward, request, options: options);
  }

  $grpc.ResponseStream<$0.RewardResponse> findUserRewards(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$findUserRewards, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.RewardResponse> updateRewardSpeech(
    $0.RewardSpeechRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateRewardSpeech, request, options: options);
  }

  $grpc.ResponseFuture<$0.RewardResponse> addRewardAssets(
    $async.Stream<$0.AddRewardAssetRequest> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$addRewardAssets, request, options: options)
        .single;
  }

  $grpc.ResponseFuture<$0.RewardResponse> removeRewardAssets(
    $0.RemoveRewardAssetRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$removeRewardAssets, request, options: options);
  }

  // method descriptors

  static final _$findReward =
      $grpc.ClientMethod<$0.RewardRequest, $0.RewardResponse>(
          '/GrpcRewardService/FindReward',
          ($0.RewardRequest value) => value.writeToBuffer(),
          $0.RewardResponse.fromBuffer);
  static final _$findUserRewards =
      $grpc.ClientMethod<$1.Empty, $0.RewardResponse>(
          '/GrpcRewardService/FindUserRewards',
          ($1.Empty value) => value.writeToBuffer(),
          $0.RewardResponse.fromBuffer);
  static final _$updateRewardSpeech =
      $grpc.ClientMethod<$0.RewardSpeechRequest, $0.RewardResponse>(
          '/GrpcRewardService/UpdateRewardSpeech',
          ($0.RewardSpeechRequest value) => value.writeToBuffer(),
          $0.RewardResponse.fromBuffer);
  static final _$addRewardAssets =
      $grpc.ClientMethod<$0.AddRewardAssetRequest, $0.RewardResponse>(
          '/GrpcRewardService/AddRewardAssets',
          ($0.AddRewardAssetRequest value) => value.writeToBuffer(),
          $0.RewardResponse.fromBuffer);
  static final _$removeRewardAssets =
      $grpc.ClientMethod<$0.RemoveRewardAssetRequest, $0.RewardResponse>(
          '/GrpcRewardService/RemoveRewardAssets',
          ($0.RemoveRewardAssetRequest value) => value.writeToBuffer(),
          $0.RewardResponse.fromBuffer);
}

@$pb.GrpcServiceName('GrpcRewardService')
abstract class GrpcRewardServiceBase extends $grpc.Service {
  $core.String get $name => 'GrpcRewardService';

  GrpcRewardServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RewardRequest, $0.RewardResponse>(
        'FindReward',
        findReward_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RewardRequest.fromBuffer(value),
        ($0.RewardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.RewardResponse>(
        'FindUserRewards',
        findUserRewards_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.RewardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RewardSpeechRequest, $0.RewardResponse>(
        'UpdateRewardSpeech',
        updateRewardSpeech_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RewardSpeechRequest.fromBuffer(value),
        ($0.RewardResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddRewardAssetRequest, $0.RewardResponse>(
        'AddRewardAssets',
        addRewardAssets,
        true,
        false,
        ($core.List<$core.int> value) =>
            $0.AddRewardAssetRequest.fromBuffer(value),
        ($0.RewardResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.RemoveRewardAssetRequest, $0.RewardResponse>(
            'RemoveRewardAssets',
            removeRewardAssets_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.RemoveRewardAssetRequest.fromBuffer(value),
            ($0.RewardResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.RewardResponse> findReward_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.RewardRequest> $request) async {
    return findReward($call, await $request);
  }

  $async.Future<$0.RewardResponse> findReward(
      $grpc.ServiceCall call, $0.RewardRequest request);

  $async.Stream<$0.RewardResponse> findUserRewards_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async* {
    yield* findUserRewards($call, await $request);
  }

  $async.Stream<$0.RewardResponse> findUserRewards(
      $grpc.ServiceCall call, $1.Empty request);

  $async.Future<$0.RewardResponse> updateRewardSpeech_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RewardSpeechRequest> $request) async {
    return updateRewardSpeech($call, await $request);
  }

  $async.Future<$0.RewardResponse> updateRewardSpeech(
      $grpc.ServiceCall call, $0.RewardSpeechRequest request);

  $async.Future<$0.RewardResponse> addRewardAssets(
      $grpc.ServiceCall call, $async.Stream<$0.AddRewardAssetRequest> request);

  $async.Future<$0.RewardResponse> removeRewardAssets_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RemoveRewardAssetRequest> $request) async {
    return removeRewardAssets($call, await $request);
  }

  $async.Future<$0.RewardResponse> removeRewardAssets(
      $grpc.ServiceCall call, $0.RemoveRewardAssetRequest request);
}
