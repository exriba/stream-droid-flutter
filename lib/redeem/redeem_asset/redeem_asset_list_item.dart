import 'package:flutter/material.dart';
import 'package:stream_droid_app/common/types.dart';
import 'package:stream_droid_app/api/custom_http_client.dart';
import 'package:stream_droid_app/setting/volume_setting.dart';
import 'package:stream_droid_app/util/dependency_manager.dart';

class RedeemAssetListItem extends StatelessWidget {
  const RedeemAssetListItem(
      {super.key,
      required this.redeemId,
      required this.asset,
      required this.handleRemove});
  final Asset asset;
  final String redeemId;
  final void Function(String fileName) handleRemove;

  Future<void> _updateAssetVolume(double volume) async {
    final httpClient = DependencyManager.getIt.get<ICustomHttpClient>();
    final map = {asset.fileName: volume.toInt()};
    await httpClient.put(
        urlFragment: UrlFragment.rewardAssets, id: redeemId, object: map);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Icon(
              asset.extension == MediaExtension.mp3
                  ? Icons.music_note_rounded
                  : Icons.play_arrow_rounded,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Text(
              asset.name,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          VolumeSetting(
            volume: asset.volume.toDouble(),
            handleVolumeChange: _updateAssetVolume,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: IconButton(
              color: Colors.red,
              icon: const Icon(Icons.delete),
              onPressed: () {
                handleRemove(asset.fileName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
