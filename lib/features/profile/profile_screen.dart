import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_assets.dart';
import '../auth/login_screen.dart';
import '../saved/saved_screen.dart';
import 'edit_profile_screen.dart';
import 'about_screen.dart';
import 'privacy_policy_screen.dart';
import '../brand_owner/edit_brand_screen.dart';
import '../brand_owner/brand_analytics_screen.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _signOut(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final fullName = user?.userMetadata?['full_name'] ?? 'Mahali User';
    final email = user?.email ?? '';
    final role = user?.userMetadata?['role'] ?? 'shopper';
    final isBrandOwner = role == 'brand_owner';

    return Scaffold(
      backgroundColor: AppColors.warmWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.12),
                      AppColors.warmWhite,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    // Logo small
                    Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(AppAssets.logo, height: 40),
                    ),
                    const SizedBox(height: 16),

                    // Avatar
                    FutureBuilder(
                    future: Supabase.instance.client
                        .from('profiles')
                        .select('avatar_url, phone')
                        .eq('id', user?.id ?? '')
                        .maybeSingle(),
                    builder: (context, snapshot) {
                      final avatarUrl = snapshot.data?['avatar_url'];
                      return Container(
                        width: 86,
                        height: 86,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            width: 2,
                          ),
                          image: avatarUrl != null
                              ? DecorationImage(
                                  image: NetworkImage(avatarUrl),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: avatarUrl == null
                            ? Center(
                                child: Text(
                                  fullName.isNotEmpty ? fullName[0].toUpperCase() : 'M',
                                  style: TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                  ),
                                ),
                              )
                            : null,
                      );
                    },
                  ),

                    const SizedBox(height: 14),

                    Text(
                      fullName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkOlive,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.darkOlive.withValues(alpha: 0.5),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Role badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 5),
                      decoration: BoxDecoration(
                        color: isBrandOwner
                            ? AppColors.secondary.withValues(alpha: 0.1)
                            : AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isBrandOwner
                                ? Icons.storefront_outlined
                                : Icons.shopping_bag_outlined,
                            size: 13,
                            color: isBrandOwner
                                ? AppColors.secondary
                                : AppColors.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isBrandOwner ? 'Brand Owner' : 'Shopper',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isBrandOwner
                                  ? AppColors.secondary
                                  : AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand owner section
                    if (isBrandOwner) ...[
                      _SectionTitle(title: 'My Brand'),
                      const SizedBox(height: 12),
                      // Manage My Brand
                      _ProfileTile(
                        icon: Icons.storefront_outlined,
                        label: 'Manage My Brand',
                        color: AppColors.secondary,
                        onTap: () async {
                          final user = Supabase.instance.client.auth.currentUser;
                          if (user == null) return;
                          final brand = await Supabase.instance.client
                              .from('brands')
                              .select()
                              .eq('owner_id', user.id)
                              .maybeSingle();
                          if (brand != null && context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditBrandScreen(brandData: brand),
                              ),
                            );
                          } else if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('No brand registered yet.'),
                                backgroundColor: AppColors.secondary,
                              ),
                            );
                          }
                        },
                      ),

                      // Brand Analytics
                      _ProfileTile(
                        icon: Icons.bar_chart_rounded,
                        label: 'Brand Analytics',
                        color: AppColors.secondary,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const BrandAnalyticsScreen()),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Account section
                    _SectionTitle(title: 'Account'),
                    const SizedBox(height: 12),
                    _ProfileTile(
                      icon: Icons.person_outline_rounded,
                      label: 'Edit Profile',
                      color: AppColors.primary,
                      onTap: () async {
                        final updated = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                        );
                        if (updated == true) {
                          // Force rebuild to show updated name
                          (context as Element).markNeedsBuild();
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    _ProfileTile(
                      icon: Icons.favorite_border_rounded,
                      label: 'Saved Brands',
                      color: AppColors.primary,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SavedScreen()),
                        ),                    ),
                    const SizedBox(height: 8),
                    _ProfileTile(
                      icon: Icons.notifications_none_rounded,
                      label: 'Notifications',
                      color: AppColors.primary,
                      onTap: () {},
                    ),

                    const SizedBox(height: 24),

                    // About section
                    _SectionTitle(title: 'About'),
                    const SizedBox(height: 12),
                    _ProfileTile(
                      icon: Icons.info_outline_rounded,
                      label: 'About Mahali',
                      color: AppColors.darkOlive,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AboutScreen()),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _ProfileTile(
                      icon: Icons.privacy_tip_outlined,
                      label: 'Privacy Policy',
                      color: AppColors.darkOlive,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Sign out
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: OutlinedButton.icon(
                        onPressed: () => _signOut(context),
                        icon: Icon(Icons.logout_rounded,
                            color: AppColors.secondary, size: 18),
                        label: Text(
                          'Sign Out',
                          style: TextStyle(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: AppColors.secondary.withValues(alpha: 0.4),
                              width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Version
                    Center(
                      child: Text(
                        'Mahali v1.0.0 • Made in Egypt 🇪🇬',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.darkOlive.withValues(alpha: 0.35),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: AppColors.darkOlive.withValues(alpha: 0.45),
        letterSpacing: 0.8,
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ProfileTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkOlive,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 13,
              color: AppColors.darkOlive.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }
}