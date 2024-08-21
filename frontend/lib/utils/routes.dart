import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/products/products_list_screen.dart';
import '../screens/clients/clients_list_screen.dart';
import '../screens/transactions/transactions_list_screen.dart';
import '../screens/orders/orders_list_screen.dart';
//... import other screens as necessary

class Routes {
  // Home
  static const String home = '/home';

  // Auth
  static const String login = '/login';
  static const String register = '/register';

  // Products
  static const String productsList = '/products/list';

  // Clients
  static const String clientsList = '/clients/list';

  // Transactions
  static const String transactionsList = '/transactions/list';

  // Orders
  static const String ordersList = '/orders/list';

  //... define other route names as necessary

  // Route generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case productsList:
        return MaterialPageRoute(builder: (_) => ProductsListScreen());
      case clientsList:
        return MaterialPageRoute(builder: (_) => ClientsListScreen());
      case transactionsList:
        return MaterialPageRoute(builder: (_) => TransactionsListScreen());
      case ordersList:
        return MaterialPageRoute(builder: (_) => OrdersListScreen());
      //... add other case statements for other routes

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
