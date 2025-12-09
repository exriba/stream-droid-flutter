// This is a generated file - do not edit.
//
// Generated from common/user.proto.

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

@$core.Deprecated('Use preferencesDescriptor instead')
const Preferences$json = {
  '1': 'Preferences',
  '2': [
    {'1': 'default_volume', '3': 1, '4': 1, '5': 5, '10': 'defaultVolume'},
  ],
};

/// Descriptor for `Preferences`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List preferencesDescriptor = $convert.base64Decode(
    'CgtQcmVmZXJlbmNlcxIlCg5kZWZhdWx0X3ZvbHVtZRgBIAEoBVINZGVmYXVsdFZvbHVtZQ==');

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'user_key', '3': 3, '4': 1, '5': 9, '10': 'userKey'},
    {
      '1': 'user_type',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.grpc.model.User.UserType',
      '10': 'userType'
    },
    {
      '1': 'preferences',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.grpc.model.Preferences',
      '10': 'preferences'
    },
  ],
  '4': [User_UserType$json],
};

@$core.Deprecated('Use userDescriptor instead')
const User_UserType$json = {
  '1': 'UserType',
  '2': [
    {'1': 'UNSPECIFIED', '2': 0},
    {'1': 'NORMAL', '2': 1},
    {'1': 'AFFILIATE', '2': 2},
    {'1': 'PARTNER', '2': 3},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhkKCHVzZXJfa2V5GA'
    'MgASgJUgd1c2VyS2V5EjYKCXVzZXJfdHlwZRgEIAEoDjIZLmdycGMubW9kZWwuVXNlci5Vc2Vy'
    'VHlwZVIIdXNlclR5cGUSOQoLcHJlZmVyZW5jZXMYBSABKAsyFy5ncnBjLm1vZGVsLlByZWZlcm'
    'VuY2VzUgtwcmVmZXJlbmNlcyJDCghVc2VyVHlwZRIPCgtVTlNQRUNJRklFRBAAEgoKBk5PUk1B'
    'TBABEg0KCUFGRklMSUFURRACEgsKB1BBUlRORVIQAw==');
