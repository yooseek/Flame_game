import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testtesttest/bloc/food_number_bloc/food_number_bloc.dart';
import 'package:testtesttest/bloc/friend_number_bloc/friend_number_bloc.dart';
import 'package:testtesttest/controller/button_controller.dart';
import 'package:testtesttest/view/flame_animation.dart';
import 'package:testtesttest/view/flame_game.dart';
import 'package:testtesttest/view/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider<FriendNumberBloc>(
                create: (context) => FriendNumberBloc()),
            BlocProvider<FoodNumberBloc>(
                create: (context) => FoodNumberBloc()),
          ],
          child: SplashScreen(),
        ),
      ),
    );
  }
}
