import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:live_match/firebase_options.dart';
import 'package:live_match/logic/locator.dart';
import 'package:live_match/ui/screen_selector.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Locator.setup();
  await Locator.startupService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool brightness =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return MaterialApp(
        title: 'Match Meter2.o',
        theme: ThemeData.from(
          colorScheme: brightness == Brightness.light
               ? const ColorScheme.light(
                  primary: Color(0xFF6C5DD3),
                  secondary: Color(0xFF212121),
                  surface: Color(0xFFFFFFFF),
                  background: Color(0xFFFFFFFF),
                  error: Color(0xFFE6521F),
                  onPrimary: Color(0xFFFFFFFF),
                  primaryContainer: Color(0xFFFFFFFF),
                  onPrimaryContainer: Color(0xFF1F2128),
                  onSecondary: Color(0xFF212121),
                  onSurface: Color(0xFF212121),
                  onBackground: Color(0xFF242731),
                  onError: Color(0xFFFFFFFF),
                  secondaryContainer: Color(0xFFFFFFFF),
                  onSecondaryContainer: Color(0xFF212121),
                  errorContainer: Color(0xFFFF754C),
                  onErrorContainer: Color(0xFFFFFFFF),
                  scrim: Color(0xFF1F2128),
                  shadow: Color(0xFF1F2128),
                )
             : const ColorScheme.dark(
                  primary: Color(0xFF6C5DD3),
                  secondary: Color(0xFFFFFFFF),
                  surface: Color(0xFF242731),
                  background: Color(0xFF1F2128),
                  error: Color(0xFFE6521F),
                  onPrimary: Color(0xFFFFFFFF),
                  primaryContainer: Color(0xFFC5BFED),
                  onPrimaryContainer: Color(0xFF1F2128),
                  onSecondary: Color(0xFFFFFFFF),
                  onSurface: Color(0xFFFFFFFF),
                  onBackground: Color(0xFFFFFFFF),
                  onError: Color(0xFFFFFFFF),
                  secondaryContainer: Color(0xFF242731),
                  onSecondaryContainer: Color(0xFFFFFFFF),
                  errorContainer: Color(0xFFFF754C),
                  onErrorContainer: Color(0xFFFFFFFF),
                  scrim: Color(0xFFC5BFED),
                  shadow: Color(0xFFC5BFED),
                  // brightness: brightness,
                ),
        ),
        home: ScreenSelector(),
        debugShowCheckedModeBanner: false);
  }
}

