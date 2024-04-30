import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:stream_droid_app/common/types.dart';
import 'package:stream_droid_app/api/custom_http_client.dart';
import 'package:stream_droid_app/context/user_context.dart';
import 'package:stream_droid_app/layout/loading_view.dart';
import 'package:stream_droid_app/redeem/redeem_asset/redeem_asset_list_item.dart';
import 'package:stream_droid_app/util/dependency_manager.dart';

class RedeemAssetList extends StatefulWidget {
  const RedeemAssetList(
      {super.key, required this.userContext, required this.redeemId});
  final UserContext userContext;
  final String redeemId;

  @override
  State<StatefulWidget> createState() => _RedeemAssetList();
}

class _RedeemAssetList extends State<RedeemAssetList> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  void setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  Future<List<Asset>> fetchRedeemAssets() async {
    final httpClient = DependencyManager.getIt.get<ICustomHttpClient>();
    final data = await httpClient.get(
        urlFragment: UrlFragment.rewardAssets, id: widget.redeemId);
    final parsed = (jsonDecode(data) as List).cast<Map<String, dynamic>>();
    return parsed.isEmpty
        ? <Asset>[]
        : parsed.map<Asset>((json) => Asset.fromJson(json)).toList();
  }

  Future<void> addRedeemAssets() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'mp4'],
      allowMultiple: true,
    );

    if (result != null) {
      final files = result.paths.map((path) => File(path!)).toList();
      final httpClient = DependencyManager.getIt.get<ICustomHttpClient>();
      final volume =
          widget.userContext.defaultMediaAssetVolume.toInt().toString();
      httpClient
          .multipart(
              urlFragment: UrlFragment.rewardAssets,
              id: widget.redeemId,
              fields: {"volume": volume},
              files: files)
          .whenComplete(() => setLoading(false));
      setState(() => setLoading(true));
    }
  }

  void removeRedeemAsset(String fileName) {
    final httpClient = DependencyManager.getIt.get<ICustomHttpClient>();
    httpClient.delete(
        urlFragment: UrlFragment.rewardAssets,
        id: widget.redeemId,
        headers: {
          "ASSET_NAME": fileName
        }).whenComplete(() => setLoading(false));
    setState(() => setLoading(true));
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
        body: FutureBuilder<List<Asset>>(
            future: fetchRedeemAssets(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                Error.throwWithStackTrace(
                    snapshot.error!, snapshot.stackTrace!);
              }

              if (snapshot.hasData && !loading) {
                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  itemCount: snapshot.data!.length,
                  prototypeItem: snapshot.data!.isNotEmpty
                      ? RedeemAssetListItem(
                          key: Key(snapshot.data!.first.id),
                          asset: snapshot.data!.first,
                          redeemId: widget.redeemId,
                          handleRemove: removeRedeemAsset,
                        )
                      : null,
                  itemBuilder: (context, index) {
                    return RedeemAssetListItem(
                      key: Key(snapshot.data![index].id),
                      asset: snapshot.data![index],
                      redeemId: widget.redeemId,
                      handleRemove: removeRedeemAsset,
                    );
                  },
                );
              }

              return const LoadingView();
            }),
        floatingActionButton: FloatingActionButton(
          mini: true,
          onPressed: addRedeemAssets,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
