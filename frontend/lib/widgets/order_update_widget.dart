import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order.dart';
import '../providers/order_provider.dart';
import '../providers/user_provider.dart';
import 'AnimatedCompanyName.dart'; // Import your custom widget
import 'AppAdvancedDrawer.dart'; // Import your custom widget
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class OrderUpdateWidget extends ConsumerStatefulWidget {
  final String orderId;

  OrderUpdateWidget({required this.orderId});

  @override
  _OrderUpdateWidgetState createState() => _OrderUpdateWidgetState();
}

class _OrderUpdateWidgetState extends ConsumerState<OrderUpdateWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AdvancedDrawerController _advancedDrawerController =
      AdvancedDrawerController();
  late Order _order;

  @override
  void initState() {
    super.initState();
    ref.read(getOrderByIdProvider(widget.orderId));
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

            final companyName = user?.companyName ?? 'Your Company';

            return NeumorphicTheme(
              theme: theme,
              child: AppAdvancedDrawer(
                controller: _advancedDrawerController,
                theme: theme,
                child: buildScaffold(companyName, theme),
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
              _advancedDrawerController.showDrawer();
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Your other form fields here

            // To update the order date
            ElevatedButton(
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: _order.orderDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (newDate != null) {
                  setState(() {
                    _order.orderDate = newDate;
                  });
                }
              },
              child: Text("Update Order Date"),
            ),

            // To update the delivery status
            DropdownButton(
              value: _order.deliveryDetails.deliveryStatus,
              onChanged: (DeliveryStatus? newValue) {
                if (newValue != null) {
                  setState(() {
                    _order.deliveryDetails.deliveryStatus = newValue;
                  });
                }
              },
              items: DeliveryStatus.values.map((DeliveryStatus status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status.toString().split('.').last),
                );
              }).toList(),
            ),

            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final updateData = UpdateOrderData(
                    orderId: _order.id,
                    data: _order.toJson(),
                  );
                  try {
                    await ref.read(updateOrderByIdProvider(updateData));
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to update order: $e'),
                      ),
                    );
                  }
                }
              },
              child: Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
