import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/app_colors.dart';
import '../components/login_required_dialog.dart';

class PackageDetailData {
  const PackageDetailData({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.destinations,
    required this.duration,
    required this.inclusions,
    required this.itinerary,
    required this.stayIncluded,
    required this.stayUpgrade,
    required this.upgradePrice,
    required this.notIncluded,
    required this.partnerName,
    required this.partnerBookings,
    required this.reviews,
    required this.price,
    required this.tags,
  });

  final String title;
  final String subtitle;
  final String imageUrl;
  final double rating;
  final String reviewCount;
  final String destinations;
  final String duration;
  final List<String> inclusions;
  final List<ItineraryHighlight> itinerary;
  final String stayIncluded;
  final String stayUpgrade;
  final int upgradePrice;
  final List<String> notIncluded;
  final String partnerName;
  final String partnerBookings;
  final List<Review> reviews;
  final int price;
  final List<String> tags;
}

class ItineraryHighlight {
  const ItineraryHighlight({
    required this.day,
    required this.title,
    required this.description,
  });

  final int day;
  final String title;
  final String description;
}

class Review {
  const Review({
    required this.avatarUrl,
    required this.rating,
    required this.comment,
    required this.date,
    required this.travelerType,
  });

  final String avatarUrl;
  final double rating;
  final String comment;
  final String date;
  final String travelerType;
}

class PackageDetailsScreen extends StatelessWidget {
  const PackageDetailsScreen({
    super.key,
    required this.packageTitle,
    required this.packagePrice,
    this.isLoggedIn = false,
  });

  final String packageTitle;
  final int packagePrice;
  final bool isLoggedIn;

  PackageDetailData get _packageData => PackageDetailData(
    title: packageTitle,
    subtitle: _getSubtitle(packageTitle),
    imageUrl: _getImageUrl(packageTitle),
    rating: 4.7,
    reviewCount: '1.3k',
    destinations: _getDestinations(packageTitle),
    duration: _getDuration(packageTitle),
    inclusions: _getInclusions(packageTitle),
    itinerary: _getItinerary(packageTitle),
    stayIncluded: _getStayIncluded(packageTitle),
    stayUpgrade: _getStayUpgrade(packageTitle),
    upgradePrice: 320,
    notIncluded: const ['Lunch & dinners (unless stated)', 'Travel insurance', 'Personal expenses'],
    partnerName: 'Himalayan Trails Nepal',
    partnerBookings: '2.1k',
    reviews: const [
      Review(
        avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=100&q=60',
        rating: 5.0,
        comment: 'Great itinerary, smooth logistics!',
        date: 'October 2024',
        travelerType: 'Couple',
      ),
      Review(
        avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=100&q=60',
        rating: 4.5,
        comment: 'Amazing views, tours well paced.',
        date: 'September 2024',
        travelerType: 'Solo',
      ),
    ],
    price: packagePrice,
    tags: _getTags(packageTitle),
  );

  String _getSubtitle(String title) {
    if (title.contains('7D/6N')) return '7D/6N';
    if (title.contains('14D/13N')) return '14D/13N';
    if (title.contains('5D/4N')) return '5D/4N';
    if (title.contains('4D/3N')) return '4D/3N';
    if (title.contains('12D/11N')) return '12D/11N';
    if (title.contains('3D/2N')) return '3D/2N';
    return '7D/6N';
  }

  String _getImageUrl(String title) {
    if (title.contains('Everest')) {
      return 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=800&q=80';
    }
    if (title.contains('Pokhara')) {
      return 'https://images.unsplash.com/photo-1558799401-1dcba79f7173?auto=format&fit=crop&w=800&q=80';
    }
    if (title.contains('Chitwan')) {
      return 'https://images.unsplash.com/photo-1549366021-9f761d450615?auto=format&fit=crop&w=800&q=80';
    }
    if (title.contains('Annapurna')) {
      return 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=800&q=80';
    }
    if (title.contains('Lumbini')) {
      return 'https://images.unsplash.com/photo-1609766857041-ed402ea8069a?auto=format&fit=crop&w=800&q=80';
    }
    return 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=800&q=80';
  }

  String _getDestinations(String title) {
    if (title.contains('Everest')) return 'Lukla • Namche • Base Camp';
    if (title.contains('Pokhara')) return 'Pokhara • Sarangkot';
    if (title.contains('Chitwan')) return 'Chitwan National Park';
    if (title.contains('Annapurna')) return 'Besisahar • Manang • Muktinath';
    if (title.contains('Lumbini')) return 'Lumbini • Kapilvastu';
    return 'Kathmandu • Pokhara • Chitwan • Nagarkot';
  }

  String _getDuration(String title) {
    if (title.contains('7D/6N')) return '7 days / 6 nights • Flexible start dates';
    if (title.contains('14D/13N')) return '14 days / 13 nights • Fixed departures';
    if (title.contains('5D/4N')) return '5 days / 4 nights • Flexible start dates';
    if (title.contains('4D/3N')) return '4 days / 3 nights • Daily departures';
    if (title.contains('12D/11N')) return '12 days / 11 nights • Seasonal';
    if (title.contains('3D/2N')) return '3 days / 2 nights • Any day';
    return '7 days / 6 nights • Flexible start dates';
  }

  List<String> _getInclusions(String title) {
    if (title.contains('Everest') || title.contains('Annapurna')) {
      return ['Domestic flights', 'Trekking permits', 'Guide & porter', 'Lodge accommodation', 'All meals on trek'];
    }
    if (title.contains('Pokhara')) {
      return ['Airport transfers', 'Resort spa credit', 'Daily breakfast', 'Yoga sessions', 'Boat ride'];
    }
    if (title.contains('Chitwan')) {
      return ['Jungle safari', 'Elephant bathing', 'Canoe ride', 'All meals', 'Cultural show'];
    }
    if (title.contains('Lumbini')) {
      return ['Transport', 'Temple guide', 'Breakfast', 'Monastery visits'];
    }
    return ['Round-trip flights', 'Airport transfers', 'Daily breakfast', 'Two guided tours', 'Resort spa credit'];
  }

  List<String> _getTags(String title) {
    if (title.contains('Everest') || title.contains('Annapurna')) {
      return ['Adventure', 'Trekking', 'Guided'];
    }
    if (title.contains('Pokhara')) {
      return ['Wellness', '5★ Resort', 'Relaxation'];
    }
    if (title.contains('Chitwan')) {
      return ['Wildlife', 'Safari', 'Nature'];
    }
    if (title.contains('Lumbini')) {
      return ['Spiritual', 'Heritage', 'Budget'];
    }
    return ['All inclusive', '4★ Hotels', 'Free cancel'];
  }

  List<ItineraryHighlight> _getItinerary(String title) {
    if (title.contains('Everest')) {
      return const [
        ItineraryHighlight(day: 1, title: 'Fly to Lukla & trek to Phakding', description: 'Scenic mountain flight, gentle acclimatization walk.'),
        ItineraryHighlight(day: 2, title: 'Trek to Namche Bazaar', description: 'First views of Everest, vibrant Sherpa town.'),
        ItineraryHighlight(day: 3, title: 'Acclimatization day', description: 'Hike to Everest View Hotel, rest and explore.'),
      ];
    }
    if (title.contains('Pokhara')) {
      return const [
        ItineraryHighlight(day: 1, title: 'Arrival & lakeside relaxation', description: 'Airport pickup, spa welcome treatment.'),
        ItineraryHighlight(day: 2, title: 'Sarangkot sunrise & yoga', description: 'Early morning viewpoint, afternoon wellness.'),
        ItineraryHighlight(day: 3, title: 'Phewa Lake & Peace Pagoda', description: 'Boat ride, hilltop stupa visit.'),
      ];
    }
    if (title.contains('Chitwan')) {
      return const [
        ItineraryHighlight(day: 1, title: 'Arrival & Tharu village tour', description: 'Check-in, cultural evening with dance.'),
        ItineraryHighlight(day: 2, title: 'Jungle safari & canoe ride', description: 'Jeep safari, bird watching, crocodile spotting.'),
        ItineraryHighlight(day: 3, title: 'Elephant bathing & departure', description: 'Morning with elephants, return transfer.'),
      ];
    }
    return const [
      ItineraryHighlight(day: 1, title: 'Arrival & Kathmandu sightseeing', description: 'Pickup, check-in, Swayambhunath visit, welcome dinner.'),
      ItineraryHighlight(day: 2, title: 'Patan & Bhaktapur heritage tour', description: 'Durbar squares, Newari lunch, pottery square.'),
      ItineraryHighlight(day: 3, title: 'Fly to Pokhara', description: 'Scenic flight, Phewa Lake boating, lakeside dinner.'),
      ItineraryHighlight(day: 4, title: 'Sarangkot sunrise & World Peace Pagoda', description: 'Early viewpoint, afternoon hike to white stupa.'),
    ];
  }

  String _getStayIncluded(String title) {
    if (title.contains('Everest') || title.contains('Annapurna')) return '3★ Mountain lodges, twin sharing';
    if (title.contains('Pokhara')) return '5★ Lakeside resort, breakfast';
    if (title.contains('Chitwan')) return '4★ Jungle lodge, all meals';
    if (title.contains('Lumbini')) return '3★ Hotel, breakfast';
    return '4★ Hotels, breakfast';
  }

  String _getStayUpgrade(String title) {
    if (title.contains('Everest') || title.contains('Annapurna')) return '4★ Premium lodges';
    if (title.contains('Pokhara')) return 'Private villa with pool';
    if (title.contains('Chitwan')) return '5★ Safari tent';
    if (title.contains('Lumbini')) return '4★ Heritage hotel';
    return '5★ Boutique hotels';
  }

  @override
  Widget build(BuildContext context) {
    final data = _packageData;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(Icons.chevron_left, color: AppColors.text, size: 28),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Package details',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          data.subtitle,
                          style: const TextStyle(
                            color: AppColors.subtext,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.stroke),
                    ),
                    child: const Icon(
                      Icons.share_outlined,
                      size: 18,
                      color: Color(0xFF606F81),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Hero image with overlay
                    Stack(
                      children: [
                        Image.network(
                          data.imageUrl,
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 220,
                            color: AppColors.stroke,
                            child: const Center(
                              child: Icon(Icons.image, size: 40, color: AppColors.subtext),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          bottom: 16,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.title.split(':').first,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Wrap(
                                        spacing: 6,
                                        children: data.tags.map((tag) => Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE6F6EE),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            tag,
                                            style: const TextStyle(
                                              color: AppColors.primary,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.star_outline, size: 18, color: Color(0xFFFBBF24)),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${data.rating}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '(${data.reviewCount})',
                                      style: const TextStyle(
                                        color: AppColors.subtext,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Info rows
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          _InfoRow(icon: Icons.location_on_outlined, text: 'Destinations: ${data.destinations}'),
                          const SizedBox(height: 10),
                          _InfoRow(icon: Icons.calendar_today_outlined, text: data.duration),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Inclusions
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.check_box_outlined, size: 18, color: AppColors.subtext),
                              SizedBox(width: 8),
                              Text(
                                'Inclusions',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: data.inclusions.map((item) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE6F6EE),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                item,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 13,
                                ),
                              ),
                            )).toList(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Itinerary highlights
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Itinerary highlights',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...data.itinerary.map((item) => _ItineraryCard(item: item)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Stay options
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Stay options',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.bed_outlined, size: 18, color: AppColors.subtext),
                              const SizedBox(width: 10),
                              Text(
                                'Included: ${data.stayIncluded}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.arrow_upward, size: 18, color: AppColors.subtext),
                              const SizedBox(width: 10),
                              Text(
                                'Upgrade: ${data.stayUpgrade} • +\$${data.upgradePrice}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // What's not included
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "What's not included",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: data.notIncluded.map((item) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: AppColors.stroke),
                              ),
                              child: Text(
                                item,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 13,
                                ),
                              ),
                            )).toList(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Partner
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Partner',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 22,
                                backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1544735716-392fe2489ffa?auto=format&fit=crop&w=100&q=60',
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.partnerName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      'Trusted partner • ${data.partnerBookings} bookings',
                                      style: const TextStyle(
                                        color: AppColors.subtext,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE6F6EE),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  'Verified',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Reviews
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Reviews',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...data.reviews.map((review) => _ReviewCard(review: review)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),

            // Bottom bar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '\$${data.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                        ),
                      ),
                      const Text(
                        'per person',
                        style: TextStyle(
                          color: AppColors.subtext,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      if (!isLoggedIn) {
                        LoginRequiredDialog.show(
                          context,
                          title: 'Sign in to book',
                          message: 'Create an account or sign in to book this tour package and manage your trips.',
                        );
                      } else {
                        // TODO: Navigate to booking flow
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Booking flow coming soon!')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Select dates',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.subtext),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}

class _ItineraryCard extends StatelessWidget {
  const _ItineraryCard({required this.item});

  final ItineraryHighlight item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Day ${item.day} • ${item.title}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.description,
            style: const TextStyle(
              color: AppColors.subtext,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(review.avatarUrl),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star_outline, size: 14, color: Color(0xFFFBBF24)),
                    const SizedBox(width: 4),
                    Text(
                      '${review.rating}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '•  ${review.comment}',
                      style: const TextStyle(
                        color: AppColors.subtext,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${review.date} • ${review.travelerType}',
                  style: const TextStyle(
                    color: AppColors.subtext,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
