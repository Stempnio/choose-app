import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:choose_app/core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:injectable/injectable.dart';

Future<void> bootstrap(
  FutureOr<Widget> Function() builder,
  Environment env,
) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  Bloc.observer = const AppBlocObserver();

  configureDependencies(env);

  runApp(await builder());
}
