import 'package:flutter/material.dart';
import 'package:live_match/data/data_model/user_model.dart';
import 'package:live_match/logic/locator.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'profile_setup_page.dart';

/// Decides which screen to show based on authentication/local user state.
class ScreenSelector extends StatelessWidget {
  const ScreenSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: Locator.navigationService.isLoadingNotifier,
      builder: (context, isLoading, _) {
        if (isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return ValueListenableBuilder<UserModel?>(
          valueListenable: Locator.userManagementService.userData,
          builder: (context, user, __) {
            // If no user in Hive / not logged in yet -> show login.
            if (user == null) {
              return const LoginPage();
            }

            // If user exists but has not completed basic profile, show setup.
            if (user.profileComplete != true) {
              return const ProfileSetupPage();
            }

            // Existing user found on this device -> go to home.
            return const HomePage();
          },
        );
      },
    );
  }
}