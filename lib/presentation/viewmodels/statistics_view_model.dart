import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stream_droid_app/core/network/droid_client.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/core/utils/types.dart';
import 'package:stream_droid_app/data/models/redeem_redemption.dart';

class StatisticsViewModel extends ChangeNotifier {
  List<RedeemRedemption> channelRedeemRedemptions = [];
  bool loading = false;

  Future<void> fetchChannelRedeemRedemptions() async {
    loading = true;
    notifyListeners();

    final httpClient = DependencyManager.getIt.get<IDroidClient>();
    final data = await httpClient.get(urlFragment: UrlFragment.redemptions);
    final parsed = (jsonDecode(data) as List).cast<Map<String, dynamic>>();

    channelRedeemRedemptions = parsed.isEmpty
        ? <RedeemRedemption>[]
        : parsed
            .map<RedeemRedemption>((json) => RedeemRedemption.fromJson(json))
            .toList();
    loading = false;
    notifyListeners();
  }
}
