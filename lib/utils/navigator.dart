import 'package:flutter/material.dart';

navigateReplace(context, Widget route, {isDialog = false}) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        fullscreenDialog: isDialog,
        builder: (context) => route,
      ),
    );

navigate(context, Widget route, {isDialog = false}) => Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: isDialog,
        builder: (context) => route,
      ),
    );

popToFirst(context) => Navigator.of(context).popUntil((route) => route.isFirst);

popView(context) => Navigator.pop(context);

navigateTransparentRoute(context, Widget route) {
  return Navigator.push(
    context,
    TransparentRoute(
      builder: (context) => route,
    ),
  );
}

class TransparentRoute extends PageRoute<void> {
  TransparentRoute({
    @required this.builder,
    RouteSettings settings,
  })  : assert(builder != null),
        super(settings: settings, fullscreenDialog: false);

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 350);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final result = builder(context);
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: result,
      ),
    );
  }
}
