import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_app/layout/voting_app/home_screen.dart';
import 'package:store_app/modules/voting_app/register/signup_screen.dart';
import 'package:store_app/shared/componants/componants.dart';
import 'package:store_app/shared/componants/image_piker.dart';
import 'package:store_app/style/colors.dart';
import 'cubit/voting_cubit.dart';
import 'cubit/voting_states.dart';

class LogIn extends StatelessWidget {
  var myEmail, myPassword;

  LogIn({Key? key}) : super(key: key);
  String? imageUrl;

  var formKey = GlobalKey<FormState>();
  var emilController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    signIn() async {
      var formData = formKey.currentState!;
      if (formData.validate()) {
        formData.save();

        try {
          UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: myEmail,
            password: myPassword,

          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
          AwesomeDialog(
            context: context,
            dialogType: DialogType.INFO,
            borderSide: const BorderSide(color: Colors.green, width: 5),
            width: 430,
            buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
            headerAnimationLoop: false,
            animType: AnimType.TOPSLIDE,
            title: ('نجحت عملية تسجيل الدخول'),
            desc: 'أضغط على اسم أو صورة المرشح لتتعرف عليه',
            //showCloseIcon: false,
            //btnCancelOnPress: () {},
            // btnOkOnPress: () {
            //
            //   Navigator.of(context).pop();
            // },
          ).show();
          return userCredential;
        } on FirebaseAuthException catch (e) {
          print(e.toString());
          if (e.code == 'user-not-found') {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.WARNING,
              borderSide: const BorderSide(color: Colors.yellow, width: 5),
              width: 430,
              buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
              headerAnimationLoop: false,
              animType: AnimType.TOPSLIDE,
              title: 'Warning',
              desc: 'هذا الاميل غير مسجل',
              showCloseIcon: false,
              // btnCancelOnPress: () {},
              btnOkOnPress: () {

              },
            ).show();

          } else if (e.code == 'wrong-password') {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.WARNING,
              borderSide: const BorderSide(color: Colors.yellow, width: 5),
              width: 430,
              buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
              headerAnimationLoop: false,
              animType: AnimType.TOPSLIDE,
              title: 'Warning',
              desc: 'الرقم القومى غير صحيح',
              showCloseIcon: false,
              // btnCancelOnPress: () {},
              btnOkOnPress: () {

              },
            ).show();
          }
        }
      } else {
        print('not valid');
      }
    }

    return BlocProvider(
        create: (BuildContext context) => VotingLoginCubit(),
        child: BlocConsumer<VotingLoginCubit, VotingLoginStates>(
          listener: (BuildContext context, state) {
            if (state is VotingLoginSuccessState) {
              if (state.loginModel.status == true) {
                print(state.loginModel.data!.token);
                print(state.loginModel.message);

                navigateAndFinish(context, HomeScreen());
              } else {
                print(state.loginModel.message);

                Fluttertoast.showToast(
                  msg: '${state.loginModel.message}',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.red,
                  fontSize: 16,
                );
              }
            }
          },
          builder: (BuildContext context, Object? state) {
            return Scaffold(
              body: Container(
                width: double.infinity,
                decoration: BoxDecoration(gradient: kMyGradient),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            "تسجيل الدخول",
                            style: TextStyle(fontSize: 40),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "صوتك يهمنا ",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: kBackgroundColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  Center(child: const Text('اضغط على الكاميرا لتأكيد الشخصية')),

                                  ImagePiker(),
                                  // Stack(
                                  //   children: [
                                  //     GestureDetector(
                                  //       onTap: () {},
                                  //       child: Container(
                                  //         height: 150,
                                  //         width: 150,
                                  //         decoration: BoxDecoration(
                                  //             borderRadius: BorderRadius.circular(100),
                                  //             image: DecorationImage(
                                  //                 image: imageUI == null ? Image.asset("images/face.gif").image : Image.file(imageUI!, fit: BoxFit.cover,).image)),
                                  //       ),
                                  //     ),
                                  //     Positioned(
                                  //       bottom: 5,
                                  //       right: 5,
                                  //       child: Container(
                                  //         child: IconButton(
                                  //           icon: Icon(Icons.camera_alt_outlined),
                                  //           onPressed: () {
                                  //             getImage(ImageSource.camera);
                                  //           },
                                  //         ),
                                  //         width: 40,
                                  //         height: 40,
                                  //         decoration: BoxDecoration(
                                  //             color: Colors.white, borderRadius: BorderRadius.circular(100)),
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),

                                  const SizedBox(
                                    height: 25,
                                  ),

//enter Email
                                  defaultFormField(
                                    onSave: (val) {
                                      myEmail = val;
                                    },
                                      controller: emilController,
                                      label: 'الاميل',
                                      onSubmit: (value) {
                                        if (formKey.currentState!.validate()) {
                                          VotingLoginCubit.get(context)
                                              .userLogin(
                                              email: emilController.text,
                                              password: passwordController.text,
                                          );
                                        }
                                      },
                                      prefix: Icons.email,
                                      type: TextInputType.emailAddress,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return "لو سمحت ادخل الاميل";
                                        }
                                      },
                                    ),

//enter password
                                  const SizedBox(
                                    height: 20,
                                  ),

 //pass
                                  defaultFormField(
                                    onSave: (val) {
                                      myPassword = val;
                                    },
                                      maxLength: 14,
                                      isPassword: false,
                                      controller: passwordController,
                                      label: 'الرقم القومى',
                                      onSubmit: (value) {
                                        if (formKey.currentState!.validate()) {
                                          VotingLoginCubit.get(context)
                                              .userLogin(
                                                  email: emilController.text,
                                                  password: passwordController.text,
                                          );
                                        }
                                      },
                                      prefix: Icons.credit_card_outlined,
                                      type: TextInputType.number,

                                      validate:  (val) {
                                        if (val!.length > 14) {
                                          return ("تأكد من ادخال الرفم القومى بشكل صحيح");
                                        }
                                        if (val.length < 14) {
                                          return ("تأكد من ادخال الرفم القومى بشكل صحيح");
                                        }
                                        return null;
                                      },
                                    ),


//Text button navigator to signUp page
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "اذا لم تقم بالتسجبل ",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            primary: Colors.cyan,
                                            textStyle:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignUp()),
                                            );
                                          },
                                          child: const Text(
                                            "اضغط هنا.",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ]),

                                  const SizedBox(
                                    height: 40,
                                  ),
// Sign in as guest

                                  // ElevatedButton(
                                  //   onPressed: () async {
                                  //     Navigator.push(
                                  //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
                                  //   },
                                  //   child: const Text('guest'),
                                  // ),

//Sign in Email and password
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 130,
                                    height: 60,
                                    child: ConditionalBuilder(
                                      condition:
                                          state is! VotingLoginLoadingState,
                                      builder: (context) {
                                        return defaultButton(
                                            function: () {
                                              var formData = formKey.currentState!;
                                              if(formData.validate()) {
                                                signIn();
                                                VotingLoginCubit.get(context)
                                                    .userLogin(
                                                  email:
                                                  emilController.text,
                                                  password:
                                                  passwordController.text,
                                                );
                                              }else {
                                                print('not valid');
                                              }

                                            },
                                            text: 'تسجيل الدخول',
                                            isUpperCase: true,
                                            context: context);
                                      },
                                      fallback: (BuildContext context) {
                                        return const Center(
                                            child:
                                                const CircularProgressIndicator());
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }






  File? imageUI;
 String baseimage='ggggggggg';
  final ImagePicker _imagePicker = ImagePicker();
  Future getImage(ImageSource src) async {
    final image = await _imagePicker.pickImage(source: src);
    if (image == null)return;
    final file = File(image.path);
    print(image.path);
    print(file);
    if (file == null)return;
   baseimage=base64Encode(file.readAsBytesSync());
    print(baseimage);
    String imageName=file.path.split("/").last;
    print("Image name : "+imageName);

    var url="http://192.168.1.3/api/login";
    var data={"image":base64};
 //   var response = await http.post(Uri.parse(url),body:data);
  }




}
