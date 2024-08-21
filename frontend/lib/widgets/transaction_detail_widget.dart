import 'dart:convert';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import '../models/transaction.dart';
import '../providers/transaction_provider.dart';
import '../providers/user_provider.dart';
import 'AnimatedCompanyName.dart'; // Import this
import 'AppAdvancedDrawer.dart'; // Import this
import 'package:http/http.dart' as http;

class TransactionDetailWidget extends ConsumerStatefulWidget {
  final String transactionId;

  TransactionDetailWidget({required this.transactionId});

  @override
  _TransactionDetailWidgetState createState() =>
      _TransactionDetailWidgetState();
}

class _TransactionDetailWidgetState
    extends ConsumerState<TransactionDetailWidget> {
  final AdvancedDrawerController _advancedDrawerController =
      AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    final transactionAsyncValue =
        ref.watch(getTransactionByIdProvider(widget.transactionId));
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
            child: buildScaffold(transactionAsyncValue, theme,
                user?.companyName ?? "Your Company Name"),
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (e, s) =>
          Center(child: Text('An error occurred while fetching the user')),
    );
  }

  Widget buildScaffold(AsyncValue<http.Response> transactionAsyncValue,
      NeumorphicThemeData theme, String companyName) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: AnimatedCompanyName(companyName: companyName, theme: theme),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: _advancedDrawerController.showDrawer,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: NeumorphicText(
              'Transaction Details',
              style: NeumorphicStyle(
                depth: 4,
                color: Theme.of(context).textTheme.displayLarge?.color,
              ),
              textStyle: NeumorphicTextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: transactionAsyncValue.when(
              data: (response) {
                final Transaction transactionData =
                    Transaction.fromJson(jsonDecode(response.body));
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Neumorphic(
                          style: NeumorphicStyle(
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(12)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Transaction Number: ${transactionData.transactionNumber}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('Amount: ${transactionData.amount}'),
                                Text('Status: ${transactionData.status}'),
                                Text(
                                    'Payment Method: ${transactionData.paymentMethod}'),
                                Text(
                                    'Transaction Date: ${transactionData.transactionDate}'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            NeumorphicButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/updateTransaction', arguments: {
                                  'transactionId': transactionData.id
                                });
                              },
                              child: Icon(Icons.update),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text('An error occurred')),
            ),
          ),
        ],
      ),
    );
  }
}
