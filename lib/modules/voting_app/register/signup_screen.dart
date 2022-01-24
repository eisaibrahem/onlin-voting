import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:store_app/modules/voting_app/login/login_screen.dart';
import 'package:store_app/shared/componants/componants.dart';
import 'package:store_app/shared/componants/image_piker.dart';
import 'package:store_app/style/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String _verificationCode;

  final FocusNode _pinPutFocusNode = FocusNode();

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: kBackgroundColor,
    borderRadius: BorderRadius.circular(5.0),
    border: Border.all(
      color: Colors.blueGrey,
    ),
  );

  var formKey = GlobalKey<FormState>();

  var emilController = TextEditingController();

  var nameController = TextEditingController();

  var passwordController = TextEditingController();

  var phoneController = TextEditingController();

  var username, address, personID, phone, pin;

  @override
  Widget build(
    BuildContext context,
  ) {

    _verifyPhone() async {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+20${phoneController.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
            if (value.user != null) {

              AlertDialog(
                title: const Text('تم التسجيل بنجاح'),
                scrollable: true,
                actions: [
                  ElevatedButton(
                      onPressed: () {

                        Navigator.of(context).pop();
                      },
                      child: const Text('حسنا'))
                ],
              );
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          AlertDialog(
            title: Text('${e.message}'),
            scrollable: true,
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('ok'))
            ],
          );
          print(e.message);
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID!;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: const Duration(seconds: 120),
      );
    }

    signUp() async {
      var formData = formKey.currentState!;
      if (formData.validate()) {
        formData.save();
        try {
          UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: address,
            password: personID,
          );
        }
        on FirebaseAuthException catch (e) {
          if (e.code == 'weak-personID') {
            AwesomeDialog(
                    context: context,
                    title: "خطأ",
                    desc: ('خطأ فى الرقم القومى'))
                .show();
          } else if (e.code == 'Email-already-in-use') {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.WARNING,
              borderSide: const BorderSide(color: Colors.yellow, width: 5),
              width: 430,
              buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
              headerAnimationLoop: false,
              animType: AnimType.TOPSLIDE,
              title: 'Warning',
              desc: 'تم تسجيل هذا الشخص من قبل',
              showCloseIcon: false,
              // btnCancelOnPress: () {},
              btnOkOnPress: () {},
            ).show();
          }
        } catch (e) {
          print(e);
        }
      } else {
        print('not valid');
        return null;
      }
    }

    return BlocProvider(
        create: (BuildContext context) => VotingRegisterCubit(),
        child: BlocConsumer<VotingRegisterCubit, VotingRegisterStates>(
          listener: (context, state) {
            if (state is VotingRegisterSuccessState) {
              if (state.loginModel.status == true) {
                print(state.loginModel.message);

                showToast(text: 'success', state: ToastStates.SUCCESS);
              } else {
                print(state.loginModel.message);
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Container(
                width: double.infinity,
                decoration: BoxDecoration(gradient: kMyGradient),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            "تسجيل بيانات المنتخب",
                            style: TextStyle(fontSize: 30),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "ادخل البيانات من البطاقة الشخصية",
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
                          padding: EdgeInsets.all(30),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                    child:  Text('اضغط على الكاميرا للتقاط الصوره')),
                                const Center(
                                  child: ImagePiker(),

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
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                defaultFormField(
                                  controller: nameController,
                                  label: 'الاسم',
                                  prefix: Icons.person,
                                  type: TextInputType.name,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return "لو سمحت ادخل اسمك";
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                defaultFormField(
                                  onSave: (val) {
                                    personID = val;
                                  },
                                  controller: emilController,
                                  label: 'الاميل',
                                  prefix: Icons.email,
                                  type: TextInputType.emailAddress,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return "لوسمحت ادخل الاميل الشخصى";
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                defaultFormField(
                                  onSave: (val) {
                                    personID = val;
                                  },
                                  maxLength: 14,
                                  isPassword: false,
                                  controller: passwordController,
                                  label: 'الرقم القومى',
                                  onSubmit: (value) {
                                    if (formKey.currentState!.validate()) {}
                                  },
                                  prefix: Icons.credit_card,
                                  type: TextInputType.number,
                                  validate: (val) {
                                    if (val!.length > 14) {
                                      return ("تأكد من ادخال الرفم القومى بشكل صحيح");
                                    }
                                    if (val.length < 14) {
                                      return ("تأكد من ادخال الرفم القومى بشكل صحيح");
                                    }
                                    return null;
                                  },

                                ),
                                const SizedBox(
                                  height: 20,
                                ),

//enter phone num
                                TextFormField(
                                  maxLength: 12,
                                  onSaved: (val) {
                                    phone = val;
                                  },
                                  validator: (val) {
                                    if (val!.length > 12) {
                                      return ("هذا الرقم غير صحيح");
                                    }
                                    if (val.length < 10) {
                                      return ("لابد من ادخال رقم هاتف صحيح");
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.phone,
                                  obscureText: false,
                                  onFieldSubmitted: (value) {
                                    if (formKey.currentState!.validate()) {}
                                  },
                                  controller: phoneController,
                                  decoration: const InputDecoration(
                                    // hintText: 'رقم الهاتف',
                                    labelText: 'رقم الهاتف',
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Text('+20'),
                                    ),
                                    suffixIcon: Icon(
                                      Icons.phone,
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                ),

                                //Enter verification code
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: PinPut(
                                    enableSuggestions: true,
                                    withCursor: true,
                                    cursorColor: Colors.black,
                                    textStyle: const TextStyle(fontSize: 25.0, color: Colors.black),
                                    fieldsCount: 6,
                                    eachFieldWidth: 40.0,
                                    eachFieldHeight: 55.0,
                                    focusNode: _pinPutFocusNode,
                                    submittedFieldDecoration: pinPutDecoration,
                                    selectedFieldDecoration: pinPutDecoration,
                                    followingFieldDecoration: pinPutDecoration,
                                    pinAnimationType: PinAnimationType.fade,
                                    onSubmit: (pin) async {
                                      try {
                                        await FirebaseAuth.instance.signInWithCredential(
                                                PhoneAuthProvider.credential(
                                                    verificationId: _verificationCode,
                                                    smsCode: pin
                                                )
                                        ).then((value) async {
                                          if (value.user != null) {
                                            if (signUp() != null) {
                                              AwesomeDialog(
                                                dismissOnTouchOutside: false,
                                                context: context,
                                                dialogType: DialogType.SUCCES,
                                                borderSide: const BorderSide(
                                                    color: Colors.green,
                                                    width: 5),
                                                width: 430,
                                                buttonsBorderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(2)),
                                                headerAnimationLoop: false,
                                                animType: AnimType.TOPSLIDE,
                                                desc:
                                                    'تم تأكيد كود التحقق و تم التسجيل',
                                                showCloseIcon: false,
                                                // btnCancelOnPress: () {}
                                                btnOkOnPress: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LogIn()));
                                                },
                                              ).show();
                                            } else {
                                              AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.WARNING,
                                                borderSide: const BorderSide(
                                                    color: Colors.yellow,
                                                    width: 5),
                                                width: 430,
                                                buttonsBorderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(2)),
                                                headerAnimationLoop: false,
                                                animType: AnimType.TOPSLIDE,
                                                desc:
                                                    'تأكد من ادخال كل البيانات',
                                                showCloseIcon: false,
                                                btnCancelOnPress: () {},
                                                // btnOkOnPress: () {
                                                //
                                                //   Navigator.of(context).pop();
                                                // },
                                              ).show();
                                            }
                                          }
                                        });
                                      } catch (e) {
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.ERROR,
                                          borderSide: const BorderSide(
                                              color: Colors.redAccent,
                                              width: 5),
                                          width: 430,
                                          buttonsBorderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(2)),
                                          headerAnimationLoop: false,
                                          animType: AnimType.TOPSLIDE,
                                          desc: 'الكود غير صحيح',
                                          showCloseIcon: false,
                                          btnCancelOnPress: () {},
                                          // btnOkOnPress: () {
                                          //
                                          //   Navigator.of(context).pop();
                                          // },
                                        ).show();
                                      }
                                    },
                                  ),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "لتصلك رسالة التأكيد",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          primary: Colors.cyan,
                                          textStyle:
                                          const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          var formData = formKey.currentState!;
                                          if (formData.validate()) {
                                            formData.save();
                                            _verifyPhone();
                                            VotingRegisterCubit.get(context).userRegister(
                                              name: nameController.text,
                                              email: emilController.text,
                                              password: passwordController.text,
                                              phone: phoneController.text,
                                            );


                                          } else {
                                            print('not valid');
                                          }
                                        },
                                        child: const Text(" اضغط هنا"),
                                      ),

                                    ]

                                ),

                                const SizedBox(
                                  height: 30,
                                ),


                              ],
                            ),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            );
          },
        ));
  }

  File? imageUI;
  var baseImageSignup;
  final ImagePicker _imagePicker = ImagePicker();

  Future getImage(ImageSource src) async {
    final image = await _imagePicker.pickImage(source: src);
    if (image == null) return;
    final file = File(image.path);
    print(image.path);
    if (file == null) return;

    setState(() {
      baseImageSignup = base64Encode(file.readAsBytesSync()).toString();
    });

    print(baseImageSignup);

    // String imageName=file.path.split("/").last;
    // print("Image name : "+imageName);

    // var url="http://192.168.1.3/api/login";
    // var data={"image":base64};
    //   var response = await http.post(Uri.parse(url),body:data);
  }
}
