import 'dart:convert';

import 'package:api_call/models.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobleState extends StateNotifier<List<ProductModel>> {
  GlobleState() : super([]);
  void addCart(ProductModel product) {
    final isExist = state.any((p) => p.id == product.id);
    if (!isExist) {
      state = [...state, product];
    } else {
      return;
    }
  }

  num total() {
    // int n = widget.cartList.length;
    // num total = 0;
    // for (int i = 0; i < n; i++) {
    //   total = total + widget.cartList[i].price;
    // }
    return state.fold(
        0 as num, (pre, ele) => pre + (ele.price * ele.itemCount));
  }

  void setPref() async {
    final mapCart = state.map((p) => p.toJson()).toList();
    print('mapcart${mapCart}');
    final jsonCart = jsonEncode(mapCart);
    print('${jsonCart.runtimeType} json');
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('cart', jsonCart);
  }

  void getPref() async {
    final prefs = await SharedPreferences.getInstance();
    final getPrefs = prefs.getString('cart');
    final jsonMap = jsonDecode(getPrefs!);
    var jsonValue = jsonMap.map((p) => ProductModel.fromJson(p)).toList();

    state = [...jsonValue];
    print('stste $state');
    print('json $jsonValue');

    // if (getPrefs != null) {
    //   print(getPrefs);
    //   setState(() {
    //     widget.cartList = [...getPrefs];
    //   });
    // }
  }

  void removeFromCart(int id) {
    state = state.where((p) => p.id != id).toList();
    print('length->>${state.length}');
    setPref();
  }
}

final addInListProvider =
    StateNotifierProvider<GlobleState, List<ProductModel>>(
        (ref) => GlobleState());
