import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/shared/strings.dart';
import '../features/authentication/presentation/screens/auth_screen.dart';

void main() => runApp(
    ProviderScope(
      child:   MaterialApp(
        title: Strings.appTitle,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.black,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            color: Colors.white,
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black)
          ),
        ),
        home: const AuthScreen(),
      ),
    )
);