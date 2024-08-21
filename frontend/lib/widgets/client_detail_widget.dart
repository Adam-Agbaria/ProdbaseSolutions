import 'dart:convert';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/client.dart';
import '../providers/client_provider.dart';
import '../providers/user_provider.dart';
import 'AnimatedCompanyName.dart'; // Import this
import 'AppAdvancedDrawer.dart'; // Import this

class ClientDetailWidget extends ConsumerStatefulWidget {
  final String clientId;

  ClientDetailWidget({required this.clientId});

  @override
  _ClientDetailWidgetState createState() => _ClientDetailWidgetState();
}

class _ClientDetailWidgetState extends ConsumerState<ClientDetailWidget> {
  final AdvancedDrawerController _advancedDrawerController =
      AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    final clientAsyncValue = ref.watch(getClientByIdProvider(widget.clientId));
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
            child: buildScaffold(clientAsyncValue, theme,
                user?.companyName ?? "Your Company Name"),
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (e, s) =>
          Center(child: Text('An error occurred while fetching the user')),
    );
  }

  Widget buildScaffold(AsyncValue<http.Response> clientAsyncValue,
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
      body: AppAdvancedDrawer(
        controller: _advancedDrawerController,
        theme: theme,
        child: clientAsyncValue.when(
          data: (http.Response response) {
            final clientData = Client.fromJson(jsonDecode(response.body));
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NeumorphicText(
                    'Client Number: ${clientData.clientNumber}',
                    style: NeumorphicStyle(depth: 2, intensity: 1),
                    textStyle: NeumorphicTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  NeumorphicText(
                    'Name: ${clientData.name}',
                    style: NeumorphicStyle(depth: 2, intensity: 1),
                    textStyle: NeumorphicTextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  NeumorphicText(
                    'Email: ${clientData.email ?? "N/A"}',
                    style: NeumorphicStyle(depth: 2, intensity: 1),
                    textStyle: NeumorphicTextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  NeumorphicText(
                    'Phone: ${clientData.phoneNumber ?? "N/A"}',
                    style: NeumorphicStyle(depth: 2, intensity: 1),
                    textStyle: NeumorphicTextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  NeumorphicText(
                    'Notes: ${clientData.notes ?? "N/A"}',
                    style: NeumorphicStyle(depth: 2, intensity: 1),
                    textStyle: NeumorphicTextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  NeumorphicText(
                    'Date Added: ${clientData.dateAdded}',
                    style: NeumorphicStyle(depth: 2, intensity: 1),
                    textStyle: NeumorphicTextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  NeumorphicText(
                    'Last Updated: ${clientData.lastUpdated}',
                    style: NeumorphicStyle(depth: 2, intensity: 1),
                    textStyle: NeumorphicTextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  if (clientData.address != null)
                    NeumorphicText(
                      'Address: ${clientData.address!.street}, ${clientData.address!.city},  ${clientData.address!.postalCode}, ${clientData.address!.country}',
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
      ),
    );
  }
}
