// This is a generated file - do not edit.
//
// Generated from service/redeemservice.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use rewardRequestDescriptor instead')
const RewardRequest$json = {
  '1': 'RewardRequest',
  '2': [
    {'1': 'reward_id', '3': 1, '4': 1, '5': 9, '10': 'rewardId'},
  ],
};

/// Descriptor for `RewardRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rewardRequestDescriptor = $convert.base64Decode(
    'Cg1SZXdhcmRSZXF1ZXN0EhsKCXJld2FyZF9pZBgBIAEoCVIIcmV3YXJkSWQ=');

@$core.Deprecated('Use userRedeemResponseDescriptor instead')
const UserRedeemResponse$json = {
  '1': 'UserRedeemResponse',
  '2': [
    {
      '1': 'user_redeems',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.grpc.model.UserRedeem',
      '10': 'userRedeems'
    },
  ],
};

/// Descriptor for `UserRedeemResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userRedeemResponseDescriptor = $convert.base64Decode(
    'ChJVc2VyUmVkZWVtUmVzcG9uc2USOQoMdXNlcl9yZWRlZW1zGAEgAygLMhYuZ3JwYy5tb2RlbC'
    '5Vc2VyUmVkZWVtUgt1c2VyUmVkZWVtcw==');

@$core.Deprecated('Use rewardRedeemResponseDescriptor instead')
const RewardRedeemResponse$json = {
  '1': 'RewardRedeemResponse',
  '2': [
    {
      '1': 'reward_redeems',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.grpc.model.RewardRedeem',
      '10': 'rewardRedeems'
    },
  ],
};

/// Descriptor for `RewardRedeemResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rewardRedeemResponseDescriptor = $convert.base64Decode(
    'ChRSZXdhcmRSZWRlZW1SZXNwb25zZRI/Cg5yZXdhcmRfcmVkZWVtcxgBIAMoCzIYLmdycGMubW'
    '9kZWwuUmV3YXJkUmVkZWVtUg1yZXdhcmRSZWRlZW1z');
