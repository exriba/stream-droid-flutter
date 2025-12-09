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

import 'user.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'user.pbenum.dart';

class Preferences extends $pb.GeneratedMessage {
  factory Preferences({
    $core.int? defaultVolume,
  }) {
    final result = create();
    if (defaultVolume != null) result.defaultVolume = defaultVolume;
    return result;
  }

  Preferences._();

  factory Preferences.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Preferences.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Preferences',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.model'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'defaultVolume')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Preferences clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Preferences copyWith(void Function(Preferences) updates) =>
      super.copyWith((message) => updates(message as Preferences))
          as Preferences;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Preferences create() => Preferences._();
  @$core.override
  Preferences createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Preferences getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Preferences>(create);
  static Preferences? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get defaultVolume => $_getIZ(0);
  @$pb.TagNumber(1)
  set defaultVolume($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDefaultVolume() => $_has(0);
  @$pb.TagNumber(1)
  void clearDefaultVolume() => $_clearField(1);
}

class User extends $pb.GeneratedMessage {
  factory User({
    $core.String? id,
    $core.String? name,
    $core.String? userKey,
    User_UserType? userType,
    Preferences? preferences,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (userKey != null) result.userKey = userKey;
    if (userType != null) result.userType = userType;
    if (preferences != null) result.preferences = preferences;
    return result;
  }

  User._();

  factory User.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory User.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'User',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.model'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'userKey')
    ..aE<User_UserType>(4, _omitFieldNames ? '' : 'userType',
        enumValues: User_UserType.values)
    ..aOM<Preferences>(5, _omitFieldNames ? '' : 'preferences',
        subBuilder: Preferences.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  User clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  User copyWith(void Function(User) updates) =>
      super.copyWith((message) => updates(message as User)) as User;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  @$core.override
  User createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static User getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userKey => $_getSZ(2);
  @$pb.TagNumber(3)
  set userKey($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserKey() => $_clearField(3);

  @$pb.TagNumber(4)
  User_UserType get userType => $_getN(3);
  @$pb.TagNumber(4)
  set userType(User_UserType value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasUserType() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserType() => $_clearField(4);

  @$pb.TagNumber(5)
  Preferences get preferences => $_getN(4);
  @$pb.TagNumber(5)
  set preferences(Preferences value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasPreferences() => $_has(4);
  @$pb.TagNumber(5)
  void clearPreferences() => $_clearField(5);
  @$pb.TagNumber(5)
  Preferences ensurePreferences() => $_ensure(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
