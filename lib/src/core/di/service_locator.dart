import 'package:get_it/get_it.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/profile/profile_service.dart';

import '../../services/auth_service.dart';
import '../../services/biometria_service.dart';

class DIService {

  final getIt = GetIt.instance;

  void init(){
    getIt.registerSingleton<NavigationHandler>(NavigationHandler());
    getIt.registerLazySingleton<AuthService>(() => AuthService());
    getIt.registerLazySingleton<BiometriaService>(() => BiometriaService(getIt.get<AuthService>()));
    getIt.registerLazySingleton<AccountService>(() => AccountService(getIt.get<AuthService>()));
  }

  T inject<T extends Object>() => getIt.get<T>();

}