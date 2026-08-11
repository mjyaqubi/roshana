import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../core/i18n/app_locale.dart';
import '../../../../core/i18n/font_resolver.dart';
import '../../../../core/i18n/locale_notifier.dart';
import '../../../library/presentation/notifiers/category_notifier.dart';
import '../../../library/presentation/pages/category_selection_page.dart';

class ProfilePage extends StatefulWidget {
  final RoshanaLocale currentLocale;

  const ProfilePage({
    super.key,
    required this.currentLocale,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final langCode = widget.currentLocale.locale.languageCode;
    final isEn = langCode == 'en';
    final localeNotifier = Provider.of<LocaleNotifier>(context);
    final categoryNotifier = Provider.of<CategoryNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEn ? 'User Profile' : 'پروفایل کاربری',
          style: RoshanaTypography.getTextStyle(
            currentLocale: widget.currentLocale,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            widget.currentLocale.direction == TextDirection.rtl
                ? Icons.arrow_forward_ios_rounded
                : Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // User Avatar & Name Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF1E293B),
                      const Color(0xFF0F172A).withValues(alpha: 0.9),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 84,
                          height: 84,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFF59E0B).withValues(alpha: 0.3),
                                blurRadius: 16,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'MJ',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xFF10B981),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check_rounded, color: Colors.white, size: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      isEn ? 'Mohammad Yaqubi' : 'محمد یاقوبی',
                      style: RoshanaTypography.getTextStyle(
                        currentLocale: widget.currentLocale,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'mjyaqubi@example.com',
                      style: TextStyle(color: Colors.white54, fontSize: 13),
                    ),
                    const SizedBox(height: 12),

                    // Subscription Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFF59E0B)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.workspace_premium_rounded, color: Color(0xFFF59E0B), size: 18),
                          const SizedBox(width: 6),
                          Text(
                            isEn ? 'Roshana Pro Member' : 'اشتراک ویژه روشنا (پرو)',
                            style: const TextStyle(
                              color: Color(0xFFF59E0B),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Gamification Stats Summary Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('7', isEn ? 'Day Streak' : 'روز پیاپی', Icons.local_fire_department_rounded, const Color(0xFFF59E0B)),
                    Container(width: 1, height: 36, color: Colors.white12),
                    _buildStatItem('1', isEn ? 'Freeze' : 'یخ‌ساز فعال', Icons.ac_unit_rounded, const Color(0xFF38BDF8)),
                    Container(width: 1, height: 36, color: Colors.white12),
                    _buildStatItem('2', isEn ? 'Completed' : 'کتاب کامل', Icons.verified_rounded, const Color(0xFF10B981)),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Settings & Preferences List
              _buildSectionTitle(isEn ? 'Preferences' : 'تنظیمات و ترجیحات'),

              // Language Selector Tile
              _buildTile(
                icon: Icons.language_rounded,
                iconColor: const Color(0xFF6366F1),
                title: isEn ? 'App Language' : 'زبان برنامه',
                subtitle: widget.currentLocale.label,
                onTap: () {
                  _showLanguageDialog(context, localeNotifier);
                },
              ),

              // Categories Tile
              _buildTile(
                icon: Icons.tune_rounded,
                iconColor: const Color(0xFFF59E0B),
                title: isEn ? 'Topics of Interest' : 'دسته‌بندی‌های مورد علاقه',
                subtitle: isEn
                    ? '${categoryNotifier.selectedCategoryIds.length} categories active'
                    : '${categoryNotifier.selectedCategoryIds.length} موضوع فعال',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CategorySelectionPage(currentLocale: widget.currentLocale),
                    ),
                  );
                },
              ),

              // Notification Switch Tile
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                ),
                child: SwitchListTile(
                  secondary: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.notifications_active_rounded, color: Color(0xFF10B981), size: 20),
                  ),
                  title: Text(
                    isEn ? 'Daily Reading Reminders' : 'یادآوری‌های روزانه مطالعه',
                    style: RoshanaTypography.getTextStyle(
                      currentLocale: widget.currentLocale,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    isEn ? '8:00 PM Notification' : 'ساعت ۲۰:۰۰ هر روز',
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                  value: _notificationsEnabled,
                  activeThumbColor: const Color(0xFFF59E0B),
                  onChanged: (val) {
                    setState(() {
                      _notificationsEnabled = val;
                    });
                  },
                ),
              ),

              const SizedBox(height: 12),
              _buildSectionTitle(isEn ? 'Account' : 'حساب کاربری'),

              // Sign Out Tile
              _buildTile(
                icon: Icons.logout_rounded,
                iconColor: const Color(0xFFEF4444),
                title: isEn ? 'Sign Out' : 'خروج از حساب کاربری',
                subtitle: isEn ? 'Logged in as mjyaqubi@example.com' : 'ورود با mjyaqubi@example.com',
                onTap: () {
                  HapticFeedback.mediumImpact();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isEn ? 'Signed out successfully' : 'با موفقیت خارج شدید'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String val, String label, IconData icon, Color color) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 4),
            Text(
              val,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.white54),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: widget.currentLocale.direction == TextDirection.rtl
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 4, right: 4),
        child: Text(
          title,
          style: RoshanaTypography.getTextStyle(
            currentLocale: widget.currentLocale,
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFF59E0B),
          ),
        ),
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: ListTile(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        title: Text(
          title,
          style: RoshanaTypography.getTextStyle(
            currentLocale: widget.currentLocale,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
        trailing: Icon(
          widget.currentLocale.direction == TextDirection.rtl
              ? Icons.arrow_back_ios_new_rounded
              : Icons.arrow_forward_ios_rounded,
          size: 14,
          color: Colors.white38,
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, LocaleNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: Text(
          'Select Language',
          style: RoshanaTypography.getTextStyle(
            currentLocale: widget.currentLocale,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('🇮🇷  فارسی (ایران)', style: TextStyle(color: Colors.white)),
              onTap: () {
                notifier.setLocale(RoshanaLocale.faIR);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('🇦🇫  فارسی دری (افغانستان)', style: TextStyle(color: Colors.white)),
              onTap: () {
                notifier.setLocale(RoshanaLocale.faAF);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('🇺🇸  English (US)', style: TextStyle(color: Colors.white)),
              onTap: () {
                notifier.setLocale(RoshanaLocale.enUS);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
