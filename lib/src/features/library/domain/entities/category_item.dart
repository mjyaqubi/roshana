import 'package:flutter/material.dart';

class CategoryItem {
  final String id;
  final String nameEn;
  final String nameFa;
  final IconData icon;
  final bool isSelected;

  const CategoryItem({
    required this.id,
    required this.nameEn,
    required this.nameFa,
    required this.icon,
    this.isSelected = true,
  });

  CategoryItem copyWith({bool? isSelected}) {
    return CategoryItem(
      id: id,
      nameEn: nameEn,
      nameFa: nameFa,
      icon: icon,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  String getLocalizedName(String languageCode) {
    return languageCode == 'en' ? nameEn : nameFa;
  }
}
