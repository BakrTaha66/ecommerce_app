import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/config/asset_constants.dart';
import 'package:ecommerce_app/controller/home_controller.dart';
import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:ecommerce_app/view/widgets/info_product_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/product_model.dart';
import '../../widgets/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController hController = HomeController();

  @override
  void initState() {
    super.initState();
    hController.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Category',
                      style: customTextTitleHome(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 54,
                child: FutureBuilder<List<ProductModel>>(
                    future: hController.getProduct(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? categoryList()
                          : snapshot.hasError
                              ? errorWidget()
                              : loadingWidget();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Offers',
                      style: customTextTitleHome(),
                    ),
                  ],
                ),
              ),
              FutureBuilder<List<ProductModel>>(
                  future: hController.getProduct(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: offerList(),
                          )
                        : snapshot.hasError
                            ? errorWidget()
                            : loadingWidget();
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Products',
                      style: customTextTitleHome(),
                    ),
                  ],
                ),
              ),
              FutureBuilder<List<ProductModel>>(
                  future: hController.getProduct(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: productList(),
                          )
                        : snapshot.hasError
                            ? errorWidget()
                            : loadingWidget();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryList() => ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 8,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(0xff03d399),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                hController.productsList[index].category ?? '',
                style: textBtnList(),
              ),
            ),
          ),
        );
      });

  Widget offerList() => GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 1,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        mainAxisExtent: 200,
      ),
      itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => InfoProductScreen(
                        image: hController.productsList[index].image,
                        title: hController.productsList[index].title,
                        price: hController.productsList[index].price.toString(),
                        description: hController.productsList[index].description
                            .toString(),
                      )));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0)),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    child: Image.network(
                      hController.productsList[index].image ?? '',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ));

  Widget productList() => GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 8,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        mainAxisExtent: 290,
      ),
      itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => InfoProductScreen(
                        image: hController.productsList[index].image,
                        title: hController.productsList[index].title,
                        price: hController.productsList[index].price.toString(),
                        description: hController.productsList[index].description
                            .toString(),
                      )));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    child: Image.network(
                      hController.productsList[index].image ?? '',
                      height: 170,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hController.productsList[index].title ?? '',
                          style: customTextTitleProduct(),
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          hController.productsList[index].price.toString(),
                          style: customTextTitleProductPrice(),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_border_rounded,
                              color: Colors.grey,
                              size: 28,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));

  // Widget productList() => Expanded(
  //       child: GridView.builder(
  //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //           crossAxisCount: 2,
  //           mainAxisSpacing: 15,
  //           crossAxisSpacing: 15,
  //         ),
  //         itemCount: hController.productsList.length,
  //         itemBuilder: (context, index) => const Padding(
  //           padding: EdgeInsets.only(
  //             top: 10,
  //             left: 10,
  //             right: 10,
  //           ),
  //           // child: ClipRRect(
  //           //   borderRadius: const BorderRadius.all(
  //           //     Radius.circular(15),
  //           //   ),
  //           //   child: Stack(
  //           //     children: [
  //           //       Positioned.fill(
  //           //         child: Image.network(
  //           //           hController.productsList[index].image ?? '',
  //           //           fit: BoxFit.fill,
  //           //         ),
  //           //       ),
  //           //       Positioned(
  //           //         bottom: 0,
  //           //         child: Container(
  //           //           height: 70,
  //           //           decoration: BoxDecoration(
  //           //             gradient: LinearGradient(
  //           //               colors: [
  //           //                 Colors.black.withOpacity(0.1),
  //           //                 Colors.black.withOpacity(0.6),
  //           //                 Colors.black.withOpacity(0.9),
  //           //               ],
  //           //               end: Alignment.bottomCenter,
  //           //               begin: Alignment.topCenter,
  //           //             ),
  //           //           ),
  //           //           child: Column(
  //           //             children: [
  //           //               Padding(
  //           //                 padding: const EdgeInsets.all(6.0),
  //           //                 child: SizedBox(
  //           //                   width: 200,
  //           //                   child: Text(
  //           //                     hController.productsList[index].title ?? '',
  //           //                     style: TextStyle(
  //           //                       color: Colors.white,
  //           //                       fontSize: 12,
  //           //                     ),
  //           //                     maxLines: 1,
  //           //                     overflow: TextOverflow.ellipsis,
  //           //                   ),
  //           //                 ),
  //           //               ),
  //           //               Padding(
  //           //                 padding: EdgeInsets.only(left: 70, top: 6),
  //           //                 child: Container(
  //           //                   padding: const EdgeInsets.all(5),
  //           //                   decoration: BoxDecoration(
  //           //                       color: Colors.deepOrange,
  //           //                       borderRadius: BorderRadius.circular(10)),
  //           //                   child: Text(
  //           //                     hController.productsList[index].price
  //           //                         .toString(),
  //           //                     style: const TextStyle(
  //           //                       fontSize: 16,
  //           //                       fontWeight: FontWeight.bold,
  //           //                       color: Colors.white,
  //           //                     ),
  //           //                   ),
  //           //                 ),
  //           //               ),
  //           //             ],
  //           //           ),
  //           //         ),
  //           //       ),
  //           //     ],
  //           //   ),
  //           // ),
  //         ),
  //       ),
  //     );

  Widget errorWidget() => const Text('Sorry, Something went wrong');

  Widget loadingWidget() => const CupertinoActivityIndicator();
}
