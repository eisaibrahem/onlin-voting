import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/shared/observer.dart';
import 'package:store_app/style/colors.dart';
import 'layout/voting_app/home_screen.dart';
import 'modules/voting_app/login/login_screen.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark  = false;
  Widget widget;

  var token  = CacheHelper.getData(key: 'token');
  if(token!=null) {
    widget=HomeScreen();
  } else {
    widget=LogIn();
  }

  runApp(MyApp(
    isDark:isDark,
    startWidget:  widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({
    required this.isDark,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'صوتك يهمنا',
      theme: ThemeData(
        textTheme: GoogleFonts.almaraiTextTheme(Theme.of(context).textTheme),
        primaryColor: kPrimaryColor,
        appBarTheme: const AppBarTheme(color: kPrimaryColor),
      ),
      // Arabic RTL

      home: Directionality(
          textDirection: TextDirection.rtl,
          child: LogIn()),
    );
  }
}







