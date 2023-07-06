import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:choose_app/core/core.dart';
import 'package:choose_app/presentation/pages/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..init(),
      child: const _SplashPageBody(),
    );
  }
}

class _SplashPageBody extends StatelessWidget {
  const _SplashPageBody();

  @override
  Widget build(BuildContext context) => BlocListener<SplashCubit, SplashState>(
        listener: (context, state) => state.mapOrNull(
          initialized: (_) => _onInitialized(context),
        ),
        child: const SizedBox.shrink(),
      );

  void _onInitialized(BuildContext context) {
    FlutterNativeSplash.remove();
  }
}
