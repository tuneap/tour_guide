import 'package:flutter/material.dart';

import 'app_colors.dart';

class FeatureCardData {
  const FeatureCardData(this.title, this.icon);
  final String title;
  final IconData icon;
}

class FeatureCardsRow extends StatelessWidget {
  const FeatureCardsRow({super.key, required this.cards});

  final List<FeatureCardData> cards;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: cards
          .map(
            (card) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: _FeatureCard(card: card),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.card});

  final FeatureCardData card;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(card.icon, color: AppColors.primary),
          const SizedBox(width: 10),
          Text(
            card.title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
