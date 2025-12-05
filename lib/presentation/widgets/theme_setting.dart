import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:stream_droid_app/core/context/theme_context.dart';

class ThemeSetting extends StatelessWidget {
  const ThemeSetting({super.key, required this.text});
  final Text text;

  ColorPicker _createColorPicker(
      BuildContext context, ThemeContext themeContext) {
    return ColorPicker(
      width: 40,
      height: 40,
      borderRadius: 4,
      wheelDiameter: 200,
      wheelSquarePadding: 10,
      color: themeContext.backgroundColor,
      onColorChanged: (Color color) {
        themeContext.updateBackgroundColor(color);
      },
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: false,
        ColorPickerType.accent: false,
        ColorPickerType.bw: false,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: true,
      },
      actionButtons: const ColorPickerActionButtons(
        dialogActionButtons: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: text,
        ),
        Consumer<ThemeContext>(builder: (context, themeContext, child) {
          final colorPicker = _createColorPicker(context, themeContext);

          return ColorIndicator(
            width: 44,
            height: 44,
            hasBorder: true,
            color: themeContext.backgroundColor,
            borderColor: Colors.white,
            onSelectFocus: true,
            onSelect: () async {
              await colorPicker.showPickerDialog(
                context,
                elevation: 5,
                shadowColor: Colors.black,
                backgroundColor: ThemeContext.defaultNavigationColor,
                transitionBuilder: (BuildContext context,
                    Animation<double> animation1,
                    Animation<double> animation2,
                    Widget widget) {
                  final double curvedValue =
                      Curves.easeInOutBack.transform(animation1.value) - 1.0;
                  return Transform(
                    transform:
                        Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
                    child: Opacity(
                      opacity: animation1.value,
                      child: widget,
                    ),
                  );
                },
                transitionDuration: const Duration(
                  milliseconds: 400,
                ),
                constraints: const BoxConstraints(
                  minHeight: 460,
                  minWidth: 300,
                  maxWidth: 320,
                ),
              );
            },
          );
        }),
      ],
    );
  }
}
