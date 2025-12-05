import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/core/context/preference_context.dart';
import 'package:stream_droid_app/presentation/viewmodels/redeem_card_asset_list_view_model.dart';
import 'package:stream_droid_app/presentation/widgets/circular_progress.dart';
import 'package:stream_droid_app/presentation/widgets/redeem_card_asset.dart';

class RedeemCardAssetList extends StatelessWidget {
  const RedeemCardAssetList({super.key, required this.redeemId});
  final String redeemId;

  @override
  Widget build(BuildContext context) {
    final preferenceContext =
        Provider.of<PreferenceContext>(context, listen: false);
    final defaultMediaAssetVolume = preferenceContext.defaultMediaAssetVolume;

    return ChangeNotifierProvider(
      create: (context) {
        final viewModel =
            RedeemCardAssetListViewModel(redeemId, defaultMediaAssetVolume);
        viewModel.loadRedeemAssets();
        return viewModel;
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Consumer<RedeemCardAssetListViewModel>(
          builder: (context, viewModel, child) {
            return Scaffold(
              backgroundColor: Colors.grey[700],
              body: viewModel.loading
                  ? const CircularProgress()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 8),
                      itemCount: viewModel.redeemAssets.length,
                      prototypeItem: viewModel.redeemAssets.isNotEmpty
                          ? RedeemCardAsset(
                              key: Key(viewModel.redeemAssets.first.id),
                              asset: viewModel.redeemAssets.first,
                              redeemId: redeemId,
                              handleRemove: viewModel.removeRedeemAsset,
                            )
                          : null,
                      itemBuilder: (context, index) {
                        return RedeemCardAsset(
                          key: Key(viewModel.redeemAssets[index].id),
                          asset: viewModel.redeemAssets[index],
                          redeemId: redeemId,
                          handleRemove: viewModel.removeRedeemAsset,
                        );
                      },
                    ),
              floatingActionButton: FloatingActionButton(
                mini: true,
                heroTag: null,
                onPressed: () async {
                  await viewModel.addRedeemAssets();
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
