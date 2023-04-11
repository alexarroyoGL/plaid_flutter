import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/utils/strings.dart';
import 'app.dart';

void main() => runApp(
    ProviderScope(
      child:   MaterialApp(
        title: Strings.appTitle,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colors.black),
              color: Colors.grey,
              titleTextStyle: TextStyle(fontWeight: FontWeight.bold)
          ),
        ),
        home: const PlaidApp(),
      ),
    )
);