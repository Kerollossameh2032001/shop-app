import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/onboarding/onboarding_model.dart';
import 'package:shop_app/shared/constants/reusable_componants.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';

Widget buildBoardingItem(BuildContext context, OnBoardingModel model) {
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 300,
          width: 400,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(model.image),
                fit: BoxFit.cover,
                //scale: 40.0,
              )),
        ),
        const SizedBox(height: 30),
        Text(
          "${model.title}",
          style: Theme.of(context).textTheme.headline3,
        ),
        const SizedBox(height: 20),
        Text(
          "${model.subTitle}",
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    ),
  );
}

void onSubmit(context){
  CacheHelper.savedData(key: 'onBoarding', value: true).then((value){
    if(value){
      navigateAndFinish(context,  LoginScreen());
    }
  });
}