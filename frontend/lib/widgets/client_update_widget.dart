import 'dart:convert';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/client.dart';
import '../providers/client_provider.dart';
import '../providers/user_provider.dart';
import 'AnimatedCompanyName.dart'; // Import this
import 'AppAdvancedDrawer.dart'; // Import this
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class ClientUpdateWidget extends ConsumerStatefulWidget {
  final String clientId;

  ClientUpdateWidget({required this.clientId});

  @override
  _ClientUpdateWidgetState createState() => _ClientUpdateWidgetState();
}

class _ClientUpdateWidgetState extends ConsumerState<ClientUpdateWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AdvancedDrawerController _advancedDrawerController =
      AdvancedDrawerController(); // Drawer Controller
  late Client _client;

  @override
  void initState() {
    super.initState();
    ref.read(getClientByIdProvider(widget.clientId));
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
                child:
                    buildScaffold(companyName, theme), // Pass the Scaffold here
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
              _advancedDrawerController.showDrawer(); // Show drawer
            },
          ),
        ],
      ),
      body: Column(
        children: [
          NeumorphicText(
            'Update Client',
            style: NeumorphicStyle(
              depth: 4,
              color: Theme.of(context).textTheme.displayLarge?.color,
            ),
            textStyle: NeumorphicTextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ref.watch(getClientByIdProvider(widget.clientId)).when(
                  data: (response) {
                    _client = Client.fromJson(jsonDecode(response.body));

                    return Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            buildNeumorphicTextField(
                              initialValue: _client.name ??
                                  '', // Providing a default value
                              labelText: 'Name',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Name cannot be empty';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _client.name = value ?? _client.name;
                              },
                            ),
                            buildNeumorphicTextField(
                              initialValue: _client.email ??
                                  '', // Providing a default value
                              labelText: 'Email',
                              validator: (value) {
                                if (value == null || !value.contains('@')) {
                                  return 'Invalid email address';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _client.email = value ?? _client.email;
                              },
                            ),
                            buildNeumorphicTextField(
                              initialValue: _client.phoneNumber ??
                                  '', // Providing a default value
                              labelText: 'Phone Number',
                              validator: (value) {
                                if (value == null || value.length < 10) {
                                  return 'Invalid phone number';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _client.phoneNumber =
                                    value ?? _client.phoneNumber;
                              },
                            ),
                            buildNeumorphicTextField(
                              initialValue: _client.notes ??
                                  '', // Providing a default value
                              labelText: 'Notes',
                              validator: (value) {
                                return null; // No validation for notes
                              },
                              onSaved: (value) {
                                _client.notes = value ?? _client.notes;
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
          _client.lastUpdated = DateTime.now();
          final updateData = _client.toJson();
          try {
            await ref.read(updateClientByIdProvider(
                UpdateClientData(clientId: widget.clientId, data: updateData)));
            Navigator.pop(context);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to update client: $e'),
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
