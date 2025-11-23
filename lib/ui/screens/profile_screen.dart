import 'package:flutter/material.dart';

import '../components/app_colors.dart';
import '../components/bottom_nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _ProfileHeader(),
              SizedBox(height: 16),
              _ProfileCard(),
              SizedBox(height: 20),
              _SectionLabel('Account'),
              SizedBox(height: 8),
              _SettingsGroup(
                children: [
                  ProfileTile(
                    icon: Icons.mail_outline,
                    title: 'Email',
                    subtitle: 'alex@example.com',
                  ),
                  ProfileTile(
                    icon: Icons.phone_outlined,
                    title: 'Phone',
                    subtitle: 'Add a phone number',
                  ),
                  ProfileTile(
                    icon: Icons.lock_outline,
                    title: 'Password',
                    subtitle: 'Last changed 4 months ago',
                  ),
                ],
              ),
              SizedBox(height: 22),
              _SectionLabel('Preferences'),
              SizedBox(height: 8),
              _SettingsGroup(
                children: [
                  ProfileTile(
                    icon: Icons.public,
                    title: 'Language',
                    subtitle: 'English (US)',
                    trailingText: 'Change',
                  ),
                  ProfileTile(
                    icon: Icons.monetization_on_outlined,
                    title: 'Currency',
                    subtitle: 'USD (\$)',
                    trailingText: 'Change',
                  ),
                  ProfileTile(
                    icon: Icons.place_outlined,
                    title: 'Default start location',
                    subtitle: 'Set your home city for trip suggestions',
                  ),
                ],
              ),
              SizedBox(height: 22),
              _SectionLabel('Privacy & Security'),
              SizedBox(height: 8),
              _SettingsGroup(
                children: [
                  ProfileTile(
                    icon: Icons.group_outlined,
                    title: 'Profile visibility',
                    subtitle: 'Only friends',
                    trailingText: 'Edit',
                  ),
                  ProfileTile(
                    icon: Icons.notifications_none,
                    title: 'Notifications',
                    subtitle: 'Trips, comments, reminders',
                    trailingText: 'Manage',
                  ),
                  ProfileTile(
                    icon: Icons.shield_outlined,
                    title: 'Two-factor authentication',
                    subtitle: 'Off',
                    trailingText: 'Set up',
                  ),
                ],
              ),
              SizedBox(height: 22),
              _AboutYouCard(),
              SizedBox(height: 22),
              _SectionLabel('Support'),
              SizedBox(height: 8),
              _SettingsGroup(
                children: [
                  ProfileTile(
                    icon: Icons.help_outline,
                    title: 'Help Center',
                    subtitle: 'FAQs, guides, and support',
                  ),
                  ProfileTile(
                    icon: Icons.chat_bubble_outline,
                    title: 'Contact support',
                    subtitle: 'We usually reply within a day',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 4,
        onItemSelected: (index) {
          if (index == 0) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(
              'Manage your account & settings',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.subtext),
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_horiz),
          color: AppColors.subtext,
        ),
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.stroke),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Manage your account & settings',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: AppColors.subtext),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz),
                color: AppColors.subtext,
              ),
            ],
          ),
          SizedBox(height: 4),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.black.withValues(alpha: 0.10),
          ),
          SizedBox(height: 4),

          Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=80',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Alex Johnson',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '@alexj',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Member since 2021',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primary.withValues(alpha:  0.08),
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Edit',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.children});

  final List<ProfileTile> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.stroke),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1)
              Divider(height: 1, thickness: 1, color: AppColors.stroke),
          ],
        ],
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailingText,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final String? trailingText;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.grey.shade800),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.subtext,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (trailingText != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Text(
                      trailingText!,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                Icon(Icons.chevron_right, color: Colors.grey.shade500),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutYouCard extends StatelessWidget {
  const _AboutYouCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.stroke),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About you',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (context, constraints) {
              final fieldWidth = (constraints.maxWidth - 12) / 2;
              const fields = [
                'Full name',
                'Username',
                'Bio',
                'Website',
                'Location',
                'Time zone',
              ];

              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: fields
                    .map(
                      (label) => SizedBox(
                        width: fieldWidth,
                        child: _ProfileInputField(label: label),
                      ),
                    )
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.primary.withValues(alpha: 0.08),
                    foregroundColor: AppColors.primary,
                    side: BorderSide(color: AppColors.primary.withValues(alpha: 0.4)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Save changes',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileInputField extends StatelessWidget {
  const _ProfileInputField({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: label,
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.stroke),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
        ),
      ),
    );
  }
}
