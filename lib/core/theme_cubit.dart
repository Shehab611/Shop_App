import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/core/Cachehelper.dart';



part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());
  ThemeMode appmode = ThemeMode.dark;

  void changetheme() {
    if (appmode == ThemeMode.dark) {
      appmode = ThemeMode.light;
      CacheHelper.saveData(key: 'light', value: true)
          .then((value) => emit(NewsLightThemeState()));
    } else {
      appmode = ThemeMode.dark;
      CacheHelper.saveData(key: 'light', value: false)
          .then((value) => emit(NewsDarkThemeState()));
    }
  }
  ThemeData newsAppLighttheme() => ThemeData(
    primarySwatch: Colors.deepOrange,
     appBarTheme: const AppBarTheme(actionsIconTheme: IconThemeData(
      size: 14,
     ),
          elevation: 1,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.black),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark)),
      scaffoldBackgroundColor: Colors.white,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.deepOrange,
          elevation: 2),
      textTheme: const TextTheme(
          bodyText1: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)));
  ThemeData newsAppDarktheme() => ThemeData(
        appBarTheme: const AppBarTheme(
            elevation: 1,
            backgroundColor: Color.fromRGBO(51, 55, 57, 1),
            titleTextStyle: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            iconTheme: IconThemeData(color: Colors.white),
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.black,
                statusBarIconBrightness: Brightness.light)),
        scaffoldBackgroundColor: const Color.fromRGBO(51, 55, 57, 1),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color.fromRGBO(51, 55, 57, 1),
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.grey,
            elevation: 20),
        textTheme: const TextTheme(
            bodyText1: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      );
}
