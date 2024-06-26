import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/auth_provider.dart';
import 'package:TaskRM/providers/goals_provider.dart';
import 'package:TaskRM/providers/task_provider.dart';
import 'package:TaskRM/providers/profile_provider.dart';
import 'package:TaskRM/routes/app_router.dart';
import 'package:TaskRM/views/splash_screen.dart';


class MyApp extends StatefulWidget {
  final Client client;
  final String sessionId;
  const MyApp({Key? key, required this.client, required this.sessionId})
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Databases db;
  // late TasksListProvider tasksListProvider;
  // late GoalsListProvider goalsListProvider;
  @override
  void initState() {
    db = Databases(widget.client);
    // tasksListProvider = TasksListProvider(db: db);
    // goalsListProvider = GoalsListProvider(db: db);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoalProvider()),
        // ChangeNotifierProvider(create: (context) => tasksListProvider),
        // ChangeNotifierProvider(create: (context) => goalsListProvider),
        // ChangeNotifierProvider(
        //     create: (context) => HomeProvider(
        //         tasksListProvider: tasksListProvider,
        //         goalsListProvider: goalsListProvider)),
        // ChangeNotifierProvider(
        //     create: (context) => EditTaskProvider(
        //         db: db,
        //         tasksListProvider: tasksListProvider,
        //         goalsListProvider: goalsListProvider)),
        // ChangeNotifierProvider(
        //     create: (context) => EditGoalsProvider(
        //         db: db, goalsListProvider: goalsListProvider)),
        // ChangeNotifierProvider(
        //     create: (context) => TaskDetailsProvider(db: db)),
        // ChangeNotifierProvider(
        //     create: (context) => TodayTasksListProvider(db: db)),
        // ChangeNotifierProvider(
        //     create: (context) => ExistingTasksProvider(db: db)),
        // ChangeNotifierProvider(
        //     create: (context) => GoalDetailsProvider(db: db)),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
       // ChangeNotifierProvider(create: (context) => JournalProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
       // ChangeNotifierProvider(create: (context) => MomentsProvider()),
       //  ChangeNotifierProvider(create: (context) => FeedProvider()),
           ChangeNotifierProvider(create: (context) => TaskProvider()),
       //  ChangeNotifierProvider(create: (context) => JiraProvider()),
      ],
      child: MaterialApp(
        title: "TaskRM",
      //  theme: AppTheme.light,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.generateRoute(),
        home: SplashScreen(sessionId: widget.sessionId,),
        //home: const LoginScreen(),
      ),
    );
  }
}
