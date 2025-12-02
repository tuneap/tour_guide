import 'package:flutter/material.dart';

import '../components/app_colors.dart';
import '../components/community_post_feed_card.dart';

class CommunityPostDetail extends StatelessWidget {
  const CommunityPostDetail({super.key, required this.feed});

  final CommunityFeed feed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text('Community', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: AppColors.subtext)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3))],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Likes column
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                child: Column(
                  children: [
                    const Icon(Icons.favorite_border, color: Color(0xFF9CA3AF)),
                    const SizedBox(height: 8),
                    Text('${feed.likes}', style: const TextStyle(color: AppColors.subtext)),
                  ],
                ),
              ),

              // Content column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header row: avatar, author, time
                      Row(
                        children: [
                          CircleAvatar(radius: 20, backgroundImage: NetworkImage(feed.avatarUrl)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(feed.author, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                                const SizedBox(height: 2),
                                Text(feed.timeLocation, style: const TextStyle(color: AppColors.subtext, fontSize: 12)),
                              ],
                            ),
                          ),
                          // small spacer for top-right
                        ],
                      ),

                      const SizedBox(height: 12),

                      Text(feed.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(color: const Color(0xFFE6F6EE), borderRadius: BorderRadius.circular(8)),
                        child: Text(feed.tag, style: const TextStyle(color: Color(0xFF10884F))),
                      ),

                      const SizedBox(height: 12),

                      // Images: left large, right tall
                      SizedBox(
                        height: 180,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: ClipRRect(borderRadius: BorderRadius.circular(8), child: feed.images.isNotEmpty ? Image.network(feed.images[0], fit: BoxFit.cover) : Container(color: AppColors.stroke)),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 1,
                              child: ClipRRect(borderRadius: BorderRadius.circular(8), child: feed.images.length > 1 ? Image.network(feed.images[1], fit: BoxFit.cover) : Container(color: AppColors.stroke)),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Itinerary box (simple bordered container)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.stroke)),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(children: const [
                            Text('DAY', style: TextStyle(fontWeight: FontWeight.w700)),
                            SizedBox(width: 8),
                            Text('1', style: TextStyle(fontWeight: FontWeight.w700)),
                          ]),
                          const SizedBox(height: 8),
                          ...feed.itinerary.map((s) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  const Text('• ', style: TextStyle(fontSize: 14)),
                                  Expanded(child: Text(s)),
                                ]),
                              )),
                        ]),
                      ),

                      const SizedBox(height: 12),

                      // Action buttons
                      Row(
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.map, color: Color(0xFF0F7A54)),
                            label: const Text('Map', style: TextStyle(color: Color(0xFF0F7A54))),
                            style: OutlinedButton.styleFrom(backgroundColor: const Color(0xFFEFFAF3), side: const BorderSide(color: Color(0xFFE6F6EE))),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.share, color: Color(0xFF0F7A54)),
                            label: const Text('Share', style: TextStyle(color: Color(0xFF0F7A54))),
                            style: OutlinedButton.styleFrom(backgroundColor: const Color(0xFFEFFAF3), side: const BorderSide(color: Color(0xFFE6F6EE))),
                          ),
                          const Spacer(),
                          ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.open_in_new), label: const Text('Visit'))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
