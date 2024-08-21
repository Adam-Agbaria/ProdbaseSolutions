import 'dart:convert';
import 'package:ProdBase_Solutions/providers/analytics_provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:http/http.dart' as http;
import '../providers/user_provider.dart';
import './styled_widgets/hoverButton.dart';
import 'AppNewDrawer.dart';
import 'package:sidebarx/sidebarx.dart';
import 'AnimatedCompanyName.dart'; // Importing the AnimatedCompanyName widget
// Importing the AppAdvancedDrawer widget
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/theme_colors.dart';

class HomeWidget extends ConsumerStatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends ConsumerState<HomeWidget> {
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
                          left: screenWidth < 300
                              ? 0.1
                              : 0.1, // Switch between mobile and desktop
                          child: HoverButton(
                            theme: theme,
                            scaffoldKey: _scaffoldKey,
                            icon: Icons.menu_rounded,
                          ),
                        ),
                        Positioned(
                          top: screenWidth < 300
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
                      theme,
                      user?.companyName ?? "Your Company Name",
                      user?.username ?? "Guest",
                      user?.id ?? ""),
                  controller: _sidebarXController,
                  neumorphicTheme: theme,
                  isUserSubscribed: user?.subscriptionStatus ?? false,
                ),
                body: buildScaffold(
                    theme,
                    user?.companyName ?? "Your Company Name",
                    user?.username ?? "Guest",
                    user?.id ?? ""),
              ),
            );
          },
          loading: () => Scaffold(
            backgroundColor: HomeColors()
                .homeBackgroundLight, // Your desired background color
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, stackTrace) => Text('$error'),
        );
  }

  Widget buildScaffold(NeumorphicThemeData theme, String companyName,
      String username, String userId) {
    return Scaffold(
      backgroundColor: theme.baseColor, // Set the background color
      body: Column(
        children: [
          // Quick Actions
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth >= 600) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    quickActionButton(
                        Icons.person_add,
                        "Add Client",
                        '/AddClient',
                        context,
                        HomeColors().addClientHomeButton),
                    quickActionButton(
                        Icons.add_shopping_cart,
                        "Add Product",
                        '/AddProduct',
                        context,
                        HomeColors().addProductHomeButton),
                    quickActionButton(Icons.assignment, "Add Order",
                        '/AddOrder', context, HomeColors().addOrderHomeButton),
                    quickActionButton(
                        Icons.money,
                        "Add Transaction",
                        '/AddTransaction',
                        context,
                        HomeColors().addTransactionHomeButton),
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // First row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        quickActionButton(
                            Icons.person_add,
                            "Add Client",
                            '/AddClient',
                            context,
                            HomeColors().addClientHomeButton),
                        Padding(
                          padding: const EdgeInsets.only(
                              right:
                                  8.0), // Additional shift to the left for "Add Product"
                          child: quickActionButton(
                              Icons.add_shopping_cart,
                              "Add Product",
                              '/AddProduct',
                              context,
                              HomeColors().addProductHomeButton),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Second row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        quickActionButton(
                            Icons.assignment,
                            "Add Order",
                            '/AddOrder',
                            context,
                            HomeColors().addOrderHomeButton),
                        quickActionButton(
                            Icons.money,
                            "Add Transaction",
                            '/AddTransaction',
                            context,
                            HomeColors().addTransactionHomeButton),
                      ],
                    ),
                  ],
                );
              }
            },
          ),

          SizedBox(height: 20),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Your existing consumer cards
                    consumerCard(
                        getTotalProfitsProvider(userId),
                        'Total Profits',
                        'You haven\'t made any sales yet.',
                        theme),
                    SizedBox(height: 16),
                    consumerCard(getTopProductsProvider(userId), 'Top Products',
                        'No products sold yet.', theme),
                    SizedBox(height: 16),
                    consumerCard(getTopClientsProvider(userId), 'Top Clients',
                        'No clients yet.', theme),
                    SizedBox(height: 16),
                    consumerCard(getAverageOrderValueProvider(userId),
                        'Average Order Value', 'No orders yet.', theme),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget quickActionButton(IconData icon, String label, String routeName,
      BuildContext context, Color buttonColor) {
    double screenWidth = MediaQuery.of(context).size.width;

    double buttonSize =
        (0.05 * screenWidth).clamp(10.0, 75.0); // Using .clamp() to limit range
    double iconSize =
        (0.05 * screenWidth).clamp(5.0, 37.5); // Using .clamp() to limit range

    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, routeName);
              },
              onHover: (isHovering) {
                setState(() {
                  buttonColor = isHovering
                      ? buttonColor
                          .withOpacity(0.8) // change opacity when hovering
                      : buttonColor;
                });
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: buttonColor,
                foregroundColor: Colors.white,
                minimumSize:
                    Size(buttonSize, buttonSize), // set the button size here
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: iconSize, // set the icon size here
                ),
              ),
            ),
            Text(label),
          ],
        );
      },
    );
  }

  Widget consumerCard(
    FutureProvider<http.Response> provider,
    String title,
    String emptyMessage,
    NeumorphicThemeData theme,
  ) {
    return Consumer(
      builder: (context, ref, child) {
        final asyncData = ref.watch(provider);

        return LayoutBuilder(builder: (context, constraints) {
          double maxWidth = (constraints.maxWidth * 0.9).clamp(70.0, 800.0);
          double titleFontSize = (constraints.maxWidth * 0.03).clamp(4.0, 14.0);
          double subtitleFontSize =
              (constraints.maxWidth * 0.025).clamp(4.0, 14.0);

          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10.0), // Adds vertical spacing between cards
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxWidth,
                ),
                child: Neumorphic(
                  style: NeumorphicStyle(
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                    surfaceIntensity: 0.1,
                    color: HomeColors().homeCards,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: asyncData.when(
                      data: (response) {
                        try {
                          final Map<String, dynamic> data =
                              jsonDecode(response.body);
                          return ListTile(
                            title: Text(
                              '$title',
                              style: TextStyle(
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'CroissantOne'),
                            ),
                            subtitle: Text(
                              '${data[title] ?? emptyMessage}',
                              style: TextStyle(fontSize: subtitleFontSize),
                            ),
                          );
                        } catch (e) {
                          print("Error in JSON decoding: $e");
                          return ListTile(
                            title: Text(
                              title,
                              style: TextStyle(
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              emptyMessage,
                              style: TextStyle(fontSize: subtitleFontSize),
                            ),
                          );
                        }
                      },
                      loading: () => Center(child: CircularProgressIndicator()),
                      error: (e, s) => ListTile(
                        title: Text(
                          title,
                          style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          emptyMessage,
                          style: TextStyle(fontSize: subtitleFontSize),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
