import 'dart:convert';

import 'package:ProdBase_Solutions/utils/theme_colors.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';
import '../providers/product_provider.dart';
import '../providers/user_provider.dart';
import 'AppNewDrawer.dart';
import 'AnimatedCompanyName.dart';
import 'package:sidebarx/sidebarx.dart';
import 'styled_widgets/hoverButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './styled_widgets/styled_widgets.dart'; // Assuming you have the styled_widget package set up as mentioned
import '../services/usb_scanner.dart';
import 'dart:async';
import '../utils/size.dart';

class ProductAddWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductAddWidgetState(); // Corrected the return type
}

class _ProductAddWidgetState extends ConsumerState<ProductAddWidget> {
  // Extended from ConsumerState
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = "";
  String description = "";
  String productNumber = "";
  double price = 0.0;
  int stock = 0;
  String category = "";
  String? imageUrl;
  Color textFieldColor = AddProductColors().textFieldColorLight;

  final SidebarXController _sidebarXController =
      SidebarXController(selectedIndex: 0, extended: true);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Add these lines to create an instance of your UsbSerialScanner class
  // final UsbSerialScanner scanner = UsbSerialScanner();
  StreamSubscription<String>? _barcodeSubscription;
  final TextEditingController _productNumberController =
      TextEditingController();

  // @override
  // void initState() {
  //   super.initState();

  //   // Add these lines to listen to barcode scans
  //   _barcodeSubscription = scanner.barcodeStream.listen((scannedBarcode) {
  //     setState(() {
  //       productNumber = scannedBarcode;
  //     });
  //   });
  // }

  @override
  void dispose() {
    _barcodeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double appBarHeight =
        MediaQuery.of(context).size.height * 0.325; // 25% of screen height
    appBarHeight =
        appBarHeight.clamp(100.0, 220.0); // Clamp between 100 and 200
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    ScreenUtil.init(
      context,
      designSize: Size(360, 690),
      splitScreenMode: false,
    );

    return ref.watch(userProvider).when(
          data: (user) {
            final theme = (user?.settings.theme ?? 'light') == 'light'
                ? NeumorphicThemeData(
                    baseColor: HomeColors().homeBackgroundLight,
                    lightSource: LightSource.topLeft,
                    depth: 10,
                  )
                : NeumorphicThemeData(
                    baseColor: HomeColors().homeBackgroundDark,
                    lightSource: LightSource.topLeft,
                    depth: 10,
                  );

            return NeumorphicTheme(
              theme: theme,
              child: Scaffold(
                key: _scaffoldKey,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(appBarHeight),
                  child: NeumorphicAppBar(
                    automaticallyImplyLeading:
                        false, // Add this line to remove the default menu button
                    color: theme.baseColor,
                    title: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: screenHeight *
                              0.01, // Change this to suit your needs
                          left: screenWidth < 400
                              ? 0.1
                              : 0.1, // Switch between mobile and desktop
                          child: HoverButton(
                            theme: theme,
                            scaffoldKey: _scaffoldKey,
                            icon: Icons.menu_rounded,
                          ),
                        ),
                        Positioned(
                          top: screenWidth < 400
                              ? appBarHeight * 0.13
                              : appBarHeight * 0.26,
                          child: AnimatedCompanyName(
                            companyName:
                                user?.companyName ?? "Your Company Name",
                            theme: theme,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                drawer: AppNewDrawer(
                  child: buildScaffold(
                      user?.id,
                      theme,
                      user?.companyName ?? "Your Company Name",
                      user?.username ?? "Guest"),
                  controller: _sidebarXController,
                  neumorphicTheme: theme,
                  isUserSubscribed: user?.subscriptionStatus ?? false,
                ),
                body: buildScaffold(
                    user?.id,
                    theme,
                    user?.companyName ?? "Your Company Name",
                    user?.username ?? "Guest"),
              ),
            );
          },
          loading: () => CircularProgressIndicator(),
          error: (error, stackTrace) => Text('$error'),
        );
  }

  Widget buildScaffold(String? userId, NeumorphicThemeData theme,
      String companyName, String username) {
    return Consumer(
      builder: (context, watch, child) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double width = constraints.maxWidth > 800
                ? 700 // Maximum width for desktop
                : constraints.maxWidth; // Maximum width for mobile
            double fontSize = constraints.maxWidth > 800
                ? 28 // Font size for desktop
                : 16; // Font size for mobile
            double fontSizeFields = constraints.maxWidth > 800
                ? 14 // Font size for desktop
                : 8; // Font size for mobile

            double fontSizeInsideFields = constraints.maxHeight > 800 ? 14 : 8;
            double textFieldHeight = textFieldSize().addCardFieldSize;
            double spaceBetweenFields = 9;

            return Scaffold(
              backgroundColor: theme.baseColor,
              body: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: width,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12),
                        ),
                        color: theme.baseColor == Color(0xFFFFFFFF)
                            ? AddProductColors().addProductRectangleColorLight
                            // Light Theme
                            : AddProductColors()
                                .addProductRectangleColorDark, // Dark Theme
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            children: [
                              // Main Title: Add Product
                              Text(
                                "Add Product",
                                style: TextStyle(
                                  color: AddProductColors().textColorTitleLight,
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily:
                                      'CroissantOne', // specify the custom font
                                ),
                              ).center(),
                              SizedBox(height: spaceBetweenFields),

                              Row(
                                children: [
                                  // Product's Name Field
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Product's Name:",
                                          style: TextStyle(
                                            color: AddProductColors()
                                                .textColorInField,
                                            fontSize: fontSizeFields,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'CroissantOne',
                                          ),
                                        ),
                                        Neumorphic(
                                          style: NeumorphicStyle(
                                            depth: 1,
                                            color: textFieldColor,
                                            boxShape:
                                                NeumorphicBoxShape.roundRect(
                                                    BorderRadius.circular(12)),
                                          ),
                                          child: Container(
                                            height: textFieldHeight,
                                            child: StyledTextField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter the product name';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) => name = value!,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: spaceBetweenFields),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Product's Price:",
                                          style: TextStyle(
                                            color: AddProductColors()
                                                .textColorInField,
                                            fontSize: fontSizeFields,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'CroissantOne',
                                          ),
                                        ),
                                        Neumorphic(
                                          style: NeumorphicStyle(
                                            depth: 1,
                                            color: textFieldColor,
                                            boxShape:
                                                NeumorphicBoxShape.roundRect(
                                                    BorderRadius.circular(12)),
                                          ),
                                          child: Container(
                                            height: textFieldHeight,
                                            child: StyledTextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty ||
                                                    double.tryParse(value) ==
                                                        null ||
                                                    double.tryParse(value)! <=
                                                        0) {
                                                  return 'Please enter a valid price';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) =>
                                                  price = double.parse(value!),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: spaceBetweenFields),

                              // Product's Number and Product's Price
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Product's Number:",
                                          style: TextStyle(
                                            color: AddProductColors()
                                                .textColorInField,
                                            fontSize: fontSizeFields,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'CroissantOne',
                                          ),
                                        ),
                                        Neumorphic(
                                          style: NeumorphicStyle(
                                            depth: 1,
                                            color: textFieldColor,
                                            boxShape:
                                                NeumorphicBoxShape.roundRect(
                                                    BorderRadius.circular(12)),
                                          ),
                                          child: Container(
                                            height: textFieldHeight,
                                            child: StyledTextField(
                                              controller:
                                                  _productNumberController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter the product number';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) =>
                                                  productNumber = value!,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: spaceBetweenFields),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Product's Stock:",
                                          style: TextStyle(
                                            color: AddProductColors()
                                                .textColorInField,
                                            fontSize: fontSizeFields,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'CroissantOne',
                                          ),
                                        ),
                                        Neumorphic(
                                          style: NeumorphicStyle(
                                            depth: 1,
                                            color: textFieldColor,
                                            boxShape:
                                                NeumorphicBoxShape.roundRect(
                                                    BorderRadius.circular(12)),
                                          ),
                                          child: Container(
                                            height: textFieldHeight,
                                            child: StyledTextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty ||
                                                    int.tryParse(value) ==
                                                        null ||
                                                    int.tryParse(value)! < 0) {
                                                  return 'Please enter a valid stock amount';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) =>
                                                  stock = int.parse(value!),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spaceBetweenFields),

                              //Product's Stock and Product's Category
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Description:",
                                          style: TextStyle(
                                            color: AddProductColors()
                                                .textColorInField,
                                            fontSize: fontSizeFields,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'CroissantOne',
                                          ),
                                        ),
                                        Neumorphic(
                                          style: NeumorphicStyle(
                                            depth: 1,
                                            color: textFieldColor,
                                            boxShape:
                                                NeumorphicBoxShape.roundRect(
                                                    BorderRadius.circular(12)),
                                          ),
                                          child: Container(
                                            height: textFieldHeight,
                                            child: StyledTextField(
                                              labelText: ' Optional',
                                              // validator: (value) {
                                              //   if (value == null ||
                                              //       value.isEmpty) {
                                              //     return 'Please enter the product description';
                                              //   }
                                              //   return null;
                                              // },
                                              onSaved: (value) =>
                                                  description = value!,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: spaceBetweenFields),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Product's Category:",
                                          style: TextStyle(
                                            color: AddProductColors()
                                                .textColorInField,
                                            fontSize: fontSizeFields,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'CroissantOne',
                                          ),
                                        ),
                                        Neumorphic(
                                          style: NeumorphicStyle(
                                            depth: 1,
                                            color: textFieldColor,
                                            boxShape:
                                                NeumorphicBoxShape.roundRect(
                                                    BorderRadius.circular(12)),
                                          ),
                                          child: Container(
                                            height: textFieldHeight,
                                            child: StyledTextField(
                                              labelText: ' Optional',
                                              // validator: (value) {
                                              //   if (value == null ||
                                              //       value.isEmpty) {
                                              //     return 'Please enter the product category';
                                              //   }
                                              //   return null;
                                              // },
                                              onSaved: (value) =>
                                                  category = value!,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spaceBetweenFields),

                              // Product's Image URL Field
                              // Text(
                              //   "Product's Image URL (Optional):",
                              //   style: TextStyle(
                              //     color: AddProductColors().textColorInField,
                              //     fontSize: fontSizeFields,
                              //     fontWeight: FontWeight.normal,
                              //     fontFamily: 'CroissantOne',
                              //   ),
                              // ),
                              // Neumorphic(
                              //   style: NeumorphicStyle(
                              //     depth: 1,
                              //     color: textFieldColor,
                              //     boxShape: NeumorphicBoxShape.roundRect(
                              //         BorderRadius.circular(12)),
                              //   ),
                              //   child: Container(
                              //     height: textFieldHeight,
                              //     child: StyledTextField(
                              //       labelText: 'Image URL',
                              //       hintText: 'Optional',
                              //       validator: (value) {
                              //         if (value != null &&
                              //             value.isNotEmpty &&
                              //             !Uri.parse(value).isAbsolute) {
                              //           return 'Please enter a valid URL';
                              //         }
                              //         return null;
                              //       },
                              //       onSaved: (value) => imageUrl = value,
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(height: spaceBetweenFields),

                              // Submit Button
                              Center(
                                child: Container(
                                  width: 200, // Set width to your desired value
                                  height: buttonSize().addCardButtonHeight,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();

                                        try {
                                          final data = {
                                            'productInfo': {
                                              'name': name,
                                              'description': description,
                                              'productNumber': productNumber,
                                              'price': price.toString(),
                                              'stock': stock.toString(),
                                              'category': category,
                                              // 'imageUrl': imageUrl,
                                            },
                                            'userId': userId
                                          };
                                          final response = await ref.read(
                                              createProductProvider(data)
                                                  .future);

                                          if (response.statusCode == 201) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Product successfully created!'),
                                              ),
                                            );

                                            // Navigate to '/products'
                                            Navigator.pushNamed(
                                                context, '/products');
                                          } else {
                                            final Map<String, dynamic>
                                                errorData = jsonDecode(
                                              utf8.decode(response.bodyBytes),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Error: ${errorData['error']}'),
                                              ),
                                            );
                                          }
                                        } catch (error) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'An error occurred: $error'),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Add Product',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSizeFields,
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(vertical: 16)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30))),
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (theme.baseColor ==
                                              HomeColors()
                                                  .homeBackgroundLight) {
                                            // Light Theme
                                            if (states.contains(
                                                MaterialState.hovered)) {
                                              return AddProductColors()
                                                  .buttonHoveringColorLight;
                                            }
                                            return AddProductColors()
                                                .buttonColorLight;
                                          } else {
                                            // Dark Theme
                                            if (states.contains(
                                                MaterialState.hovered)) {
                                              return AddProductColors()
                                                  .buttonHoveringColorDark;
                                            }
                                            return AddProductColors()
                                                .buttonColorDark;
                                          }
                                        },
                                      ),
                                      // Adding gradient, shadows and rounded corners
                                      foregroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          return Colors.white;
                                        },
                                      ),
                                      side: MaterialStateProperty.all(
                                        BorderSide(
                                            color: AddProductColors()
                                                .buttonColorLight,
                                            width: 2),
                                      ),
                                      elevation: MaterialStateProperty
                                          .resolveWith<double>(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return 10;
                                          }
                                          return 5;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
