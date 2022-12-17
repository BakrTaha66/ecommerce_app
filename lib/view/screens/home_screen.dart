import 'package:dio/dio.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Dio dio = Dio();
  String url = 'https://fakestoreapi.com/products';
  ProductsModel? productsModel;

  Future<ProductsModel> getData() async {
    Response response = await dio.get(url);

    productsModel = ProductsModel.fromJson(response.data);
    return productsModel!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
