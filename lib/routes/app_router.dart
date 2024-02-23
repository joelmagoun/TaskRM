import 'package:flutter/material.dart';
import 'package:task_rm/routes/routes.dart';
import '../views/auth/login/login_screen.dart';
import '../views/auth/signup/signup_screen.dart';
import '../views/home/home_screen.dart';


class AppRouter {
  static generateRoute() {
    return (RouteSettings settings) {
      Widget route = _getRouteWidget(settings);

      return MaterialPageRoute(
        builder: (context) => route,
        settings: settings,
      );
    };
  }

  static _getRouteWidget(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return const HomeScreen();
      // case Routes.newTask:
      //   return const NewTaskPage();
      // case Routes.newGoal:
      //   return const NewGoalPage();
      // case Routes.taskDetails:
      //   return TaskDetailsPage(task: settings.arguments as Task);
      // case Routes.goalsList:
      //   return const GoalsListPage();
      // case Routes.goalDetails:
      //   return GoalDetailPage(goalId: settings.arguments as String);
      // //return GoalDetailPage(goal: settings.arguments as Goal);
      // case Routes.todayTasksList:
      //   return const TodayTaskListPage();
      // case Routes.existingTasks:
      //   return const ExistingTasksPage();
      // case Routes.journal:
      //   return const JournalScreen();
      case Routes.login:
        return const LoginScreen();
      case Routes.signUp:
        return const SignUpScreen();
      // case Routes.profile:
      //   return const ProfileScreen();
      // case Routes.editProfile:
      //   return const EditProfileScreen();
      // case Routes.moments:
      //   return const MomentsScreen();
      // case Routes.feed:
      //   return const FeedScreen();
      // // case Routes.feedDetails:
      // //   return const FeedDetailsScreen();
      // case Routes.addMoment:
      //   return const AddMoment();

      default:
        return const LoginScreen();
    }
  }
}
