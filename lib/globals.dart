import 'package:flutter/material.dart';
import 'package:fruitshub/models/address.dart';
import 'package:fruitshub/models/cart_item.dart';
import 'package:fruitshub/models/product.dart';

// filter vars
double maxNum = 0;
double minNum = 0;
TextEditingController maxController = TextEditingController();
TextEditingController minController = TextEditingController();

// screens list
List<Product> mostSelling = [];
List<Product> lastAdded = [];
List<CartItem> cart = [];
List<Product> favourite = [];
List<AddressModel> address = [];

//
int mostSellingPageNumber = 0;
int lastAddedPageNumber = 0;
