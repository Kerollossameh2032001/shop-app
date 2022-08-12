import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/onboarding/onboarding_screen.dart';
import 'package:shop_app/shared/constants/reusable_componants.dart';
import 'package:shop_app/shared/constants/styles.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/observer/bloc_observer_class.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  late Widget startScreen;
  print(token);
  if (onBoarding == true) {
    if (token == null) {
      startScreen = LoginScreen();
    } else {
      startScreen = LayoutScreen();
    }
  } else {
    startScreen = OnBoardingScreen();
  }

  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(
    startScreen: startScreen,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.startScreen}) : super(key: key);
  final Widget startScreen;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LayoutCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoritesData()
            ..getProfileData()
            ..getCartData(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startScreen,
      ),
    );
  }
}
