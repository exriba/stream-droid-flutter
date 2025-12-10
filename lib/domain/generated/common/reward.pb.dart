// This is a generated file - do not edit.
//
// Generated from common/reward.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Speech extends $pb.GeneratedMessage {
  factory Speech({
    $core.bool? enabled,
    $core.int? voiceIndex,
  }) {
    final result = create();
    if (enabled != null) result.enabled = enabled;
    if (voiceIndex != null) result.voiceIndex = voiceIndex;
    return result;
  }

  Speech._();

  factory Speech.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Speech.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Speech',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.model'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'enabled')
    ..aI(2, _omitFieldNames ? '' : 'voiceIndex')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Speech clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Speech copyWith(void Function(Speech) updates) =>
      super.copyWith((message) => updates(message as Speech)) as Speech;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Speech create() => Speech._();
  @$core.override
  Speech createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Speech getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Speech>(create);
  static Speech? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get enabled => $_getBF(0);
  @$pb.TagNumber(1)
  set enabled($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEnabled() => $_has(0);
  @$pb.TagNumber(1)
  void clearEnabled() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get voiceIndex => $_getIZ(1);
  @$pb.TagNumber(2)
  set voiceIndex($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVoiceIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearVoiceIndex() => $_clearField(2);
}

class Asset extends $pb.GeneratedMessage {
  factory Asset({
    $core.int? volume,
    $core.String? fileName,
  }) {
    final result = create();
    if (volume != null) result.volume = volume;
    if (fileName != null) result.fileName = fileName;
    return result;
  }

  Asset._();

  factory Asset.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Asset.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Asset',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.model'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'volume')
    ..aOS(2, _omitFieldNames ? '' : 'fileName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Asset clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Asset copyWith(void Function(Asset) updates) =>
      super.copyWith((message) => updates(message as Asset)) as Asset;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Asset create() => Asset._();
  @$core.override
  Asset createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Asset getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Asset>(create);
  static Asset? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get volume => $_getIZ(0);
  @$pb.TagNumber(1)
  set volume($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVolume() => $_has(0);
  @$pb.TagNumber(1)
  void clearVolume() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get fileName => $_getSZ(1);
  @$pb.TagNumber(2)
  set fileName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFileName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFileName() => $_clearField(2);
}

class Reward extends $pb.GeneratedMessage {
  factory Reward({
    $core.String? id,
    $core.String? title,
    $core.String? prompt,
    $core.String? imageUrl,
    $core.String? backgroundColor,
    $core.String? streamerId,
    Speech? speech,
    $core.Iterable<Asset>? assets,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (prompt != null) result.prompt = prompt;
    if (imageUrl != null) result.imageUrl = imageUrl;
    if (backgroundColor != null) result.backgroundColor = backgroundColor;
    if (streamerId != null) result.streamerId = streamerId;
    if (speech != null) result.speech = speech;
    if (assets != null) result.assets.addAll(assets);
    return result;
  }

  Reward._();

  factory Reward.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Reward.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Reward',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'grpc.model'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'prompt')
    ..aOS(4, _omitFieldNames ? '' : 'imageUrl')
    ..aOS(5, _omitFieldNames ? '' : 'backgroundColor')
    ..aOS(6, _omitFieldNames ? '' : 'streamerId')
    ..aOM<Speech>(7, _omitFieldNames ? '' : 'speech', subBuilder: Speech.create)
    ..pPM<Asset>(8, _omitFieldNames ? '' : 'assets', subBuilder: Asset.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Reward clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Reward copyWith(void Function(Reward) updates) =>
      super.copyWith((message) => updates(message as Reward)) as Reward;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Reward create() => Reward._();
  @$core.override
  Reward createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Reward getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Reward>(create);
  static Reward? _defaultInstance;

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
  Speech get speech => $_getN(6);
  @$pb.TagNumber(7)
  set speech(Speech value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasSpeech() => $_has(6);
  @$pb.TagNumber(7)
  void clearSpeech() => $_clearField(7);
  @$pb.TagNumber(7)
  Speech ensureSpeech() => $_ensure(6);

  @$pb.TagNumber(8)
  $pb.PbList<Asset> get assets => $_getList(7);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
