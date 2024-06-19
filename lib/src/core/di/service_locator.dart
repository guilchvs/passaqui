import 'package:get_it/get_it.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';

import '../../services/auth_service.dart';

class DIService {

  final getIt = GetIt.instance;

  void init(){
    getIt.registerSingleton<NavigationHandler>(NavigationHandler());
    getIt.registerLazySingleton<AuthService>(() => AuthService());
  }

  T inject<T extends Object>() => getIt.get<T>();

}