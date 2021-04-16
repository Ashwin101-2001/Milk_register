import 'dart:ffi';


import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:milk_register/models/Milk.dart';
import 'package:milk_register/screens/calculate.dart';
import 'package:milk_register/utils/Databasehelper.dart';
import 'package:sqflite/sqflite.dart';
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


  @override
  initState()
  {super.initState();
  print(' initstate ');
   litres='0.0';
  _textController.text = '0.0'; //Set value
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
return TextFormField(

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

    textAlign: TextAlign.center,
    cursorColor: Colors.white,

    style: TextStyle( color:Colors.yellow[800],),
    decoration: const InputDecoration(

      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.greenAccent, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.5),
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
  );




}
  Future<bool> _willPopCallback() async {
    Navigator.pushReplacementNamed(context, 'home');
    return true; // return true if the route to be popped
  }

  Map data={};
  @override
  Widget build(BuildContext context) {

    print('building select');
   if(initdone==true)
     { data=ModalRoute.of(context).settings.arguments;
     d= data['d'];
     m= data['m'];
     y= data['y'];
     return WillPopScope(
       onWillPop:_willPopCallback ,
       child: Scaffold(
         appBar: AppBar(backgroundColor: Colors.black,
           title:Center(child: Text('SELECT MILK',style: TextStyle(color:Colors.yellow[800],fontWeight: FontWeight.bold),)),
           actions: [FlatButton(

             child:Icon(Icons.home,color:Colors.yellow[800]),
             onPressed:() {Navigator.pushReplacementNamed(context, 'home');},
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

           child:Column(
             children: [
               SizedBox(
                 height: 30,
               ),

               Row(children: [
                 Expanded(child: Container(),
                 flex:3),
                Expanded(
                  flex: 3,
                  child: Form(
                    key: formKey,
                      child:getForm(),),
                ),

                 Expanded(
                   flex:2,
                   child: ClipOval
                     (
                     child: Material(
                       child: InkWell(
                         // inkwell color
                         child: SizedBox(width: 20, height: 20, child: Icon(Icons.remove)),
                         onTap: () {setState(() {
                          double x=double.parse(litres);
                          x-=0.25;
                          litres=x.toString();
                         });},
                       ),
                     ),
                   ),
                 ),

                 Expanded(
                   flex:2,
                   child: ClipOval(
                     child: Material(
                       child: InkWell(
                         splashColor: Colors.red, // inkwell color
                         child: SizedBox(width: 20, height: 20, child: Icon(Icons.add)),
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
                   ),
                 ),
                 Expanded(child: Container(),
                     flex:2,)

               ],

               ),
               ElevatedButton.icon(
                 icon: Icon(Icons.save),
                 label: Text("Save"),
                 onPressed: (){
                   dbh.insertMilk(Milk(d,m,y,double.parse(litres)));
                 },
               )
             ],
           ),

           ),
         ),
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
