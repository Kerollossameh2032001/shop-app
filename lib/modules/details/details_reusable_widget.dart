import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import '../../models/home_model.dart';
import '../../shared/constants/reusable_componants.dart';
import '../../shared/constants/styles.dart';


Positioned buildAddToCartButton(LayoutCubit cubit,int productId) {
  return Positioned(
    top: 680,
    left: 205,
    child: defaultElevatedButton(
      color: secondDefaultColor,
      roundedRectangleBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      ),
      size: Size(150, 50),
      onPressed: () {
        if(!cubit.carts[productId]!){
          cubit.changeCarts(productId: productId);
        }else{
          showToast(message: 'Item is already existed', state: ToastState.SUCCES);
        }
      },
      child: Row(
        children: [
          Icon(Icons.add),
          SizedBox(
            width: 10.0,
          ),
          Text('Add to Cart'),
        ],
      ),
    ),
  );
}

Padding buildDetailsBody(ProductsModel model, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(30.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${model.name}',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: secondDefaultColor),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Text(
              '${model.price}',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: defaultColor),
            ),
            SizedBox(
              width: 35,
            ),
            if (model.discount != 0.0 && model.discount != null)
              Text(
                '${model.oldPrice}',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.grey, decoration: TextDecoration.lineThrough),
              ),
          ],
        ),
        SizedBox(height: 20),
        Text(
          'Description',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: secondDefaultColor),
        ),
        SizedBox(height: 12),
        Text(
          '${model.description}',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.grey),
        )
      ],
    ),
  );
}

CarouselSlider buildCarouselSlider(ProductsModel model) {
  return CarouselSlider(
    items: model.images
        .map((e) => Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(100)),
                image: DecorationImage(
                  image: NetworkImage('$e'),
                  fit: BoxFit.fill,
                ),
              ),
            ))
        .toList(),
    options: CarouselOptions(
      height: 400,
      viewportFraction: 1.0,
      autoPlay: true,
      enableInfiniteScroll: true,
      initialPage: 0,
    ),
  );
}

Positioned buildBanner() {
  return Positioned(
    left: 30,
    top: 30,
    child: Banner(
      location: BannerLocation.topStart,
      message: 'Discount',
      textStyle: TextStyle(fontSize: 15),
      color: Color.fromRGBO(179, 0, 0, 1),
      child: Container(
        width: 5,
        height: 5,
        color: Colors.blueGrey[50],
      ),
    ),
  );
}
