import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/validators.dart'; // Import the file where Validator class is defined
import '../providers/auth_provider.dart'; // Import your auth provider

class RegisterWidget extends ConsumerStatefulWidget {
  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends ConsumerState<RegisterWidget> {
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final Validators validatorCust = Validators();

  String? passwordValidationMessage;
  String? companyNameValidationMessage;
  bool isUsernameValid = true;
  String? usernameValidationMessage;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.6, // 80% of screen width
          heightFactor: 0.7, // 70% of screen height
          child: Neumorphic(
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              depth: 8,
              intensity: 0.5,
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Set to minimum
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      // Center only this text
                      child: Text(
                        'Register Your Company',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Fill in the details to create your account.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 20),
                    NeumorphicText('Company Name:',
                        style: NeumorphicStyle(
                            depth: 1, intensity: 0.5, color: Colors.black),
                        textStyle: NeumorphicTextStyle(fontSize: 16)),
                    Neumorphic(
                      style: NeumorphicStyle(
                        depth: 4,
                        intensity: 0.6,
                      ),
                      child: TextField(
                        controller: companyNameController,
                        decoration: InputDecoration(
                          labelText: 'Company Name',
                          hintText: 'Enter your company name',
                        ),
                        onChanged: (name) {
                          final validationMessage =
                              validatorCust.validateCompanyName(name);
                          setState(() {
                            companyNameValidationMessage = validationMessage;
                          });
                        },
                      ),
                    ),
                    if (companyNameValidationMessage != null)
                      Text(
                        companyNameValidationMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    SizedBox(height: 10),
                    NeumorphicText('Username:',
                        style: NeumorphicStyle(
                            depth: 1, intensity: 0.5, color: Colors.black),
                        textStyle: NeumorphicTextStyle(fontSize: 16)),
                    Neumorphic(
                      style: NeumorphicStyle(
                        depth: 4,
                        intensity: 0.6,
                      ),
                      child: TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          hintText: 'Enter your username',
                        ),
                        onChanged: (username) {
                          final validationMessage =
                              validatorCust.validateUsername(username);
                          setState(() {
                            isUsernameValid = validationMessage == null;
                            usernameValidationMessage = validationMessage;
                          });
                        },
                      ),
                    ),
                    if (!isUsernameValid && usernameValidationMessage != null)
                      Text(
                        usernameValidationMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    SizedBox(height: 10),
                    NeumorphicText('Email:',
                        style: NeumorphicStyle(
                            depth: 1, intensity: 0.5, color: Colors.black),
                        textStyle: NeumorphicTextStyle(fontSize: 16)),
                    Neumorphic(
                      style: NeumorphicStyle(
                        depth: 4,
                        intensity: 0.6,
                      ),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    NeumorphicText('Password:',
                        style: NeumorphicStyle(
                            depth: 1, intensity: 0.5, color: Colors.black),
                        textStyle: NeumorphicTextStyle(fontSize: 16)),
                    Neumorphic(
                      style: NeumorphicStyle(
                        depth: 4,
                        intensity: 0.6,
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
                            passwordValidationMessage = validationMessage;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    NeumorphicText('Confirm Password:',
                        style: NeumorphicStyle(
                            depth: 1, intensity: 0.5, color: Colors.black),
                        textStyle: NeumorphicTextStyle(fontSize: 16)),
                    Neumorphic(
                      style: NeumorphicStyle(
                        depth: 4,
                        intensity: 0.6,
                      ),
                      child: TextField(
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Confirm your password',
                        ),
                        obscureText: true,
                        onChanged: (password) {
                          if (password != passwordController.text) {
                            setState(() {
                              passwordValidationMessage =
                                  'Passwords do not match';
                            });
                          } else {
                            setState(() {
                              passwordValidationMessage = null;
                            });
                          }
                        },
                      ),
                    ),
                    if (passwordValidationMessage != null)
                      Text(
                        passwordValidationMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    SizedBox(height: 20),
                    Center(
                      child: NeumorphicButton(
                        onPressed: () async {
                          if (companyNameController.text.isNotEmpty &&
                              usernameController.text.isNotEmpty &&
                              emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty &&
                              passwordController.text ==
                                  confirmPasswordController.text) {
                            final data = {
                              'companyName': companyNameController.text,
                              'userName': usernameController.text,
                              'email': emailController.text,
                              'password': passwordController.text,
                            };


                            final response = await ref
                                .read(registerUserProvider(data).future);
                            if (response.statusCode == 200) {
                              // Navigate to home page or show success message
                              Navigator.pushReplacementNamed(
                                  context, '/unsubscribed');
                            } else {
                              // Handle error, show message to user
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Registration failed. Please try again.')),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Please fill all the fields')),
                            );
                          }
                        },
                        style: NeumorphicStyle(
                          depth: 8,
                          intensity: 0.8,
                        ),
                        child: DefaultTextStyle(
                          style: TextStyle(color: Colors.black),
                          child: NeumorphicText('Register',
                              style: NeumorphicStyle(
                                  depth: 1,
                                  intensity: 0.5,
                                  color: Colors.black),
                              textStyle: NeumorphicTextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
