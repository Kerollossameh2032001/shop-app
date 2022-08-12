import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import '../../models/categories_model.dart';
import '../../shared/constants/reusable_componants.dart';
import '../../shared/constants/styles.dart';

Row searchFormField(context,TextEditingController searchController, LayoutCubit cubit) {
  return Row(
    children: [
      Container(
        width: 270,
        child: TextFormField(
          controller: searchController,
          onChanged: (val){
            cubit.SearchData(text: val);
          },
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 15,
            ),
            label: const Text("Search"),
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
      ),
      const Spacer(),
      buildCartIcon(context)
    ],
  );
}

Padding buildCategoryExplore(BuildContext context, DataItem model) {
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Stack(
      children: [
        Container(
          height: 300,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Positioned(
          left: 15,
          top: 15,
          child: Container(
            height: 200,
            width: 170,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 0.4),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(model.image),
                )),
          ),
        ),
        Positioned(
          top: 230.0,
          left: 20,
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
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
