import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AppAdvancedDrawer extends StatelessWidget {
  final AdvancedDrawerController controller;
  final NeumorphicThemeData theme;
  final Widget child;

  AppAdvancedDrawer({
    required this.controller,
    required this.theme,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    double drawerWidth =
        MediaQuery.of(context).size.width * 0.1; // 60% of screen width

    return AdvancedDrawer(
      backdropColor: theme.baseColor,
      controller: controller,
      drawer: SafeArea(
        child: SizedBox(
          width: drawerWidth, // Set this to whatever width you need
          child: Container(
            color: theme.baseColor,
            child: ListView(
              children: [
                _createDrawerItem(
                  text: 'Home',
                  icon: Icons.home,
                  onTap: () => Navigator.pushNamed(context, '/home'),
                ),
                _createDrawerItem(
                  text: 'Clients',
                  icon: Icons.people,
                  onTap: () => Navigator.pushNamed(context, '/clients'),
                ),
                _createDrawerItem(
                  text: 'Transactions',
                  icon: Icons.attach_money,
                  onTap: () => Navigator.pushNamed(context, '/transactions'),
                ),
                _createDrawerItem(
                  text: 'Orders',
                  icon: Icons.shopping_cart,
                  onTap: () => Navigator.pushNamed(context, '/orders'),
                ),
                _createDrawerItem(
                  text: 'Analytics',
                  icon: Icons.bar_chart,
                  onTap: () => Navigator.pushNamed(context, '/analytics'),
                ),
                _createDrawerItem(
                  text: 'Settings',
                  icon: Icons.settings,
                  onTap: () => Navigator.pushNamed(context, '/settings'),
                ),
                _createDrawerItem(
                  text: 'Profile',
                  icon: Icons.account_circle,
                  onTap: () => Navigator.pushNamed(context, '/profile'),
                ),
              ],
            ),
          ),
        ),
      ),
      child: child,
    );
  }

  Widget _createDrawerItem({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: NeumorphicIcon(
        icon,
        style: NeumorphicStyle(
          depth: 4.0, // Set depth for the icon
          color: Colors.blueGrey, // Set color for the icon
        ),
      ),
      title: Text(text),
      onTap: onTap,
    );
  }
}
