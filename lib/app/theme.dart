import 'package:flutter/material.dart';

enum ThemePreference {
  light,
  dark,
  system;

  String get label => switch (this) {
        ThemePreference.light => 'Light',
        ThemePreference.dark => 'Dark',
        ThemePreference.system => 'System default',
      };

  String get storageValue => name;

  static ThemePreference fromStorage(String? raw) {
    return ThemePreference.values.asNameMap()[raw] ?? ThemePreference.system;
  }

  ThemeMode get themeMode => switch (this) {
        ThemePreference.light => ThemeMode.light,
        ThemePreference.dark => ThemeMode.dark,
        ThemePreference.system => ThemeMode.system,
      };
}

@immutable
class FinzeePalette extends ThemeExtension<FinzeePalette> {
  const FinzeePalette({
    required this.primary,
    required this.primaryDark,
    required this.primarySoft,
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.income,
    required this.expense,
    required this.warning,
    required this.info,
    required this.savings,
    required this.investment,
  });

  final Color primary;
  final Color primaryDark;
  final Color primarySoft;
  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final Color income;
  final Color expense;
  final Color warning;
  final Color info;
  final Color savings;
  final Color investment;

  static const light = FinzeePalette(
    primary: Color(0xFF075C63),
    primaryDark: Color(0xFF043F45),
    primarySoft: Color(0xFFE2F5F2),
    background: Color(0xFFF7F8F8),
    surface: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF111827),
    textSecondary: Color(0xFF667085),
    border: Color(0xFFE5E7EB),
    income: Color(0xFF16B87A),
    expense: Color(0xFFF05D5E),
    warning: Color(0xFFF5A623),
    info: Color(0xFF4A8DFF),
    savings: Color(0xFF20B486),
    investment: Color(0xFF8B6CF6),
  );

  static const dark = FinzeePalette(
    primary: Color(0xFF3DB8C4),
    primaryDark: Color(0xFF7ADCE6),
    primarySoft: Color(0xFF163338),
    background: Color(0xFF0B1014),
    surface: Color(0xFF151B22),
    textPrimary: Color(0xFFF3F4F6),
    textSecondary: Color(0xFF9CA3AF),
    border: Color(0xFF2A3441),
    income: Color(0xFF34D399),
    expense: Color(0xFFF87171),
    warning: Color(0xFFFBBF24),
    info: Color(0xFF60A5FA),
    savings: Color(0xFF2DD4BF),
    investment: Color(0xFFA78BFA),
  );

  @override
  FinzeePalette copyWith({
    Color? primary,
    Color? primaryDark,
    Color? primarySoft,
    Color? background,
    Color? surface,
    Color? textPrimary,
    Color? textSecondary,
    Color? border,
    Color? income,
    Color? expense,
    Color? warning,
    Color? info,
    Color? savings,
    Color? investment,
  }) {
    return FinzeePalette(
      primary: primary ?? this.primary,
      primaryDark: primaryDark ?? this.primaryDark,
      primarySoft: primarySoft ?? this.primarySoft,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      border: border ?? this.border,
      income: income ?? this.income,
      expense: expense ?? this.expense,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      savings: savings ?? this.savings,
      investment: investment ?? this.investment,
    );
  }

  @override
  FinzeePalette lerp(ThemeExtension<FinzeePalette>? other, double t) {
    if (other is! FinzeePalette) return this;
    return FinzeePalette(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
      primarySoft: Color.lerp(primarySoft, other.primarySoft, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      border: Color.lerp(border, other.border, t)!,
      income: Color.lerp(income, other.income, t)!,
      expense: Color.lerp(expense, other.expense, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      savings: Color.lerp(savings, other.savings, t)!,
      investment: Color.lerp(investment, other.investment, t)!,
    );
  }
}

/// Backward-compatible static colors (light palette).
class FinzeeColors {
  static const primary = Color(0xFF075C63);
  static const primaryDark = Color(0xFF043F45);
  static const primarySoft = Color(0xFFE2F5F2);
  static const background = Color(0xFFF7F8F8);
  static const surface = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF667085);
  static const border = Color(0xFFE5E7EB);
  static const income = Color(0xFF16B87A);
  static const expense = Color(0xFFF05D5E);
  static const warning = Color(0xFFF5A623);
  static const info = Color(0xFF4A8DFF);
  static const savings = Color(0xFF20B486);
  static const investment = Color(0xFF8B6CF6);
}

extension FinzeeThemeContext on BuildContext {
  FinzeePalette get finzee =>
      Theme.of(this).extension<FinzeePalette>() ?? FinzeePalette.light;
}

ThemeData buildFinzeeTheme({Brightness brightness = Brightness.light}) {
  final palette = brightness == Brightness.dark ? FinzeePalette.dark : FinzeePalette.light;
  final text = TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: palette.textPrimary),
    headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: palette.textPrimary),
    headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: palette.textPrimary),
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: palette.textPrimary),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: palette.textPrimary),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: palette.textPrimary),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: palette.textSecondary),
  );

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: ColorScheme.fromSeed(
      seedColor: palette.primary,
      brightness: brightness,
      primary: palette.primary,
      surface: palette.surface,
    ),
    scaffoldBackgroundColor: palette.background,
    textTheme: text,
    extensions: [palette],
    appBarTheme: AppBarTheme(
      backgroundColor: palette.background,
      foregroundColor: palette.textPrimary,
      elevation: 0,
      centerTitle: false,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: palette.surface,
    ),
    cardTheme: CardThemeData(
      color: palette.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: palette.primaryDark,
        foregroundColor: brightness == Brightness.dark ? palette.background : Colors.white,
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: palette.primaryDark,
        side: BorderSide(color: palette.border),
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: palette.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: palette.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: palette.border),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: palette.surface,
      indicatorColor: palette.primarySoft,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(color: palette.primaryDark, fontWeight: FontWeight.w600);
        }
        return TextStyle(color: palette.textSecondary);
      }),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: palette.surface,
      selectedItemColor: palette.primaryDark,
      unselectedItemColor: palette.textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
  );
}

ThemeData buildFinzeeLightTheme() => buildFinzeeTheme(brightness: Brightness.light);

ThemeData buildFinzeeDarkTheme() => buildFinzeeTheme(brightness: Brightness.dark);

String formatRecordTimestamp(DateTime? value) {
  if (value == null) return '—';
  final local = value.toLocal();
  final y = local.year.toString().padLeft(4, '0');
  final m = local.month.toString().padLeft(2, '0');
  final d = local.day.toString().padLeft(2, '0');
  final h = local.hour.toString().padLeft(2, '0');
  final min = local.minute.toString().padLeft(2, '0');
  return '$y-$m-$d $h:$min';
}
