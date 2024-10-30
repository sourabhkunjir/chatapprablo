import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rablochatapp/provider/user_provider.dart';
import 'package:rablochatapp/ui/screens/home_page.dart';
import 'package:rablochatapp/ui/screens/registration_screen.dart';
import 'package:rablochatapp/ui/widgets/coustom_button_container.dart';
import 'package:rablochatapp/utils/build_context_extension.dart';


class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNotifier = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Rablo Login screen"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(hintText: "email"),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(hintText: "password"),
            ),
            SizedBox(
              height: 20,
            ),
            CoustomButtonContainer(
              isLoading: userNotifier.isLoading,
              texthere: "Login here",
              onTap: () async {
                await ref
                    .read(userProvider.notifier)
                    .signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text);
                if (context.mounted) {
                  if (!userNotifier.isError && userNotifier.userData != null) {
                    context.navigateToScreen(HomePage(), isReplace: true);
                  } else {
                    log("failed to login");
                  }
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  context.navigateToScreen(RegistrationScreen(),
                      isReplace: false);
                },
                child: Text("New user? Register here")),
          ],
        ),
      ),
    );
  }
}
