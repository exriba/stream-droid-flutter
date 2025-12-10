// This is a generated file - do not edit.
//
// Generated from common/reward.proto.

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

@$core.Deprecated('Use speechDescriptor instead')
const Speech$json = {
  '1': 'Speech',
  '2': [
    {'1': 'enabled', '3': 1, '4': 1, '5': 8, '10': 'enabled'},
    {'1': 'voice_index', '3': 2, '4': 1, '5': 5, '10': 'voiceIndex'},
  ],
};

/// Descriptor for `Speech`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List speechDescriptor = $convert.base64Decode(
    'CgZTcGVlY2gSGAoHZW5hYmxlZBgBIAEoCFIHZW5hYmxlZBIfCgt2b2ljZV9pbmRleBgCIAEoBV'
    'IKdm9pY2VJbmRleA==');

@$core.Deprecated('Use assetDescriptor instead')
const Asset$json = {
  '1': 'Asset',
  '2': [
    {'1': 'volume', '3': 1, '4': 1, '5': 5, '10': 'volume'},
    {'1': 'file_name', '3': 2, '4': 1, '5': 9, '10': 'fileName'},
  ],
};

/// Descriptor for `Asset`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List assetDescriptor = $convert.base64Decode(
    'CgVBc3NldBIWCgZ2b2x1bWUYASABKAVSBnZvbHVtZRIbCglmaWxlX25hbWUYAiABKAlSCGZpbG'
    'VOYW1l');

@$core.Deprecated('Use rewardDescriptor instead')
const Reward$json = {
  '1': 'Reward',
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
    {
      '1': 'assets',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.grpc.model.Asset',
      '10': 'assets'
    },
  ],
};

/// Descriptor for `Reward`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rewardDescriptor = $convert.base64Decode(
    'CgZSZXdhcmQSDgoCaWQYASABKAlSAmlkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRIWCgZwcm9tcH'
    'QYAyABKAlSBnByb21wdBIbCglpbWFnZV91cmwYBCABKAlSCGltYWdlVXJsEikKEGJhY2tncm91'
    'bmRfY29sb3IYBSABKAlSD2JhY2tncm91bmRDb2xvchIfCgtzdHJlYW1lcl9pZBgGIAEoCVIKc3'
    'RyZWFtZXJJZBIqCgZzcGVlY2gYByABKAsyEi5ncnBjLm1vZGVsLlNwZWVjaFIGc3BlZWNoEikK'
    'BmFzc2V0cxgIIAMoCzIRLmdycGMubW9kZWwuQXNzZXRSBmFzc2V0cw==');
