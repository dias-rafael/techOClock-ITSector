import '../../features/todo/presentation/cubit/todo_cubit.dart';
import '../../features/users/data/datasources/users_datasource.dart';
import '../../features/users/data/repositories/users_repository_impl.dart';
import '../../features/users/domain/repositories/users_repository.dart';
import '../../features/users/domain/usecases/get_users.dart';
import '../../features/users/domain/usecases/get_users_simple.dart';
import '../../features/users/presentation/cubit/users_cubit.dart';
import '../../providers/injector/dependencies_injector.dart';
import '../../providers/network/data/datasources/dio_client.dart';
import '../../providers/network/domain/repositories/network_client.dart';
import '../../providers/network/domain/usecase/network_service.dart';

class Inject {
  static void initialize() {
    _injectNetwork();
    _injectDataSources();
    _injectRepositories();
    _injectUseCases();
    _injectCubits();
  }

  static void _injectNetwork() {
    DependenciesInjector.registerLazySingleton<INetworkClient>(
      () => DioClient(),
    );

    DependenciesInjector.registerFactory<NetworkService>(
      () => NetworkServiceImpl(
        DependenciesInjector.get<INetworkClient>(),
      ),
    );
  }

  static void _injectDataSources() {
    DependenciesInjector.registerFactory<UsersDatasource>(
      () => UsersDatasourceImpl(
        DependenciesInjector.get<NetworkService>(),
      ),
    );
  }

  static void _injectRepositories() {
    DependenciesInjector.registerFactory<UsersRepository>(
      () => UsersRepositoryImpl(
        DependenciesInjector.get<UsersDatasource>(),
      ),
    );
  }

  static void _injectUseCases() {
    DependenciesInjector.registerFactory<GetUsers>(
      () => GetUsersImpl(
        DependenciesInjector.get<UsersRepository>(),
      ),
    );

    DependenciesInjector.registerFactory<GetUsersSimple>(
      () => GetUsersSimpleImpl(
        DependenciesInjector.get<UsersRepository>(),
      ),
    );
  }

  static void _injectCubits() {
    DependenciesInjector.registerFactory<TodoCubit>(
      () => TodoCubit(),
    );

    DependenciesInjector.registerFactory<UsersCubit>(
      () => UsersCubit(
        DependenciesInjector.get<GetUsers>(),
        DependenciesInjector.get<GetUsersSimple>(),
      ),
    );
  }
}
