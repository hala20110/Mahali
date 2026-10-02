import 'package:flutter/material.dart';
import '../models/brand_model.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<BrandModel> _savedBrands = [];

  List<BrandModel> get savedBrands => List.unmodifiable(_savedBrands);

  bool isSaved(String brandId) =>
      _savedBrands.any((b) => b.id == brandId);

  void toggle(BrandModel brand) {
    if (isSaved(brand.id)) {
      _savedBrands.removeWhere((b) => b.id == brand.id);
    } else {
      _savedBrands.add(brand);
    }
    notifyListeners();
  }
}