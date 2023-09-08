import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:api_call/models.dart';
import 'package:flutter/material.dart';
import 'package:api_call/providers/cart_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyCart extends ConsumerStatefulWidget {
  const MyCart({
    super.key, //required this.cartList,
  });
  //final List<dynamic> cartList;

  @override
  ConsumerState<MyCart> createState() => _MyCartState();
}

class _MyCartState extends ConsumerState<MyCart> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //   final prefs = await SharedPreferences.getInstance();

  int _n = 1;

  @override
  Widget build(BuildContext context) {
    final cartList = ref.watch(addInListProvider);
    final refrect = ref.read(addInListProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 100),
          child: Text(
            "Cart",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.9 - 90,
            child: ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (context, index) => Card(
                elevation: 0,
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 14,
                      ),
                      Image(
                        width: 80,
                        image: NetworkImage(
                          cartList[index].image,
                        ),
                        height: 150,
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartList[index].category,
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              cartList[index].title,
                              softWrap: true,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Text(
                              '₹${cartList[index].price.toString()}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              cartList[index].decreaseCount();
                                            });
                                          },
                                          splashColor: Colors.deepPurpleAccent,
                                          splashRadius: 20,
                                          icon: Icon(
                                            Icons.remove,
                                            color: Colors.black38,
                                          )),
                                      Text(
                                        '${cartList[index].itemCount.toString()}',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            cartList[index].increseCount();
                                          });
                                        },
                                        splashColor: Colors.deepPurpleAccent,
                                        splashRadius: 20,
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 152, 98, 246),
                                  child: IconButton(
                                      onPressed: () {
                                        // setState(() {
                                        refrect
                                            .removeFromCart(cartList[index].id);
                                        // });
                                      },
                                      color: Colors.white,
                                      icon: Icon(Icons.delete)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 116, 42, 138),
                  borderRadius: BorderRadius.circular(28)),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "checkOut",
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text(
                            'Total:',
                            style: TextStyle(fontSize: 23, color: Colors.white),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text('${refrect.total().toInt()}',
                              style: const TextStyle(
                                  fontSize: 23, color: Colors.white))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


      // Container( 
      //           height: 150,
      //           width: MediaQuery.of(context).size.width,
      //           decoration: BoxDecoration(
      //               color: Color.fromARGB(255, 116, 42, 138),
      //               borderRadius: BorderRadius.circular(28)),
      //           child: Container(
      //             decoration:
      //                 BoxDecoration(border: Border.all(color: Colors.white)),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceAround,
      //               children: [
      //                 Text(
      //                   "checkOut",
      //                   style: TextStyle(fontSize: 23, color: Colors.white),
      //                 ),
      //                 Container(
      //                   child: Row(
      //                     children: [
      //                       Text(
      //                         'Total:',
      //                         style:
      //                             TextStyle(fontSize: 23, color: Colors.white),
      //                       ),
      //                       SizedBox(
      //                         width: 8,
      //                       ),
      //                       Text('${_total().toInt()}',
      //                           style: TextStyle(
      //                               fontSize: 23, color: Colors.white))
      //                     ],
      //                   ),
      //                 )
      //               ],
      //             ),
      //           ),
      //         )
