import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:api_call/detailed_page.dart';
import 'package:api_call/models.dart';
import 'package:api_call/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';
import 'package:api_call/providers/cart_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
    //required this.cartList,
  });
  // List<dynamic> cartList;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<dynamic> myProduct = [];
  void getData() async {
    print("getdata");
    const url = 'https://fakestoreapi.com/products';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    print(json);
    var jsonValue = json.map((p) => ProductModel.fromJson(p)).toList();
    print(jsonValue);
    setState(() {
      myProduct = jsonValue;
    });
  }

  final titleView =
      (String s) => s.length > 30 ? '${s.substring(0, 30)}...' : s;

  @override
  void initState() {
    super.initState();
    getData();
    ref.read(addInListProvider.notifier).getPref();
    //ref.read(addInListProvider.notifier).sharedPref();
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('added to cart')));
  }

  // void _addCart(ProductModel product) {
  //   print(widget.cartList);

  //   final p = widget.cartList.any((p) => p.id == product.id);
  //   print(p);
  //   !p ? widget.cartList.add(product) : null;
  // }

  @override
  Widget build(BuildContext context) {
    final cartList = ref.watch(addInListProvider);

    //print(widget.cartList);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api Calling'),
        actions: [
          Stack(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyCart(
                          //  cartList: widget.cartList,

                          ),
                    ));
                  },
                  icon: Icon(Icons.shopping_cart_checkout_rounded)),
              Positioned(
                  top: 6,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10,
                    child: Text(cartList.length.toString()),
                  )),
            ],
          ),
          SizedBox(
            width: 23,
          )
        ],
      ),
      body: GridView.builder(
        itemCount: myProduct.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.7
            // crossAxisSpacing: 12,
            // mainAxisSpacing: 45,
            ),
        itemBuilder: (context, index) => InkWell(
          hoverColor: Colors.white54,
          splashColor: Colors.amber,
          onTap: () {
            print('inkwell');

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailedPage(
                      //productDetail: myProduct[index],
                      id: myProduct[index].id,
                    )));
          },
          child: Card(
              //semanticContainer: true,
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: NetworkImage(myProduct[index].image),
                              fit: BoxFit.contain,
                            )),
                          ),
                          Positioned(
                              child: AnimatedContainer(
                            duration: Duration(microseconds: 200),
                            height: 20,
                            width: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 242, 93, 93)),
                                color: Color.fromARGB(255, 223, 220, 208),
                                borderRadius: BorderRadius.circular(24)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 14,
                                ),
                                Text(myProduct[index].rating.rate.toString()),
                              ],
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        titleView(myProduct[index].title),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "₹${myProduct[index].price.toString()}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              side: const BorderSide(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1,
                              )),
                          //   shape: MaterialStatePropertyAll(
                          //     RoundedRectangleBorder(
                          //       side: const BorderSide(color: Colors.red, width: 3),
                          //       borderRadius: BorderRadius.circular(18),
                          //     ),
                          //   ),

                          onPressed: () {
                            setState(() {
                              // widget.cartList.add(myProduct[index]);
                              // _addCart(myProduct[index]);
                              ref
                                  .read(addInListProvider.notifier)
                                  .addCart(myProduct[index]);
                              ref.read(addInListProvider.notifier).setPref();
                              _showSnackBar();
                            });
                          },
                          icon: const Icon(Icons.shopping_cart),
                          label: const Text('Add to Cart'))
                    ]),
              )),
        ),
      ),
    );
  }
}
