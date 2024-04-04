import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class _AppBarButton {
  const _AppBarButton({required this.icon, required this.action});
  final IconData icon;
  final Future<void> Function() action;
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  static final List<_AppBarButton> _appBarButtons = [
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
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Image.asset(
              "assets/icons/app-icon.png",
              height: 24,
              width: 24,
            ),
          ),
          Expanded(
            flex: 1,
            child: DragToMoveArea(
              child: Container(),
            ),
          ),
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: _appBarButtons
                  .map((btn) => InkWell(
                      hoverColor: Colors.grey,
                      onTap: btn.action,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          btn.icon,
                          size: 20,
                        ),
                      )))
                  .toList()),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(36.0);
}
