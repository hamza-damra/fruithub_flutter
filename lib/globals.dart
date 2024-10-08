import 'package:flutter/material.dart';
import 'package:fruitshub/models/cartItem.dart';
import 'package:fruitshub/models/product.dart';

// filter vars
double maxNum = 0;
double minNum = 0;
TextEditingController maxController = TextEditingController();
TextEditingController minController = TextEditingController();

List<Product> mostSelling = [];
List<Product> lastAdded = [];
List<Cartitem> cart = [];
List<Product> favourite = [];
