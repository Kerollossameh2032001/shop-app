import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/constants/reusable_componants.dart';
import '../../shared/constants/styles.dart';
import 'details_reusable_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatelessWidget {
  final int id;

  DetailsScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if(state is LayoutChangeCartsSuccesState){
          if(state.changeCartsModel.status){
            showToast(message: state.changeCartsModel.message, state: ToastState.SUCCES);
          }else{
            showToast(message: state.changeCartsModel.message, state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        ProductsModel model = LayoutCubit.get(context)
            .homeModel!.data.products.firstWhere((element) => element.id == id);
        LayoutCubit cubit = LayoutCubit.get(context);
        return Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          buildCarouselSlider(model),
                          Positioned(
                            top: 400,
                            child: Container(
                              height: 350,
                              width: 400,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                //borderRadius: BorderRadius.only(topLeft: Radius.circular(100)),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 400,
                            child: Container(
                              height: 350,
                              width: 400,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[50],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(100)),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 370,
                              left: 280,
                              child: IconButton(
                                  onPressed: () {
                                    LayoutCubit.get(context)
                                        .changeFavorites(productId: id);
                                  },
                                  icon: CircleAvatar(
                                    backgroundColor: secondDefaultColor,
                                    child: Icon(
                                      Icons.favorite,
                                      color: LayoutCubit.get(context)
                                              .favorites[id]!
                                          ? defaultColor
                                          : Colors.white,
                                    ),
                                  ))),
                          Positioned(
                            top: 5,
                            left: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(Icons.arrow_back)),
                                SizedBox(width: 80),
                                Text(
                                  "Product",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                          backgroundColor: Colors.grey[50]),
                                ),
                                SizedBox(width: 80),
                                buildCartIcon(context),
                              ],
                            ),
                          ),
                          if (model.discount != 0.0 && model.discount != null)
                            buildBanner(),
                        ],
                      ),
                      buildDetailsBody(model, context),
                    ],
                  ),
                ),
              ),
              buildAddToCartButton(cubit,model.id),
            ],
          ),
        );
      },
    );
  }
}
