import 'package:flutter/material.dart';
import 'package:shop_app/shared/constants/styles.dart';
import 'onboarding_model.dart';
import 'onboarding_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageViewController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: TextButton.icon(
                onPressed: () {
                  onSubmit(context);
                },
                icon: Icon(Icons.shopping_cart,color: defaultColor,),
                label: Text(
                  'SKIP',
                  style: TextStyle(color: defaultColor),
                )),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemBuilder: (context, index) =>
                  buildBoardingItem(context, pages[index]),
              itemCount: pages.length,
              controller: pageViewController,
              physics: BouncingScrollPhysics(),
              onPageChanged: (index) {
                if (index == pages.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 140.0),
                  child: SmoothPageIndicator(
                    controller: pageViewController,
                    count: pages.length,
                    effect: const WormEffect(
                      activeDotColor: Colors.pink,
                      dotHeight: 10,
                      //strokeWidth: 10,
                      radius: 10,
                      dotWidth: 10,
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    if (isLast) {
                      onSubmit(context);
                    } else {
                      pageViewController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  icon: const CircleAvatar(
                      radius: 40, child: Icon(Icons.arrow_forward_ios)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
