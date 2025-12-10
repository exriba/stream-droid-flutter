// This is a generated file - do not edit.
//
// Generated from service/redeemservice.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../common/redeem.pb.dart' as $3;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class UserRedeemResponse extends $pb.GeneratedMessage {
  factory UserRedeemResponse({
    $core.Iterable<$3.UserRedeem>? userRedeems,
  }) {
    final result = create();
    if (userRedeems != null) result.userRedeems.addAll(userRedeems);
    return result;
  }

  UserRedeemResponse._();

  factory UserRedeemResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserRedeemResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserRedeemResponse',
      createEmptyInstance: create)
    ..pPM<$3.UserRedeem>(1, _omitFieldNames ? '' : 'userRedeems',
        subBuilder: $3.UserRedeem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserRedeemResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserRedeemResponse copyWith(void Function(UserRedeemResponse) updates) =>
      super.copyWith((message) => updates(message as UserRedeemResponse))
          as UserRedeemResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserRedeemResponse create() => UserRedeemResponse._();
  @$core.override
  UserRedeemResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserRedeemResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserRedeemResponse>(create);
  static UserRedeemResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$3.UserRedeem> get userRedeems => $_getList(0);
}

class RewardRedeemResponse extends $pb.GeneratedMessage {
  factory RewardRedeemResponse({
    $core.Iterable<$3.RewardRedeem>? rewardRedeems,
  }) {
    final result = create();
    if (rewardRedeems != null) result.rewardRedeems.addAll(rewardRedeems);
    return result;
  }

  RewardRedeemResponse._();

  factory RewardRedeemResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RewardRedeemResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RewardRedeemResponse',
      createEmptyInstance: create)
    ..pPM<$3.RewardRedeem>(1, _omitFieldNames ? '' : 'rewardRedeems',
        subBuilder: $3.RewardRedeem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RewardRedeemResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RewardRedeemResponse copyWith(void Function(RewardRedeemResponse) updates) =>
      super.copyWith((message) => updates(message as RewardRedeemResponse))
          as RewardRedeemResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RewardRedeemResponse create() => RewardRedeemResponse._();
  @$core.override
  RewardRedeemResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RewardRedeemResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RewardRedeemResponse>(create);
  static RewardRedeemResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$3.RewardRedeem> get rewardRedeems => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
