import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_estate/services/navigation_service.dart';
import 'package:nb_utils/nb_utils.dart';
import 'app_export/app_export.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ThemeHelper().changeTheme('primary');
  await initialize();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,);
  runApp(ProviderScope(child: JobEstate()));
}

class JobEstate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: AppRoutes.splashScreen,
      routes: AppRoutes.routes,
    );
  }
}
