import 'package:flutter/material.dart';
import 'package:milk_register/utils/Databasehelper.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:sqflite/sqflite.dart';
import 'package:milk_register/models/Milk.dart';

import 'calculate.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   String month;
   String year;
   List<double> qlist= List(31);
   int nothing=1;


  final formKey = new GlobalKey<FormState>();
  @override
  initState(){
    print('initstate');
    super.initState();

    month=DateTime.now().month.toString();
    if(month.length==1)
      {month="0"+month;}

    print(month);
    year= DateTime.now().year.toString();
    print(year);

    for(int i=0;i<31;i++)
      {qlist[i]=0.0;}
      setarray();

  }
  @override


 Widget getFormMonth()
 {   return DropDownFormField(
       titleText: 'Month',
       hintText: 'Please choose one',
       value:month,
       onSaved: (value) {
         setState(() {
           month = value;
           print('set month saved');
         });
       },
       onChanged: (value) {
         setState(() {
           month = value;
           for(int i=0;i<31;i++)
           {qlist[i]=0.0;}
           setarray();
           print('set month changed');
         });
       },
       dataSource: [
         {
           "display": "Jan",
           "value": "01",
         },
         {
           "display": "Feb",
           "value": "02",
         },
         {
           "display": "Mar",
           "value": "03",
         },
         {
           "display": "Apr",
           "value": "04",
         },
         {
           "display": "May",
           "value": "05",
         },
         {
           "display": "June",
           "value": "06",
         },
         {
           "display": "July",
           "value": "07",
         },
         {
           "display": "Aug",
           "value": "08",
         },
         {
           "display": "Sep",
           "value": "09",
         },
         {
           "display": "Oct",
           "value": "10",
         },
         {
           "display": "Nov",
           "value": "11",
         },
         {
           "display": "Dec",
           "value": "12",
         },

       ],
       textField: 'display',
       valueField: 'value',
     );
 }


   Widget getFormYear()
   {   return
     DropDownFormField(
       titleText: 'Year',
       hintText: 'Please choose one',
       value:year,
       onSaved: (value) {
         setState(() {
           year = value;
         });
       },
       onChanged: (value) {
         setState(() {
           year = value;
         });
       },
       dataSource: [
         {
           "display": "2020",
           "value": "2020",
         },
         {
           "display": "2021",
           "value": "2021",
         },
         {
           "display": "2022",
           "value": "2022",
         },


       ],
       textField: 'display',
       valueField: 'value',
     );


   }





   Widget getList(){
     int count =getcount(this.month,this.year);
    return  Container(
      /*decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("android/assets/ptt.jpeg"),
          fit: BoxFit.cover,
        ),
      ), */

      color: Colors.black12,

      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,

        //list generate
        children: List.generate(count, (index) {
          int index1=index+1;
          double qmilk=qlist[index];



          return  Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              onPressed:(){
                Navigator.pushReplacementNamed(context,'select',arguments:{'d':"0${index1.toString()}",'m':this.month,
                    'y':this.year});
              },


              child: Card(
                  color: Colors.white,

                  child:Column(
                      children:<Widget>[ Text('$index1 ',style: TextStyle(color:Colors.blue[800],fontSize: 50),),
                        SizedBox(height: 2.0,),
                        Center(child: Text('$qmilk ',style: TextStyle(color:Colors.brown,fontSize: 30),))]
                  )
              ),
            ),
          );

        }),
      ),
    );

   }

    void setarray () async
   { DatabaseHelper dbh= DatabaseHelper();
     Database db= await dbh.database;
     List<double> y= List<double>();
     List<Milk> x= await dbh.getMilkList();
     for(Milk m in x)
       { if(((m.month==this.month)&&(m.year==this.year)))
         { int index=int.parse(m.day)-1;
           this.qlist[index]=m.q;
         }


       }
     setState(() {
       nothing=2;
     });



   }







  @override
  Widget build(BuildContext context) {
    print('building home');

    return Scaffold(


        appBar: AppBar(
          backgroundColor: Colors.black,
          title:Center(child: Text('CALENDAR',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.yellow[800],backgroundColor: Colors.black),)),
          actions: [FlatButton(

            child:Icon(Icons.calculate,color:Colors.yellow[800]),
            onPressed:() {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => calculate(m: this.month,y: this.year)),
              );
            },
          ),
           ],
        ),


      body: SingleChildScrollView(
        scrollDirection:  Axis.vertical,
        child: ListView(
          shrinkWrap: true,
             scrollDirection: Axis.vertical,
             //mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key:formKey,
                child: Container(
                  child: Column(
                    children: [
                      getFormMonth(),
                      getFormYear(),


                    ],
                  ),
                ),
              ),
                 // SingleChildScrollView(
                    //scrollDirection: Axis.vertical,
                       //child:
                       //ListView(
                           //children: [
                             getList()
                           //],
                       //scrollDirection: Axis.vertical,
                       //shrinkWrap: true,
                         //),
                  //),



            ],
          ),
      ),



    );


  }
}
 int getcount(String m, String y)
 { int month =int.parse(m);
   int year = int.parse(y);
 if(month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)
   {return 31;}

 else if((month == 2) && ((year%400==0) || (year%4==0 && year%100!=0)))
   {return 29;}

 else if(month == 2)
 {return 28;}
 else
   {return 30;}
 }

