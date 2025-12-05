import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:stream_droid_app/core/context/user_context.dart';
import 'package:stream_droid_app/core/network/droid_client.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/core/utils/types.dart';
import 'package:stream_droid_app/data/models/asset.dart';

class RedeemCardAssetListViewModel extends ChangeNotifier {
  RedeemCardAssetListViewModel(this.redeemId, this.userContext) {
    _httpClient = DependencyManager.getIt.get<IDroidClient>();
  }

  final String redeemId;
  final UserContext userContext;
  late IDroidClient _httpClient;

  List<Asset> redeemAssets = [];
  bool loading = false;

  Future<void> fetchChannelRedeems() async {
    if (!loading) {
      loading = true;
      notifyListeners();
    }

    final httpClient = DependencyManager.getIt.get<IDroidClient>();
    final data = await httpClient.get(
        urlFragment: UrlFragment.rewardAssets, id: redeemId);
    final parsed = (jsonDecode(data) as List).cast<Map<String, dynamic>>();

    redeemAssets = parsed.isEmpty
        ? []
        : parsed.map<Asset>((json) => Asset.fromJson(json)).toList();
    loading = false;
    notifyListeners();
  }

  Future<void> addRedeemAssets() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'mp4'],
      allowMultiple: true,
    );

    if (result != null) {
      final files = result.paths.map((path) => File(path!)).toList();
      final volume = userContext.defaultMediaAssetVolume.toInt().toString();

      loading = true;
      notifyListeners();

      await _httpClient.multipart(
          urlFragment: UrlFragment.rewardAssets,
          id: redeemId,
          fields: {"volume": volume},
          files: files);
      await fetchChannelRedeems();
    }
  }

  Future<void> removeRedeemAsset(String fileName) async {
    loading = true;
    notifyListeners();

    await _httpClient.delete(
        urlFragment: UrlFragment.rewardAssets,
        id: redeemId,
        headers: {"ASSET_NAME": fileName});
    await fetchChannelRedeems();
  }
}
