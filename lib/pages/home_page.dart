import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imcapp/service/imc_service.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double _imcResult = 0.0;
  String _imcClassification = '';
  final List<Map<String, dynamic>> _imcResultList = [];


  @override
  void dispose(){
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _showErrorDialog(){
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Please, insert a valid weight and height."),
            actions: [
              TextButton(onPressed: () {
                Navigator.of(context).pop();
              },
               child: const Text("Ok"))
            ],
          );
        }
      );
    }


    void _showResultDialog() {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('IMC results'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('IMC: ${_imcResult.toStringAsFixed(2)}'),
              Text('Classification: $_imcClassification'),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  void _calculateIMC() {
    double? weight = double.tryParse(_weightController.text);
    double? height = double.tryParse(_heightController.text);


    if(weight != null && height != null){
      IMC imcCalculator = IMC(weight: weight, height: height);


      setState(() {
        _imcResult = imcCalculator.calculatorIMC(weight, height);
        _imcClassification = imcCalculator.classifierIMC(weight, height);

        _imcResultList.add({
          'result': _imcResult.toStringAsFixed(2),
          'classification': _imcClassification
        });
      });
      _showResultDialog();
    } else {
      _showErrorDialog();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IMC Calculator"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
              ],
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.height),
                border: OutlineInputBorder(),
                labelText: 'Height (m)',
              ),
            ),
          ),
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
              ],
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.balance),
                border: OutlineInputBorder(),
                labelText: 'Weight (kgs)',
              ),
            ),
          ),
          const SizedBox(height: 30,),
          Center(
            child: ElevatedButton(
              onPressed: _calculateIMC, // Chama o método de cálculo
              child: const Text("Calculate")
            ),
          ),

          const SizedBox(height: 30,),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _imcResultList.length,
              itemBuilder: (context, index){
                final item = _imcResultList[index];
                return Container(
                  width: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.lightBlueAccent,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'IMC: ${item['result']}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Classification: ${item['classification']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              }))
        ],
      ),
    );
  }
}