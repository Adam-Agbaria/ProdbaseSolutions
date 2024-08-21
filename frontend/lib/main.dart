import 'dart:io';

import 'package:ProdBase_Solutions/screens/auth/login_screen.dart';
import 'package:ProdBase_Solutions/screens/clients/clients_list_screen.dart';
import 'package:ProdBase_Solutions/screens/home_screen.dart';
import 'package:ProdBase_Solutions/screens/orders/orders_list_screen.dart';
import 'package:ProdBase_Solutions/screens/products/products_list_screen.dart';
import 'package:ProdBase_Solutions/screens/products/product_add_screen.dart';
import 'package:ProdBase_Solutions/screens/transactions/transactions_list_screen.dart';
import 'package:ProdBase_Solutions/screens/unsubscribed_screen.dart';
import 'package:ProdBase_Solutions/screens/transactions/transaction_add_screen.dart';
import 'package:ProdBase_Solutions/screens/clients/client_add_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/products': (context) => ProductsListScreen(),
        '/unsubscribed': (context) => UnsubscribedScreen(),
        '/subscribe': (context) => UnsubscribedScreen(),
        '/clients': (context) => ClientsListScreen(),
        '/profile': (context) => HomeScreen(),
        '/settings': (context) => HomeScreen(),
        '/orders': (context) => OrdersListScreen(),
        '/transactions': (context) => TransactionsListScreen(),
        '/AddClient': (context) => ClientAddScreen(),
        '/AddProduct': (context) => ProductAddScreen(),
        '/AddOrder': (context) => HomeScreen(),
        '/AddTransaction': (context) => TransactionAddScreen(),
      },
      initialRoute: '/home',
    );
  }
}
