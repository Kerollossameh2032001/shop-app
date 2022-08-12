import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import '../../shared/constants/reusable_componants.dart';
import '../../shared/constants/styles.dart';

Widget buildCheckOutButton() {
  return defaultElevatedButton(
    roundedRectangleBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          bottomRight: Radius.circular(40)),
    ),
    size: Size(160, 50),
    onPressed: () {},
    child: Row(
      children: [
        Icon(Icons.shopping_cart_checkout_outlined),
        SizedBox(
          width: 10.0,
        ),
        Text(
          'Check out',
          style: TextStyle(fontSize: 20),
        ),
      ],
    ),
  );
}

Card buildChekOutCard(LayoutCubit cubit, BuildContext context) {
  return Card(
    elevation: 15,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20)),
    ),
    child: Padding(
      padding: const EdgeInsets.only(
        left: 18.0,
        right: 18.0,
        top: 50,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Sub Total",
                style:
                Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text('${cubit.cartData!.data.subTotal}',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(
                    color: defaultColor,
                  )),
            ],
          ),
          SizedBox(
            height: 30
          ),
          Row(
            children: [
              Text(
                "Total",
                style:
                Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text('${cubit.cartData!.data.total}',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(
                    color: defaultColor,
                  )),
            ],
          ),
          SizedBox(
              height: 30
          ),
          Divider(
            color: secondDefaultColor,
            thickness: 2,
          ),
          SizedBox(height: 30),
          buildCheckOutButton(),
        ],
      ),
    ),
  );
}