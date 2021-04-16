import 'dart:io';

import 'package:flutter/material.dart';
import 'package:milk_register/utils/calculator.dart';


import 'package:provider/provider.dart';

class calculate extends StatefulWidget {
  String m;
  String y;
  calculate({this.m,this.y});
  @override
  calculateState createState() => calculateState(m: m,y: y);
}

class calculateState extends State<calculate> {
  String m;
  String y;
  calculateState({this.m,this.y});
  double litres=0.0;
  double cost=0.0;
  double ppl= 44;

  @override
  void initState() {
    print('initstate calc');
    // TODO: implement initState
    super.initState();
    init();



  }
  void init()async{
    print('init calc');
    double l=await calculator().get(m,y);
    print(l);
    double c= await calculator().getcost(m,y,ppl);
    print(c);
    setState(() {
      print('setstate init calc');
      litres=l;
      cost=c;

    });
  }
  Future<bool> _willPopCallback() async {
    Navigator.pushReplacementNamed(context, 'home');
    return true; // return true if the route to be popped
  }
  @override
  Widget build(BuildContext context) {
    print('build calc');


    return WillPopScope(
      onWillPop: _willPopCallback,

      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Center(child: Text('CALCULATOR',
              style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.yellow[800],backgroundColor: Colors.black),)),
            actions: [FlatButton(

              child:Icon(Icons.home,color:Colors.yellow[800]),
              onPressed:() {Navigator.pushReplacementNamed(context, 'home');},
            ),],),
          body:Container(
              child:Center(
                  child:Column(

                      children:<Widget>[
                        SizedBox(height:30.0),
                        Card(
                          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 25.0,
                              //backgroundColor:Colors.yellow[800] ,
                              //backgroundImage: NetworkImage('https://www.google.com/imgres?imgurl=https%3A%2F%2Fpng.pngtree.com%2Fpng-clipart%2F20190614%2Foriginal%2Fpngtree-vector-milk-icon-png-image_3774283.jpg&imgrefurl=https%3A%2F%2Fpngtree.com%2Ffreepng%2Fvector-milk-icon_3774283.html&tbnid=zc8qfBrPVlCqLM&vet=12ahUKEwj30sigj6DuAhVp2nMBHe8HDaIQMygDegUIARCHAQ..i&docid=kT-RNCJ_rfKOhM&w=1024&h=1024&q=milk%20icon%20pictures.png&ved=2ahUKEwj30sigj6DuAhVp2nMBHe8HDaIQMygDegUIARCHAQ'),
                               backgroundImage: AssetImage("android/assets/milk-bottle.png"),
                            ),
                            title: Text('MILK CONSUMED',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,),),
                            subtitle: Text('$litres litres',
                              style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),
                          ),
                        ),
                        SizedBox(height:30.0),
                        Card(
                          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 25.0,
                              backgroundColor:Colors.black,
                              //backgroundImage: NetworkImage('https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.vhv.rs%2Fdpng%2Fd%2F33-330883_indian-rupee-symbol-png-transparent-png.png&imgrefurl=https%3A%2F%2Fwww.vhv.rs%2Fviewpic%2FhxTTwh_indian-rupee-symbol-png-transparent-png%2F&tbnid=FnRfoTLFMZtLiM&vet=12ahUKEwjQ6anGj6DuAhWsjUsFHQTpAb8QMygKegUIARCcAQ..i&docid=Eyhvxc86Ugjg3M&w=860&h=682&q=rupees%20icon%20pictures.png&ved=2ahUKEwjQ6anGj6DuAhWsjUsFHQTpAb8QMygKegUIARCcAQ'),
                              backgroundImage: AssetImage("android/assets/irs.jpg"),
                            ),
                            title: Text('EXPENSE',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,),),
                            subtitle: Text('Rs $cost',
                              style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,),),),
                        ),


                      ]
                  )
              )

          )
      ),
    );
  }
}
