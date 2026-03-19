import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:stream_droid_app/src/providers/reward.dart';
import 'package:stream_droid_app/src/utils/hex_color.dart';
import 'package:stream_droid_app/src/utils/types.dart';
import 'package:stream_droid_app/src/widgets/loading_spinner.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rewardState = ref.watch(rewardNotificationProvider);

    return rewardState.when(
      data: (rewards) {
        return GridView.count(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount:
              responsiveValue(context, xs: 1, sm: 2, md: 3, lg: 4, xl: 5),
          childAspectRatio: 1.5,
          children: rewards
              .map(
                (reward) => Material(
                  color: Colors.transparent,
                  child: InkWell(
                    mouseCursor: SystemMouseCursors.click,
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Card(
                      key: Key(reward.id),
                      elevation: 5,
                      color: HexColor.fromHex(reward.backgroundColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.network(reward.imageUrl),
                          Text(
                            reward.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      context.go(ViewRoute.rewards.route, extra: reward);
                    },
                  ),
                ),
              )
              .toList(),
        );
      },
      error: (_, __) => const SizedBox.shrink(),
      loading: () => const LoadingSpinner(),
    );
  }
}
