import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_service_demo/model/service_model.dart';
import 'package:my_service_demo/screen/add_my_service.dart';
import 'package:my_service_demo/screen/my_service_list.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

void main() {
  setupWindow();
  runApp(const MyServiceApp());
}

const double windowWidth = 400;
const double windowHeight = 800;

final appTheme = ThemeData(
  primarySwatch: Colors.yellow,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Corben',
      fontWeight: FontWeight.w700,
      fontSize: 24,
      color: Colors.black,
    ),
  ),
);

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('My Service Demo');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

GoRouter router() {
  return GoRouter(
    initialLocation: '/my_service',
    routes: [
      GoRoute(
        path: '/my_service',
        builder: (context, state) => const MyServiceList(),
        routes: [
          GoRoute(
            path: 'add',
            builder: (context, state) => const AddMyService(),
          ),
        ],
      ),
    ],
  );
}

class MyServiceApp extends StatelessWidget {
  const MyServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => MyServiceModel()),
        ChangeNotifierProxyProvider<MyServiceModel, ServiceList>(
          create: (context) => ServiceList(),
          update: (context, service, item) {
            if (item == null) throw ArgumentError.notNull('my service');
            item.service = service;
            return item;
          },
        ),
      ],
      child: MaterialApp.router(
        title: 'My Service Demo',
        theme: appTheme,
        routerConfig: router(),
      ),
    );
  }
}
