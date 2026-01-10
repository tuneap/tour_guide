import 'package:flutter/foundation.dart';

class AppRoutes {
  static const home = '/';
  static const discover = '/discover';
  static const plan = '/plan';
  static const posts = '/posts';
  static const profile = '/profile';
  static const planAi = '/plan/ai';
  static const itinerary = '/plan/itinerary';
  static const packageDetails = '/packages/details';
  static const communityPost = '/community/post';
  static const login = '/login';
  static const register = '/register';
  static const offlineMaps = '/offline-maps';

  static String packageDetailsLocation({
    required String title,
    required int price,
  }) {
    final encodedTitle = Uri.encodeComponent(title);
    return '$packageDetails?title=$encodedTitle&price=$price';
  }
}

class LoginRouteArgs {
  const LoginRouteArgs({this.onLoginSuccess, this.onGuestContinue});

  final VoidCallback? onLoginSuccess;
  final VoidCallback? onGuestContinue;
}

class RegisterRouteArgs {
  const RegisterRouteArgs({this.onRegisterSuccess});

  final VoidCallback? onRegisterSuccess;
}
