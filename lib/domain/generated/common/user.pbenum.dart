// This is a generated file - do not edit.
//
// Generated from common/user.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class User_UserType extends $pb.ProtobufEnum {
  static const User_UserType UNSPECIFIED =
      User_UserType._(0, _omitEnumNames ? '' : 'UNSPECIFIED');
  static const User_UserType NORMAL =
      User_UserType._(1, _omitEnumNames ? '' : 'NORMAL');
  static const User_UserType AFFILIATE =
      User_UserType._(2, _omitEnumNames ? '' : 'AFFILIATE');
  static const User_UserType PARTNER =
      User_UserType._(3, _omitEnumNames ? '' : 'PARTNER');

  static const $core.List<User_UserType> values = <User_UserType>[
    UNSPECIFIED,
    NORMAL,
    AFFILIATE,
    PARTNER,
  ];

  static final $core.List<User_UserType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static User_UserType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const User_UserType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
