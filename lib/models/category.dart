import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//#0 General class for category attributes
class Category {
  final String id;
  final String title;
  final Color color;

  const Category({
    @required this.id,
    @required this.title,
    this.color = Colors.orange,
  });
}
