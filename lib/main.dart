import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miaged/screens/splashscreen_wrapper.dart';
import 'package:miaged/services/authentication.dart';
import 'package:miaged/themes/custom_themes.dart';
import 'package:provider/provider.dart';

import 'models/app_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider =
              Provider.of<ThemeProvider>(context, listen: true);
          return StreamProvider<AppUser?>.value(
            value: AuthenticationService().user,
            initialData: null,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Miaged',
              home: const SplashScreenWrapper(),
              themeMode: themeProvider.themeMode,
              theme: CustomThemes.lightTheme,
              darkTheme: CustomThemes.darkTheme,
            ),
          );
        },
      );
}
