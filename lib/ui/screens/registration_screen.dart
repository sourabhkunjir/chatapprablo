import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rablochatapp/provider/user_provider.dart';
import 'package:rablochatapp/ui/screens/login_screen.dart';
import 'package:rablochatapp/ui/widgets/coustom_button_container.dart';
import 'package:rablochatapp/utils/build_context_extension.dart';
class RegistrationScreen extends ConsumerWidget {
  RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNotifier = ref.watch(userProvider);
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _mobileController = TextEditingController();  // New controller for mobile number

    return Scaffold(
      appBar: AppBar(
        title: Text("Registration screen"),
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
            SizedBox(height: 20),
            TextFormField(
              controller: _passController,
              decoration: InputDecoration(hintText: "password"),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(hintText: "name"),
            ),
            SizedBox(height: 20),
            TextFormField(  // New TextFormField for mobile number
              controller: _mobileController,
              decoration: InputDecoration(hintText: "mobile number"),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            CoustomButtonContainer(
              isLoading: userNotifier.isLoading,
              texthere: "register here",
              onTap: () async {
                await ref
                    .read(userProvider.notifier)
                    .signUpWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passController.text,
                      name: _nameController.text,
                      phoneNumber: _mobileController.text, 
                    );
                if (context.mounted) {
                  if (!userNotifier.isError && userNotifier.userData != null) {
                    context.navigateToScreen(LoginScreen(), isReplace: true);  
                  } else {
                    log("message: ${userNotifier.message}");
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
