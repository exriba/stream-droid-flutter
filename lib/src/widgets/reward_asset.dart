import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_droid_app/src/generated/common/reward.pb.dart';
import 'package:stream_droid_app/src/widgets/volume_slider.dart';

class RewardAsset extends ConsumerWidget {
  const RewardAsset({
    super.key,
    required this.rewardId,
    required this.asset,
    required this.handleRemove,
  });
  final Asset asset;
  final String rewardId;
  final Future<void> Function(String fileName) handleRemove;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Colors.purple[300],
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Icon(
              asset.mediaExtension == Asset_MediaExtension.MP3
                  ? Icons.music_note_rounded
                  : Icons.play_arrow_rounded,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Text(
              asset.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          VolumeSlider(
            volume: asset.volume.toDouble(),
            handleVolumeChange: (value) {
              // TODO: Implement this
            },
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: IconButton(
              color: Colors.red,
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await handleRemove(asset.fileName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
