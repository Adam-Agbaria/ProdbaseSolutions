import 'dart:convert';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/profit.dart';
import '../providers/profit_provider.dart';
import '../widgets/profit_detail_widget.dart';
import '../providers/user_provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'AppAdvancedDrawer.dart';
import 'AnimatedCompanyName.dart';

class ProfitsListWidget extends ConsumerStatefulWidget {
  @override
  _ProfitsListWidgetState createState() => _ProfitsListWidgetState();
}

class _ProfitsListWidgetState extends ConsumerState<ProfitsListWidget> {
  final AdvancedDrawerController _advancedDrawerController =
      AdvancedDrawerController();
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
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
            child: buildScaffold(user?.id ?? null, theme,
                user?.companyName ?? "Your Company Name"),
          ),
        );
      },
      loading: () => CircularProgressIndicator(),
      error: (error, stackTrace) => Text('Error loading user data'),
    );
  }

  Widget buildScaffold(
      String? userId, NeumorphicThemeData theme, String companyName) {
    if (userId == null) {
      return Center(child: CircularProgressIndicator());
    }

    return ref.watch(getProfitsByUserProvider(userId)).when(
          data: (response) {
            final List<Profit> profits = jsonDecode(response.body)
                .map<Profit>((item) => Profit.fromJson(item))
                .toList();

            return Scaffold(
              appBar: NeumorphicAppBar(
                title:
                    AnimatedCompanyName(companyName: companyName, theme: theme),
                actions: [
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      _advancedDrawerController.showDrawer();
                    },
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Neumorphic(
                        style: NeumorphicStyle(
                          depth: -1,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(12)),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search Profits',
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Profits List',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ...profits.map((profit) {
                        return profitCard(profit);
                      }).toList(),
                    ],
                  ),
                ),
              ),
            );
          },
          loading: () => CircularProgressIndicator(),
          error: (error, stack) => Text('Error loading profits'),
        );
  }

  Widget profitCard(Profit profit) {
    return Consumer(
      builder: (context, ref, child) {
        return Neumorphic(
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              title: Text('Profit ID: ${profit.id}').bold(),
              subtitle: Text(
                  'Order ID: ${profit.orderId}, Profit Amount: ${profit.profitAmount}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NeumorphicButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfitDetailWidget(profitId: profit.id),
                        ),
                      );
                    },
                    child: Icon(Icons.visibility, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
