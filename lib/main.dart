import 'package:flutter/material.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ui/components/app_colors.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/community_screen.dart';
import 'ui/screens/profile_screen.dart';
import 'ui/screens/plan_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const MainNavigator(),
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;

  List<Widget> get _screens => [
    TourBookHome(onProfileTap: () => setState(() => _currentIndex = 4)),
    const Center(child: Text('Discover')), // Placeholder
    PlanScreen(onBack: () => setState(() => _currentIndex = 0)),
    const CommunityScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColors.background,
        color: Colors.white,
        buttonBackgroundColor: AppColors.primary,
        height: 65,
        index: _currentIndex,
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
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
