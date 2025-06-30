import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff895100),
      surfaceTint: Color(0xff895100),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffac4b),
      onPrimaryContainer: Color(0xff482900),
      secondary: Color(0xff7f5627),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffcf9f),
      onSecondaryContainer: Color(0xff5d390c),
      tertiary: Color(0xff546431),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffb5c78a),
      onTertiaryContainer: Color(0xff283608),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfffff8f4),
      onSurface: Color(0xff221a12),
      onSurfaceVariant: Color(0xff544434),
      outline: Color(0xff877462),
      outlineVariant: Color(0xffdac2ae),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382f25),
      inversePrimary: Color(0xffffb86b),
      primaryFixed: Color(0xffffdcbc),
      onPrimaryFixed: Color(0xff2c1700),
      primaryFixedDim: Color(0xffffb86b),
      onPrimaryFixedVariant: Color(0xff683d00),
      secondaryFixed: Color(0xffffdcbc),
      onSecondaryFixed: Color(0xff2c1700),
      secondaryFixedDim: Color(0xfff3bc84),
      onSecondaryFixedVariant: Color(0xff643f11),
      tertiaryFixed: Color(0xffd7eaaa),
      onTertiaryFixed: Color(0xff141f00),
      tertiaryFixedDim: Color(0xffbbce90),
      onTertiaryFixedVariant: Color(0xff3d4c1c),
      surfaceDim: Color(0xffe8d7ca),
      surfaceBright: Color(0xfffff8f4),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e7),
      surfaceContainer: Color(0xfffcebdd),
      surfaceContainerHigh: Color(0xfff6e5d7),
      surfaceContainerHighest: Color(0xfff0e0d2),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff623900),
      surfaceTint: Color(0xff895100),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffa86500),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff5f3b0d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff986b3a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff394818),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6a7b45),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f4),
      onSurface: Color(0xff221a12),
      onSurfaceVariant: Color(0xff504030),
      outline: Color(0xff6e5c4b),
      outlineVariant: Color(0xff8b7765),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382f25),
      inversePrimary: Color(0xffffb86b),
      primaryFixed: Color(0xffa86500),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff864f00),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff986b3a),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff7c5325),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6a7b45),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff52622f),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe8d7ca),
      surfaceBright: Color(0xfffff8f4),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e7),
      surfaceContainer: Color(0xfffcebdd),
      surfaceContainerHigh: Color(0xfff6e5d7),
      surfaceContainerHighest: Color(0xfff0e0d2),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff351c00),
      surfaceTint: Color(0xff895100),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff623900),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff351c00),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5f3b0d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff1a2600),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff394818),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f4),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff2f2114),
      outline: Color(0xff504030),
      outlineVariant: Color(0xff504030),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382f25),
      inversePrimary: Color(0xffffe8d4),
      primaryFixed: Color(0xff623900),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff442600),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff5f3b0d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff442600),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff394818),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff243104),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe8d7ca),
      surfaceBright: Color(0xfffff8f4),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e7),
      surfaceContainer: Color(0xfffcebdd),
      surfaceContainerHigh: Color(0xfff6e5d7),
      surfaceContainerHighest: Color(0xfff0e0d2),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffcfa0),
      surfaceTint: Color(0xffffb86b),
      onPrimary: Color(0xff492900),
      primaryContainer: Color(0xfff89913),
      onPrimaryContainer: Color(0xff371e00),
      secondary: Color(0xfff3bc84),
      onSecondary: Color(0xff492900),
      secondaryContainer: Color(0xff593608),
      onSecondaryContainer: Color(0xffffc78e),
      tertiary: Color(0xffcee0a1),
      onTertiary: Color(0xff273507),
      tertiaryContainer: Color(0xffa5b77b),
      onTertiaryContainer: Color(0xff1c2900),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff1a120a),
      onSurface: Color(0xfff0e0d2),
      onSurfaceVariant: Color(0xffdac2ae),
      outline: Color(0xffa28d7a),
      outlineVariant: Color(0xff544434),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff0e0d2),
      inversePrimary: Color(0xff895100),
      primaryFixed: Color(0xffffdcbc),
      onPrimaryFixed: Color(0xff2c1700),
      primaryFixedDim: Color(0xffffb86b),
      onPrimaryFixedVariant: Color(0xff683d00),
      secondaryFixed: Color(0xffffdcbc),
      onSecondaryFixed: Color(0xff2c1700),
      secondaryFixedDim: Color(0xfff3bc84),
      onSecondaryFixedVariant: Color(0xff643f11),
      tertiaryFixed: Color(0xffd7eaaa),
      onTertiaryFixed: Color(0xff141f00),
      tertiaryFixedDim: Color(0xffbbce90),
      onTertiaryFixedVariant: Color(0xff3d4c1c),
      surfaceDim: Color(0xff1a120a),
      surfaceBright: Color(0xff41372e),
      surfaceContainerLowest: Color(0xff140d06),
      surfaceContainerLow: Color(0xff221a12),
      surfaceContainer: Color(0xff271e16),
      surfaceContainerHigh: Color(0xff32281f),
      surfaceContainerHighest: Color(0xff3d332a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffcfa0),
      surfaceTint: Color(0xffffb86b),
      onPrimary: Color(0xff351d00),
      primaryContainer: Color(0xfff89913),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff7c087),
      onSecondary: Color(0xff241200),
      secondaryContainer: Color(0xffb88753),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffcee0a1),
      onTertiary: Color(0xff1b2700),
      tertiaryContainer: Color(0xffa5b77b),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1a120a),
      onSurface: Color(0xfffffaf8),
      onSurfaceVariant: Color(0xffdec7b2),
      outline: Color(0xffb59f8c),
      outlineVariant: Color(0xff93806d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff0e0d2),
      inversePrimary: Color(0xff6a3e00),
      primaryFixed: Color(0xffffdcbc),
      onPrimaryFixed: Color(0xff1d0d00),
      primaryFixedDim: Color(0xffffb86b),
      onPrimaryFixedVariant: Color(0xff512e00),
      secondaryFixed: Color(0xffffdcbc),
      onSecondaryFixed: Color(0xff1d0d00),
      secondaryFixedDim: Color(0xfff3bc84),
      onSecondaryFixedVariant: Color(0xff502e02),
      tertiaryFixed: Color(0xffd7eaaa),
      onTertiaryFixed: Color(0xff0c1400),
      tertiaryFixedDim: Color(0xffbbce90),
      onTertiaryFixedVariant: Color(0xff2d3b0c),
      surfaceDim: Color(0xff1a120a),
      surfaceBright: Color(0xff41372e),
      surfaceContainerLowest: Color(0xff140d06),
      surfaceContainerLow: Color(0xff221a12),
      surfaceContainer: Color(0xff271e16),
      surfaceContainerHigh: Color(0xff32281f),
      surfaceContainerHighest: Color(0xff3d332a),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffffaf8),
      surfaceTint: Color(0xffffb86b),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffbe79),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffffaf8),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xfff7c087),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff6ffd9),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffc0d294),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1a120a),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffffaf8),
      outline: Color(0xffdec7b2),
      outlineVariant: Color(0xffdec7b2),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff0e0d2),
      inversePrimary: Color(0xff402300),
      primaryFixed: Color(0xffffe2c7),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffbe79),
      onPrimaryFixedVariant: Color(0xff241200),
      secondaryFixed: Color(0xffffe2c7),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xfff7c087),
      onSecondaryFixedVariant: Color(0xff241200),
      tertiaryFixed: Color(0xffdceeae),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc0d294),
      onTertiaryFixedVariant: Color(0xff101900),
      surfaceDim: Color(0xff1a120a),
      surfaceBright: Color(0xff41372e),
      surfaceContainerLowest: Color(0xff140d06),
      surfaceContainerLow: Color(0xff221a12),
      surfaceContainer: Color(0xff271e16),
      surfaceContainerHigh: Color(0xff32281f),
      surfaceContainerHighest: Color(0xff3d332a),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
