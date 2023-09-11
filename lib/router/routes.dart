import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_profile/core/utils/enum_utils.dart';
import 'package:my_profile/features/models/user_details_model.dart';
import 'package:my_profile/features/presentation/edit_profile/edit_work_experience.dart';
import 'package:my_profile/features/presentation/home/home_screen.dart';
import 'package:my_profile/features/presentation/login/login_screen.dart';
import 'package:my_profile/features/presentation/welcome/welcome_screen.dart';

import '../features/presentation/edit_profile/edit_profile_screen.dart';

class Routes {
  static const welcomeScreen = '/';
  static const loginScreen = '/loginScreen';
  static const homeScreen = '/homeScreen';
  static const editWorkExperience = '/editWorkExperience';
  static const editProfileScreen = '/editProfileScreen';

  static GoRouter doRouter = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: welcomeScreen,
        builder: (BuildContext context, GoRouterState state) =>
            const WelcomeScreen(),
      ),
      GoRoute(
        path: loginScreen,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      GoRoute(
        path: homeScreen,
        builder: (BuildContext context, GoRouterState state) =>
            const HomeScreen(),
      ),
      GoRoute(
        path: editProfileScreen,
        builder: (BuildContext context, GoRouterState state) =>
            EditProfileScreen(
          editFields: state.extra as EditFields,
        ),
      ),
      GoRoute(
        path: editWorkExperience,
        builder: (BuildContext context, GoRouterState state) =>
            EditWorkExperienceScreen(
          workExperience: state.extra as WorkExperienceData?,
        ),
      ),
    ],
  );
}
