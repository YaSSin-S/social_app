// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/modules/login_screen/login_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

Map<int, Color> color =
{
  50:Color.fromRGBO(51, 153, 255, .1),
  100:Color.fromRGBO(51, 153, 255, .2),
  200:Color.fromRGBO(51, 153, 255, .3),
  300:Color.fromRGBO(51, 153, 255, .4),
  400:Color.fromRGBO(51, 153, 255, .5),
  500:Color.fromRGBO(51, 153, 255, .6),
  600:Color.fromRGBO(51, 153, 255, .7),
  700:Color.fromRGBO(51, 153, 255, .8),
  800:Color.fromRGBO(51, 153, 255, .9),
  900:Color.fromRGBO(51, 153, 255, 1),
};

const Color defaultColor = Color(0xFF192154);

ThemeData lightTheme = ThemeData(
  textTheme: TextTheme(
    headline3: TextStyle(
      color: Colors.black,
    ),
  ),
  // canvasColor: Colors.transparent,
  // scaffoldBackgroundColor: Colors.transparent,
  primaryColor: defaultColor,
  primarySwatch: MaterialColor(0xFF192154, color),
  appBarTheme: AppBarTheme(
    color: Colors.white,
    elevation: 1,
    titleTextStyle: TextStyle(
      fontSize: 28,
    ),
    iconTheme: IconThemeData(
      color: defaultColor,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedIconTheme: IconThemeData(
      color: defaultColor,
    ),
    unselectedIconTheme: IconThemeData(
      color: Colors.grey,
    ),
    selectedLabelStyle: TextStyle(
      color: defaultColor,
    ),
    unselectedLabelStyle: TextStyle(
      color: Colors.grey,
    ),
    selectedItemColor: defaultColor,
    // showUnselectedLabels: true,
  ),
);
ThemeData darkTheme = ThemeData(
  textTheme: const TextTheme(
    headline6: TextStyle(
      color: Colors.white,
    ),
    headline3: TextStyle(
      color: Colors.white,
    ),
  ),
  canvasColor: Colors.transparent,
  scaffoldBackgroundColor: Colors.grey[900],
  primaryColor: defaultColor,
  primarySwatch: MaterialColor(0xFF192154, color),
  appBarTheme: const AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
  ),
);

void signOut(
  context,
) {
  CacheHelper.removeToken(key: 'token').then((value) {
    if (value) {
      navigateNoReturn(context, LoginScreen());
    }
  });
}


void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token;

String? uID;

extension StringCasingExtension on String {
  String toCapitalized() => this.length > 0 ?'${this[0].toUpperCase()}${this.substring(1)}':'';
  String get toTitleCase => this.replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.toCapitalized()).join(" ");
}

final formatCurrency = NumberFormat.currency(symbol: 'L.E');
