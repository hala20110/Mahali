import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          'Privacy Policy',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last updated: June 2025',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.darkOlive.withValues(alpha: 0.4),
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              '1. Information We Collect',
              'We collect information you provide when registering, including your name, email address, and phone number. Brand owners additionally provide brand details such as name, category, Instagram handle, and website URL.',
            ),
            _buildSection(
              '2. How We Use Your Information',
              'Your information is used to create and manage your account, display your brand profile if you are a brand owner, and improve the Mahali experience. We do not sell your personal data to third parties.',
            ),
            _buildSection(
              '3. Data Storage',
              'All data is securely stored using Supabase, which complies with industry-standard security practices. Your password is never stored in plain text.',
            ),
            _buildSection(
              '4. Avatar Photos',
              'Profile photos you upload are stored securely and are only used to personalize your Mahali profile. You can remove or update your photo at any time.',
            ),
            _buildSection(
              '5. Third-Party Links',
              'Mahali provides links to brand websites and Instagram profiles. We are not responsible for the privacy practices of those external sites.',
            ),
            _buildSection(
              '6. Your Rights',
              'You may request deletion of your account and all associated data at any time by contacting us at hello@mahali.eg. We will process your request within 14 days.',
            ),
            _buildSection(
              '7. Changes to This Policy',
              'We may update this Privacy Policy from time to time. We will notify you of significant changes via the app or email.',
            ),
            _buildSection(
              '8. Contact',
              'For any privacy-related questions, please contact us at hello@mahali.eg.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.darkOlive,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.darkOlive.withValues(alpha: 0.65),
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}