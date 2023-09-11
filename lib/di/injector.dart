import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:my_profile/core/utils/shared_preferences_utils.dart';
import 'package:my_profile/features/presentation/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:my_profile/features/presentation/login/bloc/login_bloc.dart';

GetIt sl = GetIt.instance;

Future setup() async {
  /// Setup for flutter secure storage
  AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  final storage = FlutterSecureStorage(aOptions: getAndroidOptions());

  sl.registerSingleton(storage);

  /// Blocs
  sl.registerFactory(() => LoginBloc(sl()));

  sl.registerSingleton<SharedPrefUtils>(SharedPrefUtils(sl()));

  sl.registerSingleton<EditProfileBloc>(EditProfileBloc(sl()));
}
