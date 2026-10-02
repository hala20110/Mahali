import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/data/brands_data.dart';
import '../../core/models/brand_model.dart';
import '../brand_detail/brand_detail_screen.dart';
import 'package:provider/provider.dart';
import '../../core/providers/favorites_provider.dart';
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<BrandModel> _allBrands = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBrands();
  }

  Future<void> _fetchBrands() async {
    try {
      final response = await Supabase.instance.client
          .from('brands')
          .select()
          .eq('is_approved', true)
          .order('name');

      setState(() {
        _allBrands = (response as List)
            .map((b) => BrandModel.fromMap(b))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }
  String _selectedCategory = 'All';

  List<BrandModel> get _filteredBrands {
    if (_selectedCategory == 'All') return _allBrands;
    return _allBrands
        .where((b) => b.category == _selectedCategory)
        .toList();
  }

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
      case 'Gym Wear':
        return const Color(0xFFE07B54);
      case 'Kids':
        return const Color(0xFF5BB8D4);
      case 'Men':
        return const Color(0xFF4A7FA5);
      default:
        return AppColors.primary;
    }
  }

  IconData _categoryIcon(String category) {
    switch (category) {
      case 'Modest Wear':
        return Icons.woman_outlined;
      case 'Streetwear':
        return Icons.style_outlined;
      case 'Basics':
        return Icons.check_box_outline_blank_rounded;
      case 'Swimwear':
        return Icons.pool_outlined;
      case 'Bags':
        return Icons.shopping_bag_outlined;
      case 'Jewelry':
        return Icons.diamond_outlined;
      case 'Vintage':
        return Icons.history_outlined;
      case 'Gym Wear':
        return Icons.fitness_center_outlined;
      case 'Kids':
        return Icons.child_care_outlined;
      case 'Men':
        return Icons.man_outlined;
      default:
        return Icons.category_outlined;
    }
  }

  int _brandCount(String category) {
    if (category == 'All') return _allBrands.length;
    return _allBrands.where((b) => b.category == category).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmWhite,

      body: _isLoading
      ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
       :SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explore',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkOlive,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Browse by category',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.darkOlive.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Category grid
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: brandCategories.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    final cat = brandCategories[index];
                    final isSelected = _selectedCategory == cat;
                    final color = cat == 'All'
                        ? AppColors.darkOlive
                        : _categoryColor(cat);
                    final count = _brandCount(cat);

                    return GestureDetector(
                      onTap: () =>
                          setState(() => _selectedCategory = cat),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? color
                              : color.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? color
                                : color.withValues(alpha: 0.2),
                            width: 1.5,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                cat == 'All'
                                    ? Icons.apps_rounded
                                    : _categoryIcon(cat),
                                color: isSelected
                                    ? Colors.white
                                    : color,
                                size: 26,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                cat,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.darkOlive
                                          .withValues(alpha: 0.7),
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '$count ${count == 1 ? 'brand' : 'brands'}',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: isSelected
                                      ? Colors.white.withValues(alpha: 0.8)
                                      : AppColors.darkOlive
                                          .withValues(alpha: 0.4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Results header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedCategory == 'All'
                          ? 'All Brands'
                          : _selectedCategory,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkOlive,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${_filteredBrands.length} brands',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Empty state
            if (_filteredBrands.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    children: [
                      Icon(
                        Icons.store_outlined,
                        size: 56,
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No brands yet in this category',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.darkOlive.withValues(alpha: 0.4),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'More brands coming soon!',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.darkOlive.withValues(alpha: 0.3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Brands list
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final brand = _filteredBrands[index];
                    final color = _categoryColor(brand.category);
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              BrandDetailScreen(brand: brand),
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
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
                            // Avatar
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

                            // Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
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
                                    '@${brand.instagramHandle}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.darkOlive
                                          .withValues(alpha: 0.4),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Category pill
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                brand.category,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: color,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => context.read<FavoritesProvider>().toggle(brand),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                transitionBuilder: (child, animation) =>
                                    ScaleTransition(scale: animation, child: child),
                                child: Icon(
                                  context.watch<FavoritesProvider>().isSaved(brand.id)
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  key: ValueKey(
                                      context.watch<FavoritesProvider>().isSaved(brand.id)),
                                  color: context.watch<FavoritesProvider>().isSaved(brand.id)
                                      ? AppColors.secondary
                                      : AppColors.darkOlive.withValues(alpha: 0.25),
                                  size: 18,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 13,
                              color: AppColors.darkOlive
                                  .withValues(alpha: 0.3),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: _filteredBrands.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}