// This is a generated file - do not edit.
//
// Generated from service/userservice.proto.

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

import 'userservice.pb.dart' as $0;

export 'userservice.pb.dart';

@$pb.GrpcServiceName('GrpcUserService')
class GrpcUserServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  GrpcUserServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.LoginResponse> login(
    $0.SessionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$login, request, options: options);
  }

  $grpc.ResponseStream<$0.SessionStatus> authenticationSession(
    $0.SessionRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$authenticationSession, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.MeResponse> me(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$me, request, options: options);
  }

  // method descriptors

  static final _$login =
      $grpc.ClientMethod<$0.SessionRequest, $0.LoginResponse>(
          '/GrpcUserService/Login',
          ($0.SessionRequest value) => value.writeToBuffer(),
          $0.LoginResponse.fromBuffer);
  static final _$authenticationSession =
      $grpc.ClientMethod<$0.SessionRequest, $0.SessionStatus>(
          '/GrpcUserService/AuthenticationSession',
          ($0.SessionRequest value) => value.writeToBuffer(),
          $0.SessionStatus.fromBuffer);
  static final _$me = $grpc.ClientMethod<$1.Empty, $0.MeResponse>(
      '/GrpcUserService/Me',
      ($1.Empty value) => value.writeToBuffer(),
      $0.MeResponse.fromBuffer);
}

@$pb.GrpcServiceName('GrpcUserService')
abstract class GrpcUserServiceBase extends $grpc.Service {
  $core.String get $name => 'GrpcUserService';

  GrpcUserServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SessionRequest, $0.LoginResponse>(
        'Login',
        login_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SessionRequest.fromBuffer(value),
        ($0.LoginResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SessionRequest, $0.SessionStatus>(
        'AuthenticationSession',
        authenticationSession_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.SessionRequest.fromBuffer(value),
        ($0.SessionStatus value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.MeResponse>(
        'Me',
        me_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.MeResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.LoginResponse> login_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SessionRequest> $request) async {
    return login($call, await $request);
  }

  $async.Future<$0.LoginResponse> login(
      $grpc.ServiceCall call, $0.SessionRequest request);

  $async.Stream<$0.SessionStatus> authenticationSession_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SessionRequest> $request) async* {
    yield* authenticationSession($call, await $request);
  }

  $async.Stream<$0.SessionStatus> authenticationSession(
      $grpc.ServiceCall call, $0.SessionRequest request);

  $async.Future<$0.MeResponse> me_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return me($call, await $request);
  }

  $async.Future<$0.MeResponse> me($grpc.ServiceCall call, $1.Empty request);
}
