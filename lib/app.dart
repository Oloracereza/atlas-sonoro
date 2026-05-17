import 'package:flutter/material.dart';

import 'screens/auth_gate.dart';
import 'theme/app_theme.dart';

class AtlasSonoroApp extends StatelessWidget {
  const AtlasSonoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atlas Sonoro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: AuthGate(),
    );
  }
}
