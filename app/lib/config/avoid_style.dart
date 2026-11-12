import 'package:flutter/material.dart';

/// Flat, near-black visual style: square corners, 1px borders,
/// outlined buttons and a single configurable accent color.
class AvoidPalette {
  AvoidPalette._();

  static const Color defaultAccent = Color.fromARGB(255, 224, 89, 186);
  static const Color formBorder = Color.fromARGB(255, 30, 30, 30);
  static const Color window = Color.fromARGB(255, 10, 10, 10);
  static const Color header = Color.fromARGB(255, 14, 14, 14);
  static const Color surface = Color.fromARGB(255, 18, 18, 18);
  static const Color surfaceHover = Color.fromARGB(255, 24, 24, 24);
  static const Color surfacePressed = Color.fromARGB(255, 28, 28, 28);
  static const Color border = Color.fromARGB(255, 45, 45, 45);
  static const Color divider = Color.fromARGB(255, 32, 32, 32);
  static const Color textPrimary = Color.fromARGB(255, 220, 220, 220);
  static const Color textMuted = Color.fromARGB(255, 150, 150, 150);
  static const Color textDim = Color.fromARGB(255, 108, 108, 108);
  static const Color error = Color.fromARGB(255, 229, 72, 77);
}

/// Marker added to [ThemeData.extensions] by [buildAvoidTheme], so widgets can tell
/// whether the flat style is active (see [isAvoidStyle]).
class AvoidStyleMarker extends ThemeExtension<AvoidStyleMarker> {
  const AvoidStyleMarker();

  @override
  AvoidStyleMarker copyWith() => this;

  @override
  AvoidStyleMarker lerp(ThemeExtension<AvoidStyleMarker>? other, double t) => this;
}

bool isAvoidStyle(BuildContext context) => Theme.of(context).extension<AvoidStyleMarker>() != null;

/// Control height used for buttons and fields.
const double avoidControlHeight = 35;

/// Colors derived from the accent color.
class AvoidAccent {
  final Color accent;

  const AvoidAccent(this.accent);

  Color get hover => _blend(accent, Colors.white, 0.20);

  Color get softHover => _blend(accent, Colors.white, 0.10);

  Color get hoverBackdrop => _blend(Colors.black, accent, 0.08);

  Color get pressedBackdrop => _blend(Colors.black, accent, 0.12);

  Color get selectionBackdrop => _blend(Colors.black, accent, 0.16);

  static Color _blend(Color base, Color mix, double amount) {
    final a = amount.clamp(0.0, 1.0);
    final b = 1.0 - a;
    return Color.fromARGB(
      255,
      ((base.r * 255) * b + (mix.r * 255) * a).round(),
      ((base.g * 255) * b + (mix.g * 255) * a).round(),
      ((base.b * 255) * b + (mix.b * 255) * a).round(),
    );
  }
}

const _square = RoundedRectangleBorder();

ThemeData buildAvoidTheme({
  required Color accent,
  String? fontFamily,
}) {
  final a = AvoidAccent(accent);

  final colorScheme = ColorScheme.dark(
    primary: accent,
    onPrimary: AvoidPalette.window,
    primaryContainer: a.selectionBackdrop,
    onPrimaryContainer: a.hover,
    secondary: accent,
    onSecondary: AvoidPalette.window,
    secondaryContainer: AvoidPalette.surface,
    onSecondaryContainer: AvoidPalette.textPrimary,
    tertiary: accent,
    onTertiary: AvoidPalette.window,
    error: AvoidPalette.error,
    onError: Colors.white,
    surface: AvoidPalette.window,
    onSurface: AvoidPalette.textPrimary,
    onSurfaceVariant: AvoidPalette.textMuted,
    surfaceContainerLowest: AvoidPalette.window,
    surfaceContainerLow: AvoidPalette.header,
    surfaceContainer: AvoidPalette.surface,
    surfaceContainerHigh: AvoidPalette.surfaceHover,
    surfaceContainerHighest: AvoidPalette.surfacePressed,
    outline: AvoidPalette.border,
    outlineVariant: AvoidPalette.divider,
    surfaceTint: Colors.transparent,
  );

  OutlineInputBorder inputBorder(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.zero,
    borderSide: BorderSide(color: color),
  );

  bool isDisabled(Set<WidgetState> s) => s.contains(WidgetState.disabled);

  bool isHot(Set<WidgetState> s) => s.contains(WidgetState.hovered) || s.contains(WidgetState.focused);

  // Accent outline on near-black, used for ElevatedButton / FilledButton.
  final primaryButton = ButtonStyle(
    elevation: const WidgetStatePropertyAll(0),
    shadowColor: const WidgetStatePropertyAll(Colors.transparent),
    surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
    shape: const WidgetStatePropertyAll(_square),
    padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16, vertical: 0)),
    minimumSize: const WidgetStatePropertyAll(Size(0, avoidControlHeight)),
    textStyle: const WidgetStatePropertyAll(TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.4)),
    foregroundColor: WidgetStateProperty.resolveWith((s) => isDisabled(s) ? AvoidPalette.textDim : accent),
    backgroundColor: WidgetStateProperty.resolveWith((s) {
      if (isDisabled(s)) return AvoidPalette.window;
      if (s.contains(WidgetState.pressed)) return a.pressedBackdrop;
      if (isHot(s)) return a.hoverBackdrop;
      return AvoidPalette.window;
    }),
    side: WidgetStateProperty.resolveWith(
      (s) => BorderSide(color: isDisabled(s) ? AvoidPalette.border : accent),
    ),
  );

  // Grey outline on dark surface, used for OutlinedButton.
  final secondaryButton = ButtonStyle(
    elevation: const WidgetStatePropertyAll(0),
    shadowColor: const WidgetStatePropertyAll(Colors.transparent),
    surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
    shape: const WidgetStatePropertyAll(_square),
    padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16, vertical: 0)),
    minimumSize: const WidgetStatePropertyAll(Size(0, avoidControlHeight)),
    foregroundColor: WidgetStateProperty.resolveWith((s) {
      if (isDisabled(s)) return AvoidPalette.textDim;
      return isHot(s) ? AvoidPalette.textPrimary : AvoidPalette.textMuted;
    }),
    backgroundColor: WidgetStateProperty.resolveWith((s) {
      if (isDisabled(s)) return AvoidPalette.surface;
      if (s.contains(WidgetState.pressed)) return AvoidPalette.surfacePressed;
      if (isHot(s)) return AvoidPalette.surfaceHover;
      return AvoidPalette.surface;
    }),
    side: const WidgetStatePropertyAll(BorderSide(color: AvoidPalette.border)),
  );

  final flatButton = ButtonStyle(
    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
    shape: const WidgetStatePropertyAll(_square),
    padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
    foregroundColor: WidgetStateProperty.resolveWith((s) => isDisabled(s) ? AvoidPalette.textDim : accent),
    backgroundColor: WidgetStateProperty.resolveWith((s) {
      if (s.contains(WidgetState.pressed)) return a.pressedBackdrop;
      if (isHot(s)) return a.hoverBackdrop;
      return Colors.transparent;
    }),
  );

  final base = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: colorScheme,
    // same density on all platforms so desktop matches mobile (defaults to compact on desktop)
    visualDensity: VisualDensity.standard,
    fontFamily: fontFamily,
    scaffoldBackgroundColor: AvoidPalette.window,
    canvasColor: AvoidPalette.window,
    cardColor: AvoidPalette.surface,
    dividerColor: AvoidPalette.divider,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    hoverColor: a.hoverBackdrop,
    appBarTheme: const AppBarTheme(
      backgroundColor: AvoidPalette.header,
      foregroundColor: AvoidPalette.textPrimary,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    cardTheme: const CardThemeData(
      color: AvoidPalette.surface,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(side: BorderSide(color: AvoidPalette.border)),
    ),
    dialogTheme: const DialogThemeData(
      backgroundColor: AvoidPalette.window,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(side: BorderSide(color: AvoidPalette.border)),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AvoidPalette.window,
      modalBackgroundColor: AvoidPalette.window,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(side: BorderSide(color: AvoidPalette.border)),
    ),
    popupMenuTheme: const PopupMenuThemeData(
      color: AvoidPalette.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(side: BorderSide(color: AvoidPalette.border)),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AvoidPalette.surface,
      contentTextStyle: const TextStyle(color: AvoidPalette.textPrimary),
      actionTextColor: accent,
      shape: const RoundedRectangleBorder(side: BorderSide(color: AvoidPalette.border)),
    ),
    tooltipTheme: const TooltipThemeData(
      decoration: BoxDecoration(
        color: AvoidPalette.surface,
        border: Border.fromBorderSide(BorderSide(color: AvoidPalette.border)),
      ),
      textStyle: TextStyle(color: AvoidPalette.textPrimary, fontSize: 12),
    ),
    dividerTheme: const DividerThemeData(color: AvoidPalette.divider, thickness: 1, space: 1),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AvoidPalette.surface,
      border: inputBorder(AvoidPalette.border),
      enabledBorder: inputBorder(AvoidPalette.border),
      focusedBorder: inputBorder(accent),
      errorBorder: inputBorder(AvoidPalette.error),
      focusedErrorBorder: inputBorder(AvoidPalette.error),
      hintStyle: const TextStyle(color: AvoidPalette.textDim),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: primaryButton),
    filledButtonTheme: FilledButtonThemeData(style: primaryButton),
    outlinedButtonTheme: OutlinedButtonThemeData(style: secondaryButton),
    textButtonTheme: TextButtonThemeData(style: flatButton),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        shape: const WidgetStatePropertyAll(_square),
        foregroundColor: WidgetStateProperty.resolveWith((s) {
          if (isDisabled(s)) return AvoidPalette.textDim;
          return isHot(s) ? accent : AvoidPalette.textMuted;
        }),
      ),
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: AvoidPalette.header,
      indicatorColor: a.selectionBackdrop,
      indicatorShape: _square,
      selectedIconTheme: IconThemeData(color: accent),
      unselectedIconTheme: const IconThemeData(color: AvoidPalette.textMuted),
      selectedLabelTextStyle: TextStyle(color: accent),
      unselectedLabelTextStyle: const TextStyle(color: AvoidPalette.textMuted),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AvoidPalette.header,
      surfaceTintColor: Colors.transparent,
      indicatorColor: a.selectionBackdrop,
      indicatorShape: _square,
      iconTheme: WidgetStateProperty.resolveWith(
        (s) => IconThemeData(color: s.contains(WidgetState.selected) ? accent : AvoidPalette.textMuted),
      ),
      labelTextStyle: WidgetStateProperty.resolveWith(
        (s) => TextStyle(
          fontSize: 12,
          color: s.contains(WidgetState.selected) ? accent : AvoidPalette.textMuted,
        ),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? accent : AvoidPalette.textMuted,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? a.selectionBackdrop : AvoidPalette.surface,
      ),
      trackOutlineColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? accent : AvoidPalette.border,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: _square,
      checkColor: const WidgetStatePropertyAll(AvoidPalette.window),
      fillColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? accent : Colors.transparent,
      ),
      side: const BorderSide(color: AvoidPalette.textDim, width: 1.5),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? accent : AvoidPalette.textDim,
      ),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: accent,
      inactiveTrackColor: AvoidPalette.border,
      thumbColor: accent,
      overlayColor: accent.withValues(alpha: 0.12),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: accent),
    scrollbarTheme: ScrollbarThemeData(
      thickness: const WidgetStatePropertyAll(6),
      radius: const Radius.circular(3),
      thumbColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.dragged)
            ? a.hover
            : s.contains(WidgetState.hovered)
            ? a.softHover
            : accent,
      ),
    ),
    listTileTheme: ListTileThemeData(
      shape: _square,
      selectedColor: accent,
      iconColor: AvoidPalette.textMuted,
    ),
    chipTheme: ChipThemeData(
      shape: _square,
      backgroundColor: AvoidPalette.surface,
      selectedColor: a.selectionBackdrop,
      side: const BorderSide(color: AvoidPalette.border),
      labelStyle: const TextStyle(color: AvoidPalette.textPrimary),
    ),
  );

  // Smaller text (the reference style uses Segoe UI 9pt, about 12px)
  return base.copyWith(
    extensions: const [AvoidStyleMarker()],
    textTheme: base.textTheme.apply(
      bodyColor: AvoidPalette.textPrimary,
      displayColor: AvoidPalette.textPrimary,
      fontSizeFactor: 0.88,
    ),
  );
}
