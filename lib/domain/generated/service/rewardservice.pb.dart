// This is a generated file - do not edit.
//
// Generated from service/rewardservice.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../common/reward.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class RewardRequest extends $pb.GeneratedMessage {
  factory RewardRequest({
    $core.String? rewardId,
  }) {
    final result = create();
    if (rewardId != null) result.rewardId = rewardId;
    return result;
  }

  RewardRequest._();

  factory RewardRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RewardRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RewardRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'rewardId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RewardRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RewardRequest copyWith(void Function(RewardRequest) updates) =>
      super.copyWith((message) => updates(message as RewardRequest))
          as RewardRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RewardRequest create() => RewardRequest._();
  @$core.override
  RewardRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RewardRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RewardRequest>(create);
  static RewardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get rewardId => $_getSZ(0);
  @$pb.TagNumber(1)
  set rewardId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRewardId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRewardId() => $_clearField(1);
}

class RewardResponse extends $pb.GeneratedMessage {
  factory RewardResponse({
    $2.Reward? reward,
  }) {
    final result = create();
    if (reward != null) result.reward = reward;
    return result;
  }

  RewardResponse._();

  factory RewardResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RewardResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RewardResponse',
      createEmptyInstance: create)
    ..aOM<$2.Reward>(1, _omitFieldNames ? '' : 'reward',
        subBuilder: $2.Reward.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RewardResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RewardResponse copyWith(void Function(RewardResponse) updates) =>
      super.copyWith((message) => updates(message as RewardResponse))
          as RewardResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RewardResponse create() => RewardResponse._();
  @$core.override
  RewardResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RewardResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RewardResponse>(create);
  static RewardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Reward get reward => $_getN(0);
  @$pb.TagNumber(1)
  set reward($2.Reward value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasReward() => $_has(0);
  @$pb.TagNumber(1)
  void clearReward() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Reward ensureReward() => $_ensure(0);
}

class RewardSpeechRequest extends $pb.GeneratedMessage {
  factory RewardSpeechRequest({
    $core.String? rewardId,
    $2.Speech? speech,
  }) {
    final result = create();
    if (rewardId != null) result.rewardId = rewardId;
    if (speech != null) result.speech = speech;
    return result;
  }

  RewardSpeechRequest._();

  factory RewardSpeechRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RewardSpeechRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RewardSpeechRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'rewardId')
    ..aOM<$2.Speech>(2, _omitFieldNames ? '' : 'speech',
        subBuilder: $2.Speech.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RewardSpeechRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RewardSpeechRequest copyWith(void Function(RewardSpeechRequest) updates) =>
      super.copyWith((message) => updates(message as RewardSpeechRequest))
          as RewardSpeechRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RewardSpeechRequest create() => RewardSpeechRequest._();
  @$core.override
  RewardSpeechRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RewardSpeechRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RewardSpeechRequest>(create);
  static RewardSpeechRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get rewardId => $_getSZ(0);
  @$pb.TagNumber(1)
  set rewardId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRewardId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRewardId() => $_clearField(1);

  @$pb.TagNumber(2)
  $2.Speech get speech => $_getN(1);
  @$pb.TagNumber(2)
  set speech($2.Speech value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSpeech() => $_has(1);
  @$pb.TagNumber(2)
  void clearSpeech() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.Speech ensureSpeech() => $_ensure(1);
}

class AddRewardAssetRequest extends $pb.GeneratedMessage {
  factory AddRewardAssetRequest({
    $core.String? rewardId,
    $core.List<$core.int>? file,
  }) {
    final result = create();
    if (rewardId != null) result.rewardId = rewardId;
    if (file != null) result.file = file;
    return result;
  }

  AddRewardAssetRequest._();

  factory AddRewardAssetRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddRewardAssetRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddRewardAssetRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'rewardId')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'file', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddRewardAssetRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddRewardAssetRequest copyWith(
          void Function(AddRewardAssetRequest) updates) =>
      super.copyWith((message) => updates(message as AddRewardAssetRequest))
          as AddRewardAssetRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddRewardAssetRequest create() => AddRewardAssetRequest._();
  @$core.override
  AddRewardAssetRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AddRewardAssetRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddRewardAssetRequest>(create);
  static AddRewardAssetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get rewardId => $_getSZ(0);
  @$pb.TagNumber(1)
  set rewardId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRewardId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRewardId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get file => $_getN(1);
  @$pb.TagNumber(2)
  set file($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFile() => $_has(1);
  @$pb.TagNumber(2)
  void clearFile() => $_clearField(2);
}

class RemoveRewardAssetRequest extends $pb.GeneratedMessage {
  factory RemoveRewardAssetRequest({
    $core.String? rewardId,
    $core.Iterable<$core.String>? fileName,
  }) {
    final result = create();
    if (rewardId != null) result.rewardId = rewardId;
    if (fileName != null) result.fileName.addAll(fileName);
    return result;
  }

  RemoveRewardAssetRequest._();

  factory RemoveRewardAssetRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveRewardAssetRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveRewardAssetRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'rewardId')
    ..pPS(2, _omitFieldNames ? '' : 'fileName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveRewardAssetRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveRewardAssetRequest copyWith(
          void Function(RemoveRewardAssetRequest) updates) =>
      super.copyWith((message) => updates(message as RemoveRewardAssetRequest))
          as RemoveRewardAssetRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveRewardAssetRequest create() => RemoveRewardAssetRequest._();
  @$core.override
  RemoveRewardAssetRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RemoveRewardAssetRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveRewardAssetRequest>(create);
  static RemoveRewardAssetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get rewardId => $_getSZ(0);
  @$pb.TagNumber(1)
  set rewardId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRewardId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRewardId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get fileName => $_getList(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
