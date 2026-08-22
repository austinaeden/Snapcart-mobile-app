import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'helper/locator.dart';
import 'screens/home/home_screen.dart';
import 'screens/splash/ui/splash_screen.dart';
import 'providers/providers.dart' as providers;
import 'resources/services/auth/auth_service.dart';

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => locator<AuthService>()),
        ChangeNotifierProvider(create: (_) => locator<providers.AuthProvider>()),
        ChangeNotifierProvider(create: (_) => locator<providers.ProductProvider>()),
        ChangeNotifierProvider(create: (_) => locator<providers.CartProvider>()),
        ChangeNotifierProvider(create: (_) => locator<providers.OrderProvider>()),
        ChangeNotifierProvider(create: (_) => locator<providers.PaymentProvider>()),
        ChangeNotifierProvider(create: (_) => locator<providers.ProfileProvider>()),
        ChangeNotifierProvider(create: (_) => locator<providers.AddressProvider>()),
        ChangeNotifierProvider(create: (_) => locator<providers.ReviewProvider>()),
      ],
      child: GetMaterialApp(
        title: 'SnapCart Ecommerce App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepOrange, fontFamily: 'Poppins'),
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData && snapshot.data != null) {
                Provider.of<providers.AuthProvider>(context, listen: false).getUserDetails(snapshot.data!);
                log(snapshot.data.toString());
                return const HomeScreen();
              }
              return const SplashScreen();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return const SplashScreen();
          },
        ),
      ),
    );
  }
}
