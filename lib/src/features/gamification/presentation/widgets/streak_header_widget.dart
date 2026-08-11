import 'package:flutter/material.dart';
import '../../../../core/i18n/app_locale.dart';
import '../../../../core/i18n/font_resolver.dart';

class StreakHeaderWidget extends StatelessWidget {
  final int streakDays;
  final bool hasStreakFreeze;
  final RoshanaLocale currentLocale;

  const StreakHeaderWidget({
    super.key,
    required this.streakDays,
    required this.hasStreakFreeze,
    required this.currentLocale,
  });

  @override
  Widget build(BuildContext context) {
    final langCode = currentLocale.locale.languageCode;
    final isEn = langCode == 'en';
    final streakText = isEn ? '$streakDays Day Streak' : '$streakDays روز پیاپی';
    final freezeText = isEn ? 'Streak Freeze Active' : 'حفاظت زنجیره فعال است';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.local_fire_department_rounded,
                  color: Color(0xFFF59E0B),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    streakText,
                    style: RoshanaTypography.getTextStyle(
                      currentLocale: currentLocale,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  if (hasStreakFreeze)
                    Row(
                      children: [
                        const Icon(Icons.ac_unit_rounded, size: 12, color: Color(0xFF38BDF8)),
                        const SizedBox(width: 4),
                        Text(
                          freezeText,
                          style: RoshanaTypography.getTextStyle(
                            currentLocale: currentLocale,
                            fontSize: 11,
                            color: const Color(0xFF38BDF8),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF10B981), Color(0xFF059669)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              isEn ? 'PRO MEMBER' : 'عضو ویژه',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
