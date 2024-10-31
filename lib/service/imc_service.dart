class IMC {
  late final double height;
  late final double weight;


  IMC({required this.weight, required this.height});

  double calculatorIMC(weight, height){
    return weight/(height*height);
  }

  String classifierIMC(weight, height){
    double imc = calculatorIMC(weight, height);


    if (imc < 18.5) {
      return "Underweight";
    } else if (imc >= 18.5 && imc < 24.9) {
      return "Normal - Healthy";
    } else if (imc >= 25 && imc < 29.9) {
      return "Overweight";
    } else if (imc >= 30 && imc < 34.9) {
      return "Obesity I";
    } else if (imc >= 35 && imc < 39.9) {
      return "Obesity II";
    } else {
      return "Obesity III";
    }
  }
}