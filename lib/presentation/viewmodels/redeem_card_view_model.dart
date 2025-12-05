import 'package:flutter/material.dart';
import 'package:stream_droid_app/core/network/droid_client.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/core/utils/types.dart';
import 'package:stream_droid_app/data/models/redeem.dart';
import 'package:stream_droid_app/data/models/speech.dart';

class RedeemCardViewModel extends ChangeNotifier {
  RedeemCardViewModel(Redeem redeem) {
    speech = redeem.speech ?? Speech(enabled: false);
    redeemId = redeem.id;
  }

  late Speech speech;
  late String redeemId;

  Future<void> toggleTextToSpeech(bool value) async {
    final redeemSpeech = Speech(enabled: value);
    final httpClient = DependencyManager.getIt.get<IDroidClient>();
    await httpClient.put(
        urlFragment: UrlFragment.rewardSpeech,
        id: redeemId,
        object: redeemSpeech);

    speech = redeemSpeech;
    notifyListeners();
  }
}
