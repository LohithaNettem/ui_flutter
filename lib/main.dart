import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ui_flutter/provider/darktheme_provider.dart';
import 'package:ui_flutter/screens/splash_screen.dart';
import 'package:ui_flutter/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider provider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    //getAppTheme();
    //checkUser();
  }

  void getAppTheme() async {
    provider.darkTheme = await provider.obj.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: false,
      create: (context) {
        return provider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (context, value, child) => MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          //theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          theme: Styles.themeData(provider.darkTheme, context),
          home: const SplashScreen(),
          // floatingActionButton: FloatingActionButton(
          //     child: const Icon(
          //       Icons.light_mode_outlined,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {
          //       if (provider.darkTheme == true) {
          //         provider.darkTheme = false;
          //       } else {
          //         provider.darkTheme = true;
          //       }
          //     }),
        ),
      ),
    );
  }
}
