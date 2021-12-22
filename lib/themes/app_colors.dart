import '../lib_exp.dart';

class AppColors {
  static const _brightness = Brightness.light;

  static MaterialColor get homePrimaryColor => const MaterialColor(
        0xff2c3e50,
        <int, Color>{
          50: Color(0xff2c3e50),
          100: Color(0xff2c3e50),
          200: Color(0xff2c3e50),
          300: Color(0xff2c3e50),
          400: Color(0xff2c3e50),
          500: Color(0xff2c3e50),
          600: Color(0xff2c3e50),
          700: Color(0xff2c3e50),
          800: Color(0xff2c3e50),
          900: Color(0xff2c3e50),
        },
      );

  static Color get primaryColor => _brightness == Brightness.light
      ? const Color(0xff2c3e50)
      : const Color(0xff2c3e50);
  // : const Color(0xff2356A5);

  static Color get alertColor => _brightness == Brightness.light
      ? const Color(0xff0c6aff)
      : const Color(0xff0c6aff);

  static Color get backgroundColor => _brightness == Brightness.light
      ? const Color(0xffFBFBFB)
      : const Color(0xffFBFBFB);

  static Color get commonInputBoxBorder => _brightness == Brightness.light
      ? const Color(0xffc7c7c7)
      : const Color(0xffc7c7c7);

  static Color get scaffoldBackgroundColor => _brightness == Brightness.light
      ? const Color(0xfff0f0f0)
      : const Color(0xfffcfcfc);

  static Color get textHintColor => _brightness == Brightness.light
      ? const Color(0xffb4b4b4)
      : const Color(0xffb4b4b4);

  static Color get transparentColor => _brightness == Brightness.light
      ? const Color(0xFF222932)
      : const Color(0xFF222932);

  static Color get greyBackgroundColor => _brightness == Brightness.light
      ? const Color(0xfff5f5f5)
      : const Color(0xfff5f5f5);

  static Color get appBarTextTitleColor => _brightness == Brightness.light
      ? const Color(0xff484848)
      : const Color(0xff484848);

  static Color get warningColor => _brightness == Brightness.light
      ? const Color(0xfff7af0b)
      : const Color(0xfff7af0b);

  static Color get successColor => _brightness == Brightness.light
      ? const Color(0xff42b40f)
      : const Color(0xff42b40f);

  static Color get errorColor => _brightness == Brightness.light
      ? const Color(0xffff0000)
      : const Color(0xffff0000);

  static Color get goldColor => _brightness == Brightness.light
      ? const Color(0xffffda05)
      : const Color(0xffffda05);

  static Color get silverColor => _brightness == Brightness.light
      ? const Color(0xffc2c2c2)
      : const Color(0xffc2c2c2);

  static Color get bronzeColor => _brightness == Brightness.light
      ? const Color(0xffcd7f32)
      : const Color(0xffcd7f32);
}
