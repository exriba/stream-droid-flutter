import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/core/context/preference_context.dart';
import 'package:stream_droid_app/presentation/viewmodels/reward_card_asset_list_view_model.dart';
import 'package:stream_droid_app/presentation/widgets/circular_progress.dart';
import 'package:stream_droid_app/presentation/widgets/reward_card_asset.dart';

class RewardCardAssetList extends StatelessWidget {
  const RewardCardAssetList({super.key, required this.rewardId});
  final String rewardId;

  @override
  Widget build(BuildContext context) {
    final preferenceContext =
        Provider.of<PreferenceContext>(context, listen: false);
    final defaultMediaAssetVolume = preferenceContext.defaultMediaAssetVolume;

    return ChangeNotifierProvider(
      create: (context) {
        final viewModel =
            RewardCardAssetListViewModel(rewardId, defaultMediaAssetVolume);
        viewModel.loadRewardAssets();
        return viewModel;
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Consumer<RewardCardAssetListViewModel>(
          builder: (context, viewModel, child) {
            return Scaffold(
              backgroundColor: Colors.grey[700],
              body: viewModel.loading
                  ? const CircularProgress()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 8),
                      itemCount: viewModel.rewardAssets.length,
                      prototypeItem: viewModel.rewardAssets.isNotEmpty
                          ? RewardCardAsset(
                              key: Key(viewModel.rewardAssets.first.id),
                              asset: viewModel.rewardAssets.first,
                              rewardId: rewardId,
                              handleRemove: viewModel.removeRewardAsset,
                            )
                          : null,
                      itemBuilder: (context, index) {
                        return RewardCardAsset(
                          key: Key(viewModel.rewardAssets[index].id),
                          asset: viewModel.rewardAssets[index],
                          rewardId: rewardId,
                          handleRemove: viewModel.removeRewardAsset,
                        );
                      },
                    ),
              floatingActionButton: FloatingActionButton(
                mini: true,
                heroTag: null,
                onPressed: () async {
                  await viewModel.addRewardAssets();
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
