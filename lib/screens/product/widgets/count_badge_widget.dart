import 'package:flutter/material.dart';

Widget countBadge(int count) {
  return Container(
    margin: EdgeInsets.all(2),
    padding: EdgeInsets.symmetric(horizontal: count > 9 ? 10 : 8, vertical: 2),
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      count > 99 ? "99+" : "$count",
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}
