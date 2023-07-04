import 'package:flutter/src/widgets/basic.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_manager/Resources/user-activity-detector.dart';
import 'package:inventory_manager/Screens/AboutUs.dart';
import 'package:inventory_manager/Screens/AccessManagement.dart';
import 'package:inventory_manager/Screens/FileTypeErrorPage.dart';
import 'package:inventory_manager/Screens/LoginErrorPage.dart';
import 'package:inventory_manager/Screens/ManageHubs.dart';

import '../Screens/DeployBoxesToHub.dart';
import '../Screens/HomePage.dart';
import '../Screens/LoggedInPage.dart';
import '../Screens/LoginPage.dart';
import '../Screens/NewShipmentImportPage.dart';
import '../Screens/OnHandStockPage.dart';
import '../Screens/RegistrationPage.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => UserActivityDetector(child: HomePage()),
    ),
    GoRoute(
      path: '/loggedin',
      builder: (context, state) => UserActivityDetector(child: loggedInPage()),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => UserActivityDetector(child: LoginPage()),
    ),
    GoRoute(
      path: '/registration',
      builder: (context, state) =>
          UserActivityDetector(child: RegistrationPage()),
    ),
    GoRoute(
      path: '/onhand',
      builder: (context, state) =>
          UserActivityDetector(child: OnHandStockPage()),
    ),
    GoRoute(
      path: '/newshipment',
      builder: (context, state) =>
          UserActivityDetector(child: NewShipmentImportPage()),
    ),
    GoRoute(
      path: '/deployboxes',
      builder: (context, state) =>
          UserActivityDetector(child: DeployBoxesToHub()),
    ),
    GoRoute(
      path: '/aboutus',
      builder: (context, state) => UserActivityDetector(child: AboutUs()),
    ),
    GoRoute(
      path: '/accessmgmt',
      builder: (context, state) =>
          UserActivityDetector(child: AccessManagement()),
    ),
    GoRoute(
      path: '/managehubs',
      builder: (context, state) => UserActivityDetector(child: ManageHubs()),
    ),
    GoRoute(
      path: '/loginerror',
      builder: (context, state) => LoginErrorPage(),
    ),
    GoRoute(
      path: '/fileerrorpage',
      builder: (context, state) =>
          UserActivityDetector(child: FileTypeErrorPage()),
    ),
  ],
);
