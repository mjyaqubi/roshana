import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/category_item.dart';

class CategoryNotifier extends ChangeNotifier {
  static const String _prefKey = 'roshana_selected_category_ids';

  List<CategoryItem> _categories = [
    const CategoryItem(
      id: 'Self-Improvement',
      nameEn: 'Self-Improvement',
      nameFa: 'رشد و توسعه فردی',
      icon: Icons.trending_up_rounded,
      isSelected: true,
    ),
    const CategoryItem(
      id: 'Psychology',
      nameEn: 'Psychology',
      nameFa: 'روانشناسی و ذهن',
      icon: Icons.psychology_rounded,
      isSelected: true,
    ),
    const CategoryItem(
      id: 'Productivity',
      nameEn: 'Productivity',
      nameFa: 'بهره‌وری و تمرکز',
      icon: Icons.bolt_rounded,
      isSelected: true,
    ),
    const CategoryItem(
      id: 'Finance',
      nameEn: 'Finance & Wealth',
      nameFa: 'مدیریت مالی و ثروت',
      icon: Icons.attach_money_rounded,
      isSelected: false,
    ),
    const CategoryItem(
      id: 'History',
      nameEn: 'History & Culture',
      nameFa: 'تاریخ و جامعه‌شناسی',
      icon: Icons.menu_book_rounded,
      isSelected: false,
    ),
    const CategoryItem(
      id: 'Leadership',
      nameEn: 'Leadership & Business',
      nameFa: 'مدیریت و رهبری',
      icon: Icons.business_center_rounded,
      isSelected: false,
    ),
  ];

  List<CategoryItem> get categories => List.unmodifiable(_categories);

  List<String> get selectedCategoryIds =>
      _categories.where((c) => c.isSelected).map((c) => c.id).toList();

  CategoryNotifier() {
    _loadSavedCategories();
  }

  Future<void> _loadSavedCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIds = prefs.getStringList(_prefKey);
    if (savedIds != null && savedIds.isNotEmpty) {
      _categories = _categories.map((cat) {
        return cat.copyWith(isSelected: savedIds.contains(cat.id));
      }).toList();
      notifyListeners();
    }
  }

  void toggleCategory(String id) {
    _categories = _categories.map((cat) {
      if (cat.id == id) {
        return cat.copyWith(isSelected: !cat.isSelected);
      }
      return cat;
    }).toList();
    notifyListeners();
    _saveCategories();
  }

  Future<void> _saveCategories() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefKey, selectedCategoryIds);
  }
}
