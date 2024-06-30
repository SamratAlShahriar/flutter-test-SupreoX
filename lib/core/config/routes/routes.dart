import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterfoody/features/cart/presentation/page/cart_page.dart';

abstract class AppRouter {
  static const String launcherPage = 'launcher';
  static const String cartPage = 'cart-page';

  static final Map<String, Widget Function(BuildContext)> routes = {

  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case cartPage:
        return getRoute(page: const CartPage(), transition: fadeInTransition);

      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(
                    child: Text('ERROR'),
                  ),
                ));
    }
  }

  static Widget fadeInTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    // const begin = Offset(0.0, 1.0);
    // const end = Offset.zero;
    // const curve = Curves.ease;

    //var tween = FadeT(begin: begin, end: end).chain(CurveTween(curve: curve));

    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  static Widget scaleAndSlideTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    const begin = Offset(-0.2, -0.2);
    const end = Offset.zero;
    const curve = Curves.easeOut;

    var offsetTween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var scaleTween =
        Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(offsetTween),
      child: ScaleTransition(
        scale: animation.drive(scaleTween),
        child: child,
      ),
    );
  }

  static Widget scaleTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  }

  static Widget slideFromBottomTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.linear;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  static Widget slideFromRightTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  static Widget slideFromRightWithFadeInTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var offsetTween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var opacityTween =
        Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(offsetTween),
      child: FadeTransition(
        opacity: animation.drive(opacityTween),
        child: child,
      ),
    );
  }

  static Route<dynamic> getRoute(
          {required Widget page,
          required Widget Function(
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child)
              transition,
          bool? opaque,
          Duration? enterAnimDuration,
          Duration? reverseAnimDuration}) =>
      PageRouteBuilder(
          opaque: opaque ?? true,
          transitionDuration:
              enterAnimDuration ?? const Duration(milliseconds: 300),
          reverseTransitionDuration:
              reverseAnimDuration ?? const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: transition);

  AppRouter._();
}
