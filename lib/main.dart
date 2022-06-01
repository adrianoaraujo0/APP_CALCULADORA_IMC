import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: _HomeState(),
  ));
}

class _HomeState extends StatefulWidget {
  const _HomeState({Key? key}) : super(key: key);

  @override
  State<_HomeState> createState() => _HomeStateState();
}

class _HomeStateState extends State<_HomeState> {

  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();

  String infoText = "Insira seus dados";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Calculadora de IMC"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () {
                reset();
              },
              icon: Icon(Icons.refresh)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outlined,
                size: 100,
                color: Colors.green,
              ),
              TextFormField(
                controller: alturaController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira sua altura";
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Insira sua altura",
                    hintText: "ex: 1,75",
                    suffixText: "Metros"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: pesoController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira seu peso";
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Insira seu peso",
                  hintText: "ex: 85kg",
                  suffixText: "Kilogramas",
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      calculate();
                    }
                  },
                  child: Text("Calcular IMC"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void reset() {
    alturaController.clear();
    pesoController.clear();
    setState(() {
      formkey = GlobalKey();
      infoText = "Insira seus dados";
    });
  }

  void calculate() {
    double peso = double.parse(pesoController.value.text);
    double altura = double.parse(alturaController.value.text) / 100;

    double imc = peso / (altura * altura);
    setState(
      () {
        if (imc < 18.5) {
          infoText = "Magreza (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 18.5 && imc <= 25) {
          infoText = "Normal (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 25 && imc <= 30) {
          infoText = "Sobrepeso (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 30 && imc <= 35) {
          infoText = "Obesidade grau 1 (${imc.toStringAsPrecision(4)})";
        } else if (imc >= 35 && imc <= 40) {
          infoText = "Obesidade grau 2 (${imc.toStringAsPrecision(4)})";
        } else if (imc > 40) {
          infoText = "Obesidade grau 3 (${imc.toStringAsPrecision(4)})";
        }
      },
    );
  }
}
