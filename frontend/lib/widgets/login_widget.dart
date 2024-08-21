import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/validators.dart'; // Import the file where Validator class is defined
import '../providers/auth_provider.dart'; // Import your auth provider
import '../models/user.dart';
import 'dart:convert';

class LoginWidget extends ConsumerStatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends ConsumerState<LoginWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordValid = true;
  String? passwordValidationMessage;
  final Validators validatorCust = Validators();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Log in to Your Account',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Access all the features by logging in.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 20),
              Neumorphic(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  depth: 8,
                ),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(height: 16),
              Neumorphic(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  depth: 8,
                ),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                  ),
                  obscureText: true,
                  onChanged: (password) {
                    final validationMessage =
                        validatorCust.validatePassword(password);
                    setState(() {
                      isPasswordValid = validationMessage == null;
                      passwordValidationMessage = validationMessage;
                    });
                  },
                ),
              ),
              if (!isPasswordValid && passwordValidationMessage != null)
                Text(
                  passwordValidationMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              SizedBox(height: 20),
              NeumorphicButton(
                onPressed: () async {
                  if (isPasswordValid) {
                    final data = {
                      'email': emailController.text,
                      'password': passwordController.text,
                    };
                    final response =
                        await ref.read(loginUserProvider(data).future);

                    if (response.statusCode == 200) {
                      final jsonBody = json.decode(response.body);
                      final userJson = jsonBody['user'];
                      final user = User.fromJson(userJson);
                      if (user.subscriptionStatus) {
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        Navigator.pushReplacementNamed(
                            context, '/unsubscribed');
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Login failed. Please try again.')),
                      );
                    }
                  }
                },
                style: NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
