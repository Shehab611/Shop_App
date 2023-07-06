// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/Cubit/shop_cubit.dart';
import 'package:shop/core/Cachehelper.dart';
import 'package:shop/core/components1.dart';
import 'package:shop/core/theme_cubit.dart';
import 'package:shop/modules/Shop_Login.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
   
      },
      builder: (context, state) {
        ThemeCubit themecubit = BlocProvider.of(context);
        ShopCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Shop Screen',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    themecubit.changetheme();
                  },
                  icon: const Icon(Icons.brightness_4_outlined)),
              TextButton(
                  onPressed: () {
                    CacheHelper.removeData(key: 'token').then((value) {
                      if (value) {
                        navigatandfinsh(
                            context: context, screen: ShopLoginScreen());
                      }
                    });
                  },
                  child: const Text('Sign out')),
              /* IconButton(
                    onPressed: () {
                      themecubit.changetheme();
                    },
                    icon: const Icon(Icons.brightness))_ */
            ],
          ),
          body: cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.items,
            currentIndex: cubit.currentindex,
            onTap: (index) {
              cubit.changeindex(index);
            },
          ),
        );
      },
    );
  }
}
