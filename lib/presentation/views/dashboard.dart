import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:stream_droid_app/core/utils/types.dart';
import 'package:stream_droid_app/presentation/viewmodels/dashboard_view_model.dart';
import 'package:stream_droid_app/presentation/widgets/circular_progress.dart';
import 'package:stream_droid_app/core/utils/hex_color.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(builder: (context, viewModel, child) {
      if (viewModel.loading) {
        return const CircularProgress();
      }

      return GridView.count(
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        padding: const EdgeInsets.all(5),
        crossAxisCount:
            responsiveValue(context, xs: 1, sm: 2, md: 3, lg: 4, xl: 5),
        childAspectRatio: 1.4,
        // TODO: Convert to custom widget. Add zoom animation.
        children: viewModel.channelRedeems
            .map(
              (redeem) => Material(
                color: Colors.transparent,
                child: InkWell(
                  mouseCursor: SystemMouseCursors.click,
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Card(
                    key: Key(redeem.id),
                    elevation: 5,
                    color: HexColor.fromHex(redeem.backgroundColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network(redeem.imageUrl),
                        Text(
                          redeem.title,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    final redeemRoute =
                        ViewRoute.redeems.route.replaceFirst(':id', redeem.id);
                    context.go(redeemRoute);
                  },
                ),
              ),
            )
            .toList(),
      );
    });
  }
}
