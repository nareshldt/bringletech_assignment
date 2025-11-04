import 'package:go_router/go_router.dart';

import './features/home/presentation/screens/home_screen.dart';
import './features/favorite/presentation/screens/favorite_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/favorites',
        builder: (context, state) => const FavoriteScreen(),
      ),
    ],
  );
}
