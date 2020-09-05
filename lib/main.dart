import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main()
{
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: SimpleCalculator(),      
    );
  }
}


class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}



class _SimpleCalculatorState extends State<SimpleCalculator> {
  
  String equation ="0";
  String result ="0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText){
    setState((){
      if(buttonText =='C'){
        equation ="0";
        result ="0";
        equationFontSize=38.0;
        resultFontSize=48.0;
      }
      else if(buttonText=='⌫'){
        equationFontSize=48.0;
        resultFontSize=38.0;
        equation=equation.substring(0,equation.length-1);
        if(equation =="")
        {
          equation = "0";
        }
      }
        else if(buttonText=="=")
        {
          equationFontSize=38.0;
          resultFontSize=48.0;

          expression = equation;
          expression = expression.replaceAll('x','*');
          expression = expression.replaceAll('÷', "/");
          try{
            Parser p = new Parser();
            Expression exp = p.parse(expression);
            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          }catch(e){
            result = "Error";
          }
        }else
        {
          equationFontSize=48.0;
          resultFontSize =38.0;
          if(equation =="0")
          {
            equation=buttonText;
          }else{
            equation = equation+buttonText;
          }
        }
      

    });
  }


  Widget buildButoon(String buttonText,double buttonHeight,Color buttonColor)
  {
     return Container(
                        height: MediaQuery.of(context).size.height*buttonHeight*0.1,
                        color: buttonColor,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                            side: BorderSide(
                              color: Colors.black45,
                              width: 1,
                              style: BorderStyle.solid
                            )
                          ),
                          padding: EdgeInsets.all(16.0),
                          onPressed: ()=> buttonPressed(buttonText),
                          child: Text(
                            buttonText,
                            style:TextStyle(
                              fontSize:30.0,
                              fontWeight:FontWeight.normal,
                              color:Colors.black, 
                            )
                          ),
                        ),
                      );
  }
 
 
 
 
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Simple Calculator"),),
      body: Column(
        children: <Widget>[


          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10,20, 10, 0),
            child: Text(equation,
            style: TextStyle(
              fontSize: equationFontSize,
            ),
            ),
          ),


          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10,20, 10, 0),
            child: Text(result,
            style: TextStyle(
              fontSize: resultFontSize,
            ),
            ),
          ),

          Expanded(
            child: Divider(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                       buildButoon("C",1, Colors.redAccent),
                       buildButoon("⌫",1, Colors.blueAccent),
                       buildButoon("÷",1, Colors.greenAccent),
                      ]
                    ),
                    TableRow(
                      children: [
                       buildButoon("7",1, Colors.grey),
                       buildButoon("8",1, Colors.grey),
                       buildButoon("9",1, Colors.grey),
                      ]
                    ),
                    TableRow(
                      children: [
                       buildButoon("4",1, Colors.grey),
                       buildButoon("5",1, Colors.grey),
                       buildButoon("6",1, Colors.grey),
                      ]
                    ),
                    TableRow(
                      children: [
                       buildButoon("1",1, Colors.grey),
                       buildButoon("2",1, Colors.grey),
                       buildButoon("3",1, Colors.grey),
                      ]
                    )
                  ],
                ),

              ),

              Container(
                width: MediaQuery.of(context).size.width*0.25,
                child: Table(
                  children: [
                    TableRow(
                      children:[

                       buildButoon("*",1, Colors.blue),
                      ] 
                    ),
                    TableRow(
                      children:[

                       buildButoon("-",1, Colors.blue),
                      ] 
                    ),
                    TableRow(
                      children:[

                       buildButoon("+",1, Colors.blue),
                      ] 
                    ),
                    TableRow(
                      children:[

                       buildButoon("=",1, Colors.redAccent),
                      ] 
                    ),
                
                  ],
                ),
              )
            ],
          )

        ],
      ),
      
    );
  }
}