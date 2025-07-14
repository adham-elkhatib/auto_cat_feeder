// 🔹 Core External Packages
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🔹 Core Providers & Services
import 'Data/Repositories/cat_repo.dart';
import 'Data/Repositories/feeder_repo.dart';
import 'Data/Repositories/meal_repo.dart';
import 'Data/Repositories/user_repo.dart';
import 'core/Providers/FB Firestore/fbfirestore_repo.dart';
import 'core/Providers/FB RTDB/fbrtdb.provider.dart';
import 'core/Providers/FB RTDB/fbrtdb_repo.dart';
import 'core/Services/Auth/auth.service.dart';
import 'core/Services/Auth/src/Providers/firebase/firebase_auth_provider.dart';
import 'core/connection/network_info.dart';
// 🔹 Profile Feature
import 'features/Profile/data/datasources/profile_local_data_source.dart';
import 'features/Profile/data/datasources/profile_remote_data_source.dart';
import 'features/Profile/data/models/user_model.dart';
import 'features/Profile/data/repositories/profile_repository_impl.dart';
import 'features/Profile/domain/repositories/profile_repository.dart';
import 'features/Profile/domain/usecases/create_profile.dart';
import 'features/Profile/domain/usecases/get_profile.dart';
import 'features/Profile/domain/usecases/update_profile.dart';
import 'features/Profile/presentation/providers/profile_bloc.dart';
// 🔹 Auth Feature
import 'features/authentication/data/datasources/auth_local_data_source.dart';
import 'features/authentication/data/datasources/auth_remote_data_source.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/domain/usecases/check_auth_status.dart';
import 'features/authentication/domain/usecases/login_user.dart';
import 'features/authentication/domain/usecases/logout_user.dart';
import 'features/authentication/domain/usecases/register_user.dart';
import 'features/authentication/domain/usecases/reset_password.dart';
import 'features/authentication/presentation/providers/auth_bloc.dart';
// 🔹 Cat Profile Feature
import 'features/cat_profile/data/datasources/cat_profile_local_data_source.dart';
import 'features/cat_profile/data/datasources/cat_profile_remote_data_source.dart';
import 'features/cat_profile/data/models/cat_model.dart';
import 'features/cat_profile/data/repositories/cat_profile_repository_impl.dart';
import 'features/cat_profile/domain/repositories/cat_profile_repository.dart';
import 'features/cat_profile/domain/usecases/create_cat_profile.dart';
import 'features/cat_profile/domain/usecases/get_cat_profile.dart';
import 'features/cat_profile/domain/usecases/update_cat_profile.dart';
// 🔹 Feeder Feature
import 'features/cat_profile/presentation/providers/cat_profile_bloc.dart';
import 'features/feeder/data/datasources/feeder_local_data_source.dart';
import 'features/feeder/data/datasources/feeder_remote_data_source.dart';
import 'features/feeder/data/models/feeder_model.dart';
import 'features/feeder/data/repositories/feeder_repository_impl.dart';
import 'features/feeder/domain/repositories/feeder_repository.dart';
import 'features/feeder/domain/usecases/connect_feeder.dart';
import 'features/feeder/domain/usecases/disconnect_feeder.dart';
import 'features/feeder/domain/usecases/get_feeder.dart';
import 'features/feeder/domain/usecases/stream_feeder.dart';
import 'features/feeder/domain/usecases/sync_to_feeder.dart';
// import 'features/feeder/presentation/providers/feeder_bloc.dart';
// 🔹 Home Feature
import 'features/feeder/presentation/providers/feeder_bloc.dart';
import 'features/home/presentation/providers/home_bloc.dart';
// 🔹 Meals Feature
import 'features/meals/data/datasources/meal_local_data_source.dart';
import 'features/meals/data/datasources/meal_remote_data_source.dart';
import 'features/meals/data/models/meal_model.dart';
import 'features/meals/data/repositories/meal_repository_impl.dart';
import 'features/meals/domain/repositories/meal_repository.dart';
import 'features/meals/domain/usecases/create_meal.dart';
import 'features/meals/domain/usecases/delete_meal.dart';
import 'features/meals/domain/usecases/get_meals.dart';
import 'features/meals/domain/usecases/update_meal.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //! ========== Bloc ==========
  sl.registerFactory(() => AuthBloc(
        loginUseCase: sl(),
        registerUseCase: sl(),
        authService: sl(),
        resetPasswordUseCase: sl(),
        createProfileUseCase: sl(),
      ));

  sl.registerFactory(
    () => HomeBloc(
      getCatProfileUseCase: sl(),
      createMealUseCase: sl(),
      deleteMealUseCase: sl(),
      getFeederUseCase: sl(),
      updateCatProfileUseCase: sl(),
      updateMealUseCase: sl(),
      getMealsUseCase: sl(),
      syncToFeederUseCase: sl(),
      disconnectFeederUseCase: sl(),
      connectFeederUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => FeederBloc(
      streamFeederUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ProfileBloc(
      createProfileUseCase: sl(),
      getProfileUseCase: sl(),
      updateProfileUseCase: sl(),
      logoutUserUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => CatProfileBloc(
      getCatProfileUseCase: sl(),
      createCatProfileUseCase: sl(),
      updateCatProfileUseCase: sl(),
      authService: sl(),
    ),
  );
  //! ========== UseCases ==========
  sl.registerLazySingleton(() => LoginUser(authRepository: sl()));
  sl.registerLazySingleton(() => RegisterUser(authRepository: sl()));
  sl.registerLazySingleton(() => ResetPassword(authRepository: sl()));
  sl.registerLazySingleton(() => CheckAuthStatus(authRepository: sl()));
  sl.registerLazySingleton(() => LogoutUser(authRepository: sl()));
  //
  sl.registerLazySingleton(() => ConnectToFeeder(feederRepository: sl()));
  sl.registerLazySingleton(() => GetFeeder(feederRepository: sl()));
  sl.registerLazySingleton(() => SyncToFeeder(feederRepository: sl()));
  sl.registerLazySingleton(() => StreamFeeder(feederRepository: sl()));
  sl.registerLazySingleton(() => DisconnectFeeder(feederRepository: sl()));
  //
  sl.registerLazySingleton(() => CreateProfile(profileRepository: sl()));
  sl.registerLazySingleton(() => GetProfile(profileRepository: sl()));
  sl.registerLazySingleton(() => UpdateProfile(profileRepository: sl()));
  //
  sl.registerLazySingleton(() => CreateMeal(mealRepository: sl()));
  sl.registerLazySingleton(() => DeleteMeal(mealRepository: sl()));
  sl.registerLazySingleton(() => GetMeals(mealRepository: sl()));
  sl.registerLazySingleton(() => UpdateMeal(mealRepository: sl()));
  //
  sl.registerLazySingleton(() => CreateCatProfile(catProfileRepository: sl()));
  sl.registerLazySingleton(() => GetCatProfile(catProfileRepository: sl()));
  sl.registerLazySingleton(() => UpdateCatProfile(catProfileRepository: sl()));
//! ========== Repositories ==========
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<CatProfileRepository>(() => CatRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<FeederRepository>(() => FeederRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
        localDataSource: sl(),
      ));

  sl.registerLazySingleton<MealRepository>(() => MealRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));
//! ========== DataSources ==========
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(authService: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<CatRemoteDataSource>(
      () => CatRemoteDataSourceImpl(firestoreRepo: sl()));

  sl.registerLazySingleton<CatLocalDataSource>(
      () => CatLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<FeederRemoteDataSource>(
      () => FeederRemoteDataSourceImpl(db: sl()));
  sl.registerLazySingleton<FeederLocalDataSource>(
      () => FeederLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<MealRemoteDataSource>(
      () => MealRemoteDataSourceImpl(firestoreRepo: sl()));
  sl.registerLazySingleton<MealLocalDataSource>(
      () => MealLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(firestoreRepo: sl()));
  sl.registerLazySingleton<ProfileLocalDataSource>(
      () => ProfileLocalDataSourceImpl(sharedPreferences: sl()));

  //! ========== Core ==========
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(
    () => AuthService(
      authProvider: FirebaseAuthProvider(firebaseAuth: FirebaseAuth.instance),
    ),
  );
  sl.registerLazySingleton(() => DataConnectionChecker());

  //! ========== External ==========
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<FirestoreRepo<CatModel>>(() => CatRepo());
  sl.registerLazySingleton<RTDBRepo<FeederModel>>(() => FeederRepo());
  sl.registerLazySingleton<FirestoreRepo<UserModel>>(() => UserRepo());
  sl.registerLazySingleton<FirestoreRepo<MealModel>>(() => MealRepo());

  //
  // sl.registerLazySingleton<FirestoreRepo<CatModel>>(
  //   () => FirestoreRepo<CatModel>("cats"),
  // );
  // sl.registerLazySingleton<FirestoreRepo<MealModel>>(
  //   () => FirestoreRepo<MealModel>("meals"),
  // );
  // sl.registerLazySingleton<FirestoreRepo<UserModel>>(
  //   () => FirestoreRepo<UserModel>("Users"),
  // );

  // sl.registerLazySingleton<RTDBRepo<FeederModel>>(
  //   () => RTDBRepo<FeederModel>(path: 'Devices', discardKey: false),
  // );
  sl.registerLazySingleton(() => RTDBProvider());
}
