import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:stream_droid_app/layout/navigation_view.dart';
import 'package:stream_droid_app/model/reward.dart';
import 'package:stream_droid_app/utils/hex_color.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  Future<List<Reward>> fetchRewards() async {
    await Future.delayed(const Duration(seconds: 5));
    final data = await rootBundle.loadString("assets/mock-rewards.json");
    final parsed = (jsonDecode(data) as List).cast<Map<String, dynamic>>();
    return parsed.isEmpty
        ? <Reward>[]
        : parsed.map<Reward>((json) => Reward.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Reward>>(
      future: fetchRewards(),
      builder: (context, AsyncSnapshot<List<Reward>> snapshot) {
        return NavigationView(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: snapshot.hasData
                    ? GridView.count(
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        padding: const EdgeInsets.all(5),
                        crossAxisCount: responsiveValue(context,
                            xs: 1, sm: 2, md: 3, lg: 4, xl: 5),
                        childAspectRatio: 1.4,
                        children: snapshot.data!
                            .map(
                              (reward) => Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Card(
                                    elevation: 5,
                                    color: HexColor.fromHex(
                                        reward.backgroundColor),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          leading:
                                              Image.network(reward.imageUrl),
                                          title: Text(reward.title,
                                              style: GoogleFonts.lato(
                                                textStyle: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    letterSpacing: 1),
                                              )),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            margin: const EdgeInsets.all(8),
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(reward.prompt,
                                                style: GoogleFonts.lato(
                                                  textStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      letterSpacing: 1),
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            )
                            .toList(),
                      )
                    : const Align(
                        child: CircularProgressIndicator(
                          color: Colors.grey,
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
