import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stacked/stacked.dart';

import 'login_model.dart';

class LoginViewScreen extends StatefulWidget {
  const LoginViewScreen({super.key});

  @override
  State<LoginViewScreen> createState() => _LoginViewScreenState();
}

class _LoginViewScreenState extends State<LoginViewScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onViewModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return Scaffold(
          body: WillPopScope(
            onWillPop: showExitPopup,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFE082), Color(0xFFFFCA28)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),
                              const LogoWidget(),
                              const SizedBox(height: 20),
                              const WelcomeText(),
                              const SizedBox(height: 30),

                              // Login Card
                              Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: LoginForm(model: model),
                                ),
                              ),

                              const Spacer(),

                              // Footer with company name
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Powered by",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Sanpra Software Solution Pvt Ltd",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text('Exit App'),
            content: const Text('Do you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }
}

// Logo
class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "app-logo",
      child: Image.asset(
        "assets/images/logo.png",
        height: 150,
        width: 150,
      ),
    );
  }
}

// Welcome Text
class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          "Welcome Back!",
          style: theme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Please sign in to continue",
          style: TextStyle(fontSize: 15, color: Colors.black54),
        ),
      ],
    );
  }
}

// Login Form
class LoginForm extends StatelessWidget {
  final LoginViewModel model;

  const LoginForm({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: model.formGlobalKey,
      child: Column(
        children: [
          UsernameField(model: model),
          const SizedBox(height: 16),
          PasswordField(model: model),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Forgot Password?",
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          LoginButton(model: model),
        ],
      ),
    );
  }
}

class UsernameField extends StatelessWidget {
  final LoginViewModel model;
  const UsernameField({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: model.usernameController,
      decoration: InputDecoration(
        hintText: 'Username',
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
      ),
      autofillHints: const [AutofillHints.username],
      validator: model.validateUsername,
    );
  }
}

class PasswordField extends StatelessWidget {
  final LoginViewModel model;
  const PasswordField({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: model.passwordController,
      obscureText: model.obscurePassword,
      decoration: InputDecoration(
        hintText: 'Password',
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(
            model.obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: model.togglePasswordVisibility,
        ),
      ),
      autofillHints: const [AutofillHints.password],
      onEditingComplete: () {
        TextInput.finishAutofillContext();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      validator: model.validatePassword,
    );
  }
}

class LoginButton extends StatelessWidget {
  final LoginViewModel model;
  const LoginButton({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (model.formGlobalKey.currentState!.validate()) {
          model.formGlobalKey.currentState!.save();
          model.loginWithUsernamePassword(context);
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.yellow[800],
      ),
      child: model.isLoading
          ? LoadingAnimationWidget.hexagonDots(
              color: Colors.white,
              size: 24,
            )
          : const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 12),
                Icon(Icons.login_outlined),
              ],
            ),
    );
  }
}
