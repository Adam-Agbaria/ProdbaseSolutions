import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sidebarx/sidebarx.dart';

class AppNewDrawer extends StatelessWidget {
  final Widget child;
  final SidebarXController controller;
  final NeumorphicThemeData neumorphicTheme;
  final bool isUserSubscribed;

  AppNewDrawer({
    required this.child,
    required this.controller,
    required this.neumorphicTheme,
    required this.isUserSubscribed,
  });

  @override
  Widget build(BuildContext context) {
    List<SidebarXItem> items = [
      SidebarXItem(
        label: 'Home',
        icon: Icons.home,
        onTap: () => Navigator.pushNamed(context, '/home'),
      ),
      SidebarXItem(
        label: 'Products',
        icon: Icons.inventory,
        onTap: () => Navigator.pushNamed(context, '/products'),
      ),
      SidebarXItem(
        label: 'Clients',
        icon: Icons.people,
        onTap: () {
          if (isUserSubscribed) {
            Navigator.pushNamed(context, '/clients');
          } else {
            // Redirect to subscription page or show dialog
            Navigator.pushNamed(context, '/subscribe');
          }
        },
      ),
      SidebarXItem(
        label: 'Transactions',
        icon: Icons.money,
        onTap: () => Navigator.pushNamed(context, '/transactions'),
      ),
      SidebarXItem(
        label: 'Orders',
        icon: Icons.shopping_cart,
        onTap: () => Navigator.pushNamed(context, '/orders'),
      ),
      SidebarXItem(
        label: 'Analytics',
        icon: Icons.bar_chart,
        onTap: () {
          if (isUserSubscribed) {
            Navigator.pushNamed(context, '/analytics');
          } else {
            // Redirect to subscription page or show dialog
            Navigator.pushNamed(context, '/subscribe');
          }
        },
      ),
      SidebarXItem(
        label: 'Settings',
        icon: Icons.settings,
        onTap: () => Navigator.pushNamed(context, '/settings'),
      ),
      SidebarXItem(
        label: 'Profile',
        icon: Icons.account_circle,
        onTap: () => Navigator.pushNamed(context, '/profile'),
      ),
    ];

    final sidebarXTheme = SidebarXTheme(
      decoration: BoxDecoration(
        color: neumorphicTheme.baseColor,
      ),
      textStyle: TextStyle(
        color: neumorphicTheme.defaultTextColor,
      ),
      selectedTextStyle: TextStyle(
        color: neumorphicTheme.variantColor,
      ),
      iconTheme: IconThemeData(
        color: neumorphicTheme.defaultTextColor,
      ),
      selectedIconTheme: IconThemeData(
        color: neumorphicTheme.variantColor,
      ),
    );

    return SidebarX(
      key: GlobalKey(),
      controller: controller,
      items: items,
      theme: sidebarXTheme,
      extendedTheme: const SidebarXTheme(
          width: 200), // Setting the extendedTheme to match the theme
      showToggleButton: true,
      collapseIcon: Icons.arrow_back_ios_new,
      extendIcon: Icons.arrow_forward_ios,
    );
  }
}
