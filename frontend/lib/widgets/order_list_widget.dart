import 'dart:convert';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order.dart'; // Import your Order model
import '../providers/order_provider.dart'; // Import your Order provider
import '../widgets/order_detail_widget.dart'; // Import your OrderDetailWidget
import '../widgets/order_update_widget.dart'; // Import your OrderUpdateWidget
import '../providers/user_provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'AppAdvancedDrawer.dart';
import 'AnimatedCompanyName.dart';
import '../providers/search_provider.dart'; // <-- Import the search provider

class OrdersListWidget extends ConsumerStatefulWidget {
  @override
  _OrdersListWidgetState createState() => _OrdersListWidgetState();
}

class _OrdersListWidgetState extends ConsumerState<OrdersListWidget> {
  final AdvancedDrawerController _advancedDrawerController =
      AdvancedDrawerController();
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final userAsyncValue = ref.watch(userProvider);

    return userAsyncValue.when(
      data: (user) {
        final theme = (user?.settings.theme ?? 'light') == 'light'
            ? NeumorphicThemeData(
                baseColor: Color(0xFFFFFFFF),
                lightSource: LightSource.topLeft,
                depth: 10,
              )
            : NeumorphicThemeData(
                baseColor: Color(0xFF3E3E3E),
                lightSource: LightSource.topLeft,
                depth: 10,
              );

        return NeumorphicTheme(
          theme: theme,
          child: AppAdvancedDrawer(
            controller: _advancedDrawerController,
            theme: theme,
            child: buildScaffold(user?.id ?? null, theme,
                user?.companyName ?? "Your Company Name"),
          ),
        );
      },
      loading: () => CircularProgressIndicator(),
      error: (error, stackTrace) => Text('Error loading user data'),
    );
  }

  Widget buildScaffold(
      String? userId, NeumorphicThemeData theme, String companyName) {
    if (userId == null) {
      return Center(child: CircularProgressIndicator());
    }

    return ref.watch(getOrdersByUserIdProvider(userId)).when(
          data: (response) {
            final List<Order> orders = jsonDecode(response.body)
                .map<Order>((item) => Order.fromJson(item))
                .toList();

            return Scaffold(
              appBar: NeumorphicAppBar(
                title:
                    AnimatedCompanyName(companyName: companyName, theme: theme),
                actions: [
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      _advancedDrawerController.showDrawer();
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Neumorphic(
                        style: NeumorphicStyle(
                          depth: -1,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(12)),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search Orders',
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                            ref.read(searchQueryProvider.notifier).state =
                                _searchQuery;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Orders List',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ...ref
                          .watch(searchNotifierProvider)
                          .orders // assuming you add an "orders" field to your search provider
                          .map((order) {
                        return orderCard(order);
                      }).toList(),
                    ],
                  ),
                ),
              ),
            );
          },
          loading: () => CircularProgressIndicator(),
          error: (error, stack) => Text('Error loading orders'),
        );
  }

  Widget orderCard(Order order) {
    return Consumer(
      builder: (context, ref, child) {
        return Neumorphic(
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              title: Text('Order ID: ${order.id}').bold(),
              subtitle: Text(
                  'Number: ${order.orderNumber}, Total Amount: ${order.totalAmount}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NeumorphicButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OrderDetailWidget(orderId: order.id),
                        ),
                      );
                    },
                    child: Icon(Icons.visibility, color: Colors.blue),
                  ),
                  NeumorphicButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OrderUpdateWidget(orderId: order.id),
                        ),
                      );
                    },
                    child: Icon(Icons.edit),
                  ),
                  NeumorphicButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                              'Are you sure you want to delete this order?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                ref.read(deleteOrderByIdProvider(order.id));
                                Navigator.of(context).pop();
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
