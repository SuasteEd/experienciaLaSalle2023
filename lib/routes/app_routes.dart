import 'package:get/get.dart';
import 'package:semana_academica/routes/routes_barrel.dart';

class AppRouter {
  static final List<GetPage<dynamic>> appRouter = [
    GetPage(name: '/', page: () => SplashScreen()),
    GetPage(name: '/home', page: () => HomeScreen()),
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/register', page: () => RegisterProduct()),
  ];
}
