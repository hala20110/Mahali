import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class BrandAnalyticsScreen extends StatelessWidget {
  const BrandAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmWhite,
      appBar: AppBar(
        backgroundColor: AppColors.warmWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.darkOlive, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Brand Analytics',
          style: TextStyle(
            color: AppColors.darkOlive,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Coming soon banner
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
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.auto_awesome_rounded,
                      color: AppColors.primary, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Analytics Coming Soon',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.darkOlive,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Full analytics will be available once your brand is live and receiving traffic.',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.darkOlive.withValues(alpha: 0.55),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Overview',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.darkOlive,
              ),
            ),

            const SizedBox(height: 12),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: [
                _AnalyticsCard(
                  label: 'Profile Views',
                  value: '—',
                  icon: Icons.visibility_outlined,
                  color: const Color(0xFF6B7FD4),
                  subtitle: 'Total views',
                ),
                _AnalyticsCard(
                  label: 'Saves',
                  value: '—',
                  icon: Icons.favorite_border_rounded,
                  color: AppColors.secondary,
                  subtitle: 'Users saved you',
                ),
                _AnalyticsCard(
                  label: 'Website Clicks',
                  value: '—',
                  icon: Icons.language_rounded,
                  color: AppColors.primary,
                  subtitle: 'Shop Now taps',
                ),
                _AnalyticsCard(
                  label: 'Instagram Clicks',
                  value: '—',
                  icon: Icons.camera_alt_outlined,
                  color: const Color(0xFFE1306C),
                  subtitle: 'IG profile taps',
                ),
              ],
            ),

            const SizedBox(height: 24),

            Text(
              'Monthly Traffic',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.darkOlive,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.08),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bar_chart_rounded,
                    size: 48,
                    color: AppColors.primary.withValues(alpha: 0.25),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Chart available after go-live',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.darkOlive.withValues(alpha: 0.4),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Top Performing Days',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.darkOlive,
              ),
            ),

            const SizedBox(height: 12),

            _DayRow(day: 'Monday', bar: 0.0),
            _DayRow(day: 'Tuesday', bar: 0.0),
            _DayRow(day: 'Wednesday', bar: 0.0),
            _DayRow(day: 'Thursday', bar: 0.0),
            _DayRow(day: 'Friday', bar: 0.0),
            _DayRow(day: 'Saturday', bar: 0.0),
            _DayRow(day: 'Sunday', bar: 0.0),
          ],
        ),
      ),
    );
  }
}

class _AnalyticsCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final String subtitle;

  const _AnalyticsCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: color.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.darkOlive,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.darkOlive.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _DayRow extends StatelessWidget {
  final String day;
  final double bar;
  const _DayRow({required this.day, required this.bar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              day,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.darkOlive.withValues(alpha: 0.55),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: bar,
                minHeight: 8,
                backgroundColor: AppColors.cardBg,
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '—',
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