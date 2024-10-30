import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rablochatapp/ui/screens/home_page.dart';
import 'package:rablochatapp/ui/screens/login_screen.dart';
import 'package:rablochatapp/utils/build_context_extension.dart';

import '../../repo/auth_repo.dart';


class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        checkUser();
      },
    );
  }

  // auth gate
  void checkUser() {
    bool isUserLoggedIn = ref.read(authRepoProvider).isUserLoggedIn();
    if (isUserLoggedIn) {
      context.navigateToScreen(HomePage(), isReplace: true);
    } else {
      context.navigateToScreen(LoginScreen(), isReplace: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body : Center(
        child: CircularProgressIndicator(),
        
      ),
    );
  }
}
