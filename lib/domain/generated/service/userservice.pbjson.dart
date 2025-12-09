// This is a generated file - do not edit.
//
// Generated from service/userservice.proto.

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

@$core.Deprecated('Use sessionRequestDescriptor instead')
const SessionRequest$json = {
  '1': 'SessionRequest',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
  ],
};

/// Descriptor for `SessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sessionRequestDescriptor = $convert.base64Decode(
    'Cg5TZXNzaW9uUmVxdWVzdBIdCgpzZXNzaW9uX2lkGAEgASgJUglzZXNzaW9uSWQ=');

@$core.Deprecated('Use loginUrlResponseDescriptor instead')
const LoginUrlResponse$json = {
  '1': 'LoginUrlResponse',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 9, '10': 'sessionId'},
    {
      '1': 'authorization_url',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'authorizationUrl'
    },
  ],
};

/// Descriptor for `LoginUrlResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginUrlResponseDescriptor = $convert.base64Decode(
    'ChBMb2dpblVybFJlc3BvbnNlEh0KCnNlc3Npb25faWQYASABKAlSCXNlc3Npb25JZBIrChFhdX'
    'Rob3JpemF0aW9uX3VybBgCIAEoCVIQYXV0aG9yaXphdGlvblVybA==');

@$core.Deprecated('Use sessionStatusDescriptor instead')
const SessionStatus$json = {
  '1': 'SessionStatus',
  '2': [
    {
      '1': 'status',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.SessionStatus.Status',
      '10': 'status'
    },
    {'1': 'access_token', '3': 2, '4': 1, '5': 9, '10': 'accessToken'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
  '4': [SessionStatus_Status$json],
};

@$core.Deprecated('Use sessionStatusDescriptor instead')
const SessionStatus_Status$json = {
  '1': 'Status',
  '2': [
    {'1': 'PENDING', '2': 0},
    {'1': 'AUTHORIZED', '2': 1},
    {'1': 'ERROR', '2': 2},
  ],
};

/// Descriptor for `SessionStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sessionStatusDescriptor = $convert.base64Decode(
    'Cg1TZXNzaW9uU3RhdHVzEi0KBnN0YXR1cxgBIAEoDjIVLlNlc3Npb25TdGF0dXMuU3RhdHVzUg'
    'ZzdGF0dXMSIQoMYWNjZXNzX3Rva2VuGAIgASgJUgthY2Nlc3NUb2tlbhIYCgdtZXNzYWdlGAMg'
    'ASgJUgdtZXNzYWdlIjAKBlN0YXR1cxILCgdQRU5ESU5HEAASDgoKQVVUSE9SSVpFRBABEgkKBU'
    'VSUk9SEAI=');

@$core.Deprecated('Use userResponseDescriptor instead')
const UserResponse$json = {
  '1': 'UserResponse',
  '2': [
    {
      '1': 'user',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.grpc.model.User',
      '10': 'user'
    },
  ],
};

/// Descriptor for `UserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userResponseDescriptor = $convert.base64Decode(
    'CgxVc2VyUmVzcG9uc2USJAoEdXNlchgBIAEoCzIQLmdycGMubW9kZWwuVXNlclIEdXNlcg==');
