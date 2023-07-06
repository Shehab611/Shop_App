import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Cubit/register_cubit.dart';
import 'package:shop/Cubit/shop_cubit.dart';
import 'package:shop/core/Cachehelper.dart';
import 'package:shop/core/Dio.dart';
import 'package:shop/core/theme_cubit.dart';
import 'package:shop/modules/onboarding.dart';

bool? isLight;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init(url: 'https://student.valuxapps.com/api/');
  runApp(const MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCatigoriesData()
            ..getFavouritesData()
            ..getUserData(),
        ),
      ],
      child: BlocConsumer<ThemeCubit, ThemeState>(
        listener: (context, state) {},
        builder: (context, state) {
          ThemeCubit cubit = BlocProvider.of(context);
          isLight = CacheHelper.getData(key: 'light');
          if (isLight != null) if (isLight!) cubit.appmode = ThemeMode.light;
          return MaterialApp(
            home:  OnBoardingScreen(),
            theme: cubit.newsAppLighttheme(),
            darkTheme: cubit.newsAppDarktheme(),
            themeMode: cubit.appmode,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}


