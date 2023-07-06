part of 'shop_cubit.dart';

@immutable
abstract class ShopState {}

class ShopInitial extends ShopState {}

class BottomNavigationState extends ShopState {}

class ShopLoadingHomeDataState extends ShopState {}

class ShopSuccessHomeDataState extends ShopState {}

class ShopErrorHomeDataState extends ShopState {}

class ShopSuccessCatigoriesDataState extends ShopState {}

class ShopErrorCatigoriesDataState extends ShopState {}

class ShopSuccessChangeFavouritesState extends ShopState {
 final ChangeFavourtiesModel model;
  ShopSuccessChangeFavouritesState(this.model);
}

class ShopSuccessChangeState extends ShopState {}

class ShopErrorChangeFavouritesState extends ShopState {}
class ShopSuccessGetFavouritesDataState extends ShopState {}

class ShopErrorGetFavouritesDataState extends ShopState {}
class ShopLoadingGetFavouritesDataState extends ShopState {}
class ShopSuccessGetUserDataState extends ShopState {}

class ShopErrorGetUserDataState extends ShopState {}
class ShopLoadingGetUserDataState extends ShopState {}