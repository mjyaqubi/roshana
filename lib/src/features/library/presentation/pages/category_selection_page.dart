import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../core/i18n/app_locale.dart';
import '../../../../core/i18n/font_resolver.dart';
import '../notifiers/category_notifier.dart';

class CategorySelectionPage extends StatelessWidget {
  final RoshanaLocale currentLocale;

  const CategorySelectionPage({
    super.key,
    required this.currentLocale,
  });

  @override
  Widget build(BuildContext context) {
    final langCode = currentLocale.locale.languageCode;
    final isEn = langCode == 'en';
    final categoryNotifier = Provider.of<CategoryNotifier>(context);
    final categories = categoryNotifier.categories;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEn ? 'Categories of Interest' : 'دسته‌بندی‌های مورد علاقه',
          style: RoshanaTypography.getTextStyle(
            currentLocale: currentLocale,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            currentLocale.direction == TextDirection.rtl
                ? Icons.arrow_forward_ios_rounded
                : Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top Header Explanation Card
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.tune_rounded, color: Color(0xFFF59E0B), size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isEn ? 'Personalize Your Summary Feed' : 'شخصی‌سازی خلاصه کتاب‌ها',
                          style: RoshanaTypography.getTextStyle(
                            currentLocale: currentLocale,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          isEn
                              ? 'Select the topics you want to prioritize in your daily micro-learning feed.'
                              : 'دسته‌بندی‌های دلخواه خود را برای نمایش در بخش اختصاصی انتخاب کنید.',
                          style: RoshanaTypography.getTextStyle(
                            currentLocale: currentLocale,
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Grid of Categories
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.35,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isSelected = cat.isSelected;

                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      categoryNotifier.toggleCategory(cat.id);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFF59E0B).withValues(alpha: 0.15)
                            : const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isSelected ? const Color(0xFFF59E0B) : Colors.white12,
                          width: isSelected ? 2.0 : 1.0,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ]
                            : [],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                cat.icon,
                                color: isSelected ? const Color(0xFFF59E0B) : Colors.white54,
                                size: 28,
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? const Color(0xFFF59E0B)
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFFF59E0B)
                                        : Colors.white38,
                                  ),
                                ),
                                child: isSelected
                                    ? const Icon(Icons.check_rounded, color: Colors.black, size: 14)
                                    : null,
                              ),
                            ],
                          ),
                          Text(
                            cat.getLocalizedName(langCode),
                            style: RoshanaTypography.getTextStyle(
                              currentLocale: currentLocale,
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected ? Colors.white : Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Confirm & Save Action Button
            Container(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF59E0B),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    isEn ? 'Save & Apply Preferences' : 'تایید و بروزرسانی',
                    style: RoshanaTypography.getTextStyle(
                      currentLocale: currentLocale,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
