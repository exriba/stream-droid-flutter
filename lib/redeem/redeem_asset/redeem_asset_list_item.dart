import 'package:flutter/material.dart';
import 'package:stream_droid_app/common/types.dart';
import 'package:stream_droid_app/setting/volume_setting.dart';

class RedeemAssetListItem extends StatefulWidget {
  const RedeemAssetListItem(
      {super.key, required this.asset, required this.handleRemove});
  final Asset asset;
  final void Function() handleRemove;

  @override
  State<StatefulWidget> createState() => _RedeemAssetListItem();
}

class _RedeemAssetListItem extends State<RedeemAssetListItem> {
  @override
  void initState() {
    super.initState();
  }

  void updateVolume(double value) {
    setState(() {
      widget.asset.volume = value.toInt();
    });
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
            child: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Text(
              widget.asset.fileName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          VolumeSetting(
            volume: widget.asset.volume.toDouble(),
            handleVolumeChange: (value) {
              updateVolume(value);
            },
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: IconButton(
              color: Colors.white,
              icon: const Icon(Icons.delete),
              onPressed: widget.handleRemove,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
