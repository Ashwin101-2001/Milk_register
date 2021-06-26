import 'dart:ffi';


import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:milk_register/models/Milk.dart';
import 'package:milk_register/screens/calculate.dart';
import 'package:milk_register/utils/Databasehelper.dart';
import 'package:milk_register/utils/screens_size.dart';
import 'package:sqflite/sqflite.dart';

import 'home.dart';
//String  global;

class SelectMilk extends StatefulWidget {

  @override
  _SelectMilkState createState() => _SelectMilkState();
}

class _SelectMilkState extends State<SelectMilk> {
  final TextEditingController _textController = new TextEditingController();

  String d='';
  String m='';
  String y='';
  bool initdone=false;
  DatabaseHelper dbh;
  Database db;
  String litres;
  final formKey = new GlobalKey<FormState>();
  double width;
  double height;
  bool save;


  @override
  initState()
  {super.initState();
  print(' initstate ');
   litres='0.0';
  _textController.text = '0.0'; //Set value
  save = false;
   init();



  }
  void init() async
  {  dbh= DatabaseHelper();
     db= await dbh.database;
     print('db done');
     setState(() {
       initdone=true;
     });
  }

Widget getForm()
{  print(' getform ');
  print(litres) ;
return Theme(
  data:Theme.of(context).copyWith(primaryColor: Colors.black),
  child:   TextFormField(
    autofocus: false,

    controller: _textController,
      onFieldSubmitted: (value){
        print('ofs  ');
        setState(() {
          litres=value;
        });
      },
      onSaved: (value)
      {print(' os ');
      setState(() {
        litres=value;
      });
      },

    onChanged: (value)
    {setState(() {
      litres=value;
    });},

    onEditingComplete: ()
    { print("on completete edit");
    dbh.insertMilk(Milk(d,m,y,double.parse(litres)));},

      textAlign: TextAlign.center,
      cursorColor: Colors.white,



      style: TextStyle( color:Colors.white,),
      decoration: const InputDecoration(


        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent, width: 2.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.5),
        ),




        // labelStyle: TextStyle(color:Colors.white)
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        value=litres;
        print("val:$value");
        return null;
      },
    ),
);




}
  Future<bool> _willPopCallback() async {
    if(save==false)
      { return showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Are you sure?',
                style: TextStyle(fontWeight: FontWeight.bold),),
              content: Text(
                'Do you want save $litres Litres ?? ', style: TextStyle(),),
              actions: <Widget>[ FlatButton(
                onPressed: () async {
                  await dbh.insertMilk(Milk(d, m, y, double.parse(litres)));
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => Home()),
                      ModalRoute.withName('/')
                  );
                },
                /*Navigator.of(context).pop(true)*/
                child: Text('Yes', style: TextStyle(),),
              ),
                FlatButton(
                  onPressed: () { Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => Home()),
                      ModalRoute.withName('/')
                  );},
                  child: Text('No', style: TextStyle(),),
                ),

              ],
            ),
      ) ?? false;
      }
    else
      { Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => Home()),
          ModalRoute.withName('/')
      );

      }
     }

  Map data={};
  @override
  Widget build(BuildContext context) {
    width =Responsive.width(5, context);
    height =Responsive.height(5, context);
  if(height<width)
    {double a= height;
     height =width;
     width =a;
    }

    print("h:$height");
    print('w:$width');

    print('building select');
   if(initdone==true)
     { data=ModalRoute.of(context).settings.arguments;
     d= data['d'];
     int day=int.parse(d);
     m= data['m'];
     y= data['y'];
     String date="${getMonth(int.parse(m))}  $day  $y";
     double offset=1.5;

     return OrientationBuilder(
       builder: (context, orientation) {
         return WillPopScope(
           onWillPop:_willPopCallback ,
           child: Scaffold(
             appBar: AppBar(backgroundColor: Colors.black,
               title:Center(child: Text('SELECT MILK',style: TextStyle(color:Colors.yellow[800],fontWeight: FontWeight.bold),)),
               actions: [FlatButton(

                 child:Icon(Icons.home,color:Colors.yellow[800]),
                 onPressed:() async {
                   await dbh.insertMilk(Milk(d,m,y,double.parse(litres)));
                   Navigator.pushReplacementNamed(context, 'home');},
               ),
                 FlatButton(

                   child:Icon(Icons.calculate,color:Colors.yellow[800]),
                   onPressed:() {
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context) => calculate(m:m,y:y)),
                     );},
                 ),],
             ),
             body:  Container(
               decoration: BoxDecoration(
                 image: DecorationImage(
                   image: AssetImage("android/assets/ak123.jpg"),
                   fit: BoxFit.cover,
                 ),
               ),

               child:Column(
                // scrollDirection: Axis.vertical,
                 //crossAxisAlignment:CrossAxisAlignment.center,
                 children: [
                   SizedBox(height: getdouble(orientation, height, width),),
                   Container(

                     child: Text(date,style: TextStyle(color: Colors.white,
                         fontWeight: FontWeight.bold,fontSize: 35,
                         shadows: [
                           Shadow( // bottomLeft
                               offset: Offset(-offset, -offset),
                               color: Colors.yellow[800]
                           ),
                           Shadow( // bottomRight
                               offset: Offset(offset ,-offset),
                               color: Colors.yellow[800]
                           ),
                           Shadow( // topRight
                               offset: Offset(offset, offset),
                               color: Colors.yellow[800]
                           ),
                           Shadow( // topLeft
                               offset: Offset(-offset, offset),
                               color: Colors.yellow[800]
                           ),
                         ]),),
                   ),

                   SizedBox(height:getdouble(orientation, height, width),),

                   SizedBox(
                     width: getdouble(orientation, width*20/3, height/5*20)
                     ,
                     child: Form(
                       key: formKey,
                       child:getForm(),),
                   ),

                   SizedBox(height: (getdouble(orientation, height, width))/2,),
                   Row(mainAxisAlignment: MainAxisAlignment.center,
                     children: [  ClipOval
                       (
                       child: Material(
                         child: InkWell(
                           // inkwell color
                           child: SizedBox(width: 56, height: 56, child: Icon(Icons.remove)),
                           onTap: () {setState(() {
                             double x=double.parse(litres);
                             x-=0.25;
                             litres=x.toString();
                           });},
                         ),
                       ),
                     ),
                       SizedBox(
                         width :getdouble(orientation, height, width)/2,
                       ),
                       ClipOval(
                         child: Material(
                           child: InkWell(
                             splashColor: Colors.red, // inkwell color
                             child: SizedBox(width: 56, height: 56, child: Icon(Icons.add)),
                             onTap: () {
                               double x=double.parse(litres);
                               x+=0.25;
                               setState(()
                               {
                                 litres=x.toString();
                                 _textController.text=litres;
                               });},
                           ),
                         ),
                       ),],
                   ),




                   SizedBox(height: height/2,),
                   ElevatedButton.icon(

                     icon: Icon(Icons.save),
                     label: Text("Save",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                     onPressed: (){
                       dbh.insertMilk(Milk(d,m,y,double.parse(litres)));
                       setState(() {
                         save=true;
                       });
                     },
                   )
                 ],
               ),

             ),
           ),
         );
       },

     );

     }
   else{
     return Scaffold(
       appBar: AppBar(backgroundColor: Colors.black,
         title:Center(child: Text('SELECT MILK',style: TextStyle(color:Colors.yellow[800],fontWeight: FontWeight.bold),)),
         actions: [FlatButton(

           child:Icon(Icons.calculate,color:Colors.yellow[800]),
           onPressed:() {Navigator.pushReplacementNamed(context, 'calc');},
         ),],
       ),
       body:  Center(
       child: CircularProgressIndicator(
     valueColor: AlwaysStoppedAnimation<Color>(
         Theme
         .of(context)
         .primaryColor,
    ),
    ),
    ),
     );
   }
  }
}
String getMonth(int n)
{
  switch(n)
  {
    case 1:
      return "January";
      break;
    case 2:
      return"February";
      break;
    case 3:
      return"March";
      break;
    case 4:
      return"April";
      break;
    case 5:
      return"May";
      break;
    case 6:
      return"June";
      break;
    case 7:
      return"July";
      break;
    case 8:
      return"August";
      break;
    case 9:
      return"September";
      break;
    case 10:
      return"October";
      break;
    case 11:
      return"November";
      break;
    case 12:
      return"December";
      break;
    default:
      return"Invalid Month number";
      break;
  }

}

  double getdouble(Orientation orientation ,double a,double b)
  { double x=orientation == Orientation.portrait ? a:b;
   print("x:$x a:$a b:$b");
   return x;

  }

