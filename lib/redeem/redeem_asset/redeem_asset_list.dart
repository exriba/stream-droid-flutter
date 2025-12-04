import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/common/types.dart';
import 'package:stream_droid_app/util/droid_client.dart';
import 'package:stream_droid_app/context/user_context.dart';
import 'package:stream_droid_app/layout/loading_view.dart';
import 'package:stream_droid_app/redeem/redeem_asset/redeem_asset_list_item.dart';
import 'package:stream_droid_app/util/dependency_manager.dart';

class RedeemAssetList extends StatefulWidget {
  const RedeemAssetList({super.key, required this.redeemId});
  final String redeemId;

  @override
  State<StatefulWidget> createState() => _RedeemAssetList();
}

class _RedeemAssetList extends State<RedeemAssetList> {
  late Future<List<Asset>> redeemAssets;
  late IDroidClient httpClient;
  late bool loading = false;

  @override
  void initState() {
    super.initState();
    httpClient = DependencyManager.getIt.get<IDroidClient>();
    redeemAssets = _fetchRedeemAssets();
  }

  Future<List<Asset>> _fetchRedeemAssets() async {
    final data = await httpClient.get(
        urlFragment: UrlFragment.rewardAssets, id: widget.redeemId);
    final parsed = (jsonDecode(data) as List).cast<Map<String, dynamic>>();
    return parsed.isEmpty
        ? <Asset>[]
        : parsed.map<Asset>((json) => Asset.fromJson(json)).toList();
  }

  Future<void> _addRedeemAssets(UserContext userContext) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'mp4'],
      allowMultiple: true,
    );

    if (result != null) {
      final files = result.paths.map((path) => File(path!)).toList();
      final volume = userContext.defaultMediaAssetVolume.toInt().toString();
      final future = httpClient.multipart(
          urlFragment: UrlFragment.rewardAssets,
          id: widget.redeemId,
          fields: {"volume": volume},
          files: files);

      future.whenComplete(() {
        setState(() {
          loading = false;
          redeemAssets = _fetchRedeemAssets();
        });
      });

      setState(() {
        loading = true;
      });
    }
  }

  void _removeRedeemAsset(String fileName) {
    final future = httpClient.delete(
        urlFragment: UrlFragment.rewardAssets,
        id: widget.redeemId,
        headers: {"ASSET_NAME": fileName});

    future.whenComplete(() {
      setState(() {
        loading = false;
        redeemAssets = _fetchRedeemAssets();
      });
    });

    setState(() {
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userContext = context.read<UserContext>();

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[700],
        body: FutureBuilder<List<Asset>>(
            future: redeemAssets,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                Error.throwWithStackTrace(
                    snapshot.error!, snapshot.stackTrace!);
              }

              if (loading ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingView();
              }

              if (snapshot.hasData) {
                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  itemCount: snapshot.data!.length,
                  prototypeItem: snapshot.data!.isNotEmpty
                      ? RedeemAssetListItem(
                          key: Key(snapshot.data!.first.id),
                          asset: snapshot.data!.first,
                          redeemId: widget.redeemId,
                          handleRemove: _removeRedeemAsset,
                        )
                      : null,
                  itemBuilder: (context, index) {
                    return RedeemAssetListItem(
                      key: Key(snapshot.data![index].id),
                      asset: snapshot.data![index],
                      redeemId: widget.redeemId,
                      handleRemove: _removeRedeemAsset,
                    );
                  },
                );
              }

              return const LoadingView();
            }),
        floatingActionButton: FloatingActionButton(
          mini: true,
          heroTag: null,
          onPressed: () async {
            await _addRedeemAssets(userContext);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
