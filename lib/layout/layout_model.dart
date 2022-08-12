import 'package:flutter/material.dart';
import 'package:shop_app/modules/categories/categories.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/home/home_screen.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/profile/profile_screen.dart';

class MenuModel {
  Widget screen;
  String title;
  Widget icon;

  MenuModel({
    required this.screen,
    required this.title,
    required this.icon,
  });
}

List<MenuModel> model = [
  MenuModel(
      screen: HomeScreen(),
      title: 'Home',
      icon: Icon(
        Icons.home,
        color: Colors.white,
      )),
  MenuModel(
      screen: ProfileScreen(),
      title: 'Profile',
      icon: Icon(
        Icons.person,
        color: Colors.white,
      )),
  MenuModel(
      screen: FavoritesScreen(),
      title: 'Favorites',
      icon: Icon(
        Icons.favorite,
        color: Colors.white,
      )),
  MenuModel(
      screen: CategoriesScreen(),
      title: 'Categories',
      icon: Icon(
        Icons.category_outlined,
        color: Colors.white,
      )),
  MenuModel(
      screen: LoginScreen(),
      title: 'Log out',
      icon: Icon(
        Icons.logout,
        color: Colors.white,
      )),
];
