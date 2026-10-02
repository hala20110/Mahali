import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/models/brand_model.dart';

class BrandDetailScreen extends StatefulWidget {
  final BrandModel brand;
  const BrandDetailScreen({super.key, required this.brand});

  @override
  State<BrandDetailScreen> createState() => _BrandDetailScreenState();
}

class _BrandDetailScreenState extends State<BrandDetailScreen> {
  bool _showWebView = false;
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.brand.websiteUrl));
  }

  Color get _categoryColor {
    switch (widget.brand.category) {
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
    if (_showWebView) {
      return Scaffold(
        backgroundColor: AppColors.warmWhite,
        appBar: AppBar(
          backgroundColor: AppColors.warmWhite,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                color: AppColors.darkOlive, size: 20),
            onPressed: () => setState(() => _showWebView = false),
          ),
          title: Text(
            widget.brand.name,
            style: TextStyle(
              color: AppColors.darkOlive,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          centerTitle: true,
        ),
        body: WebViewWidget(controller: _webViewController),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.warmWhite,
      body: CustomScrollView(
        slivers: [
          // App bar with gradient
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppColors.warmWhite,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back_ios_new_rounded,
                    color: AppColors.darkOlive, size: 16),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _categoryColor.withValues(alpha: 0.25),
                      _categoryColor.withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 48),
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: _categoryColor.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _categoryColor.withValues(alpha: 0.3),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            widget.brand.name[0].toUpperCase(),
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w700,
                              color: _categoryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand name + category
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          widget.brand.name,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: AppColors.darkOlive,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: _categoryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.brand.category,
                          style: TextStyle(
                            fontSize: 12,
                            color: _categoryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Instagram handle
                  Row(
                    children: [
                      Icon(Icons.camera_alt_outlined,
                          size: 14,
                          color: AppColors.darkOlive.withValues(alpha: 0.45)),
                      const SizedBox(width: 6),
                      Text(
                        '@${widget.brand.instagramHandle}',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.darkOlive.withValues(alpha: 0.45),
                        ),
                      ),
                    ],
                  ),

                  if (widget.brand.isFeatured) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star_rounded,
                              size: 13, color: AppColors.secondary),
                          const SizedBox(width: 4),
                          Text(
                            'Featured Brand',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 32),

                  // Divider
                  Divider(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      thickness: 1),

                  const SizedBox(height: 32),

                  // Links section
                  Text(
                    'Find Us',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkOlive,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Instagram link
                  _LinkTile(
                    icon: Icons.camera_alt_outlined,
                    label: 'Instagram',
                    value: '@${widget.brand.instagramHandle}',
                    color: const Color(0xFFE1306C),
                    onTap: () {},
                  ),

                  const SizedBox(height: 12),

                  // Website link
                  _LinkTile(
                    icon: Icons.language_rounded,
                    label: 'Website',
                    value: widget.brand.websiteUrl
                        .replaceAll('https://', '')
                        .replaceAll('www.', ''),
                    color: AppColors.primary,
                    onTap: () => setState(() => _showWebView = true),
                  ),

                  const SizedBox(height: 40),

                  // Visit website button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () => setState(() => _showWebView = true),
                      icon: const Icon(Icons.shopping_bag_outlined,
                          color: Colors.white, size: 20),
                      label: const Text(
                        'Shop Now',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _categoryColor,
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
          ),
        ],
      ),
    );
  }
}

class _LinkTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final VoidCallback onTap;

  const _LinkTile({
    required this.icon,
    required this.label,
    required this.value,
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
            color: color.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.darkOlive.withValues(alpha: 0.45),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.darkOlive,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 14,
                color: AppColors.darkOlive.withValues(alpha: 0.3)),
          ],
        ),
      ),
    );
  }
}