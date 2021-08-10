
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../theme.dart';

class ChangeThemeButtonWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // TODO: implement build

    return Switch.adaptive(

      // activeTrackColor: myWhite1,
      inactiveThumbColor: myWhite1,
      focusColor: myWhite1,

      inactiveTrackColor: myWhite2,
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
    // throw UnimplementedError();
  }

}