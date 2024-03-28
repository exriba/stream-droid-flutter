// import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:stream_droid_app/common/types.dart';
import 'package:stream_droid_app/redeem/redeem_asset/redeem_asset_list_item.dart';

class RedeemAssetList extends StatefulWidget {
  const RedeemAssetList({super.key, required this.redeemId});
  final String redeemId;

  @override
  State<StatefulWidget> createState() => _RedeemAssetList();
}

class _RedeemAssetList extends State<RedeemAssetList> {
  late List<Asset> assets = [Asset(id: '1', fileName: 'file.mp4')];

  @override
  void initState() {
    super.initState();
    fetchRedeemAssets();
  }

  Future<void> fetchRedeemAssets() async {
    // final data =
    //     await rootBundle.loadString("assets/mock-channel-redeems.json");
    // final parsed = (jsonDecode(data) as List).cast<Map<String, dynamic>>();
    // return parsed.isEmpty
    //     ? <Asset>[]
    //     : parsed.map<Asset>((json) => Asset.fromJson(json)).toList();
  }

  void removeAsset(int index) {
    setState(() {
      assets.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[700],
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          itemCount: assets.length,
          prototypeItem: assets.isNotEmpty
              ? RedeemAssetListItem(
                  asset: assets.first,
                  handleRemove: () => removeAsset(0),
                )
              : null,
          itemBuilder: (context, index) {
            return RedeemAssetListItem(
              asset: assets[index],
              handleRemove: () => removeAsset(0),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          foregroundColor: const Color.fromRGBO(33, 33, 33, 1),
          backgroundColor: const Color.fromRGBO(33, 33, 33, 1),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
