import 'package:ecommerce_app/config/asset_constants.dart';
import 'package:ecommerce_app/config/dimens.dart';
import 'package:ecommerce_app/view/screens/nav_screen/home_screen.dart';
import 'package:ecommerce_app/view/widgets/authenticate.dart';
import 'package:flutter/material.dart';

import '../widgets/animation_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();

  List<Widget> pages = [
    AnimationWidget(AssetConstants.anim_6, 'Welcome to store'),
    AnimationWidget(AssetConstants.anim_7, 'Shipping any where'),
    AnimationWidget(AssetConstants.anim_5, 'Make an Order right now'),
  ];

  List<Widget> texts = [
    Text('Welcome to store'),
    Text('Shipping any where'),
    Text('Make an Order right now'),
  ];

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: Dimens.screenHeight(context) * 0.4,
          child: PageView.builder(
            controller: pageController,
            itemCount: pages.length,
            onPageChanged: (newIndex) {
              setState(() {
                index = newIndex;
              });
            },
            itemBuilder: (context, index) => pages[index],
          ),
        ),
        SizedBox(
          height: 100,
          width: 50,
          child: ListView.separated(
            itemCount: pages.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(
              width: 10,
            ),
            itemBuilder: (context, index) => dotWidget(index),
          ),
        ),
        if (index == pages.length - 1) ...[
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => Authenticate()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    fixedSize: const Size(300, 50),
                    primary: Color(0xff03d399)),
                child: const Text(
                  "Let's Go",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
          )
        ]
      ],
    ));

    // Navigation Stac on opreating system
  }

  Widget dotWidget(int val) => Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
            color: val == index
                ? Color(0xff03d399)
                : Color(0xff03d399).withOpacity(0.5),
            shape: BoxShape.circle),
      );
}
