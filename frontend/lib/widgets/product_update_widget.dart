import 'dart:convert';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';
import '../providers/user_provider.dart';
import 'AnimatedCompanyName.dart';
import 'AppAdvancedDrawer.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class ProductUpdateWidget extends ConsumerStatefulWidget {
  final String productId;

  ProductUpdateWidget({required this.productId});

  @override
  _ProductUpdateWidgetState createState() => _ProductUpdateWidgetState();
}

class _ProductUpdateWidgetState extends ConsumerState<ProductUpdateWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AdvancedDrawerController _advancedDrawerController =
      AdvancedDrawerController();
  late Product _product;

  @override
  void initState() {
    super.initState();
    ref.read(getProductByIdProvider(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(userProvider).when(
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

            final companyName = user?.companyName ?? 'Unknown Company';

            return NeumorphicTheme(
              theme: theme,
              child: AppAdvancedDrawer(
                controller: _advancedDrawerController,
                theme: theme,
                child: buildScaffold(companyName, theme),
              ),
            );
          },
          loading: () => CircularProgressIndicator(),
          error: (error, stackTrace) => Text('Error loading user data'),
        );
  }

  Widget buildScaffold(String companyName, NeumorphicThemeData theme) {
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
      body: Column(
        children: [
          NeumorphicText(
            'Update Product',
            style: NeumorphicStyle(
              depth: 4,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
            textStyle: NeumorphicTextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ref.watch(getProductByIdProvider(widget.productId)).when(
                  data: (response) {
                    _product = Product.fromJson(jsonDecode(response.body));

                    return Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            buildNeumorphicTextField(
                              initialValue: _product.name,
                              labelText: 'Product Name',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Product name cannot be empty';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _product.name = value ?? _product.name;
                              },
                            ),
                            buildNeumorphicTextField(
                              initialValue: _product.description,
                              labelText: 'Description',
                              validator: (value) {
                                return null;
                              },
                              onSaved: (value) {
                                _product.description =
                                    value ?? _product.description;
                              },
                            ),
                            buildNeumorphicTextField(
                              initialValue: _product.price.toString(),
                              labelText: 'Price',
                              validator: (value) {
                                if (value == null ||
                                    double.tryParse(value) == null) {
                                  return 'Invalid price';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _product.price = double.parse(value!);
                              },
                            ),
                            buildNeumorphicTextField(
                              initialValue: _product.stock.toString(),
                              labelText: 'Stock',
                              validator: (value) {
                                if (value == null ||
                                    int.tryParse(value) == null) {
                                  return 'Invalid stock';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _product.stock = int.parse(value!);
                              },
                            ),
                            buildConfirmButton(),
                          ],
                        ),
                      ),
                    );
                  },
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (e, s) => Center(
                    child: Text('An error occurred'),
                  ),
                ),
          ),
        ],
      ),
    );
  }

  Widget buildNeumorphicTextField({
    required String initialValue,
    required String labelText,
    required String? Function(String?) validator,
    required void Function(String?) onSaved,
  }) {
    return Neumorphic(
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(labelText: labelText),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }

  Widget buildConfirmButton() {
    return NeumorphicButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          _product.lastUpdated = DateTime.now();
          final updateData = _product.toJson();

          try {
            await ref.read(updateProductByIdProvider(UpdateProductData(
                productId: widget.productId, data: updateData)));
            Navigator.pop(context);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to update product: $e'),
              ),
            );
          }
        }
      },
      child: Text(
        'Confirm Edit',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
