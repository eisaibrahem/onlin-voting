import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/network/local/cache_helper.dart';
import 'package:store_app/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({ bool? fromShared}){
    if(fromShared !=null) {
      isDark=fromShared;
      return  emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value){
        return   emit(AppChangeModeState());
      });
    }
    print('$isDark ');
  }

}
