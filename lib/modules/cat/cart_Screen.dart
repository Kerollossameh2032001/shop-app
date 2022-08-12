import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/constants/reusable_componants.dart';
import 'cart_reusable_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (cntext, state) {
        if(state is LayoutChangeCartsSuccesState){
          if(state.changeCartsModel.status){
            showToast(message: state.changeCartsModel.message, state: ToastState.SUCCES);
          }else{
            showToast(message: state.changeCartsModel.message, state: ToastState.ERROR);
          }
        }
      },
      builder: (cntext, state) {
        LayoutCubit cubit = LayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Cart"),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Icon(Icons.shopping_cart),
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => ConditionalBuilder(
                      condition: state is! LayoutChangeCartsLoadingState,
                      builder: (context)=>Dismissible(
                        key: Key(cubit.cartData!.data.cartItem[index].product.id.toString()),
                        onDismissed: (direction){
                          cubit.changeCarts(productId: cubit.cartData!.data.cartItem[index].product.id);
                        },
                        child: buildItem(cubit, context,
                            cubit.cartData!.data.cartItem[index].product, false),
                      ),
                      fallback: (context)=>Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: const Center(child: CircularProgressIndicator(),),
                      ),
                  ),
                  itemCount: cubit.cartData!.data.cartItem.length,
                ),
              ),
              SizedBox(
                height: 300,
                width: double.maxFinite,
                child: buildChekOutCard(cubit, context),
              )
            ],
          ),
        );
      },
    );
  }
}
