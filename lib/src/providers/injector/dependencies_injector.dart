import 'package:get_it/get_it.dart';

typedef FactoryFunc<T extends Object> = T Function();

class DependenciesInjector {
  DependenciesInjector._();

  static final GetIt _locator = GetIt.I;

  static T get<T extends Object>({String? instanceName}) {
    return _locator.get<T>(instanceName: instanceName);
  }

  static void registerFactory<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
  }) {
    _locator.allowReassignment = true;
    _locator.registerFactory(factoryFunc, instanceName: instanceName);
  }

  static void registerLazySingleton<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) {
    _locator.allowReassignment = true;
    _locator.registerLazySingleton(
      factoryFunc,
      instanceName: instanceName,
      dispose: dispose,
    );
  }

  static void resetLazySingleton<T extends Object>({
    T? instance,
    String? instanceName,
    DisposingFunc<T>? disposingFunction,
  }) {
    _locator.resetLazySingleton<T>(
      instance: instance,
      instanceName: instanceName,
      disposingFunction: disposingFunction,
    );
  }
}
