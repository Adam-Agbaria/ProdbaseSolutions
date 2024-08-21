import 'dart:convert';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/profit.dart';
import '../providers/profit_provider.dart';
import '../providers/user_provider.dart';
import 'AnimatedCompanyName.dart';
import 'AppAdvancedDrawer.dart';

class ProfitDetailWidget extends ConsumerStatefulWidget {
  final String profitId;

  ProfitDetailWidget({required this.profitId});

  @override
  _ProfitDetailWidgetState createState() => _ProfitDetailWidgetState();
}

class _ProfitDetailWidgetState extends ConsumerState<ProfitDetailWidget> {
  final AdvancedDrawerController _advancedDrawerController =
      AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    final profitAsyncValue = ref.watch(getProfitByIdProvider(widget.profitId));
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
            child: buildScaffold(profitAsyncValue, theme,
                user?.companyName ?? "Your Company Name"),
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (e, s) =>
          Center(child: Text('An error occurred while fetching the user')),
    );
  }

  Widget buildScaffold(AsyncValue<http.Response> profitAsyncValue,
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
      body: profitAsyncValue.when(
        data: (http.Response response) {
          final profitData = Profit.fromJson(jsonDecode(response.body));
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NeumorphicText(
                  'Profit Number: ${profitData.profitNumber}',
                  style: NeumorphicStyle(depth: 2, intensity: 1),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                NeumorphicText(
                  'User ID: ${profitData.userId}',
                  style: NeumorphicStyle(depth: 2, intensity: 1),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                NeumorphicText(
                  'Order ID: ${profitData.orderId}',
                  style: NeumorphicStyle(depth: 2, intensity: 1),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                NeumorphicText(
                  'Client ID: ${profitData.clientId}',
                  style: NeumorphicStyle(depth: 2, intensity: 1),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                NeumorphicText(
                  'Profit Amount: ${profitData.profitAmount}',
                  style: NeumorphicStyle(depth: 2, intensity: 1),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                NeumorphicText(
                  'Profit Date: ${profitData.profitDate}',
                  style: NeumorphicStyle(depth: 2, intensity: 1),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                // Add more details here as needed
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
