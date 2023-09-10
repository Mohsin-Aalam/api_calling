import 'package:flutter/material.dart';

class RatingModel {
  num rate;
  int count;
  RatingModel({
    required this.count,
    required this.rate,
  });
  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      RatingModel(count: json["count"], rate: json["rate"]);

  Map<String, dynamic> toJson() {
    return {
      'rate': this.rate,
      'count': this.count,
    };
  }
}

class ProductModel {
  int itemCount;
  int id;
  String title;
  num price;
  String description;
  String category;
  String image;
  RatingModel rating;

  ProductModel({
    this.itemCount = 1,
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });
  factory ProductModel.fromJson(Map<String, dynamic> product) => ProductModel(
      id: product["id"],
      title: product["title"],
      price: product["price"],
      description: product["description"],
      category: product["category"],
      image: product["image"],
      rating: RatingModel.fromJson(product["rating"]));

  void increseCount() => this.itemCount++;

  void decreaseCount() => this.itemCount > 1 ? this.itemCount-- : 1;

  Map<String, dynamic> toJson() {
    return {
      'itemCount': this.itemCount,
      'id': this.id,
      'title': this.title,
      'price': this.price,
      'description': this.description,
      'category': this.category,
      'image': this.image,
      'rating': this.rating.toJson(),
    };
  }
}







// class ProductModel {
//   int? id;
//   String? title;
//   double? price;
//   String? description;
//   String? category;
//   String? image;
//   Rating? rating;

//   ProductModel(
//       {this.id,
//       this.title,
//       this.price,
//       this.description,
//       this.category,
//       this.image,
//       this.rating});

//   ProductModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     price = json['price'];
//     description = json['description'];
//     category = json['category'];
//     image = json['image'];
//     rating =
//         json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['price'] = this.price;
//     data['description'] = this.description;
//     data['category'] = this.category;
//     data['image'] = this.image;
//     if (this.rating != null) {
//       data['rating'] = this.rating!.toJson();
//     }
//     return data;
//   }
// }

// class Rating {
//   double? rate;
//   int? count;

//   Rating({this.rate, this.count});

//   Rating.fromJson(Map<String, dynamic> json) {
//     rate = json['rate'];
//     count = json['count'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['rate'] = this.rate;
//     data['count'] = this.count;
//     return data;
//   }
// }