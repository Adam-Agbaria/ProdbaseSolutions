import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import the SVG package
import '../models/User.dart';

class AppDrawer extends StatelessWidget {
  final ThemeData currentTheme;
  final User? currentUser;

  AppDrawer({required this.currentTheme, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  currentTheme.primaryColorLight,
                  currentTheme.primaryColor
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Text(
              'Menu',
              style: currentTheme.textTheme.titleLarge?.copyWith(
                color: currentTheme.primaryTextTheme.titleLarge?.color ??
                    Colors.white,
              ),
            ),
          ),
          _createDrawerItem(
            text: 'Home',
            iconPath: 'assets/icons/home.svg',
            onTap: () => Navigator.pushNamed(context, '/home'),
          ),
          _createDrawerItem(
            text: 'Clients',
            iconPath: 'assets/icons/client.svg',
            onTap: () => Navigator.pushNamed(context, '/clients'),
          ),
          _createDrawerItem(
            text: 'Transactions',
            iconPath: 'assets/icons/transaction.svg',
            onTap: () => Navigator.pushNamed(context, '/transactions'),
          ),
          _createDrawerItem(
            text: 'Orders',
            iconPath: 'assets/icons/order.svg',
            onTap: () => Navigator.pushNamed(context, '/orders'),
          ),
          _createDrawerItem(
            text: 'Analytics',
            iconPath: 'assets/icons/analytic.svg',
            onTap: () => Navigator.pushNamed(context, '/analytics'),
          ),
          _createDrawerItem(
            text: 'Settings',
            iconPath: 'assets/icons/settings.svg',
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),
          _createDrawerItem(
            text: 'Profile',
            iconPath: 'assets/icons/profile.svg',
            onTap: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem({
    required String text,
    required String iconPath,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      leading: SvgPicture.asset(
        iconPath,
        colorFilter: ColorFilter.mode(
          currentTheme.iconTheme.color ?? Colors.black,
          BlendMode.srcIn,
        ),
        width: 24,
      ),
      title: Text(
        text,
        style: currentTheme.textTheme.bodyLarge,
      ),
      onTap: onTap,
    );
  }
}
