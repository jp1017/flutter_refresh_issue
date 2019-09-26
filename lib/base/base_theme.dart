import 'package:flutter/material.dart';
import 'package:flutter_refresh_issue/colors.dart';

const pageTransitions = const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    });

final ThemeData whiteTheme = ThemeData(
    primaryColor: Colors.white,
    accentColor: Colours.primary,
    backgroundColor: Colours.white,
    toggleableActiveColor: Color(0xFF758FFF),
    hintColor: Colours.bg_AEAEBA,
    ///加上这两个透明颜色，去掉InkWell点击效果
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    pageTransitionsTheme: pageTransitions);

final ThemeData mainTheme = ThemeData(
    primaryColor: Colours.primary,
    accentColor: Colours.primary,
    backgroundColor: Colours.white,
    hintColor: Colours.bg_AEAEBA,
    ///加上这两个透明颜色，去掉InkWell点击效果
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    toggleableActiveColor: Color(0xFF758FFF),
    pageTransitionsTheme: pageTransitions);
