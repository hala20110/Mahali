import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_assets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
          'About Mahali',
          style: TextStyle(
            color: AppColors.darkOlive,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
        child: Column(
          children: [
            Image.asset(AppAssets.logo, height: 100),
            const SizedBox(height: 20),
            Text(
              'Mahali — محلي',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.darkOlive,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.darkOlive.withValues(alpha: 0.4),
              ),
            ),
            const SizedBox(height: 32),
            _buildCard(
              icon: Icons.favorite_rounded,
              color: AppColors.secondary,
              title: 'Our Mission',
              body:
                  'Mahali exists to connect Egyptian shoppers with the best local fashion brands — all in one place. No more scrolling through TikTok or Instagram hunting for brands. We bring them to you.',
            ),
            const SizedBox(height: 16),
            _buildCard(
              icon: Icons.storefront_outlined,
              color: AppColors.primary,
              title: 'For Brand Owners',
              body:
                  'Are you an Egyptian fashion brand? Register on Mahali and get discovered by thousands of shoppers looking for exactly what you create. Grow your presence, your way.',
            ),
            const SizedBox(height: 16),
            _buildCard(
              icon: Icons.flag_outlined,
              color: const Color(0xFF2E8B9A),
              title: 'Made in Egypt 🇪🇬',
              body:
                  'Mahali is built by Egyptians, for Egyptians. Every brand on our platform is 100% local. When you shop on Mahali, you support real people building real businesses right here at home.',
            ),
            const SizedBox(height: 32),
            Divider(color: AppColors.primary.withValues(alpha: 0.1)),
            const SizedBox(height: 24),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.darkOlive,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'hello@mahali.eg',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '@mahali.eg on Instagram',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              '© 2025 Mahali. All rights reserved.',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.darkOlive.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required Color color,
    required String title,
    required String body,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkOlive,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            body,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.darkOlive.withValues(alpha: 0.65),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}