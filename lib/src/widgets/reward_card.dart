import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_droid_app/src/generated/common/reward.pb.dart';
import 'package:stream_droid_app/src/providers/reward.dart';

class RewardCard extends ConsumerStatefulWidget {
  const RewardCard({super.key, required this.reward});
  final Reward reward;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RewardCard();
}

class _RewardCard extends ConsumerState<RewardCard> {
  bool enabled = false;

  @override
  void initState() {
    super.initState();
    enabled = widget.reward.speech.enabled;
  }

  Future<void> _handleSpeechChange(bool value) async {
    final service = ref.read(rewardServiceProvider);
    final response = await service.updateRewardSpeech(widget.reward.id, value);
    if (context.mounted) {
      setState(() {
        enabled = response;
      });
    }
  }

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
                child: Image.network(widget.reward.imageUrl),
              ),
              Flexible(
                flex: 1,
                child: Text(
                  widget.reward.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                    widget.reward.prompt,
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
                      value: enabled,
                      activeThumbColor: Colors.black,
                      onChanged: (value) async {
                        await _handleSpeechChange(value);
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
