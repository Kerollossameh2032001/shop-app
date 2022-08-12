import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/modules/cat/cart_Screen.dart';
import 'package:shop_app/modules/details/details_screen.dart';
import 'package:shop_app/shared/constants/styles.dart';
import '../../models/home_model.dart';

String? token;

void navigateTo(BuildContext context, Widget widget) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
}

void navigateAndFinish(BuildContext context, Widget widget) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => widget));
}

Widget defaultElevatedButton(
    {required void Function()? onPressed,
    required Widget child,
    Size? size,
    Color? color,
    RoundedRectangleBorder? roundedRectangleBorder}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        fixedSize: MaterialStateProperty.all(size),
        shape: MaterialStateProperty.all(roundedRectangleBorder)),
    child: child,
  );
}

enum ToastState { ERROR, SUCCES, WARNIG }

 chooseColor(ToastState state) {
  dynamic color;
  switch (state) {
    case ToastState.ERROR:
      color = Colors.pink;
      break;
    case ToastState.SUCCES:
      color = secondDefaultColor;
      break;
    case ToastState.WARNIG:
      color = Colors.amber;
      break;
  }
  return color;
}

void showToast({
  required String message,
  required ToastState state,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseColor(state),
      textColor: Colors.white /*chooseColor(state)*/,
      fontSize: 16.0);
}

Padding buildItem(LayoutCubit cubit,BuildContext context, dynamic model, isSearch) {
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 100.0,
          width: 340.0,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
        ),
        Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(model.image),
              //fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          top: 15.0,
          left: 100,
          child: Container(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 20, color: secondDefaultColor),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: secondDefaultColor, height: 2),
                    ),
                    SizedBox(width: 20),
                    if (isSearch == false)
                      if (model.discount != 0.0)
                        Text(
                          '${model.oldPrice}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Colors.grey,
                                  height: 2,
                                  decoration: TextDecoration.lineThrough),
                        ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 200,
          top: 60,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  cubit.changeFavorites(productId: model.id);
                },
                icon: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      shape: BoxShape.rectangle,
                      color: secondDefaultColor),
                  child: Icon(
                    Icons.favorite,
                    color: cubit.favorites[model.id]!? defaultColor:Colors.white,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  navigateTo(
                      context,
                      DetailsScreen(
                        id: model.id,
                      ));
                },
                icon: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      shape: BoxShape.rectangle,
                      color: secondDefaultColor),
                  child: Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isSearch == false)
          if (model.discount != 0.0)
            Positioned(
              left: -10,
              top: -5,
              child: Banner(
                location: BannerLocation.topStart,
                message: 'Discount',
                textStyle: TextStyle(fontSize: 13),
                color: Color.fromRGBO(179, 0, 0, 1),
                child: Container(
                  width: 5,
                  height: 5,
                  color: Colors.blueGrey[50],
                ),
              ),
            ),
      ],
    ),
  );
}

Widget buildCartIcon(context) {
  return IconButton(
      onPressed: () {
        navigateTo(context, CartScreen());
      },
      icon: Icon(Icons.shopping_cart));
}