import 'package:get_it/get_it.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';

class DIService {

  final getIt = GetIt.instance;

  void init(){
    getIt.registerSingleton<NavigationHandler>(NavigationHandler());
  }

  T inject<T extends Object>() => getIt.get<T>();

}