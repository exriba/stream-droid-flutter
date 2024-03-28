import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:stream_droid_app/common/types.dart';

class RedeemCard extends StatefulWidget {
  const RedeemCard({super.key, required this.redeem});
  final Redeem redeem;

  @override
  State<StatefulWidget> createState() => _RedeemCard();
}

class _RedeemCard extends State<RedeemCard> {
  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
  }

  void toggleTextToSpeech(bool value) {
    setState(() {
      widget.redeem.speech = Speech(enabled: value, voiceIndex: 0);
    });
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
                child: Text(
                  widget.redeem.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Flexible(
                flex: 1,
                child: Image.network(widget.redeem.imageUrl),
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
                    widget.redeem.prompt,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
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
                      child: Switch(
                        value: widget.redeem.speech?.enabled ?? false,
                        activeColor: Colors.black,
                        onChanged: (value) {
                          toggleTextToSpeech(value);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }
}
