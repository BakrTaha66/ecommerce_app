import 'package:ecommerce_app/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/product_model.dart';

class InfoProductScreen extends StatefulWidget {
  final String? description;
  final String? image;
  final String? title;
  final String? price;
  InfoProductScreen(
      {Key? key, this.image, this.title, this.price, this.description})
      : super(key: key);
  @override
  State<InfoProductScreen> createState() => _InfoProductScreenState();
}

class _InfoProductScreenState extends State<InfoProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.network(
            widget.image ?? '',
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title ?? '',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    widget.description.toString(),
                    maxLines: 3,
                    style: TextStyle(
                        fontSize: 16, color: Colors.black.withOpacity(0.5)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color(0xff03d399),
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      widget.price.toString(),
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget errorWidget() => const Text('Sorry, Something went wrong');

  Widget loadingWidget() => const CupertinoActivityIndicator();
}
