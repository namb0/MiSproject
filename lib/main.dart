import 'package:flutter/material.dart';
import 'package:certificate_app/pages/home.dart';
import 'package:certificate_app/pages/history.dart';
import 'package:certificate_app/pages/workspaces.dart';
import 'package:certificate_app/pages/machines.dart';
import 'package:certificate_app/pages/safety_instructions.dart';
import 'package:certificate_app/pages/certificates.dart';
import 'package:certificate_app/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    supportedLocales: L10n.all,
    localizationsDelegates: [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ],
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    routes: {
      '/login': (context) => Login(),
      '/home': (context) => Home(),
      '/history': (context) => History(),
      '/workspaces': (context) => Workspaces(),
      '/machines': (context) => Machines(),
      '/safety_instructions': (context) => SafetyInstructions(),
      '/certificates': (context) => Certificates(),
    },
  ));
}
