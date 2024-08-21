import 'dart:convert';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../providers/product_provider.dart';
import '../providers/user_provider.dart';
import 'AnimatedCompanyName.dart'; // Import this
import 'AppAdvancedDrawer.dart'; // Import this

class ProductDetailWidget extends ConsumerStatefulWidget {
  final String productId;

  ProductDetailWidget({required this.productId});

  @override
  _ProductDetailWidgetState createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends ConsumerState<ProductDetailWidget> {
  final AdvancedDrawerController _advancedDrawerController =
      AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    final productAsyncValue =
        ref.watch(getProductByIdProvider(widget.productId));
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
            child: buildScaffold(productAsyncValue, theme,
                user?.companyName ?? "Your Company Name"),
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (e, s) =>
          Center(child: Text('An error occurred while fetching the user')),
    );
  }

  Widget buildScaffold(AsyncValue<http.Response> productAsyncValue,
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
      body: productAsyncValue.when(
        data: (http.Response response) {
          final productData = Product.fromJson(jsonDecode(response.body));
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NeumorphicText(
                  'Product Number: ${productData.productNumber}',
                  style: NeumorphicStyle(depth: 2, intensity: 1),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                NeumorphicText(
                  'Name: ${productData.name}',
                  style: NeumorphicStyle(depth: 2, intensity: 1),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                NeumorphicText(
                  'Description: ${productData.description}',
                  style: NeumorphicStyle(depth: 2, intensity: 1),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                NeumorphicText(
                  'Price: ${productData.price}',
                  style: NeumorphicStyle(depth: 2, intensity: 1),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                NeumorphicText(
                  'Stock: ${productData.stock}',
                  style: NeumorphicStyle(depth: 2, intensity: 1),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                NeumorphicText(
                  'Category: ${productData.category}',
                  style: NeumorphicStyle(depth: 2, intensity: 1),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                NeumorphicText(
                  'Date Added: ${productData.dateAdded}',
                  style: NeumorphicStyle(depth: 2, intensity: 1),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                NeumorphicText(
                  'Last Updated: ${productData.lastUpdated}',
                  style: NeumorphicStyle(depth: 2, intensity: 1),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 16,
                  ),
                ),
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
    );
  }
}
