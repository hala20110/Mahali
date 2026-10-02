import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_assets.dart';
import 'register_brand_screen.dart';


class BrandOwnerScreen extends StatefulWidget {
  const BrandOwnerScreen({super.key});

  @override
  State<BrandOwnerScreen> createState() => _BrandOwnerScreenState();
}

class _BrandOwnerScreenState extends State<BrandOwnerScreen> {
  Map<String, dynamic>? _brandData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBrand();
  }

  Future<void> _loadBrand() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    final response = await Supabase.instance.client
        .from('brands')
        .select()
        .eq('owner_id', user.id)
        .maybeSingle();

    setState(() {
      _brandData = response;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final fullName =
        user?.userMetadata?['full_name'] ?? 'Brand Owner';

    return Scaffold(
      backgroundColor: AppColors.warmWhite,
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                    color: AppColors.primary),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, $fullName 👋',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppColors.darkOlive,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Brand Owner Dashboard',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.darkOlive
                                    .withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ),
                        Image.asset(AppAssets.logo, height: 44),
                      ],
                    ),

                    const SizedBox(height: 32),

                    _brandData == null
                        ? _buildNoBrand(context)
                        : _buildBrandDashboard(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildNoBrand(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Center(
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.storefront_outlined,
                  size: 48,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'No brand registered yet',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkOlive,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Register your brand to appear\nin the Mahali directory',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.darkOlive.withValues(alpha: 0.5),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RegisterBrandScreen(),
                      ),
                    );
                    _loadBrand();
                  },
                  icon: const Icon(Icons.add_rounded,
                      color: Colors.white),
                  label: const Text(
                    'Register My Brand',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBrandDashboard() {
    final name = _brandData!['name'] ?? '';
    final category = _brandData!['category'] ?? '';
    final website = _brandData!['website_url'] ?? '';
    final instagram = _brandData!['instagram'] ?? '';
    final isApproved = _brandData!['is_approved'] ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isApproved
                ? AppColors.primary.withValues(alpha: 0.1)
                : AppColors.accent.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isApproved
                  ? AppColors.primary.withValues(alpha: 0.3)
                  : AppColors.secondary.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(
                isApproved
                    ? Icons.check_circle_rounded
                    : Icons.schedule_rounded,
                color: isApproved
                    ? AppColors.primary
                    : AppColors.secondary,
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                isApproved
                    ? 'Your brand is live on Mahali!'
                    : 'Pending approval — we\'ll review shortly',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isApproved
                      ? AppColors.primary
                      : AppColors.secondary,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Brand card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withValues(alpha: 0.12),
                AppColors.secondary.withValues(alpha: 0.06),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.15),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        name.isNotEmpty ? name[0].toUpperCase() : 'B',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.darkOlive,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color:
                                AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (instagram.isNotEmpty)
                _InfoRow(
                    icon: Icons.camera_alt_outlined,
                    value: '@$instagram'),
              if (website.isNotEmpty)
                _InfoRow(icon: Icons.language_rounded, value: website),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Stats row
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: 'Status',
                value: isApproved ? 'Live' : 'Pending',
                icon: Icons.bar_chart_rounded,
                color: isApproved
                    ? AppColors.primary
                    : AppColors.secondary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                label: 'Category',
                value: category,
                icon: Icons.category_outlined,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton.icon(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RegisterBrandScreen(),
                ),
              );
              _loadBrand();
            },
            icon: Icon(Icons.add_rounded, color: AppColors.primary, size: 18),
            label: Text(
              'Register Another Brand',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.4), width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String value;
  const _InfoRow({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon,
              size: 14,
              color: AppColors.darkOlive.withValues(alpha: 0.45)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.darkOlive.withValues(alpha: 0.6),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.darkOlive,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.darkOlive.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}