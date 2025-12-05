import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/data/models/asset.dart';
import 'package:stream_droid_app/domain/services/redeem_service.dart';

class RedeemCardAssetListViewModel extends ChangeNotifier {
  RedeemCardAssetListViewModel(this._redeemId, this._defaultVolume) {
    _redeemService = DependencyManager.getIt.get<RedeemService>();
  }
  final String _redeemId;
  final double _defaultVolume;
  late RedeemService _redeemService;

  List<Asset> redeemAssets = [];
  bool loading = false;

  Future<void> loadRedeemAssets() async {
    if (!loading) {
      loading = true;
      notifyListeners();
    }

    redeemAssets = await _redeemService.fetchRedeemAssets(_redeemId);

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
      loading = true;
      notifyListeners();

      await _redeemService.addRedeemAssets(_redeemId, _defaultVolume, files);
      await loadRedeemAssets();
    }
  }

  Future<void> removeRedeemAsset(String fileName) async {
    loading = true;
    notifyListeners();

    await _redeemService.deleteRedeemAsset(_redeemId, fileName);
    await loadRedeemAssets();
  }
}
