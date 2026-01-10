import 'package:flutter/material.dart';

import '../components/app_colors.dart';
import '../components/category_chips.dart';
import '../components/community_post_card.dart';
import '../components/destination_card.dart';
import '../components/feature_cards.dart';
import '../components/plan_header.dart';
import '../components/section_header.dart';
import '../components/top_bar.dart';
import '../../services/destination_service.dart';

class TourBookHome extends StatefulWidget {
  const TourBookHome({super.key, this.onProfileTap});

  final VoidCallback? onProfileTap;

  @override
  State<TourBookHome> createState() => _TourBookHomeState();
}

class _TourBookHomeState extends State<TourBookHome> {
  bool _showAllPosts = false;
  bool _loadingDestinations = true;
  String? _destinationError;
  List<Destination> _destinations = [];
  final DestinationService _destinationService = DestinationService();

  static const List<String> _unsplashPool = [
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=900&q=80',
    'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=900&q=80',
    'https://images.unsplash.com/photo-1512453979798-5ea266f8880c?auto=format&fit=crop&w=900&q=80',
    'https://images.unsplash.com/photo-1505761671935-60b3a7427bad?auto=format&fit=crop&w=900&q=80',
    'https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1?auto=format&fit=crop&w=900&q=80',
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=900&q=80',
    'https://images.unsplash.com/photo-1494475673543-6a6a27143b16?auto=format&fit=crop&w=900&q=80',
    'https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=900&q=80',
    'https://images.unsplash.com/photo-1489515217757-5fd1be406fef?auto=format&fit=crop&w=900&q=80',
  ];

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
  void initState() {
    super.initState();
    _loadDestinations();
  }

  Future<void> _loadDestinations() async {
    setState(() {
      _loadingDestinations = true;
      _destinationError = null;
    });
    try {
      final results = await _destinationService.fetchDestinations();
      if (!mounted) return;
      setState(() {
        _destinations = results;
        _loadingDestinations = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _destinationError = 'Could not load destinations. Tap to retry.';
        _loadingDestinations = false;
      });
    }
  }

  List<DestinationCardData> get _destinationCards {
    return _destinations
        .map(
          (destination) => DestinationCardData(
            title: destination.name,
            subtitle: destination.subtitle,
            tag: destination.category ?? destination.type ?? 'Explore',
            tagColor: _tagColorForType(destination.type),
            imageUrl: _imageForDestination(destination),
            metaIcon: _iconForCategory(destination.category ?? destination.type),
          ),
        )
        .toList();
  }

  Color _tagColorForType(String? type) {
    switch (type?.toUpperCase()) {
      case 'ADVENTURE':
        return const Color(0xFFEF4444);
      case 'RELIGIOUS':
        return const Color(0xFF3B82F6);
      case 'NATURAL':
        return const Color(0xFF22C55E);
      default:
        return AppColors.primary;
    }
  }

  IconData _iconForCategory(String? category) {
    switch (category?.toUpperCase()) {
      case 'TREKKING':
      case 'HIKING':
        return Icons.terrain_outlined;
      case 'TEMPLE':
      case 'STUPA':
        return Icons.temple_buddhist_outlined;
      case 'LAKE':
        return Icons.water_outlined;
      default:
        return Icons.place_outlined;
    }
  }

  String _imageForDestination(Destination destination) {
    final seed = destination.id.abs();
    final index = seed % _unsplashPool.length;
    final baseUrl = _unsplashPool[index];
    return '$baseUrl&sig=$seed';
  }

  void _openSeeAllDestinations() {
    if (_destinations.isEmpty) return;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'All destinations',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: _destinations.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final destination = _destinations[index];
                      final image = _imageForDestination(destination);
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.stroke),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              image,
                              width: 64,
                              height: 64,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            destination.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              destination.subtitle,
                              style: const TextStyle(
                                color: AppColors.subtext,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  _tagColorForType(destination.type).withValues(
                                alpha: 0.12,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              destination.category ??
                                  destination.type ??
                                  'Explore',
                              style: TextStyle(
                                color: _tagColorForType(destination.type),
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final featureCards = [
      const FeatureCardData('Explore', Icons.explore_outlined),
      const FeatureCardData('Trip Planner', Icons.event_note_outlined),
      const FeatureCardData('Itineraries', Icons.route_outlined),
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(onProfileTap: widget.onProfileTap),
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
              SectionHeader(
                title: 'Featured destinations',
                actionText: _destinations.isNotEmpty ? 'See all' : null,
                onActionTap:
                    _destinations.isNotEmpty ? _openSeeAllDestinations : null,
              ),
              const SizedBox(height: 12),
              if (_loadingDestinations)
                Container(
                  height: 220,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                )
              else if (_destinationError != null)
                GestureDetector(
                  onTap: _loadDestinations,
                  child: Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.stroke),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.wifi_off, color: AppColors.subtext),
                          const SizedBox(height: 8),
                          Text(
                            _destinationError!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.subtext,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else if (_destinationCards.isEmpty)
                Container(
                  height: 120,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'No destinations found right now.',
                    style: TextStyle(
                      color: AppColors.subtext,
                      fontSize: 14,
                    ),
                  ),
                )
              else
                FeaturedList(destinations: _destinationCards),
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
    );
  }
}
