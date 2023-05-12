import 'dart:io';

import 'package:download/components/theme_model.dart';
import 'package:download/feature_download/presentation/bloc/download_cubit/download_cubit.dart';
import 'package:download/feature_download/presentation/bloc/download_cubit_api/download_api_cubit.dart';
import 'package:download/feature_download/presentation/bloc/download_file_cubit/download_file_cubit.dart';
import 'package:download/feature_download/presentation/screens/update.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'locator.dart';






final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await initLocator();

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=> DownloadCubit()),
        BlocProvider(create: (_)=> DownloadFileCubit(locator())),
        BlocProvider(create: (_)=> DownloadApiCubit(locator())),
      ],
      child: MyApp(
      )));
}

class MyApp extends StatefulWidget {


  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{




  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer(builder: (context, ThemeModel themeNotifier, child) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent, ));
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Update(),
          navigatorObservers: [routeObserver],
          builder: (context, child) {
            return MediaQuery(
              child: child!,
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            );
          },
        );
      }),
    );
  }
}



