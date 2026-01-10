import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_routes.dart';
import 'ui/components/app_colors.dart';
import 'ui/components/community_post_feed_card.dart';
import 'ui/screens/community_post_detail.dart';
import 'ui/screens/community_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/itinerary_screen.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/offline_maps_screen.dart';
import 'ui/screens/package_details_screen.dart';
import 'ui/screens/plan_screen.dart';
import 'ui/screens/plan_with_ai_screen.dart';
import 'ui/screens/profile_screen.dart';
import 'ui/screens/register_screen.dart';
import 'ui/screens/tour_packages_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<bool> _isLoggedIn = ValueNotifier<bool>(false);

  late final GoRouter _router = GoRouter(
    refreshListenable: _isLoggedIn,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MainNavigator(
          navigationShell: navigationShell,
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => TourBookHome(
                  onProfileTap: () => context.go(AppRoutes.profile),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.discover,
                builder: (context, state) => const TourPackagesScreen(
                  showBackButton: false,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.plan,
                builder: (context, state) => PlanScreen(
                  onBack: () => context.go(AppRoutes.home),
                  onNavigateToDiscover: () => context.go(AppRoutes.discover),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.posts,
                builder: (context, state) => const CommunityScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => ProfileScreen(
                  isLoggedIn: _isLoggedIn.value,
                  onLogin: () => _isLoggedIn.value = true,
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.packageDetails,
        builder: (context, state) {
          final title = state.uri.queryParameters['title'] ?? 'Package details';
          final price = int.tryParse(state.uri.queryParameters['price'] ?? '') ?? 0;
          return PackageDetailsScreen(
            packageTitle: title,
            packagePrice: price,
            isLoggedIn: _isLoggedIn.value,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.communityPost,
        builder: (context, state) {
          final feed = state.extra as CommunityFeed?;
          if (feed == null) {
            return const Scaffold(
              body: Center(child: Text('Post not found')),
            );
          }
          return CommunityPostDetail(feed: feed);
        },
      ),
      GoRoute(
        path: AppRoutes.planAi,
        builder: (context, state) => const PlanWithAIScreen(),
      ),
      GoRoute(
        path: AppRoutes.itinerary,
        builder: (context, state) => const ItineraryScreen(),
      ),
      GoRoute(
        path: AppRoutes.offlineMaps,
        builder: (context, state) => const OfflineMapsScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) {
          final args = state.extra as LoginRouteArgs?;
          return LoginScreen(
            onLoginSuccess: () {
              _isLoggedIn.value = true;
              context.pop();
              args?.onLoginSuccess?.call();
            },
            onGuestContinue: () {
              context.pop();
              args?.onGuestContinue?.call();
            },
          );
        },
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) {
          final args = state.extra as RegisterRouteArgs?;
          return RegisterScreen(
            onRegisterSuccess: () {
              _isLoggedIn.value = true;
              args?.onRegisterSuccess?.call();
            },
          );
        },
      ),
    ],
  );

  @override
  void dispose() {
    _isLoggedIn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
          primary: AppColors.primary,
        ),
        textTheme: GoogleFonts.ubuntuTextTheme(
          const TextTheme(
            bodyMedium: TextStyle(color: AppColors.text),
          ),
        ),
        fontFamily: GoogleFonts.ubuntu().fontFamily,
      ),
      routerConfig: _router,
    );
  }
}

class MainNavigator extends StatelessWidget {
  const MainNavigator({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final currentIndex = navigationShell.currentIndex;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColors.background,
        color: Colors.white,
        buttonBackgroundColor: AppColors.primary,
        height: 65,
        index: currentIndex,
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined, color: Colors.white),
            label: 'Home',
            labelStyle: TextStyle(color: AppColors.text, fontSize: 11),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.search, color: Colors.white),
            label: 'Discover',
            labelStyle: TextStyle(color: AppColors.text, fontSize: 11),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.add_circle_outline, color: Colors.white),
            label: 'Plan',
            labelStyle: TextStyle(color: AppColors.text, fontSize: 11),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.article_outlined, color: Colors.white),
            label: 'Posts',
            labelStyle: TextStyle(color: AppColors.text, fontSize: 11),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.person_outline, color: Colors.white),
            label: 'Profile',
            labelStyle: TextStyle(color: AppColors.text, fontSize: 11),
          ),
        ],
        onTap: (index) {
          navigationShell.goBranch(index);
        },
      ),
    );
  }
}
