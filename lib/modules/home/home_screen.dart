import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import '../../shared/constants/reusable_componants.dart';
import '../../shared/constants/styles.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'home_reusable_componants.dart';

class HomeScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if(state is LayoutChangeFavoritesSuccesState){
          print(state.changeFavoriteModel.status);
          if(!state.changeFavoriteModel.status){
            showToast(message: state.changeFavoriteModel.message, state: ToastState.ERROR);
          }else{
            showToast(message: state.changeFavoriteModel.message, state: ToastState.SUCCES);
          }
        }
      },
      builder: (context, states) {
        LayoutCubit cubit = LayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            title: Text('Shop App'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                    onPressed: () {},
                    icon: CircleAvatar(
                        backgroundColor: secondDefaultColor,
                        child: Icon(
                          Icons.brightness_2_outlined,
                          color: Colors.white,
                        ))),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  searchFormField(context, searchController, cubit),
                  ConditionalBuilder(
                    condition: searchController.text.isEmpty,
                    builder: (context)=>Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Explore',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: secondDefaultColor),
                        ),
                        ConditionalBuilder(
                          condition: cubit.categoriesModel != null,
                          builder: (context) => Container(
                            height: 300,
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => buildCategoryExplore(
                                  context, cubit.categoriesModel!.data.data[index]),
                              separatorBuilder: (context, index) => SizedBox(
                                width: 0.0,
                              ),
                              itemCount: cubit.categoriesModel!.data.data.length,
                            ),
                          ),
                          fallback: (context) => const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                        Text(
                          'Best Selling',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: secondDefaultColor),
                        ),
                        ConditionalBuilder(
                          condition: cubit.homeModel != null,
                          builder: (context) => Column(
                            children: cubit.homeModel!.data.products
                                .map((e) => buildItem(cubit,context, e, false))
                                .toList(),
                          ),
                          fallback: (context) => const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    fallback: (context)=>ConditionalBuilder(
                      condition: cubit.searchModel != null,
                        builder: (context)=>Column(
                          children: cubit.searchModel!.data.data
                              .map((e) => buildItem(cubit,context, e, true))
                              .toList(),
                        ),
                      fallback: (context) => const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
