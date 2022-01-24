import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flip_card/flip_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:store_app/modules/voting_app/login/login_screen.dart';
import 'package:store_app/shared/voters/Rania.dart';
import 'package:store_app/shared/voters/talaat.dart';
import 'package:store_app/style/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import 'componants.dart';

class HomeBody extends StatefulWidget {
  const   HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  Color Rania=Colors.black;
  bool  boolRania = false;
  bool  boolTalat = false;
  Color Talat=Colors.black;
  int id=0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      bottom: false,
      child: Container(
          margin: const EdgeInsets.only(top: 10.0),
          decoration: const BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Container(
           // color: Colors.black,
            height: MediaQuery.of(context).size.height,
            width: double.infinity,

                  child: ListView(
                    children:  [
         //rania
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 5,top: 10),
                        child: FlipCard(
                          direction: FlipDirection.HORIZONTAL, // default
                          front: Material(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(24.0),
                            shadowColor: const Color(0x802196F3).withOpacity(0.2),
                            child: _nameDetailsContainerRania(),
                          ),
                          back: Material(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(24.0),
                            shadowColor: const Color(0x802196F3),
                            child: _socialContainerRania(),
                          ),
                        ),
                      ),
          //talat
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 5,top: 10),
                        child: FlipCard(
                          direction: FlipDirection.HORIZONTAL, // default
                          front: Material(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(24.0),
                            shadowColor: const Color(0x802196F3).withOpacity(0.2),
                            child: _nameDetailsContainer(),
                          ),
                          back: Material(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(24.0),
                            shadowColor: const Color(0x802196F3),
                            child: _socialContainer(),
                          ),
                        ),
                      ),

                        const SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.only(left: 100,right: 100),
                        child: Container(
                          width: 130,
                          height: 60,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                              ),
                              onPressed: (){
                                AwesomeDialog(
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
                                  btnOkOnPress: () {

                                    navigateAndFinish(context, LogIn());
                                    vote(id);
                                    print("$id");
                                  },
                                ).show();

                              },
                              child: const Text("انتهيت",style: TextStyle(
                                fontSize: 25
                              ),))
                          ,
                        ),
                      )

                    ],
                  ),
                ),


          )


    );
  }

  Widget _socialContainerRania() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 80.0,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ListTile(
                  leading: Container(
                      width: 80.0,
                      height: 60.0,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.scaleDown,
                            image: NetworkImage(
                                "http://www.hti.edu.eg/images/academics/large/202.jpg?960578402"),
                          )
                      )
                  ),
                  title: const Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text('نبذة مختصرة عن المرشح', style: TextStyle(

                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: kTextColor
                    )),
                  ),

                ),
              ),
            ],),
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),

          Container(
            child: _detailsContainerRania(),
          ),
        ],
      ),
    );
  }

  Widget _nameDetailsContainerRania() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 100.0,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 2.0),

                child: ListTile(
                  leading: Container(
                      width:60.0,
                      height: 60.0,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image:  NetworkImage(
                                "http://www.hti.edu.eg/images/academics/large/202.jpg?960578402"),
                          )
                      )
                  ),
                  title: const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text('د.رانيا رجب حسين', style: TextStyle(

                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: kTextColor
                    )),
                  ),
                  subtitle: const Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: Text('المرشح الاول', style: TextStyle(color: kTextColor,
                      fontSize: 20.0,
                    ),),
                  ),
                ),
              ),
            ],),
            decoration: BoxDecoration(
              color:kSecondaryColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
          // تحديد الاختيار
          Container(
            height: 80,

            child: InkWell(
              child: Row(
                children: [
                  Text('أعطى صوتى',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: kTextColor),),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: 30,
                      height: 30,
                      color: Talat,

                    ),
                  ),
                ],

              ),

              onTap: (){

                id=12;
                boolTalat=true;
                boolRania=false;

                Talat=Colors.green;
                Rania=Colors.black;

                setState(() {

                });
              },
            )



          )
        ],
      ),
    );
  }

  Widget _detailsContainerRania() {
    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 5.0, left: 2.0, right: 2.0),
          child: Text("""   ماجستير في نظم دعم القرار من جامعة القاهرة عنوان الرسالة "Optimizing Buffers' Sizes in Critical Chain Project Management: A Simulation-Optimization Approach" ، والمشرف عليها الأستاذ هشام محمد بكالوريوس العلوم. في نظم دعم القرار من جامعة القاهرة ، كلية الحاسبات والمعلومات بتقدير جيد جداً مع مرتبة الشرف. للمزيد اضغط على الرابط""",
            style: TextStyle(
              color: Color(0xff000000),
              fontSize: 16.0,
            ),),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2.0, left: 2.0, right: 2.0),
          child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(child: const Icon(
                      FontAwesomeIcons.envelope, color: kSecondaryColor)),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Container(
                      child: TextButton(
                        child: const Text('raniaragab1010@hotmail.com',style: TextStyle(fontSize: 20),),
                        onPressed: (){
                          if ( canLaunch('http://www.hti.edu.eg/ar/staff-member.aspx?id=202&departmentID=1015') != null) {
                            launch('http://www.hti.edu.eg/ar/staff-member.aspx?id=202&departmentID=1015');
                          } else {
                            print ("Could not launch  raniaragab1010@hotmail.com");
                          }


                        },
                      ),
                    ),
                  ),
                ],)
          ),
        ),
      ],);
  }

  Widget _socialContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 80.0,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListTile(
                leading: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "http://www.hti.edu.eg/images/academics/large/315.jpg?626116033"),
                        )
                    )
                ),
                title: const Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text('نبذة مختصرة عن المرشح', style: TextStyle(

                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: kTextColor
                  )),
                ),

              ),
            ),
          ],),
          decoration: BoxDecoration(
            color: kSecondaryColor.withOpacity(0.9),
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),

        Container(
          child: _detailsContainer(),
        ),
      ],
    );
  }

  Widget _nameDetailsContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 100.0,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 2.0),

              child: ListTile(
                leading: Container(
                    width:60.0,
                    height: 60.0,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:  NetworkImage(
                              "http://www.hti.edu.eg/images/academics/large/315.jpg?626116033"),
                        )
                    )
                ),
                title: const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text('د. طلعت عبد اللطيف ', style: TextStyle(

                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: kTextColor
                  )),
                ),
                subtitle: const Padding(
                  padding: EdgeInsets.only(top: 0.0),
                  child: Text('المرشح الثانى', style: TextStyle(color: kTextColor,
                    fontSize: 20.0,
                  ),),
                ),
              ),
            ),
          ],),
          decoration: BoxDecoration(
            color:kSecondaryColor.withOpacity(0.9),
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
        // تحديد الاختيار
        Container(
          height: 80,

          child: InkWell(
            child: Row(
              children: [
                Text('أعطى صوتى',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: kTextColor),),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 30,
                      width: 30,
                      color: Rania,
                    ),
                  ),

              ],
    ),
            onTap: (){

              setState(() {
                id=11;
                boolRania=true;
                boolTalat=false;

                Rania=Colors.green;
                Talat=Colors.black;
              });
            },
          ),



        )
      ],
    );
  }

  Widget _detailsContainer() {
    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 5.0, left: 2.0, right: 2.0),
          child: Text("""   30 عامًا في مجالات أمن الاتصالات والاتصالات بما في ذلك: صيانة أجهزة الراديو والكومسيك. تخطيط أنظمة الاتصالات الحديثة الآمنة. تحليل أنظمة التشفير وتقييم مستوى الأمان. تصميم وتنفيذ أنظمة التشفير لتأمين أنظمة الاتصالات . ترقية أنظمة التشفير الحالية لزيادة مستوى الأمان الخاص بها.  للمزيد اضغط على الرابط""",
            style: TextStyle(
              color: Color(0xff000000),
              fontSize: 16.0,
            ),),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2.0, left: 2.0, right: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Icon(
                  FontAwesomeIcons.envelope, color: kSecondaryColor),
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: TextButton(
                  child: const Text('talaat.elgarf@hti.edu.eg',style: TextStyle(fontSize: 20),),
                  onPressed: (){
                    if ( canLaunch('http://www.hti.edu.eg/ar/staff-member.aspx?id=315&departmentID=1007') != null) {
                      launch('http://www.hti.edu.eg/ar/staff-member.aspx?id=315&departmentID=1007');
                    } else {
                      print ("Could not launch  talaat.elgarf@hti.edu.eg");
                    }


                  },
                ),
              ),
            ],),
        ),
      ],);
  }
  Future<bool> vote(int id) async {
    final response = await http
        .post(Uri.parse("http://192.168.1.2:80/polls/apiChoice/$id/vote/"));
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      final votes = json["votes"];
      print(json);
      return true;
    } else {
      return false;
    }
  }

}
