
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_app/models/voting_app/login_model.dart';
import 'package:store_app/modules/voting_app/login/cubit/voting_states.dart';
import 'package:store_app/network/endpoints.dart';
import 'package:store_app/network/remote/dio_helper.dart';

class VotingLoginCubit extends Cubit<VotingLoginStates> {
  VotingLoginCubit() : super(VotingLoginInitialState());

  static VotingLoginCubit get(context) => BlocProvider.of(context);
  VotingLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
     String? image ,
  }) {
    emit(VotingLoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data: {
        "email": email,
        "password": password,
        "image": 'img',

      },
    ).then((value) {
      loginModel = VotingLoginModel.fromJson(value.data);

      print('ffffffffffffffffffffffffffffffff');
      print(loginModel?.data?.image);
      print('ffffffffffffffffffffffffffffffff');
      print(loginModel?.status);
      print(loginModel?.message);
      emit(VotingLoginSuccessState(loginModel!));
    }).catchError((error) {
      print('ffffffffffffffffffffffffffffffff');
      print(error.toString());
      emit(VotingLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(VotingChangePasswordVisibilityState());
  }












}
