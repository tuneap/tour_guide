import 'package:flutter/material.dart';

import '../components/app_colors.dart';
import '../components/bottom_nav.dart';
import '../components/category_chips.dart';
import '../components/community_post_card.dart';
import '../components/destination_card.dart';
import '../components/feature_cards.dart';
import '../components/plan_header.dart';
import '../components/section_header.dart';
import '../components/top_bar.dart';
import 'community_screen.dart';
import 'profile_screen.dart';

class TourBookHome extends StatefulWidget {
  const TourBookHome({super.key});

  @override
  State<TourBookHome> createState() => _TourBookHomeState();
}

class _TourBookHomeState extends State<TourBookHome> {
  bool _showAllPosts = false;

  List<CommunityPostData> get _communityPosts => const [
        CommunityPostData(
          title: 'Night market finds',
          author: 'Alex',
          likes: 124,
          comments: 18,
          imageUrl:
              'https://images.unsplash.com/photo-1534447677768-be436bb09401?auto=format&fit=crop&w=400&q=80',
          accent: Color(0xFFB4B5BE),
        ),
        CommunityPostData(
          title: 'Sunrise trail tips',
          author: 'Maya',
          likes: 87,
          comments: 32,
          imageUrl:
              'https://images.unsplash.com/photo-1489515217757-5fd1be406fef?auto=format&fit=crop&w=400&q=80',
          accent: Color(0xFF144019),
        ),
        CommunityPostData(
          title: 'Street food crawl',
          author: 'Noah',
          likes: 65,
          comments: 14,
          imageUrl:
              'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=400&q=80',
          accent: Color(0xFF8E4C1B),
        ),
        CommunityPostData(
          title: 'Hidden beach gems',
          author: 'Lena',
          likes: 102,
          comments: 21,
          imageUrl:
              'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=400&q=80',
          accent: Color(0xFF0E6245),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final featureCards = [
      const FeatureCardData('Explore', Icons.explore_outlined),
      const FeatureCardData('Trip Planner', Icons.event_note_outlined),
      const FeatureCardData('Itineraries', Icons.route_outlined),
    ];

    final featuredDestinations = [
      const DestinationCardData(
        title: 'Bali, Indonesia',
        subtitle: '8h flight',
        tag: 'Trending',
        tagColor: AppColors.primary,
        imageUrl:
            'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=800&q=80',
        metaIcon: Icons.flight_takeoff_outlined,
      ),
      const DestinationCardData(
        title: 'Swiss Alps',
        subtitle: 'Hikes • Views',
        tag: 'New',
        tagColor: Color(0xFF4A90E2),
        imageUrl:
            'https://images.unsplash.com/photo-1469474968028-56623f02e42e?auto=format&fit=crop&w=800&q=80',
        metaIcon: Icons.terrain_outlined,
      ),
      const DestinationCardData(
        title: 'Kyoto, Japan',
        subtitle: 'Culture • Food',
        tag: 'Popular',
        tagColor: Color(0xFFEEA734),
        imageUrl:
            'https://images.unsplash.com/photo-1468276311594-df7cb65d8df6?auto=format&fit=crop&w=800&q=80',
        metaIcon: Icons.ramen_dining_outlined,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopBar(),
              const SizedBox(height: 12),
              const CategoryChips(
                chips: [
                  'Nearby',
                  'Popular',
                  'Budget',
                  'Nature',
                  'Adventure',
                  'Luxury',
                ],
              ),
              const SizedBox(height: 16),
              const PlanHeader(),
              const SizedBox(height: 12),
              FeatureCardsRow(cards: featureCards),
              const SizedBox(height: 22),
              const SectionHeader(
                title: 'Featured destinations',
                actionText: 'See all',
              ),
              const SizedBox(height: 12),
              FeaturedList(destinations: featuredDestinations),
              const SizedBox(height: 22),
              SectionHeader(
                title: 'Community posts',
                actionText: _showAllPosts ? 'Show less' : 'Show more',
                onActionTap: () {
                  setState(() {
                    _showAllPosts = !_showAllPosts;
                  });
                },
              ),
              const SizedBox(height: 12),
              ...(_showAllPosts ? _communityPosts : _communityPosts.take(2))
                  .map(
                    (post) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CommunityPostCard(post: post),
                    ),
                  ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onItemSelected: (index) {
          if (index == 3) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const CommunityScreen(),
              ),
            );
          } else if (index == 4) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const ProfileScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}
