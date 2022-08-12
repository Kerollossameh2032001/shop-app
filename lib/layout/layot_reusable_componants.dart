import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/shared/constants/reusable_componants.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';
import '../modules/home/home_screen.dart';
import 'layout_model.dart';

Widget buildBackground() {
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
      colors: [
        Colors.pink[300]!,
        Colors.pink[400]!,
        Colors.pink[800]!,
        Colors.pink[900]!,
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    )),
  );
}

TweenAnimationBuilder<double> buildTweenAnimationBuilder(LayoutCubit cubit) {
  return TweenAnimationBuilder(
    tween: Tween<double>(
      begin: 0.0,
      end: cubit.angle,
    ),
    curve: Curves.easeIn,
    duration: Duration(milliseconds: 500),
    builder: (_, double val, child) => Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..setEntry(0, 3, val * 200)
        ..rotateY((pi / 6) * val),
      child: HomeScreen(),
    ),
  );
}

GestureDetector openDrawer(LayoutCubit cubit) {
  return GestureDetector(
    onHorizontalDragUpdate: (e) {
      //print(e.delta.dx); e > 0 when open else when closed
      cubit.openClosedDrawer(value: e);
    },
  );
}

ListTile buildMenuItem(BuildContext context, MenuModel model) {
  return ListTile(
    onTap: () {
      if(model.title == 'Log out'){
        CacheHelper.removeData(key: 'token').then((value){
          if(value){
            navigateAndFinish(context, model.screen);
          }
        });
      }else{
        navigateTo(context, model.screen);
      }
    },
    title: Text(
      '${model.title}',
      style: Theme.of(context)
          .textTheme
          .bodyText1!
          .copyWith(color: Colors.white, fontSize: 18),
    ),
    leading: model.icon,
  );
}
