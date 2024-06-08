import 'package:TaskRM/views/goals/goalDetails/sub_goal_details_screen.dart';
import 'package:TaskRM/views/goals/select_parent_goal_screen.dart';
import 'package:TaskRM/views/goals/select_sub_goal_screen.dart';
import 'package:TaskRM/views/tasks/taskDetails/jira/jira_information_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:TaskRM/routes/routes.dart';
import 'package:TaskRM/views/goals/goalDetails/parent_goal_details_screen.dart';
import 'package:TaskRM/views/goals/goals_screen.dart';
import 'package:TaskRM/views/profile/jiraCollection/jira_connection_screen.dart';
import 'package:TaskRM/views/tasks/taskDetails/task_details_screen.dart';
import 'package:TaskRM/views/tasks/taskQueue/task_queue_screen.dart';
import 'package:TaskRM/views/tasks/today_task_screen.dart';
import '../models/goal.dart';
import '../models/task.dart';
import '../views/auth/login/login_screen.dart';
import '../views/auth/signup/signup_screen.dart';
import '../views/home/home_screen.dart';
import '../views/profile/profile_screen.dart';

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
      case Routes.todayTask:
        return const TodayTaskScreen();
      case Routes.taskQueue:
        return const TaskQueueScreen();
      case Routes.goals:
        return const GoalsScreen();
      case Routes.taskDetails:
        return TaskDetailsScreen(task: settings.arguments as Task);
      case Routes.goalDetails:
        return ParentGoalDetailsScreen(goal: settings.arguments as Goal);
      case Routes.profile:
        return const ProfileScreen();
      case Routes.jiraCollectionScreen:
        return const JiraConnectionScreen();
      case Routes.subGoalDetailsScreen:
        return SubGoalDetailsScreen(goal: settings.arguments as Goal);
      case Routes.selectParentGoalScreen:
        return SelectParentGoalScreen(type: settings.arguments as String);
      case Routes.selectSubGoalScreen:
        //return SelectSubGoalScreen(goalTitle: settings.arguments as String);
        final args = settings.arguments as Map<String, String>;
        return SelectSubGoalScreen(
            goalTitle: args['goalTitle']!,
            parentGoalId: args['parentGoalId']!,
            type: args['type']!);
      case Routes.jiraInformationScreen:
        final args = settings.arguments as Map<String, String>;
        return JiraInformationBottomSheet(
          jiraIssueId: args['jiraIssueId']!,
          taskType: args['taskType']!,
        );

      // case Routes.newGoal:
      //   return const NewGoalPage();
      // case Routes.taskDetails:
      //   return TaskDetailsPage(task: settings.arguments as Task);
      // case Routes.goalsList:
      //   return const GoalsListPage();

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
