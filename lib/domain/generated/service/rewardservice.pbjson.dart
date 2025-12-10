// This is a generated file - do not edit.
//
// Generated from service/rewardservice.proto.

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

@$core.Deprecated('Use rewardResponseDescriptor instead')
const RewardResponse$json = {
  '1': 'RewardResponse',
  '2': [
    {
      '1': 'reward',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.grpc.model.Reward',
      '10': 'reward'
    },
  ],
};

/// Descriptor for `RewardResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rewardResponseDescriptor = $convert.base64Decode(
    'Cg5SZXdhcmRSZXNwb25zZRIqCgZyZXdhcmQYASABKAsyEi5ncnBjLm1vZGVsLlJld2FyZFIGcm'
    'V3YXJk');

@$core.Deprecated('Use rewardSpeechRequestDescriptor instead')
const RewardSpeechRequest$json = {
  '1': 'RewardSpeechRequest',
  '2': [
    {'1': 'reward_id', '3': 1, '4': 1, '5': 9, '10': 'rewardId'},
    {
      '1': 'speech',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.grpc.model.Speech',
      '10': 'speech'
    },
  ],
};

/// Descriptor for `RewardSpeechRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rewardSpeechRequestDescriptor = $convert.base64Decode(
    'ChNSZXdhcmRTcGVlY2hSZXF1ZXN0EhsKCXJld2FyZF9pZBgBIAEoCVIIcmV3YXJkSWQSKgoGc3'
    'BlZWNoGAIgASgLMhIuZ3JwYy5tb2RlbC5TcGVlY2hSBnNwZWVjaA==');

@$core.Deprecated('Use addRewardAssetRequestDescriptor instead')
const AddRewardAssetRequest$json = {
  '1': 'AddRewardAssetRequest',
  '2': [
    {'1': 'reward_id', '3': 1, '4': 1, '5': 9, '10': 'rewardId'},
    {'1': 'file', '3': 2, '4': 1, '5': 12, '10': 'file'},
  ],
};

/// Descriptor for `AddRewardAssetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addRewardAssetRequestDescriptor = $convert.base64Decode(
    'ChVBZGRSZXdhcmRBc3NldFJlcXVlc3QSGwoJcmV3YXJkX2lkGAEgASgJUghyZXdhcmRJZBISCg'
    'RmaWxlGAIgASgMUgRmaWxl');

@$core.Deprecated('Use removeRewardAssetRequestDescriptor instead')
const RemoveRewardAssetRequest$json = {
  '1': 'RemoveRewardAssetRequest',
  '2': [
    {'1': 'reward_id', '3': 1, '4': 1, '5': 9, '10': 'rewardId'},
    {'1': 'file_name', '3': 2, '4': 3, '5': 9, '10': 'fileName'},
  ],
};

/// Descriptor for `RemoveRewardAssetRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeRewardAssetRequestDescriptor =
    $convert.base64Decode(
        'ChhSZW1vdmVSZXdhcmRBc3NldFJlcXVlc3QSGwoJcmV3YXJkX2lkGAEgASgJUghyZXdhcmRJZB'
        'IbCglmaWxlX25hbWUYAiADKAlSCGZpbGVOYW1l');
