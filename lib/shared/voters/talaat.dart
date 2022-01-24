import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app/style/colors.dart';
import 'package:url_launcher/url_launcher.dart';


class Talaat extends StatefulWidget {
  const Talaat({Key? key}) : super(key: key);

  @override
  State<Talaat> createState() => _TalaatState();
}

class _TalaatState extends State<Talaat> {
  bool? _checked1=false;
  bool? _checked2=false;
  int id=0;


  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
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

          child: CheckboxListTile(

            title:const Text('أعطى صوتى',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: kTextColor),),

            controlAffinity: ListTileControlAffinity.platform,

            onChanged: (bool? value){
              setState(() {
                _checked1=value;
                _checked2!=value;
              });
            },
            value: _checked1,

            activeColor: kSecondaryColor,

            selectedTileColor: Colors.black,
            selected: false,


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
}
