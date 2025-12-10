// This is a generated file - do not edit.
//
// Generated from service/redeemservice.proto.

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
    as $0;

import 'redeemservice.pb.dart' as $1;

export 'redeemservice.pb.dart';

@$pb.GrpcServiceName('GrpcRedeemService')
class GrpcRedeemServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  GrpcRedeemServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.RewardRedeemResponse>
      findRewardRedeemStatisticsFromUser(
    $0.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$findRewardRedeemStatisticsFromUser, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.UserRedeemResponse> findUserRedeemStatisticsByReward(
    $1.RewardRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$findUserRedeemStatisticsByReward, request,
        options: options);
  }

  // method descriptors

  static final _$findRewardRedeemStatisticsFromUser =
      $grpc.ClientMethod<$0.Empty, $1.RewardRedeemResponse>(
          '/GrpcRedeemService/FindRewardRedeemStatisticsFromUser',
          ($0.Empty value) => value.writeToBuffer(),
          $1.RewardRedeemResponse.fromBuffer);
  static final _$findUserRedeemStatisticsByReward =
      $grpc.ClientMethod<$1.RewardRequest, $1.UserRedeemResponse>(
          '/GrpcRedeemService/FindUserRedeemStatisticsByReward',
          ($1.RewardRequest value) => value.writeToBuffer(),
          $1.UserRedeemResponse.fromBuffer);
}

@$pb.GrpcServiceName('GrpcRedeemService')
abstract class GrpcRedeemServiceBase extends $grpc.Service {
  $core.String get $name => 'GrpcRedeemService';

  GrpcRedeemServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.RewardRedeemResponse>(
        'FindRewardRedeemStatisticsFromUser',
        findRewardRedeemStatisticsFromUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.RewardRedeemResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RewardRequest, $1.UserRedeemResponse>(
        'FindUserRedeemStatisticsByReward',
        findUserRedeemStatisticsByReward_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.RewardRequest.fromBuffer(value),
        ($1.UserRedeemResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.RewardRedeemResponse> findRewardRedeemStatisticsFromUser_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.Empty> $request) async {
    return findRewardRedeemStatisticsFromUser($call, await $request);
  }

  $async.Future<$1.RewardRedeemResponse> findRewardRedeemStatisticsFromUser(
      $grpc.ServiceCall call, $0.Empty request);

  $async.Future<$1.UserRedeemResponse> findUserRedeemStatisticsByReward_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.RewardRequest> $request) async {
    return findUserRedeemStatisticsByReward($call, await $request);
  }

  $async.Future<$1.UserRedeemResponse> findUserRedeemStatisticsByReward(
      $grpc.ServiceCall call, $1.RewardRequest request);
}
