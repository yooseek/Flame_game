import 'package:easy_localization/easy_localization.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testtesttest/bloc/Logger.dart';
import 'package:testtesttest/bloc/food_number_bloc/food_number_bloc.dart';
import 'package:testtesttest/bloc/friend_number_bloc/friend_number_bloc.dart';
import 'package:testtesttest/bloc/george_position_bloc/george_position_bloc.dart';
import 'package:testtesttest/bloc/noti_overlay_bloc/noti_overlay_bloc.dart';
import 'package:testtesttest/view/splash_screen.dart';

// 앱에서 지원하는 언어 리스트 변수
final supportedLocales = [const Locale('en', 'US'), const Locale('ko', 'KR')];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();
  Flame.device.fullScreen();
  Bloc.observer = Logger();
  // runApp(EasyLocalization(
  //   supportedLocales: supportedLocales,
  //   //path: 언어 파일 경로
  //   path: 'assets/translations',
  //   //fallbackLocale supportedLocales에 설정한 언어가 없는 경우 설정되는 언어
  //   fallbackLocale: const Locale('en', 'US'),
  //
  //   //startLocale을 지정하면 초기 언어가 설정한 언어로 변경됨
  //   //만일 이 설정을 하지 않으면 OS 언어를 따라 기본 언어가 설정됨
  //   startLocale: const Locale('ko', 'KR'),
  //   child: const MyApp()
  // ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 기본적으로 필요한 언어 설정
      // localizationsDelegates: context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      // locale: context.locale,

      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider<FriendNumberBloc>(
                create: (context) => FriendNumberBloc()),
            BlocProvider<FoodNumberBloc>(create: (context) => FoodNumberBloc()),
            BlocProvider<GeorgePositionBloc>(create: (context) => GeorgePositionBloc()),
            BlocProvider<NotiOverlayBloc>(create: (context) => NotiOverlayBloc()),
          ],
          child: SplashScreen(),
        ),
      ),
    );
  }
}
