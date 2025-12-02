import 'package:flutter/material.dart';

import '../components/app_colors.dart';
import '../components/community_post_feed_card.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final List<CommunityFeed> _posts = [
    const CommunityFeed(
      author: 'Maya Patel',
      avatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&h=200&fit=crop',
      timeLocation: '2h • Kyoto',
      title: '3-day Cherry Blossom Walks',
      tag: 'Slow travel',
      images: [
        'https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1?w=800',
        'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=800',
      ],
      itinerary: [
        'Sunrise at Yasaka Shrine',
        "Stroll Philosopher's Path",
        'Ninenzaka tea stop',
      ],
      likes: 128,
    ),
    const CommunityFeed(
      author: 'Liam Chen',
      avatarUrl: 'https://images.unsplash.com/photo-1545996124-1b5a2e3d6f3b?w=200&h=200&fit=crop',
      timeLocation: '5h • Tokyo',
      title: 'Golden Hour in Gion',
      tag: 'Photography',
      images: [
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
        'https://images.unsplash.com/photo-1512453979798-5ea266f8880c?w=800',
      ],
      itinerary: [
        'Gion district walk',
        'Dinner at local izakaya',
      ],
      likes: 42,
    ),
    const CommunityFeed(
      author: 'Sara Johnson',
      avatarUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&h=200&fit=crop',
      timeLocation: '1d • Bali',
      title: 'Secret Beach Spots',
      tag: 'Adventure',
      images: [
        'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800',
        'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=800',
      ],
      itinerary: [
        'Early morning drive to Nusa Penida',
        'Snorkeling at Crystal Bay',
        'Sunset at Kelingking Beach',
      ],
      likes: 215,
    ),
    const CommunityFeed(
      author: 'Raj Kumar',
      avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&h=200&fit=crop',
      timeLocation: '3d • Paris',
      title: 'Parisian Cafe Culture',
      tag: 'Food',
      images: [
        'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=800',
        'https://images.unsplash.com/photo-1514933651103-005eec06c04b?w=800',
      ],
      itinerary: [
        'Morning croissant at local boulangerie',
        'Lunch at Le Marais bistro',
        'Evening wine tasting',
      ],
      likes: 89,
    ),
    const CommunityFeed(
      author: 'Emma Wilson',
      avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop',
      timeLocation: '1w • Iceland',
      title: 'Northern Lights Road Trip',
      tag: 'Nature',
      images: [
        'https://images.unsplash.com/photo-1483347756197-71ef80e95f73?w=800',
        'https://images.unsplash.com/photo-1579033461380-adb47c3eb938?w=800',
      ],
      itinerary: [
        'Chase auroras near Thingvellir',
        'Soak in Blue Lagoon',
        'Explore ice caves',
      ],
      likes: 342,
    ),
    const CommunityFeed(
      author: 'Carlos Martinez',
      avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop',
      timeLocation: '4d • Barcelona',
      title: 'Gaudi Architecture Walk',
      tag: 'Culture',
      images: [
        'https://images.unsplash.com/photo-1539037116277-4db20889f2d4?w=800',
        'https://images.unsplash.com/photo-1523531294919-4bcd7c65e216?w=800',
      ],
      itinerary: [
        'Sagrada Familia tour',
        'Park Guell visit',
        'Casa Batllo exploration',
      ],
      likes: 167,
    ),
  ];

  void _openCreatePostSheet() {
    final titleCtrl = TextEditingController();
    final tagCtrl = TextEditingController();
    final image1Ctrl = TextEditingController();
    final image2Ctrl = TextEditingController();
    final itineraryCtrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Create Post', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
              const SizedBox(height: 8),
              TextField(controller: tagCtrl, decoration: const InputDecoration(labelText: 'Tag')),
              const SizedBox(height: 8),
              TextField(controller: image1Ctrl, decoration: const InputDecoration(labelText: 'Image URL 1')),
              const SizedBox(height: 8),
              TextField(controller: image2Ctrl, decoration: const InputDecoration(labelText: 'Image URL 2')),
              const SizedBox(height: 8),
              TextField(
                controller: itineraryCtrl,
                decoration: const InputDecoration(labelText: 'Itinerary (one per line)'),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      final title = titleCtrl.text.trim();
                      if (title.isEmpty) return;
                      final newPost = CommunityFeed(
                        author: 'You',
                        avatarUrl: 'https://images.unsplash.com/photo-1545996124-1b5a2e3d6f3b?w=200&h=200&fit=crop',
                        timeLocation: 'now',
                        title: title,
                        tag: tagCtrl.text.trim().isEmpty ? 'General' : tagCtrl.text.trim(),
                        images: [if (image1Ctrl.text.trim().isNotEmpty) image1Ctrl.text.trim(), if (image2Ctrl.text.trim().isNotEmpty) image2Ctrl.text.trim()],
                        itinerary: itineraryCtrl.text.split('\n').map((s) => s.trim()).where((s) => s.isNotEmpty).toList(),
                        likes: 0,
                      );
                      setState(() => _posts.insert(0, newPost));
                      Navigator.pop(ctx);
                    },
                    child: const Text('Post'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Community', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800)),
            SizedBox(height: 2),
            Text('Plans, itineraries and tips', style: TextStyle(color: AppColors.subtext, fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: AppColors.subtext),
          ),
          TextButton(
            onPressed: _openCreatePostSheet,
            child: const Text('Post', style: TextStyle(color: Colors.white)),
            style: TextButton.styleFrom(backgroundColor: const Color(0xFF007BFF)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Community posts', style: TextStyle(color: AppColors.subtext)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) => CommunityPostFeedCard(feed: _posts[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
