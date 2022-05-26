import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:webroutingtest/book_pag.dart';
import 'package:webroutingtest/login_page.dart';
import 'package:webroutingtest/main.dart';
import 'package:webroutingtest/no_animation_page.dart';
import 'package:webroutingtest/page_scaffold.dart';

RouteMap buildRouteMap(BuildContext context) {
  return RouteMap(
    onUnknownRoute: (path) {
      return NoAnimationPage(
        child: PageScaffold(
          title: 'Page not found',
          body: Center(
            child: Text(
              "Couldn't find page '$path'",
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
      );
    },
    routes: {
      '/': (route) => NoAnimationPage(
              child: MyHomePage(
            title: 'Test',
          )),
      '/login': (route) => NoAnimationPage(
            child: LoginPage(),
          ),
      '/book/:id': (route) => NoAnimationPage(
          child: BookPage(id: int.parse(route.pathParameters['id']!)))
    },
  );
}
