import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({super.key});

  // ignore: library_private_types_in_public_api
  final List<_AppBarButton> appBarButtons = [
    _AppBarButton(
      icon: Icons.horizontal_rule,
      action: () async => await windowManager.minimize(),
    ),
    _AppBarButton(
      icon: Icons.close,
      action: () async => await windowManager.close(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(33, 33, 33, 1),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: DragToMoveArea(
              child: Container(),
            ),
          ),
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: appBarButtons
                  .map((btn) => InkWell(
                      hoverColor: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          btn.icon,
                          size: 20,
                        ),
                      ),
                      onTap: () async => await btn.action()))
                  .toList()),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(36.0);
}

class _AppBarButton {
  const _AppBarButton({required this.icon, required this.action});

  final IconData icon;
  final Future<void> Function() action;
}
