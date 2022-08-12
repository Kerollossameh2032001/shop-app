import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/chanege_cart.dart';
import 'package:shop_app/models/change_favorites.dart';
import 'package:shop_app/models/get_favorites_data_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/constants/reusable_componants.dart';
import 'package:shop_app/shared/end_points/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../../models/get_cart_data_model.dart';
import '../../models/home_model.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  double angle = 1.0;
  bool edit = false;
  bool update = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void changeEdit() {
    edit = !edit;
    emit(LayoutProfileChangeShowToEditState());
  }

  void changeUpdateButton(bool value) {
    update = value;
    emit(LayoutProfileChangeUpdateButtonState());
  }

  void openClosedDrawer({
    required DragUpdateDetails value,
  }) {
    value.delta.dx > 0 ? angle = 1.0 : angle = 0.0;
    emit(LayoutChangeAngleState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  Map<int, bool> carts = {};

  void getHomeData() {
    emit(LayoutHomeDataLoadingState());
    DioHelper.getData(url: HOME, token: token, lang: 'en').then((value) {
      print("data get");
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });

      homeModel!.data.products.forEach((element) {
        carts.addAll({element.id: element.inCart});
      });
      print(favorites);
      emit(LayoutHomeDataSuccesState());
    }).catchError((error) {
      print('Error ${error.toString()}');
      emit(LayoutHomeDataErrorState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    emit(LayoutCategoriesDataLoadingState());
    DioHelper.getData(url: CATEGOTIES, lang: 'en').then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      print(categoriesModel!.data.data[0].name);

      emit(LayoutCategoriesDataSuccesState());
    }).catchError((error) {
      print('Error ${error.toString()}');
      emit(LayoutCategoriesDataErrorState());
    });
  }

  SearchModel? searchModel;

  void SearchData({
    required String? text,
  }) {
    emit(LayoutSearchDataLoadingState());
    DioHelper.postData(
      url: SEARCH,
      data: {'text': text},
      lang: 'en',
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print('name : ${searchModel!.data.data[0].name}');
      emit(LayoutSearchDataSuccesState());
    }).catchError((error) {
      print(error.toString());
      emit(LayoutSearchDataErrorState());
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;

  void changeFavorites({required int productId}) {
    favorites[productId] = !favorites[productId]!;
    emit(LayoutChangeFavoritesLoadingState());
    DioHelper.postData(
        url: FAVORITES,
        token: token,
        lang: 'en',
        data: {'product_id': productId}).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      print('name : ${changeFavoriteModel!.message}');
      if (!changeFavoriteModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesData();
      }
      emit(LayoutChangeFavoritesSuccesState(changeFavoriteModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      print(error.toString());
      emit(LayoutChangeFavoritesErrorState());
    });
  }

  FavoritesData? favoritesData;
  void getFavoritesData() {
    emit(LayoutGetFavoritesDataLoadingState());
    DioHelper.getData(url: FAVORITES, token: token, lang: 'en').then((value) {
      favoritesData = FavoritesData.fromJson(value.data);
      print(favoritesData!.data!.data![0].product!.description);
      emit(LayoutGetFavoritesDataSuccesState());
    }).catchError((error) {
      print('Error ${error.toString()}');
      emit(LayoutGetFavoritesDataErrorState());
    });
  }

  LoginModel? profileData;

  void getProfileData() {
    emit(LayoutProfileDataLoadingState());
    DioHelper.getData(url: PROFLE, token: token, lang: 'en').then((value) {
      profileData = LoginModel.fromJson(value.data);
      nameController.text = profileData!.data!.name;
      emailController.text = profileData!.data!.email;
      phoneController.text = profileData!.data!.phone;
      emit(LayoutProfileDataSuccesState());
    }).catchError((error) {
      print('Error ${error.toString()}');
      emit(LayoutProfileDataErrorState());
    });
  }

  void getUpdateProfileData() {
    emit(LayoutUpdateProfileDataLoadingState());
    DioHelper.putData(
            url: UPDATE_PRFILE,
            data: {
              'name': nameController.text,
              'email': emailController.text,
              'phone': phoneController.text,
            },
            token: token,
            lang: 'en').then((value) {
      profileData = LoginModel.fromJson(value.data);
      nameController.text = profileData!.data!.name;
      emailController.text = profileData!.data!.email;
      phoneController.text = profileData!.data!.phone;
      changeUpdateButton(false);
      emit(LayoutUpdateProfileDataSuccesState(profileData!));
    }).catchError((error) {
      print('Error ${error.toString()}');
      emit(LayoutUpdateProfileDataErrorState());
    });
  }


  ChangeCarts? changeCartsModel;
  void changeCarts({required int productId}) {
    carts[productId] = !carts[productId]!;
    emit(LayoutChangeCartsLoadingState());
    DioHelper.postData(
        url: CART,
        token: token,
        lang: 'en',
        data: {'product_id': productId}).then((value) {
      changeCartsModel = ChangeCarts.fromJson(value.data);
      //print('name : ${changeFavoriteModel!.message}');
      if (!changeCartsModel!.status) {
        carts[productId] = !carts[productId]!;
      }else{
        getCartData();
      }
      emit(LayoutChangeCartsSuccesState(changeCartsModel!));
    }).catchError((error) {
      carts[productId] = !carts[productId]!;
      print(error.toString());
      emit(LayoutChangeCartsErrorState());
    });
  }

  GetCartData? cartData;
  void getCartData() {
    emit(LayoutGetCartDataLoadingState());
    DioHelper.getData(url: CART, token: token, lang: 'en').then((value) {
      cartData = GetCartData.fromJson(value.data);
      //print(cartData.data.cartItem[0].product.)
      emit(LayoutGetCartDataSuccesState());
    }).catchError((error) {
      print('Error ${error.toString()}');
      emit(LayoutGetCartDataErrorState());
    });
  }
}
