import 'package:flutter/material.dart';

class UnsubscribedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      appBar: AppBar(
        title:
            Text('Subscribe Now!', style: themeData.appBarTheme.titleTextStyle),
        backgroundColor: themeData.primaryColor, // Use primaryColor from theme
        iconTheme: themeData.appBarTheme.iconTheme,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    themeData.colorScheme.primary,
                    themeData.colorScheme.secondary,
                  ],
                ),
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                'Unlock Premium Features',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'ProdBaseSolutions',
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'With a subscription, you get:',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'ProdBaseSolutions',
              ),
            ),
            SizedBox(height: 12),
            buildBenefitItem('Advanced analytics', themeData),
            buildBenefitItem('Priority support', themeData),
            buildBenefitItem('Unlimited access to all features', themeData),
            SizedBox(height: 24),
            Text(
              'All for just \$29.99/month',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontFamily: 'ProdBaseSolutions',
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/subscribe');
              },
              child: Text('Subscribe Now',
                  style: TextStyle(
                    fontFamily: 'ProdBaseSolutions',
                  )),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ProdBaseSolutions',
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBenefitItem(String benefit, ThemeData themeData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 8),
          Text(
            benefit,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'ProdBaseSolutions',
            ),
          ),
        ],
      ),
    );
  }
}
