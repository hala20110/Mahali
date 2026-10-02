import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/providers/favorites_provider.dart';
import '../brand_detail/brand_detail_screen.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  Color _categoryColor(String category) {
    switch (category) {
      case 'Modest Wear':
        return AppColors.primary;
      case 'Streetwear':
        return const Color(0xFF6B7FD4);
      case 'Basics':
        return const Color(0xFFB8860B);
      case 'Swimwear':
        return const Color(0xFF2E8B9A);
      case 'Bags':
        return AppColors.secondary;
      case 'Jewelry':
        return const Color(0xFFD4A017);
      case 'Vintage':
        return const Color(0xFF8B6F47);
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final saved = context.watch<FavoritesProvider>().savedBrands;

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
          'Saved Brands',
          style: TextStyle(
            color: AppColors.darkOlive,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: saved.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border_rounded,
                    size: 64,
                    color: AppColors.primary.withValues(alpha: 0.25),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No saved brands yet',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkOlive.withValues(alpha: 0.4),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Tap the heart on any brand to save it',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.darkOlive.withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              itemCount: saved.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final brand = saved[index];
                final color = _categoryColor(brand.category);
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BrandDetailScreen(brand: brand),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              brand.name[0].toUpperCase(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: color,
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
                                brand.name,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkOlive,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                brand.category,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: color,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              context.read<FavoritesProvider>().toggle(brand),
                          child: Icon(
                            Icons.favorite_rounded,
                            color: AppColors.secondary,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}