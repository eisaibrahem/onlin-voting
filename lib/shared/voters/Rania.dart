import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app/style/colors.dart';
import 'package:url_launcher/url_launcher.dart';


class Rania extends StatefulWidget {
  const Rania({Key? key}) : super(key: key);

  @override
  State<Rania> createState() => _RaniaState();
}

class _RaniaState extends State<Rania> {
  bool? _checked1=false;
  bool? _checked2=false;
  int id =0;


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
          child: _nameDetailsContainerRania(),
        ),
        back: Material(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(24.0),
          shadowColor: const Color(0x802196F3),
          child: _socialContainerRania(),
        ),
      ),
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

            child: CheckboxListTile(
              title:const Text('أعطى صوتى',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: kTextColor),),

              controlAffinity: ListTileControlAffinity.platform,
              value: _checked1,
              onChanged: (bool? value){
                setState(() {
                  _checked1=value;
                  _checked2!=value;
                  id=11;

                });
              },
              activeColor: kSecondaryColor,

              selectedTileColor: Colors.black,
              selected: false,


            ),
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
}
