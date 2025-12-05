import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stream_droid_app/core/network/droid_client.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/core/utils/types.dart';
import 'package:stream_droid_app/data/models/redeem.dart';

class RedeemScreenViewModel extends ChangeNotifier {
  RedeemScreenViewModel({required this.redeemId});
  final String redeemId;
  bool loading = false;
  Redeem? redeem;

  Future<void> fetchRedeem() async {
    loading = true;
    notifyListeners();

    final httpClient = DependencyManager.getIt.get<IDroidClient>();
    final data =
        await httpClient.get(urlFragment: UrlFragment.reward, id: redeemId);
    final json = jsonDecode(data);

    redeem = Redeem.fromJson(json);
    loading = false;
    notifyListeners();
  }
}
