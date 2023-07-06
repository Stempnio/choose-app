import 'package:choose_app/core/get_it/get_it_init.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies(Environment env) =>
    getIt.init(environment: env.name);
