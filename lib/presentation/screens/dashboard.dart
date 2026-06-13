import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:myFevTempV1/data/constant/app_color.dart';
import 'package:myFevTempV1/data/constant/app_text_style.dart';
import 'package:myFevTempV1/presentation/bloc/language/language_cubit.dart';
import 'package:myFevTempV1/presentation/bloc/theme/theme_cubit.dart';
import 'package:myFevTempV1/presentation/localization/app_localizations.dart';
import 'package:myFevTempV1/presentation/widgets/log_out_dialogue.dart';
import 'package:myFevTempV1/presentation/widgets/data_activity.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          _buildHomeScreen(context, isDark),
          _buildAttendanceScreen(context, isDark),
          _buildCalendarScreen(context, isDark),
          _buildProfileScreen(context, isDark),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: AppColor.primaryColor,
        unselectedItemColor: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(LucideIcons.house, size: 26),
            label: context.translate("home"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(LucideIcons.history, size: 26),
            label: context.translate("attendance"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(LucideIcons.tickets_plane, size: 26),
            label: context.translate("calendar"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(LucideIcons.circle_user, size: 26),
            label: context.translate("profile"),
          ),
        ],
      ),
    );
  }

  // --- HOME TAB VIEW ---
  Widget _buildHomeScreen(BuildContext context, bool isDark) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate("home")),
        actions: [
          IconButton(
            icon: Icon(isDark ? LucideIcons.sun : LucideIcons.moon),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Premium Greeting Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.primaryColor,
                      AppColor.primaryColor.withValues(alpha: 0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.primaryColor.withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.translate("welcome_back"),
                      style: context.title.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.translate("dashboard_info"),
                      style: context.label.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Activity section title
              Text(
                context.translate("active_logs"),
                style: context.title,
              ),
              const SizedBox(height: 16),
              // Data activity stub
              DataActivity.emptyData(
                context,
                title: context.translate("active_logs"),
                subtitle: context.translate("dashboard_info"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- ATTENDANCE TAB VIEW ---
  Widget _buildAttendanceScreen(BuildContext context, bool isDark) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate("attendance")),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DataActivity.emptyData(
                context,
                title: context.translate("attendance_history"),
                subtitle: context.translate("dashboard_info"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- CALENDAR TAB VIEW ---
  Widget _buildCalendarScreen(BuildContext context, bool isDark) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate("calendar")),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DataActivity.emptyData(
                context,
                title: context.translate("calendar_schedule"),
                subtitle: context.translate("dashboard_info"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- PROFILE / SETTINGS TAB VIEW ---
  Widget _buildProfileScreen(BuildContext context, bool isDark) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate("profile")),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile Info card
              _buildUserProfileCard(context, isDark),
              const SizedBox(height: 24),

              // Language selector card
              _buildLanguageSelectorCard(context, isDark),
              const SizedBox(height: 24),

              // Theme settings card
              _buildThemeSelectorCard(context, isDark),
              const SizedBox(height: 24),

              // Logout button card
              _buildLogoutCard(context, isDark),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfileCard(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColor.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColor.darkBorder : AppColor.lightBorder,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: AppColor.primaryColor.withValues(alpha: 0.15),
            child: Text(
              "JD",
              style: context.title.copyWith(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "John Doe",
                  style: context.title.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  "john.doe@example.com",
                  style: context.sublabel.copyWith(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelectorCard(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColor.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColor.darkBorder : AppColor.lightBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.languages, color: AppColor.primaryColor, size: 22),
              const SizedBox(width: 10),
              Text(
                context.translate("language_setting"),
                style: context.subtitle.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          BlocBuilder<LanguageCubit, Locale>(
            builder: (context, currentLocale) {
              final languageCodes = ['en', 'hi', 'es'];
              final languageLabels = [
                '🇺🇸 ${context.translate("english")}',
                '🇮🇳 ${context.translate("hindi")}',
                '🇪🇸 ${context.translate("spanish")}'
              ];

              return Row(
                children: List.generate(languageCodes.length, (index) {
                  final code = languageCodes[index];
                  final label = languageLabels[index];
                  final isSelected = currentLocale.languageCode == code;

                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 0 : 6,
                        right: index == languageCodes.length - 1 ? 0 : 6,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          context.read<LanguageCubit>().changeLanguage(code);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColor.primaryColor.withValues(alpha: 0.12)
                                : (isDark ? AppColor.darkBackground : AppColor.lightBackground),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? AppColor.primaryColor
                                  : Colors.transparent,
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              label,
                              style: context.label.copyWith(
                                color: isSelected
                                    ? AppColor.primaryColor
                                    : (isDark ? Colors.white70 : Colors.black87),
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSelectorCard(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColor.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColor.darkBorder : AppColor.lightBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.palette, color: AppColor.primaryColor, size: 22),
              const SizedBox(width: 10),
              Text(
                context.translate("theme_mode"),
                style: context.subtitle.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, currentThemeMode) {
              final modes = [ThemeMode.light, ThemeMode.dark, ThemeMode.system];
              final modeKeys = ["light_mode", "dark_mode", "system_mode"];
              final modeIcons = [LucideIcons.sun, LucideIcons.moon, LucideIcons.laptop];

              return Row(
                children: List.generate(modes.length, (index) {
                  final mode = modes[index];
                  final labelKey = modeKeys[index];
                  final icon = modeIcons[index];
                  final isSelected = currentThemeMode == mode;

                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 0 : 6,
                        right: index == modes.length - 1 ? 0 : 6,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          context.read<ThemeCubit>().updateTheme(mode);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColor.primaryColor.withValues(alpha: 0.12)
                                : (isDark ? AppColor.darkBackground : AppColor.lightBackground),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? AppColor.primaryColor
                                  : Colors.transparent,
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                icon,
                                size: 18,
                                color: isSelected
                                    ? AppColor.primaryColor
                                    : (isDark ? Colors.white70 : Colors.black87),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                context.translate(labelKey),
                                style: context.label.copyWith(
                                  color: isSelected
                                      ? AppColor.primaryColor
                                      : (isDark ? Colors.white70 : Colors.black87),
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutCard(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColor.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColor.darkBorder : AppColor.lightBorder,
        ),
      ),
      child: InkWell(
        onTap: () {
          LogOutDialogue.dialogue(context);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(LucideIcons.log_out, color: Colors.red, size: 20),
              const SizedBox(width: 8),
              Text(
                context.translate("logout"),
                style: context.subtitle.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
