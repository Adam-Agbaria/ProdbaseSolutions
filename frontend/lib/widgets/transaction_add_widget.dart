import 'dart:convert';

import 'package:ProdBase_Solutions/utils/size.dart';
import 'package:ProdBase_Solutions/utils/theme_colors.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';
import '../models/transaction.dart';
import '../providers/transaction_provider.dart';
import '../providers/user_provider.dart';
import 'AppNewDrawer.dart';
import 'AnimatedCompanyName.dart';
import 'package:sidebarx/sidebarx.dart';
import 'styled_widgets/hoverButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/theme_colors.dart';
import './styled_widgets/styled_widgets.dart'; // Assuming you have the styled_widget package set up as mentioned

class TransactionAddWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionAddWidgetState(); // Corrected the return type
}

class _TransactionAddWidgetState extends ConsumerState<TransactionAddWidget> {
  // Extended from ConsumerState
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String transactionNumber = "";
  double amount = 0.0;
  PaymentMethod paymentMethod = PaymentMethod.CreditCard;
  TransactionStatus status = TransactionStatus.Pending;
  List<String> products = [];
  String clientId = "";
  String clientNumber = "";
  String description = "";
  String orderId = "";
  String orderNumber = "";
  Color textFieldColor = AddTransactionColors().textFieldColorLight;

  final SidebarXController _sidebarXController =
      SidebarXController(selectedIndex: 0, extended: true);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                        color: theme.baseColor ==
                                HomeColors().homeBackgroundLight
                            ? AddTransactionColors()
                                .addTransactionRectangleColorLight
                            // Light Theme
                            : AddTransactionColors()
                                .addTransactionRectangleColorDark, // Dark Theme
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            children: [
                              // Main Title: Add Product
                              Text(
                                "Add Transaction",
                                style: TextStyle(
                                  color: AddTransactionColors()
                                      .textColorTitleLight,
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily:
                                      'CroissantOne', // specify the custom font
                                ),
                              ).center(),
                              SizedBox(height: spaceBetweenFields),

                              // First Pair: Transaction Number and Transaction's Description
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Transaction Number:",
                                          style: TextStyle(
                                            color: AddTransactionColors()
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
                                                  return 'Please enter the transaction number';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) =>
                                                  transactionNumber = value!,
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
                                          "Transaction's Description:",
                                          style: TextStyle(
                                            color: AddTransactionColors()
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
                                              onSaved: (value) =>
                                                  description = value!,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spaceBetweenFields),

// Second Pair: Client's Number and Amount Transferred
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Client's Number:",
                                          style: TextStyle(
                                            color: AddTransactionColors()
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
                                              onSaved: (value) =>
                                                  clientNumber = value!,
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
                                          "Amount transferred:",
                                          style: TextStyle(
                                            color: AddTransactionColors()
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
                                                  amount = double.parse(value!),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spaceBetweenFields),
// Third Pair: Payment Method and Transaction Status
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Payment Method:",
                                          style: TextStyle(
                                            color: AddTransactionColors()
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
                                          child: DropdownButtonFormField<
                                              PaymentMethod>(
                                            value: paymentMethod,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: textFieldColor,
                                              labelText:
                                                  ' Select Payment Method',
                                            ),
                                            items: PaymentMethod.values
                                                .map((PaymentMethod value) {
                                              return DropdownMenuItem<
                                                  PaymentMethod>(
                                                value: value,
                                                child: Text(value
                                                    .toString()
                                                    .split('.')
                                                    .last),
                                              );
                                            }).toList(),
                                            onChanged: (PaymentMethod? value) {
                                              if (value != null) {
                                                paymentMethod = value;
                                              }
                                            },
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
                                          "Transaction Status:",
                                          style: TextStyle(
                                            color: AddTransactionColors()
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
                                          child: DropdownButtonFormField<
                                              TransactionStatus>(
                                            value: status,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: textFieldColor,
                                              labelText:
                                                  ' Select Transaction Status',
                                            ),
                                            items: TransactionStatus.values
                                                .map((TransactionStatus value) {
                                              return DropdownMenuItem<
                                                  TransactionStatus>(
                                                value: value,
                                                child: Text(value
                                                    .toString()
                                                    .split('.')
                                                    .last),
                                              );
                                            }).toList(),
                                            onChanged:
                                                (TransactionStatus? value) {
                                              if (value != null) {
                                                status = value;
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spaceBetweenFields),

                              // Order Number Field
                              Text(
                                "Order Number:",
                                style: TextStyle(
                                  color:
                                      AddTransactionColors().textColorInField,
                                  fontSize: fontSizeFields,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'CroissantOne',
                                ),
                              ),
                              Neumorphic(
                                style: NeumorphicStyle(
                                  depth: 1,
                                  color: textFieldColor,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(12)),
                                ),
                                child: Container(
                                  height: textFieldHeight,
                                  child: StyledTextField(
                                    labelText: ' Optional',
                                    onSaved: (value) => orderId = value!,
                                  ),
                                ),
                              ),
                              SizedBox(height: spaceBetweenFields),

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
                                            'TransactionInfo': {
                                              'transactionNumber':
                                                  transactionNumber,
                                              'description': description,
                                              'clientId': clientNumber,
                                              'orderId': orderNumber,
                                              'amount': amount.toString(),
                                              'status':
                                                  transactionStatusToString(
                                                      status),
                                              'paymentMethod':
                                                  paymentMethodToString(
                                                      paymentMethod),
                                            },
                                            'userId': userId
                                          };
                                          final response = await ref.read(
                                              createTransactionProvider(data)
                                                  .future);

                                          if (response.statusCode == 201) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Transaction successfully created!'),
                                              ),
                                            );

                                            // Navigate to '/products'
                                            Navigator.pushNamed(
                                                context, '/transactions');
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
                                      'Add Transaction',
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
                                              return AddTransactionColors()
                                                  .buttonHoveringColorLight;
                                            }
                                            return AddTransactionColors()
                                                .buttonColorLight;
                                          } else {
                                            // Dark Theme
                                            if (states.contains(
                                                MaterialState.hovered)) {
                                              return AddTransactionColors()
                                                  .buttonHoveringColorDark;
                                            }
                                            return AddTransactionColors()
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
                                            color: AddTransactionColors()
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

String formatEnumToString(String enumToString) {
  final List<String> words = enumToString.split(RegExp("(?=[A-Z])"));
  return words.join(' ');
}

String transactionStatusToString(TransactionStatus status) {
  return status.toString().split('.').last;
}

String paymentMethodToString(PaymentMethod method) {
  return method.toString().split('.').last;
}
