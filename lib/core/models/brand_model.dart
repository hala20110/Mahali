class BrandModel {
  final String id;
  final String name;
  final String instagramHandle;
  final String websiteUrl;
  final String category;
  final bool isFeatured;

  const BrandModel({
    required this.id,
    required this.name,
    required this.instagramHandle,
    required this.websiteUrl,
    required this.category,
    this.isFeatured = false,
  });

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      instagramHandle: map['instagram'] ?? '',
      websiteUrl: map['website_url'] ?? '',
      category: map['category'] ?? '',
      isFeatured: map['is_featured'] ?? false,
    );
  }
}