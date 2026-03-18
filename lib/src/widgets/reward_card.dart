import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_droid_app/src/generated/common/reward.pb.dart';

class RewardCard extends ConsumerWidget {
  const RewardCard({super.key, required this.reward});
  final Reward reward;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  reward.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
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
                    color: Colors.purple[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    reward.prompt,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: ListTile(
                        leading: Icon(
                          Icons.record_voice_over,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Text to Speech',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Switch(
                      value: reward.speech.enabled,
                      activeThumbColor: Colors.black,
                      onChanged: (value) {
                        // TODO: Implement this
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
