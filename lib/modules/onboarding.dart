// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shop/core/Cachehelper.dart';
import 'package:shop/core/components1.dart';
import 'package:shop/modules/Shop_Login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel {
  String image, title, body;
  OnBoardingModel(
      {required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  void submit(context) {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      navigatandfinsh(context: context, screen: ShopLoginScreen());
    });
  }

  List<OnBoardingModel> boardingScreens = [
    OnBoardingModel(
        image: 'images/onboarding.jpg',
        title: 'Screen 1 Title',
        body: 'Screen 1 Body'),
    OnBoardingModel(
        image: 'images/onboarding.jpg',
        title: 'Screen 2 Title',
        body: 'Screen 2 Body'),
    OnBoardingModel(
        image: 'images/onboarding.jpg',
        title: 'Screen 3 Title',
        body: 'Screen 3 Body'),
  ];
  PageController boardingController = PageController();
  int pageindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: TextButton(
                  onPressed: () {
                    submit(context);
                  },
                  child: const Text('Skip to Login')),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                  child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  pageindex = index;
                },
                controller: boardingController,
                itemBuilder: ((context, index) =>
                    onboardingitem(boardingScreens[index])),
                itemCount: boardingScreens.length,
              )),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                      controller: boardingController,
                      effect: const ExpandingDotsEffect(
                          dotColor: Colors.grey,
                          activeDotColor: Colors.deepOrange,
                          dotHeight: 10,
                          expansionFactor: 4,
                          dotWidth: 10,
                          spacing: 5),
                      count: boardingScreens.length),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (pageindex == boardingScreens.length - 1) {
                        submit(context);
                      }
                      boardingController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    },
                    child: const Icon(Icons.forward),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Widget onboardingitem(OnBoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image(
            image: AssetImage(model.image),
            width: double.infinity,
          )),
          Text(
            model.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            model.body,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );
}
