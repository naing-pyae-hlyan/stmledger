import '../lib_exp.dart';

extension AnimationUtils on Widget {
  AnimatedSwitcher get fadeTrans {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: this,
    );
  }


  AnimatedSwitcher get scaleTrans {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: this,
    );
  }
}
