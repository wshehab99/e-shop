import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/data_source/local_data_source/local_data_source.dart';
import '../data/data_source/local_data_source/local_data_source_implementer.dart';
import '../data/data_source/remote_data_source/remote_data_source.dart';
import '../data/data_source/remote_data_source/remote_data_source_implementer.dart';
import '../data/network/app_api/app_api.dart';
import '../data/network/dio_factory/dio_factory.dart';
import '../data/network/network_info/network_info.dart';
import '../data/network/repository/repository.dart';
import '../data/network/repository/repository_implementer.dart';
import '../presentation/login/view_model/login_view_model.dart';
import '../presentation/onboarding/view_model/onboarding_view_model.dart';
import '../presentation/register/view_model.dart/register_view_model.dart';
import 'app_preferences.dart';

class DependencyInjection {
  static GetIt instance = GetIt.instance;
  static Future<void> initApp() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    //SharedPreferences
    instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
    //app preferences
    instance.registerLazySingleton<AppPreferences>(
        () => AppPreferences(sharedPreferences));
    //dio factory
    instance.registerLazySingleton<DioFactory>(
        () => DioFactory(instance<AppPreferences>()));
    //app service client
    Dio dio = instance<DioFactory>().getDio();
    instance
        .registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

    //remote data source
    instance.registerLazySingleton<RemoteDataSource>(
        () => RemoteDataSourceImpl(instance<AppServiceClient>()));
    //local data source
    instance.registerLazySingleton<LocalDataSource>(
        () => LocalDataSourceImplementer());

    //Network info
    instance.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(InternetConnectionChecker()));
//Repository
    instance.registerLazySingleton<Repository>(() => RepositoryImplementer(
          instance<RemoteDataSource>(),
          instance<NetworkInfo>(),
          instance<LocalDataSource>(),
        ));
  }

  static void initOnboarding() {
    if (!instance.isRegistered<OnboardingViewModel>()) {
      instance
          .registerFactory<OnboardingViewModel>(() => OnboardingViewModel());
    }
  }

  static void initLogin() {
    if (!instance.isRegistered<LoginViewModel>()) {
      instance.registerFactory<LoginViewModel>(() => LoginViewModel());
    }
  }

  static void initRegister() {
    if (!instance.isRegistered<RegisterViewModel>()) {
      instance.registerFactory<RegisterViewModel>(() => RegisterViewModel());
    }
  }
}
