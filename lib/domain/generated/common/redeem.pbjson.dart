// This is a generated file - do not edit.
//
// Generated from common/redeem.proto.

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

@$core.Deprecated('Use userRedeemDescriptor instead')
const UserRedeem$json = {
  '1': 'UserRedeem',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'user_name', '3': 2, '4': 1, '5': 9, '10': 'userName'},
    {'1': 'redeem_count', '3': 3, '4': 1, '5': 5, '10': 'redeemCount'},
    {'1': 'percentage', '3': 4, '4': 1, '5': 9, '10': 'percentage'},
  ],
};

/// Descriptor for `UserRedeem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userRedeemDescriptor = $convert.base64Decode(
    'CgpVc2VyUmVkZWVtEhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZBIbCgl1c2VyX25hbWUYAiABKA'
    'lSCHVzZXJOYW1lEiEKDHJlZGVlbV9jb3VudBgDIAEoBVILcmVkZWVtQ291bnQSHgoKcGVyY2Vu'
    'dGFnZRgEIAEoCVIKcGVyY2VudGFnZQ==');

@$core.Deprecated('Use rewardRedeemDescriptor instead')
const RewardRedeem$json = {
  '1': 'RewardRedeem',
  '2': [
    {'1': 'reward_id', '3': 1, '4': 1, '5': 9, '10': 'rewardId'},
    {'1': 'reward_title', '3': 2, '4': 1, '5': 9, '10': 'rewardTitle'},
    {'1': 'fill', '3': 3, '4': 1, '5': 9, '10': 'fill'},
    {'1': 'percentage', '3': 4, '4': 1, '5': 9, '10': 'percentage'},
  ],
};

/// Descriptor for `RewardRedeem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rewardRedeemDescriptor = $convert.base64Decode(
    'CgxSZXdhcmRSZWRlZW0SGwoJcmV3YXJkX2lkGAEgASgJUghyZXdhcmRJZBIhCgxyZXdhcmRfdG'
    'l0bGUYAiABKAlSC3Jld2FyZFRpdGxlEhIKBGZpbGwYAyABKAlSBGZpbGwSHgoKcGVyY2VudGFn'
    'ZRgEIAEoCVIKcGVyY2VudGFnZQ==');

@$core.Deprecated('Use redeemDescriptor instead')
const Redeem$json = {
  '1': 'Redeem',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'prompt', '3': 3, '4': 1, '5': 9, '10': 'prompt'},
    {'1': 'image_url', '3': 4, '4': 1, '5': 9, '10': 'imageUrl'},
    {'1': 'background_color', '3': 5, '4': 1, '5': 9, '10': 'backgroundColor'},
    {'1': 'streamer_id', '3': 6, '4': 1, '5': 9, '10': 'streamerId'},
    {
      '1': 'speech',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.grpc.model.Speech',
      '10': 'speech'
    },
  ],
};

/// Descriptor for `Redeem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List redeemDescriptor = $convert.base64Decode(
    'CgZSZWRlZW0SDgoCaWQYASABKAlSAmlkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIWCgZwcm9tcH'
    'QYAyABKAlSBnByb21wdBIbCglpbWFnZV91cmwYBCABKAlSCGltYWdlVXJsEikKEGJhY2tncm91'
    'bmRfY29sb3IYBSABKAlSD2JhY2tncm91bmRDb2xvchIfCgtzdHJlYW1lcl9pZBgGIAEoCVIKc3'
    'RyZWFtZXJJZBIqCgZzcGVlY2gYByABKAsyEi5ncnBjLm1vZGVsLlNwZWVjaFIGc3BlZWNo');
