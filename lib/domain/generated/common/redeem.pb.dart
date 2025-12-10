// This is a generated file - do not edit.
//
// Generated from common/redeem.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'reward.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class UserRedeem extends $pb.GeneratedMessage {
  factory UserRedeem({
    $core.String? userId,
    $core.String? userName,
    $core.int? redeemCount,
    $core.String? percentage,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (userName != null) result.userName = userName;
    if (redeemCount != null) result.redeemCount = redeemCount;
    if (percentage != null) result.percentage = percentage;
    return result;
  }

  UserRedeem._();

  factory UserRedeem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserRedeem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserRedeem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.model'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'userName')
    ..aI(3, _omitFieldNames ? '' : 'redeemCount')
    ..aOS(4, _omitFieldNames ? '' : 'percentage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserRedeem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserRedeem copyWith(void Function(UserRedeem) updates) =>
      super.copyWith((message) => updates(message as UserRedeem)) as UserRedeem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserRedeem create() => UserRedeem._();
  @$core.override
  UserRedeem createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserRedeem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserRedeem>(create);
  static UserRedeem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userName => $_getSZ(1);
  @$pb.TagNumber(2)
  set userName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserName() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get redeemCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set redeemCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRedeemCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearRedeemCount() => $_clearField(3);

  /// Consider sfixed32 to represent decimal fields. The problem is consumers will require conversion logic.
  /// Example: 12345.6789 becomes units = 12345, nanos = 678900000
  @$pb.TagNumber(4)
  $core.String get percentage => $_getSZ(3);
  @$pb.TagNumber(4)
  set percentage($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPercentage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPercentage() => $_clearField(4);
}

class RewardRedeem extends $pb.GeneratedMessage {
  factory RewardRedeem({
    $core.String? rewardId,
    $core.String? rewardTitle,
    $core.String? fill,
    $core.String? percentage,
  }) {
    final result = create();
    if (rewardId != null) result.rewardId = rewardId;
    if (rewardTitle != null) result.rewardTitle = rewardTitle;
    if (fill != null) result.fill = fill;
    if (percentage != null) result.percentage = percentage;
    return result;
  }

  RewardRedeem._();

  factory RewardRedeem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RewardRedeem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RewardRedeem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.model'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'rewardId')
    ..aOS(2, _omitFieldNames ? '' : 'rewardTitle')
    ..aOS(3, _omitFieldNames ? '' : 'fill')
    ..aOS(4, _omitFieldNames ? '' : 'percentage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RewardRedeem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RewardRedeem copyWith(void Function(RewardRedeem) updates) =>
      super.copyWith((message) => updates(message as RewardRedeem))
          as RewardRedeem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RewardRedeem create() => RewardRedeem._();
  @$core.override
  RewardRedeem createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RewardRedeem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RewardRedeem>(create);
  static RewardRedeem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get rewardId => $_getSZ(0);
  @$pb.TagNumber(1)
  set rewardId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRewardId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRewardId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get rewardTitle => $_getSZ(1);
  @$pb.TagNumber(2)
  set rewardTitle($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRewardTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearRewardTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get fill => $_getSZ(2);
  @$pb.TagNumber(3)
  set fill($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFill() => $_has(2);
  @$pb.TagNumber(3)
  void clearFill() => $_clearField(3);

  /// Consider sfixed32 to represent decimal fields. The problem is consumers will require conversion logic.
  /// Example: 12345.6789 becomes units = 12345, nanos = 678900000
  @$pb.TagNumber(4)
  $core.String get percentage => $_getSZ(3);
  @$pb.TagNumber(4)
  set percentage($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPercentage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPercentage() => $_clearField(4);
}

class Redeem extends $pb.GeneratedMessage {
  factory Redeem({
    $core.String? id,
    $core.String? title,
    $core.String? prompt,
    $core.String? imageUrl,
    $core.String? backgroundColor,
    $core.String? streamerId,
    $0.Speech? speech,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (prompt != null) result.prompt = prompt;
    if (imageUrl != null) result.imageUrl = imageUrl;
    if (backgroundColor != null) result.backgroundColor = backgroundColor;
    if (streamerId != null) result.streamerId = streamerId;
    if (speech != null) result.speech = speech;
    return result;
  }

  Redeem._();

  factory Redeem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Redeem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Redeem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.model'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'prompt')
    ..aOS(4, _omitFieldNames ? '' : 'imageUrl')
    ..aOS(5, _omitFieldNames ? '' : 'backgroundColor')
    ..aOS(6, _omitFieldNames ? '' : 'streamerId')
    ..aOM<$0.Speech>(7, _omitFieldNames ? '' : 'speech',
        subBuilder: $0.Speech.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Redeem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Redeem copyWith(void Function(Redeem) updates) =>
      super.copyWith((message) => updates(message as Redeem)) as Redeem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Redeem create() => Redeem._();
  @$core.override
  Redeem createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Redeem getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Redeem>(create);
  static Redeem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get prompt => $_getSZ(2);
  @$pb.TagNumber(3)
  set prompt($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPrompt() => $_has(2);
  @$pb.TagNumber(3)
  void clearPrompt() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get imageUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set imageUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasImageUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearImageUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get backgroundColor => $_getSZ(4);
  @$pb.TagNumber(5)
  set backgroundColor($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBackgroundColor() => $_has(4);
  @$pb.TagNumber(5)
  void clearBackgroundColor() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get streamerId => $_getSZ(5);
  @$pb.TagNumber(6)
  set streamerId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasStreamerId() => $_has(5);
  @$pb.TagNumber(6)
  void clearStreamerId() => $_clearField(6);

  @$pb.TagNumber(7)
  $0.Speech get speech => $_getN(6);
  @$pb.TagNumber(7)
  set speech($0.Speech value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasSpeech() => $_has(6);
  @$pb.TagNumber(7)
  void clearSpeech() => $_clearField(7);
  @$pb.TagNumber(7)
  $0.Speech ensureSpeech() => $_ensure(6);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
