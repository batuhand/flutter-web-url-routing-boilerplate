import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:webroutingtest/book_pag.dart';
import 'package:webroutingtest/login_page.dart';
import 'package:webroutingtest/main.dart';
import 'package:webroutingtest/model/login_data.dart';
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
          child: context.watch<LoginData>().mail == null
              ? const LoginPage()
              : const MyDataPage()),
      '/login': (route) => NoAnimationPage(
            child: const LoginPage(),
          ),
      '/book/:id': (route) => NoAnimationPage(
          child: BookPage(id: int.parse(route.pathParameters['id']!)))
    },
  );
}
