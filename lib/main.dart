import 'package:flutter/material.dart';
import 'package:gamestop/provider/provider_export.dart';
import 'package:gamestop/screens/game_screen/comment_screen/comment_screen.dart';
import 'package:gamestop/widgets/comments/comments_list_view.dart';
import 'package:gamestop/screens/game_screen/game_detail_screen/game_detail_screen.dart';
import 'package:gamestop/screens/game_screen/game_search_screen/game_search_screen.dart';
import 'package:gamestop/screens/screens.dart';
import 'package:gamestop/style/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Games(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Gamestop',
          debugShowCheckedModeBanner: false,
          theme: themeData,
          home: auth.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? Scaffold(
                              body: Center(
                              child: CircularProgressIndicator(),
                            ))
                          : AuthScreen(),
                ),
          routes: {
            GameDetailScreen.routeName: (ctx) => GameDetailScreen(),
          },
        ),
      ),
    );
  }
}
