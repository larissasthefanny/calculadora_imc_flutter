import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController(); // controladores
  TextEditingController heightController = TextEditingController();

  // ignore: non_constant_identifier_names
  GlobalKey<FormState> _FormKey = GlobalKey <FormState>();

String _infoText = "Informe seus dados";

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _FormKey = GlobalKey<FormState>();    // ADICIONE ESTA LINHA!
    });
  }

  void _calculate (){
    setState(() { //informa que houve uma modificação nos dados 
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text)/100;
    double imc = weight / (height * height);
    print(imc);
    if(imc < 18.6){
      _infoText = "Abaixo do peso(${imc.toStringAsPrecision(3)})";
    } else if (imc >=18.6 && imc< 24.9) {
      _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
    } else if ( imc >= 24.9 && imc < 29.9){
      _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
    } else if (imc >= 29.9 && imc < 34.9) {
      _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
    } else if ( imc >= 34.9 && imc < 39.9) {
      _infoText = "Obesidade Grau II(${imc.toStringAsPrecision(3)})";
    } else if (imc >= 40){
      _infoText = "Obesidade Grau III(${imc.toStringAsPrecision(3)})";
    }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), 
          onPressed: _resetFields,)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView
      (padding: EdgeInsets.fromLTRB(10, 0, 10, 0), //padding que ajeita as medidas da tela

        child: Form(
         key: _FormKey,
          child:   
        Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
        Icon(Icons.person_outline, size: 120, color:Colors.green),
        TextFormField(keyboardType: TextInputType.number,
        decoration: InputDecoration
        (labelText:"Peso(kg)",
        labelStyle: TextStyle(color: Colors.green)),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.green, fontSize: 18),
        controller: weightController,
        validator: (value){ //se a label estiver vazia, nao preenc
          if(value.isEmpty){
            return "Insira seu peso!";
          }
        },
        ),
         TextFormField(keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText:"Altura (cm)",
        labelStyle: TextStyle(color: Colors.green)),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.green, fontSize: 18),
        controller: heightController,
        validator: (value){
          if(value.isEmpty){
            return "Insira sua altura!";
          }
        },
        ),
       Padding(
         padding: EdgeInsets.only(top: 10, bottom: 10), //especifica onde você quer o espaçamento
         child: Container( //child: filho do padding
         height: 50,
         child:  RaisedButton(
           onPressed: () { //msg de erro ao pressionar o botao e as labels estarem vazias
             if (_FormKey.currentState.validate()){
               _calculate();
             }
           },
        child: Text("Calcular",
         style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        color: Colors.green,
        ),
       ), 
       ),
       Text(_infoText,
       textAlign: TextAlign.center,
       style: TextStyle(color: Colors.green, fontSize: 18),
       )],
      ),)
      ),
    );
  }
}