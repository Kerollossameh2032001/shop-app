import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/layout_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'layot_reusable_componants.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LayoutCubit.get(context).getHomeData();
    LayoutCubit.get(context).getProfileData();
    LayoutCubit.get(context).getCartData();
    LayoutCubit.get(context).getFavoritesData();
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LayoutCubit cubit = LayoutCubit.get(context);
        return Scaffold(
          body: Stack(
            children: [
              //let's start first by creating Background of the app
              buildBackground(),
              //Now let's make the navigation menu
              SafeArea(
                  child: Container(
                width: 200.0,
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ConditionalBuilder(
                      condition: cubit.profileData != null,
                      builder: (context) => SizedBox(
                        height: 200,
                        child: DrawerHeader(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 50.0,
                                backgroundImage:
                                    NetworkImage(cubit.profileData!.data!.image),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                cubit.profileData!.data!.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Expanded(
                        child: ListView.builder(
                      itemBuilder: (context, index) =>
                          buildMenuItem(context, model[index]),
                      itemCount: model.length,
                    ))
                  ],
                ),
              )),
              //now we build our main Screen
              // we wrap it with tween animation to animated i t
              buildTweenAnimationBuilder(cubit),
              // now we will create Gesture to make user swap and build the drawer
              openDrawer(cubit),
            ],
          ),
        );
      },
    );
  }
}
