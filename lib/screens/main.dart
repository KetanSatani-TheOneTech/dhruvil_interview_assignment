import 'package:dhruvil_interview_assignment/providers/cart_provider.dart';
import 'package:dhruvil_interview_assignment/providers/product_provider.dart';
import 'package:dhruvil_interview_assignment/screens/authentication/auth_screen.dart';
import 'package:dhruvil_interview_assignment/screens/product/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) => auth.isAuthenticated ? ProductListScreen() : AuthScreen(),
      ),
    );
  }
}
