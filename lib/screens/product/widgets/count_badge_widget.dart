import 'package:flutter/material.dart';

Widget countBadge(int count) {
  return Container(
    margin: EdgeInsets.all(2),
    padding: EdgeInsets.symmetric(horizontal: count > 9 ? 10 : 8, vertical: 2),
    decoration: count != 0
        ? BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(20),
          )
        : null,
    child: Text(
      count != 0
          ? count > 99
              ? "99+"
              : "$count"
          : '',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}
