import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/models/voting_app/login_model.dart';
import 'package:store_app/modules/voting_app/register/cubit/states.dart';
import 'package:store_app/network/endpoints.dart';
import 'package:store_app/network/remote/dio_helper.dart';


class VotingRegisterCubit extends Cubit<VotingRegisterStates> {
  VotingRegisterCubit() : super(VotingRegisterInitialState());

  static VotingRegisterCubit get(context) => BlocProvider.of(context);
  VotingLoginModel? loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
     String? image,
  }) {
    emit(VotingRegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      data: {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "image": 'img',
      },
    ).then((value) {
      loginModel = VotingLoginModel.fromJson(value.data);
      print('ffffffffffffffffffffffffffffffff');
      print(loginModel?.data?.id);
      print('ffffffffffffffffffffffffffffffff');
      print(loginModel?.status);
      print(loginModel?.message);
      emit(VotingRegisterSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(VotingRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(VotingRegisterChangePasswordVisibilityState());
  }
}
