import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plaid/features/authentication/domain/cubits/auth_cubit.dart';
import '../features/authentication/data/datasource/auth_datasource.dart';
import '../features/authentication/data/repositories/auth_repository_impl.dart';
import '/shared/strings.dart';
import '../features/authentication/presentation/screens/auth_screen.dart';

void main() => runApp(const PlaidApp());

class PlaidApp extends StatelessWidget {
  const PlaidApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthRepositoryImpl(AuthDataSourceImpl())),
      child: MaterialApp(
        title: Strings.appTitle,
        debugShowCheckedModeBanner: false,
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
      )
    );
  }
}
