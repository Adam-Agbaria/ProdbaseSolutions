import 'dart:convert';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/order.dart'; // Import your Order model
import '../providers/order_provider.dart'; // Import your Order provider
import '../providers/user_provider.dart';
import 'AnimatedCompanyName.dart'; // Import this
import 'AppAdvancedDrawer.dart'; // Import this

class OrderDetailWidget extends ConsumerStatefulWidget {
  final String orderId;

  OrderDetailWidget({required this.orderId});

  @override
  _OrderDetailWidgetState createState() => _OrderDetailWidgetState();
}

class _OrderDetailWidgetState extends ConsumerState<OrderDetailWidget> {
  final AdvancedDrawerController _advancedDrawerController =
      AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    final orderAsyncValue = ref.watch(getOrderByIdProvider(widget.orderId));
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
            child: buildScaffold(orderAsyncValue, theme,
                user?.companyName ?? "Your Company Name"),
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (e, s) =>
          Center(child: Text('An error occurred while fetching the user')),
    );
  }

  Widget buildScaffold(AsyncValue<http.Response> orderAsyncValue,
      NeumorphicThemeData theme, String companyName) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: AnimatedCompanyName(companyName: companyName, theme: theme),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _advancedDrawerController.showDrawer();
            },
          ),
        ],
      ),
      body: AppAdvancedDrawer(
        controller: _advancedDrawerController,
        theme: theme,
        child: orderAsyncValue.when(
          data: (http.Response response) {
            final orderData = Order.fromJson(jsonDecode(response.body));
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NeumorphicText(
                    'Products:',
                    style: NeumorphicStyle(depth: 2, intensity: 1),
                    textStyle: NeumorphicTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ...orderData.products.map((productDetail) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NeumorphicText(
                            'Product Name: ${productDetail.productName}',
                            style: NeumorphicStyle(depth: 2, intensity: 1),
                            textStyle: NeumorphicTextStyle(
                              fontSize: 16,
                            ),
                          ),
                          NeumorphicText(
                            'Product Number: ${productDetail.productNumber}',
                            style: NeumorphicStyle(depth: 2, intensity: 1),
                            textStyle: NeumorphicTextStyle(
                              fontSize: 16,
                            ),
                          ),
                          NeumorphicText(
                            'Quantity: ${productDetail.quantity}',
                            style: NeumorphicStyle(depth: 2, intensity: 1),
                            textStyle: NeumorphicTextStyle(
                              fontSize: 16,
                            ),
                          ),
                          NeumorphicText(
                            'Price: \$${productDetail.price.toStringAsFixed(2)}',
                            style: NeumorphicStyle(depth: 2, intensity: 1),
                            textStyle: NeumorphicTextStyle(
                              fontSize: 16,
                            ),
                          ),
                          NeumorphicText(
                            'Total: \$${(productDetail.price * productDetail.quantity).toStringAsFixed(2)}',
                            style: NeumorphicStyle(depth: 2, intensity: 1),
                            textStyle: NeumorphicTextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(
            child: NeumorphicText(
              'An error occurred',
              style: NeumorphicStyle(
                depth: 2,
                intensity: 1,
                color: Colors.red,
              ),
              textStyle: NeumorphicTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
