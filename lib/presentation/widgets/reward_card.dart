import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/domain/generated/common/reward.pb.dart';
import 'package:stream_droid_app/presentation/viewmodels/reward_card_view_model.dart';

class RewardCard extends StatelessWidget {
  const RewardCard({super.key, required this.reward});
  final Reward reward;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: 100,
                  child: Text(
                    reward.title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Image.network(reward.imageUrl),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    reward.prompt,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: ChangeNotifierProvider(
            create: (context) => RewardCardViewModel(reward.id, reward.speech),
            child: LayoutBuilder(builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ListTile(
                            leading: const Icon(
                              Icons.record_voice_over,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Text to Speech',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Consumer<RewardCardViewModel>(
                          builder: (context, viewModel, child) {
                            return Switch(
                              value: viewModel.speech.enabled,
                              activeThumbColor: Colors.black,
                              onChanged: (value) async {
                                await viewModel.toggleTextToSpeech(value);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
