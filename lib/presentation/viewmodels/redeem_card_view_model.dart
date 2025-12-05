import 'package:flutter/material.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/data/models/speech.dart';
import 'package:stream_droid_app/domain/services/redeem_service.dart';

class RedeemCardViewModel extends ChangeNotifier {
  RedeemCardViewModel(this._redeemId, Speech? redeemSpeech) {
    speech = redeemSpeech ?? Speech(enabled: false);
    _redeemService = DependencyManager.getIt<RedeemService>();
  }
  final String _redeemId;
  late RedeemService _redeemService;
  late Speech speech;

  Future<void> toggleTextToSpeech(bool value) async {
    final redeemSpeech = Speech(enabled: value);
    await _redeemService.updateTextToSpeech(_redeemId, speech);

    speech = redeemSpeech;
    notifyListeners();
  }
}
