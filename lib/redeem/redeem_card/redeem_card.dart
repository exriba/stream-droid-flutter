import 'package:flutter/material.dart';
import 'package:stream_droid_app/util/droid_client.dart';
import 'package:stream_droid_app/common/types.dart';
import 'package:stream_droid_app/util/dependency_manager.dart';

class RedeemCard extends StatefulWidget {
  const RedeemCard({super.key, required this.redeem});
  final Redeem redeem;

  @override
  State<StatefulWidget> createState() => _RedeemCard();
}

class _RedeemCard extends State<RedeemCard> {
  Speech speech = Speech(enabled: false);

  @override
  void initState() {
    super.initState();
    speech = widget.redeem.speech ?? speech;
  }

  Future<void> toggleTextToSpeech(bool value) async {
    final redeemSpeech = Speech(enabled: value);
    final httpClient = DependencyManager.getIt.get<IDroidClient>();
    await httpClient.put(
        urlFragment: UrlFragment.rewardSpeech,
        id: widget.redeem.id,
        object: redeemSpeech);
    setState(() {
      speech = redeemSpeech;
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
                child: SizedBox(
                  width: 100,
                  child: Text(
                    widget.redeem.title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
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
                        value: speech.enabled,
                        activeThumbColor: Colors.black,
                        onChanged: toggleTextToSpeech,
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
}
