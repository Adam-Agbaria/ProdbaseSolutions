import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import '../models/transaction.dart';
import '../providers/transaction_provider.dart';
import '../providers/user_provider.dart';
import 'AnimatedCompanyName.dart'; // Import this
// Import this

class TransactionUpdateWidget extends ConsumerStatefulWidget {
  final String transactionId;

  TransactionUpdateWidget({required this.transactionId});

  @override
  _TransactionUpdateWidgetState createState() =>
      _TransactionUpdateWidgetState();
}

class _TransactionUpdateWidgetState
    extends ConsumerState<TransactionUpdateWidget> {
  late Transaction _transaction;
  late TransactionStatus _selectedStatus;
  final AdvancedDrawerController _advancedDrawerController =
      AdvancedDrawerController();

  @override
  void initState() {
    super.initState();
    ref.read(getTransactionByIdProvider(widget.transactionId));
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
              child:
                  buildScaffold(theme, companyName), // Pass company name here
            );
          },
          loading: () => CircularProgressIndicator(),
          error: (error, stackTrace) => Text('Error loading user data'),
        );
  }

  Widget buildScaffold(NeumorphicThemeData theme, String companyName) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              NeumorphicText(
                'Update Transaction Status',
                style: NeumorphicStyle(
                  depth: 4, // Set the depth of the text (negative or positive)
                  color: Theme.of(context).textTheme.displayLarge?.color,
                ),
                textStyle: NeumorphicTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              buildDropdownButton(),
              buildConfirmButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropdownButton() {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: 8,
        surfaceIntensity: 0.5,
      ),
      child: DropdownButtonFormField<TransactionStatus>(
        value: _selectedStatus,
        items: TransactionStatus.values.map((status) {
          return DropdownMenuItem(
            value: status,
            child: Text(
              status.toString().split('.').last,
              style: TextStyle(fontSize: 16),
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: 'Transaction Status',
        ),
        onChanged: (newValue) {
          if (newValue != null) {
            setState(() {
              _selectedStatus = newValue;
            });
          }
        },
      ),
    );
  }

  Widget buildConfirmButton() {
    return NeumorphicButton(
      onPressed: () async {
        _transaction.status = _selectedStatus;
        final updateData = _transaction.toJson();
        try {
          await ref.read(updateTransactionByIdProvider(UpdateTransactionData(
              transactionId: widget.transactionId, data: updateData)));
          Navigator.pop(context);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to update transaction: $e'),
          ));
        }
      },
      child: Text(
        'Confirm Edit',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
