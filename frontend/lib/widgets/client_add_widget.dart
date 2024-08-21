import 'dart:convert';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';
import '../providers/user_provider.dart';
import 'AppNewDrawer.dart';
import 'AnimatedCompanyName.dart';
import '../providers/client_provider.dart';
import 'package:sidebarx/sidebarx.dart';
import 'styled_widgets/hoverButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/theme_colors.dart';
import '../utils/size.dart';
import './styled_widgets/styled_widgets.dart'; // Assuming you have the styled_widget package set up as mentioned

class ClientAddWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ClientAddWidgetState(); // Corrected the return type
}

class _ClientAddWidgetState extends ConsumerState<ClientAddWidget> {
  // Extended from ConsumerState
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String clientNumber = "";
  String name = "";
  String? email;
  String? phoneNumber;
  String? street;
  String? city;
  String? postalCode;
  String? country;
  String? notes;
  Color textFieldColor = AddClientColors().textFieldColorLight;

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
                    automaticallyImplyLeading: false,
                    color: theme.baseColor,
                    title: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: screenHeight * 0.01,
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
                        color:
                            theme.baseColor == HomeColors().homeBackgroundLight
                                ? AddClientColors().addClientRectangleColorLight
                                // Light Theme
                                : AddClientColors()
                                    .addClientRectangleColorDark, // Dark Theme
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            children: [
                              // Main Title: Add Product
                              Text(
                                "Add Client",
                                style: TextStyle(
                                  color: AddClientColors().textColorTitleLight,
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily:
                                      'CroissantOne', // specify the custom font
                                ),
                              ).center(),
                              SizedBox(height: spaceBetweenFields),

                              // First Pair: Client's Number and Client's Name
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
                                            color: AddClientColors()
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
                                                  return 'Please enter the client number';
                                                }
                                                return null;
                                              },
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
                                          "Client's Name:",
                                          style: TextStyle(
                                            color: AddClientColors()
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
                                                  return 'Please enter the client name';
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
                                ],
                              ),
                              SizedBox(height: spaceBetweenFields),

                              // Second Pair: Email and Phone Number
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Email:",
                                          style: TextStyle(
                                            color: AddClientColors()
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
                                                  email = value!,
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
                                          "Phone Number:",
                                          style: TextStyle(
                                            color: AddClientColors()
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
                                                if (value != null &&
                                                    value.isNotEmpty) {
                                                  if (int.tryParse(value) ==
                                                          null ||
                                                      int.tryParse(value)! <=
                                                          0) {
                                                    return 'Phone number should be composed of numbers only';
                                                  }
                                                }
                                                return null;
                                              },
                                              onSaved: (value) =>
                                                  phoneNumber = value!,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spaceBetweenFields),

                              // Third Pair: Country and City
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Country:",
                                          style: TextStyle(
                                            color: AddClientColors()
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
                                                  country = value,
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
                                          "City:",
                                          style: TextStyle(
                                            color: AddClientColors()
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
                                              onSaved: (value) => city = value,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spaceBetweenFields),

// Fourth Pair: Street and Postal Code
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Street:",
                                          style: TextStyle(
                                            color: AddClientColors()
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
                                                  street = value,
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
                                          "Postal Code:",
                                          style: TextStyle(
                                            color: AddClientColors()
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
                                                  postalCode = value,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spaceBetweenFields),

                              // Notes Field
                              Text(
                                "Notes:",
                                style: TextStyle(
                                  color: AddClientColors().textColorInField,
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
                                    onSaved: (value) => notes = value,
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
                                            'ClientInfo': {
                                              'clientNumber': clientNumber,
                                              'notes': notes,
                                              'name': name,
                                              'email': email,
                                              'phoneNumber': phoneNumber,
                                              'address': {
                                                'street': street,
                                                'city': city,
                                                'postalCode': postalCode,
                                                'country': country,
                                              }
                                            },
                                            'userId': userId
                                          };
                                          final response = await ref.read(
                                              createClientProvider(data)
                                                  .future);

                                          if (response.statusCode == 201) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Client successfully created!'),
                                              ),
                                            );

                                            // Navigate to '/products'
                                            Navigator.pushNamed(
                                                context, '/clients');
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
                                      'Add Client',
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
                                              return AddClientColors()
                                                  .buttonHoveringColorLight;
                                            }
                                            return AddClientColors()
                                                .buttonColorLight;
                                          } else {
                                            // Dark Theme
                                            if (states.contains(
                                                MaterialState.hovered)) {
                                              return AddClientColors()
                                                  .buttonHoveringColorDark;
                                            }
                                            return AddClientColors()
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
                                            color: AddClientColors()
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
