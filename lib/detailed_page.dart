import 'dart:convert';

import 'package:api_call/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailedPage extends StatefulWidget {
  const DetailedPage(
      {super.key, //  required this.productDetail,
      required this.id});
  // final ProductModel productDetail;
  final int id;

  @override
  State<DetailedPage> createState() => _DetailedPageState();
}

class _DetailedPageState extends State<DetailedPage> {
  // late int idp;
  ProductModel? productDetail;
  apiData() async {
    final url = 'https://fakestoreapi.com/products/${widget.id}';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    print(json);
    var jsonValue = ProductModel.fromJson(json);
    print(jsonValue);
    // ProductModel(
    //     id: json["id"],
    //     title: json["title"],
    //     price: json["price"],
    //     description: json["description"],
    //     category: json["category"],
    //     image: json["image"],
    //     rating: RatingModel(count: json["count"], rate: json["rate"]));

    setState(() {
      productDetail = jsonValue;
    });
  }

  @override
  void initState() {
    super.initState();
    apiData();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (productDetail == null) {
      content = Center(
        child: CircularProgressIndicator(color: Colors.blueGrey),
      );
    } else {
      content = SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(12),
              height: MediaQuery.of(context).size.height * 0.40,
              decoration: BoxDecoration(
                image:
                    DecorationImage(image: NetworkImage(productDetail!.image)),
              ),
            ),
            Container(
              margin: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.category,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        productDetail!.category,
                        style: TextStyle(
                            fontWeight: FontWeight.w100, fontSize: 20),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Divider(),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    productDetail!.title,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 30,
                      ),
                      Text(
                        productDetail!.rating.rate.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 24),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        'Ratings',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Icon(
                        Icons.circle,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        productDetail!.rating.rate.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        'Count',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.grey),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 14,
                    ),
                    child: Text(
                      "Description :-",
                      style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    productDetail!.description,
                    style: TextStyle(
                        // fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 70,
                    width: double.infinity,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Total Price',
                              style: TextStyle(
                                  // fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '₹${productDetail!.price.toString()}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 179, 64, 44),
                                  fontSize: 24),
                            )
                          ],
                        ),
                        InkWell(
                          child: Container(
                            padding: const EdgeInsets.only(right: 24),
                            height: double.infinity,
                            width: 200,
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: double.infinity,
                                    width: 60,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                      color: Color.fromARGB(255, 0, 184, 129),
                                    ),
                                    child: const Icon(Icons.shopping_bag),
                                  ),
                                  const Text(
                                    "Buy Now",
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.white),
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: content),
    );
  }
}
