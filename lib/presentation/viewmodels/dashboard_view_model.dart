import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stream_droid_app/core/network/droid_client.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';
import 'package:stream_droid_app/core/utils/types.dart';
import 'package:stream_droid_app/data/models/redeem.dart';

class DashboardViewModel extends ChangeNotifier {
  List<Redeem> channelRedeems = [];
  bool loading = false;

  Future<void> fetchChannelRedeems() async {
    loading = true;
    notifyListeners();

    final httpClient = DependencyManager.getIt.get<IDroidClient>();
    final data = await httpClient.get(urlFragment: UrlFragment.rewards);
    final parsed = (jsonDecode(data) as List).cast<Map<String, dynamic>>();

    channelRedeems = parsed.isEmpty
        ? []
        : parsed.map<Redeem>((json) => Redeem.fromJson(json)).toList();
    loading = false;
    notifyListeners();
  }
}
