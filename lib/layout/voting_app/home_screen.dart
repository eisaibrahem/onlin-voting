import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:store_app/shared/componants/home_body.dart';
import 'package:store_app/style/colors.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('تم-------------------------------');
  }
  Future MyAwesomeDeyalog() async {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      borderSide: const BorderSide(color: Colors.yellow, width: 5),
      width: 430,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      // title: ('تحذير'),
      desc: 'هل انتهبت من عملية التسجيل',
      showCloseIcon: false,
      btnCancelOnPress: () {},
      // btnOkOnPress: () {
      //
      //   Navigator.of(context).pop();
      // },
    ).show();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          showModalBottomSheet<void>(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Text('حدد الشخص الذى تراه مناسبا للمنصب'),
                    Text('اضغط على الاسم لتعرف المزيد'),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.announcement,
          size: 25,
          color: Colors.white,
        ),
      ),
      drawer: Drawer(
        elevation: 0,
        child: Scaffold(
          appBar: AppBar(),
          body: ListView(
            children: [
              ListTile(
                onTap: () {
                  const snackBar = SnackBar(content: Text('عيسى ابراهيم'));

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                trailing: const Text("اسم العميل "),
                leading: const Icon(Icons.face_rounded),
              ),
              ListTile(
                onTap: () {
                  const snackBar = SnackBar(content: Text('العاشر من رمضان'));

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                trailing: const Text("عنوان العميل "),
                leading: const Icon(Icons.house),
              ),
              ListTile(
                onTap: () {
                  const snackBar = SnackBar(content: Text('01023726497'));

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                trailing: const Text("رقم تليفون العميل "),
                leading: const Icon(Icons.phone_android),
              ),
              ListTile(
                onTap: () {
                  const snackBar = SnackBar(content: Text('الاعدادات'));

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                trailing: const Text(" الاعدادات "),
                leading: const Icon(Icons.settings),
              ),
              ListTile(
                onTap: () {
                  const snackBar = SnackBar(content: Text('حول التطبيق'));

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                trailing: const Text(" حول التطبيق "),
                leading: const Icon(Icons.info_outline),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: kPrimaryColor,
      appBar: homeAppBar(),
      body: HomeBody(),
    );
  }
  AppBar homeAppBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        'صوتك يهمنا',
        style: GoogleFonts.getFont('Almarai',
            fontWeight: FontWeight.bold, fontSize: 30),
      ),
      centerTitle: false,
    );
  }
}
