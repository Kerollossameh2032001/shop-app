import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';

import '../../models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LayoutCubit cubit = LayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("Categories"),
          ),
          body: ConditionalBuilder(
            condition: cubit.categoriesModel != null,
            builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildCatItem(context,cubit.categoriesModel!.data.data[index]),
              separatorBuilder: (context, index) => Divider(),
              itemCount: cubit.categoriesModel!.data.data.length,
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Padding buildCatItem(BuildContext context, DataItem model) {
    return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 5,
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(model.image),
                        )
                      ),
                    ),
                    SizedBox(width: 20,),
                    Text('${model.name}', style: Theme.of(context).textTheme.headline5,),
                  ],
                ),
              ),
            );
  }
}
