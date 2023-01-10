// import 'package:flutter/material.dart';
//
// class PageView extends StatefulWidget {
//   const PageView({Key? key}) : super(key: key);
//
//   @override
//   State<PageView> createState() => _PageViewState();
// }
//
// class _PageViewState extends State<PageView> {
//   late final PageController pageController;
//
//   @override
//   void initState() {
//     pageController = PageController(initialPage: 0, viewportFraction: 0.85);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200,
//       child: PageView.builder(
//         controller: pageController,
//         itemBuilder: (_, index) {
//           return AnimatedBuilder(
//             animation: pageController,
//             builder: (ctx, child) {
//               return child!;
//             },
//             child: Container(
//               margin:
//                   const EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 12),
//               decoration: BoxDecoration(
//                   color: Colors.amberAccent,
//                   borderRadius: BorderRadius.circular(24.0)),
//             ),
//           );
//         },
//         itemCount: 5,
//       ),
//     );
//   }
// }
