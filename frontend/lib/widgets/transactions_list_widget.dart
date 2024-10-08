import 'dart:convert';
import 'package:ProdBase_Solutions/models/transaction.dart';
import 'package:ProdBase_Solutions/utils/theme_colors.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/transaction_provider.dart';
import '../providers/user_provider.dart';
import 'AppNewDrawer.dart';
import 'AnimatedCompanyName.dart';
import '../providers/search_provider.dart';
import 'package:sidebarx/sidebarx.dart';
import './styled_widgets/hoverButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // <-- Import the search provider
import '../utils/helpers.dart';

class TransactionListWidget extends ConsumerStatefulWidget {
  @override
  _TransactionListWidgetState createState() => _TransactionListWidgetState();
}

class _TransactionListWidgetState extends ConsumerState<TransactionListWidget> {
  String _searchQuery = "";

  final SidebarXController _sidebarXController =
      SidebarXController(selectedIndex: 0, extended: true);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    UIParameters uiParameters = UIParameters(
        titleFontSize: (screenWidth * 0.04).clamp(15.0, 30.0),
        textFontSize: (screenWidth * 0.05).clamp(10.0, 22.0),
        searchBoxHeight: (screenHeight * 0.05).clamp(10.0, 60.0),
        searchBoxWidth: (screenWidth * 0.9).clamp(70.0, 800.0),
        iconSize: (screenWidth * 0.04).clamp(10.0, 24.0));

    double appBarHeight =
        MediaQuery.of(context).size.height * 0.4; // 25% of screen height
    appBarHeight =
        appBarHeight.clamp(100.0, 250.0); // Clamp between 100 and 200
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
                          top: appBarHeight * 0.1,
                          left: appBarHeight * 0.1,
                          child: HoverButton(
                            theme: theme,
                            scaffoldKey: _scaffoldKey,
                            icon: Icons.menu_rounded,
                          ),
                        ),
                        Positioned(
                          top: appBarHeight * 0.3,
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
                      user?.username ?? "Guest",
                      uiParameters),
                  controller: _sidebarXController,
                  neumorphicTheme: theme,
                  isUserSubscribed: user?.subscriptionStatus ?? false,
                ),
                body: buildScaffold(
                    user?.id,
                    theme,
                    user?.companyName ?? "Your Company Name",
                    user?.username ?? "Guest",
                    uiParameters),
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

  Widget buildScaffold(String? userId, NeumorphicThemeData theme,
      String companyName, String username, UIParameters uiParameters) {
    if (userId == null) {
      return Center(child: CircularProgressIndicator());
    }

    return ref.watch(getTransactionsByUserProvider(userId)).when(
          data: (response) {
            if (response.statusCode == 200) {
              var decodedJson = jsonDecode(response.body);
              if (decodedJson['data'] is List) {
                final List<dynamic> dataList = decodedJson['data'];
                final List<Transaction> originalTransactions =
                    dataList.map((item) => Transaction.fromJson(item)).toList();

                return Consumer(
                  builder: (context, ref, _) {
                    final searchNotifier =
                        ref.read(searchNotifierProvider.notifier);

                    List<Transaction> filteredTransactions =
                        ref.watch(searchNotifierProvider).transactions;

                    // If no search query, show all transactions
                    if (_searchQuery.isEmpty) {
                      filteredTransactions = originalTransactions;
                    }

                    return Scaffold(
                      backgroundColor: theme.baseColor,
                      body: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 800,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Transactions:',
                                        style: TextStyle(
                                          fontSize: uiParameters.titleFontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      HoverButton(
                                        theme: theme,
                                        scaffoldKey: _scaffoldKey,
                                        icon: Icons.add,
                                        navigationPlace: '/AddTransaction',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              Center(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight: uiParameters.searchBoxHeight,
                                    maxWidth: uiParameters.searchBoxWidth,
                                  ),
                                  child: Neumorphic(
                                    style: NeumorphicStyle(
                                      depth: -1,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(12)),
                                      color: theme.baseColor,
                                    ),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Search Transactions',
                                        hintStyle: TextStyle(
                                            fontSize:
                                                uiParameters.textFontSize),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: (uiParameters
                                                        .searchBoxHeight -
                                                    uiParameters.textFontSize) *
                                                0.8), // Adjust vertical padding here
                                        prefixIcon: Icon(
                                          Icons.search,
                                          size: uiParameters.iconSize,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        ref
                                            .read(searchQueryProvider.notifier)
                                            .state = value;
                                        searchNotifier.searchTransactions(
                                            originalTransactions, value);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              ...filteredTransactions.map((transaction) {
                                return Center(
                                    child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 800,
                                  ),
                                  child: transactionCard(transaction, theme),
                                ));
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Scaffold(
                  backgroundColor: theme.baseColor,
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth: uiParameters.searchBoxWidth,
                                maxHeight: uiParameters.searchBoxHeight),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Transactions:',
                                  style: TextStyle(
                                      fontSize: uiParameters.titleFontSize,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Lobster'),
                                ),
                                HoverButton(
                                  theme: theme,
                                  scaffoldKey: _scaffoldKey,
                                  icon: Icons.add,
                                  navigationPlace: '/AddTransaction',
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth: uiParameters.searchBoxWidth,
                                maxHeight: uiParameters.searchBoxHeight),
                            child: Neumorphic(
                              style: NeumorphicStyle(
                                depth: -1,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(12)),
                                color: transactionListColor().cardColor,
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search Transactions',
                                  hintStyle: TextStyle(
                                      fontSize: uiParameters.textFontSize),
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
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: NeumorphicText(
                            'No transactions were found',
                            textStyle: NeumorphicTextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            style: NeumorphicStyle(
                              depth: 5,
                              color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color ??
                                  transactionListColor().textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            } else {
              return Text('Error: ${response.statusCode}');
            }
          },
          loading: () => Scaffold(
            backgroundColor: HomeColors()
                .homeBackgroundLight, // Your desired background color
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, stack) => Text('Error loading transactions'),
        );
  }

  Widget transactionCard(Transaction transaction, NeumorphicThemeData theme) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = (constraints.maxWidth * 0.9).clamp(70.0, 800.0);
      double titleFontSize = (constraints.maxWidth * 0.03).clamp(4.0, 14.0);
      double subtitleFontSize = (constraints.maxWidth * 0.025).clamp(4.0, 14.0);
      bool isMobile = constraints.maxWidth < 400;
      double maxHeight;
      if (isMobile) {
        maxHeight =
            (constraints.maxHeight * 0.9).clamp(40.0, 75.0); // For mobile
      } else {
        maxHeight =
            (constraints.maxHeight * 0.9).clamp(40.0, 120.0); // For desktop
      }
      final String formattedDate = formatDate(transaction.transactionDate);

      return Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 10.0), // Adds vertical spacing between cards
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
              maxHeight: maxHeight,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.all(8.0), // Adds margin around each card
              child: Neumorphic(
                style: NeumorphicStyle(
                  color: transactionListColor().cardColor,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: NeumorphicText(
                          'transaction ID: ${transaction.transactionNumber}',
                          style: NeumorphicStyle(
                            depth: 4,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                          textStyle: NeumorphicTextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: NeumorphicText(
                          'Amount: ${transaction.amount}, Client Id: ${transaction.clientId} ',
                          style: NeumorphicStyle(
                            depth: 4,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                          textStyle: NeumorphicTextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: NeumorphicText(
                          'Transaction date: $formattedDate',
                          style: NeumorphicStyle(
                            depth: 1,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                          textStyle: NeumorphicTextStyle(
                            fontSize: subtitleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: isMobile
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: _buildButtons(theme),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: _buildButtons(theme),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  List<Widget> _buildButtons(NeumorphicThemeData theme) {
    return [
      HoverButton(
        theme: theme,
        scaffoldKey: _scaffoldKey,
        icon: Icons.visibility,
        navigationPlace: '/TransactionDetail',
      ),
      SizedBox(width: 8),
      HoverButton(
        theme: theme,
        scaffoldKey: _scaffoldKey,
        icon: Icons.edit,
        navigationPlace: '/TransactionUpdate',
      ),
      SizedBox(width: 8),
      HoverButton(
        theme: theme,
        scaffoldKey: _scaffoldKey,
        icon: Icons.delete,
        navigationPlace: null,
      ),
    ];
  }
}
