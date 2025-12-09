// This is a generated file - do not edit.
//
// Generated from service/userservice.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class SessionStatus_Status extends $pb.ProtobufEnum {
  static const SessionStatus_Status PENDING =
      SessionStatus_Status._(0, _omitEnumNames ? '' : 'PENDING');
  static const SessionStatus_Status AUTHORIZED =
      SessionStatus_Status._(1, _omitEnumNames ? '' : 'AUTHORIZED');
  static const SessionStatus_Status ERROR =
      SessionStatus_Status._(2, _omitEnumNames ? '' : 'ERROR');

  static const $core.List<SessionStatus_Status> values = <SessionStatus_Status>[
    PENDING,
    AUTHORIZED,
    ERROR,
  ];

  static final $core.List<SessionStatus_Status?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static SessionStatus_Status? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SessionStatus_Status._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
