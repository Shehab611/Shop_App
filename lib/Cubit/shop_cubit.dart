// ignore_for_file: curly_braces_in_flow_control_structures


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/core/Cachehelper.dart';
import 'package:shop/core/Dio.dart';
import 'package:shop/models/HomeModel.dart';
import 'package:shop/models/ShopLoginModel.dart';
import 'package:shop/models/catigories_model.dart';
import 'package:shop/models/change_favourites_model.dart';
import 'package:shop/models/favourites_model.dart';
import 'package:shop/modules/CatigoriesScreen.dart';
import 'package:shop/modules/FavouritesScreen.dart';
import 'package:shop/modules/ProductsScreen.dart';



part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());
  int currentindex = 0;
  void changeindex(int index) {
    currentindex = index;

    emit(BottomNavigationState());
  }

  List screens = [
    const ProductsScreen(),
    const CatigoriesScreen(),
    const FavouritesScreen(),
   // const SettingsScreen()
  ];
  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: ' Products'),
    const BottomNavigationBarItem(icon: Icon(Icons.apps), label: ' Catigories'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: ' Favourites'),
    //const BottomNavigationBarItem( icon: Icon(Icons.settings), label: ' Settings'),
  ];

  HomeModel? productsModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getdata(url: 'home', auth: CacheHelper.getData(key: 'token'))
        .then((value) {
      productsModel = HomeModel.fromJson(value.data);

      for (var element in productsModel!.data.products) {
        favourites.addAll({element.id: element.infavorites});
      }

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCatigoriesData() {
    DioHelper.getdata(
            url: 'categories', auth: CacheHelper.getData(key: 'token'))
        .then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCatigoriesDataState());
    }).catchError((error) {
      emit(ShopErrorCatigoriesDataState());
    });
  }

  ChangeFavourtiesModel? changefavourtiesModel;
  late Map<int, bool> favourites = {};
  void changeFavourites(int productId) {
    favourites[productId] = !favourites[productId]!;
    emit(ShopSuccessChangeState());
    DioHelper.postdata(
        url: 'favorites',
        auth: CacheHelper.getData(key: 'token'),
        data: {'product_id': productId}).then((value) {
      changefavourtiesModel = ChangeFavourtiesModel.fromJson(value.data);
      if (!favourtiesModel!.status)
        favourites[productId] = !favourites[productId]!;
      else
        getFavouritesData();
      emit(ShopSuccessChangeFavouritesState(changefavourtiesModel!));
    }).catchError((error) {
      favourites[productId] = !favourites[productId]!;
      emit(ShopErrorChangeFavouritesState());
    });
  }

  FavourtiesModel? favourtiesModel;
  void getFavouritesData() {
    emit(ShopLoadingGetFavouritesDataState());
    DioHelper.getdata(url: 'favorites', auth: CacheHelper.getData(key: 'token'))
        .then((value) {
      favourtiesModel = FavourtiesModel.fromJson(value.data);

      emit(ShopSuccessGetFavouritesDataState());
    }).catchError((error) {
      emit(ShopErrorGetFavouritesDataState());
    });
  }

  ShopLoginModel? loginModel;
  void getUserData() {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getdata(url: 'profile', auth: CacheHelper.getData(key: 'token'))
        .then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessGetUserDataState());
    }).catchError((error) {
      emit(ShopErrorGetUserDataState());
    });
  }
}
