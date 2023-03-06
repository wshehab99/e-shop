import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sneakers_shop/domain/use_cases/cart_use_case.dart';
import 'package:sneakers_shop/domain/use_cases/favorite_use_case.dart';
import 'package:sneakers_shop/domain/use_cases/settings_use_case.dart';
import 'package:sneakers_shop/presentation/main/pages/cart_page/view_model/cart_page_view_model.dart';
import 'package:sneakers_shop/presentation/main/pages/profile_page/view_model/profile_view_model.dart';
import 'package:sneakers_shop/presentation/main/view_model/main_page_view_model.dart';
import 'package:sneakers_shop/presentation/resources/them_manager/view_model/theme_view_model.dart';

import '../data/data_source/local_data_source/local_data_source.dart';
import '../data/data_source/local_data_source/local_data_source_implementer.dart';
import '../data/data_source/remote_data_source/remote_data_source.dart';
import '../data/data_source/remote_data_source/remote_data_source_implementer.dart';
import '../data/network/app_api/app_api.dart';
import '../data/network/dio_factory/dio_factory.dart';
import '../data/network/network_info/network_info.dart';
import '../data/network/repository/repository.dart';
import '../data/network/repository/repository_implementer.dart';
import '../domain/use_cases/home_use_case.dart';
import '../domain/use_cases/login_use_case.dart';
import '../domain/use_cases/register_use_case.dart';
import '../presentation/login/view_model/login_view_model.dart';
import '../presentation/main/pages/favorite/view_model/favorite_page_view_model.dart';
import '../presentation/main/pages/home/view_model/home_view_model.dart';
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
    //theme manager
    instance.registerLazySingleton<ThemeMangerViewModel>(
        () => ThemeMangerViewModel(instance<AppPreferences>()));
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
    if (!instance.isRegistered<LoginUseCase>()) {
      instance.registerFactory<LoginUseCase>(
          () => LoginUseCase(instance<Repository>()));
      instance.registerFactory<LoginViewModel>(
          () => LoginViewModel(instance<LoginUseCase>()));
    }
  }

  static void initRegister() {
    if (!instance.isRegistered<RegisterUseCase>()) {
      instance.registerFactory<RegisterUseCase>(
          () => RegisterUseCase(instance<Repository>()));

      instance.registerFactory<RegisterViewModel>(
          () => RegisterViewModel(instance<RegisterUseCase>()));
    }
  }

  static void initMain() {
    if (!instance.isRegistered<MainViewModel>()) {
      instance.registerFactory<MainViewModel>(() => MainViewModel());
      _initHome();
      _initBag();
      _initFavorite();
      _initSettings();
    }
  }

  static void initDetails() {}
  static void initSearch() {}
  static void initNotifications() {}
  static void _initHome() {
    instance.registerLazySingleton<HomeUseCase>(
        () => HomeUseCase(instance<Repository>()));

    instance.registerLazySingleton<HomeViewMode1>(
        () => HomeViewMode1(instance<HomeUseCase>()));
  }

  static void _initBag() {
    instance.registerLazySingleton<CartUseCase>(
        () => CartUseCase(instance<Repository>()));

    instance.registerLazySingleton<CartPageViewModel>(
        () => CartPageViewModel(instance<CartUseCase>()));
  }

  static void _initFavorite() {
    instance.registerLazySingleton<FavoriteUseCase>(
        () => FavoriteUseCase(instance<Repository>()));

    instance.registerLazySingleton<FavoritePageViewModel>(
        () => FavoritePageViewModel(instance<FavoriteUseCase>()));
  }

  static void _initSettings() {
    instance.registerLazySingleton<SettingsUseCase>(
        () => SettingsUseCase(instance<Repository>()));

    instance.registerLazySingleton<ProfilePageViewModel>(
        () => ProfilePageViewModel(instance<SettingsUseCase>()));
  }
}
