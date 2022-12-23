import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/config/asset_constants.dart';
import 'package:ecommerce_app/controller/home_controller.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController hController = HomeController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hController.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Product'),
        backgroundColor: Colors.deepOrange,
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder<List<ProductModel>>(
              future: hController.getProduct(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? productList()
                    : snapshot.hasError
                        ? errorWidget()
                        : loadingWidget();
              }),
        ],
      ),
    );
  }

  Widget productList() => Expanded(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
          ),
          itemCount: hController.productsList.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      hController.productsList[index].image ?? '',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.9),
                          ],
                          end: Alignment.bottomCenter,
                          begin: Alignment.topCenter,
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: SizedBox(
                              width: 200,
                              child: Text(
                                hController.productsList[index].title ?? '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 70, top: 6),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                hController.productsList[index].price
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget errorWidget() => const Text('Sorry, Something went wrong');

  Widget loadingWidget() => const CupertinoActivityIndicator();
}
