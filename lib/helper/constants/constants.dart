import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/setting/theme_provider.dart';

class AppColors {

 /// ================= PRIMARY =================

 static Color backgroundPrimary(BuildContext context) {
  final isDark = context.read<ThemeProvider>().isDark;
  return isDark ? const Color(0xFF062F1F) : Colors.white;
 }

 static const Color primaryLight = Color(0xFFEAF1FF);

 static Color primary(BuildContext context) {
  final isDark = context.read<ThemeProvider>().isDark;
  return isDark ? const Color(0xFF0B3D2A) : const Color(0xFFF5F7F6);
 }

 static Color primary2(BuildContext context) {
  final isDark = context.read<ThemeProvider>().isDark;
  return isDark ? const Color(0xFF0E4A32) : const Color(0xFFE5E7EB);
 }

 /// ================= BACKGROUNDS =================

 static Color scaffoldBackground(BuildContext context) {
  final isDark = context.read<ThemeProvider>().isDark;
  return isDark ? const Color(0xFF062F1F) : Colors.white;
 }

 static Color cardBackground(BuildContext context) {
  final isDark = context.read<ThemeProvider>().isDark;
  return isDark ? const Color(0xFF0B3D2A) : Colors.white;
 }

 /// ================= TEXT =================

 static Color textPrimary(BuildContext context) {
  final isDark = context.read<ThemeProvider>().isDark;
  return isDark ? Colors.white : const Color(0xFF111827); // أسود ناعم
 }

 static Color textSecondary(BuildContext context) {
  final isDark = context.read<ThemeProvider>().isDark;
  return isDark ? Colors.white70 : const Color(0xFF6B7280); // رمادي مرتب
 }

 static Color textHint(BuildContext context) {
  final isDark = context.read<ThemeProvider>().isDark;
  return isDark ? const Color(0xFF9DB6A5) : const Color(0xFF9CA3AF);
 }

 /// ================= BORDERS =================

 static Color border(BuildContext context) {
  final isDark = context.read<ThemeProvider>().isDark;
  return isDark ? const Color(0xFF1B5E3C) : const Color(0xFFE5E7EB);
 }

 static const Color divider = Color(0xFFEAEAEA);

 /// ================= BUTTONS =================

 static const Color buttonPrimary = Color(0xFF1ED760);
 static const Color buttonDisabled = Color(0xFFB3D1F7);

 /// ================= STATUS =================

 static const Color success = Color(0xFF2BB673);
 static const Color error = Color(0xFFE53935);
 static const Color warning = Color(0xFFFFA000);

 /// ================= ICONS =================

 static Color iconPrimary(BuildContext context) {
  return buttonPrimary; // ثابت في الحالتين
 }

 static Color iconSecondary(BuildContext context) {
  final isDark = context.read<ThemeProvider>().isDark;
  return isDark ? const Color(0xFF9E9E9E) : const Color(0xFF6B7280);
 }
}