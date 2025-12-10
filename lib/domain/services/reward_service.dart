import 'dart:io';
import 'dart:convert';
import 'package:stream_droid_app/core/network/droid_client.dart';
import 'package:stream_droid_app/core/utils/types.dart';
import 'package:stream_droid_app/data/models/asset.dart';
import 'package:stream_droid_app/data/models/redeem.dart';
import 'package:stream_droid_app/data/models/speech.dart';

class RewardService {
  RewardService(this._httpClient);
  final IDroidClient _httpClient;

  Future<List<Redeem>> fetchRedeems() async {
    final data = await _httpClient.get(urlFragment: UrlFragment.rewards);
    final parsed = (jsonDecode(data) as List).cast<Map<String, dynamic>>();
    return parsed.isEmpty
        ? []
        : parsed.map((json) => Redeem.fromJson(json)).toList();
  }

  Future<Redeem?> fetchRedeem(String redeemId) async {
    final data =
        await _httpClient.get(urlFragment: UrlFragment.reward, id: redeemId);
    final json = jsonDecode(data);
    return Redeem.fromJson(json);
  }

  Future<void> updateTextToSpeech(String redeemId, Speech speech) async {
    await _httpClient.put(
        urlFragment: UrlFragment.rewardSpeech, id: redeemId, object: speech);
  }

  Future<List<Asset>> fetchRedeemAssets(String redeemId) async {
    final data = await _httpClient.get(
        urlFragment: UrlFragment.rewardAssets, id: redeemId);
    final parsed = (jsonDecode(data) as List).cast<Map<String, dynamic>>();
    return parsed.isEmpty
        ? []
        : parsed.map<Asset>((json) => Asset.fromJson(json)).toList();
  }

  Future<void> addRedeemAssets(
      String redeemId, double volume, List<File> files) async {
    await _httpClient.multipart(
        urlFragment: UrlFragment.rewardAssets,
        id: redeemId,
        fields: {"volume": volume.toInt().toString()},
        files: files);
  }

  Future<void> deleteRedeemAsset(String redeemId, String fileName) async {
    await _httpClient.delete(
        urlFragment: UrlFragment.rewardAssets,
        id: redeemId,
        headers: {"ASSET_NAME": fileName});
  }
}
