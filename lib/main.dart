import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(const CalculadoraApp());

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      theme: ThemeData.light(),
      home: const CalculadoraHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculadoraHomePage extends StatefulWidget {
  const CalculadoraHomePage({super.key});

  @override
  CalculadoraHomePageState createState() => CalculadoraHomePageState();
}

class CalculadoraHomePageState extends State<CalculadoraHomePage> {
  String inputUser = '';
  String resultado = '';

  final Set<String> operadores = {'+', '-', '*', '/', '^', '!'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fundo branco
      body: Center(
        child: Container(
          width: 470, // Largura ajustada para 470 px
          height: 604,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFD3D3D3), // Fundo da calculadora em light-grey
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.black, // Cor da borda
              width: 1.0, // Largura da borda
            ),
          ),
          child: Column(
            children: <Widget>[
              // Display da Calculadora
              Container(
                height: 160,
                width: double.infinity,
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black54, // Fundo do display em grey
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: SingleChildScrollView(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    inputUser,
                    style: const TextStyle(fontSize: 36, color: Colors.white),
                    maxLines: 1,
                  ),
                ),
              ),
              // Espaçamento entre o display e os botões
              const SizedBox(height: 10), // Adicionado espaçamento de 10 pixels
              // Botões da Calculadora
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black54, // Fundo em grey
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente
                    children: [
                      // Linha 1 de botões
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center, // Centraliza horizontalmente
                          children: [
                            Expanded(child: botaoCalculadora('C')),
                            Expanded(child: botaoCalculadora('^')),
                            Expanded(child: botaoCalculadora('!')),
                            Expanded(child: botaoCalculadora('/')),
                          ],
                        ),
                      ),
                      // Linha 2 de botões
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: botaoCalculadora('7')),
                            Expanded(child: botaoCalculadora('8')),
                            Expanded(child: botaoCalculadora('9')),
                            Expanded(child: botaoCalculadora('*')),
                          ],
                        ),
                      ),
                      // Linha 3 de botões
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: botaoCalculadora('4')),
                            Expanded(child: botaoCalculadora('5')),
                            Expanded(child: botaoCalculadora('6')),
                            Expanded(child: botaoCalculadora('-')),
                          ],
                        ),
                      ),
                      // Linha 4 de botões
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: botaoCalculadora('1')),
                            Expanded(child: botaoCalculadora('2')),
                            Expanded(child: botaoCalculadora('3')),
                            Expanded(child: botaoCalculadora('+')),
                          ],
                        ),
                      ),
                      // Linha 5 de botões
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: botaoCalculadora('0')),
                            Expanded(child: botaoCalculadora('00')),
                            Expanded(child: botaoCalculadora('.')),
                            Expanded(child: botaoCalculadora('=')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget botaoCalculadora(String texto) {
    return BotaoCalculadora(
      texto: texto,
      callback: () => cliqueBotao(texto),
      corTexto: getColorTexto(texto),
      corBotao: getColorBotao(texto),
    );
  }

  void cliqueBotao(String texto) {
    setState(() {
      if (texto == 'C') {
        inputUser = '';
        resultado = '';
      } else if (texto == '=') {
        calcularResultado();
      } else {
        // Validação de operadores e pontos decimais
        if (inputUser.isNotEmpty) {
          String ultimoCaractere =
              inputUser.substring(inputUser.length - 1);
          if ((operadores.contains(ultimoCaractere) &&
                  operadores.contains(texto)) ||
              (texto == '.' && ultimoCaractere == '.')) {
            // Não adicionar operador ou ponto se o anterior for o mesmo
            return;
          } else {
            inputUser += texto;
          }
        } else {
          // Não iniciar a expressão com operadores (exceto menos)
          if (operadores.contains(texto) && texto != '-') {
            return;
          } else {
            inputUser += texto;
          }
        }
      }
    });
  }

  void calcularResultado() {
    String expressaoFinal = inputUser;
    expressaoFinal = expressaoFinal.replaceAll('×', '*');
    expressaoFinal = expressaoFinal.replaceAll('÷', '/');

    try {
      Parser p = Parser();
      ContextModel cm = ContextModel();

      // Tratamento para fatorial
      if (expressaoFinal.contains('!')) {
        expressaoFinal =
            expressaoFinal.replaceAllMapped(RegExp(r'(\d+)!'), (Match m) {
          int num = int.parse(m.group(1)!);
          return fatorial(num).toString();
        });
      }

      Expression exp = p.parse(expressaoFinal);
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      resultado = eval.toString();
      inputUser = resultado;
    } catch (e) {
      resultado = 'Erro';
      inputUser = '';
    }
  }

  Color getColorTexto(String texto) {
    if (isOperador(texto) || texto == 'C' || texto == '=') {
      return Colors.white; // Texto dos botões de operação em branco
    } else {
      return Colors.black; // Texto dos botões numéricos em preto
    }
  }

  Color getColorBotao(String texto) {
    if (isOperador(texto) || texto == 'C' || texto == '=') {
      return Colors.black; // Fundo dos botões de operação em preto
    } else {
      return Colors.white; // Fundo dos botões numéricos em branco
    }
  }

  bool isOperador(String x) {
    return operadores.contains(x) || x == '=';
  }

  int fatorial(int n) {
    if (n <= 1) return 1;
    return n * fatorial(n - 1);
  }
}

class BotaoCalculadora extends StatelessWidget {
  final String texto;
  final VoidCallback callback;
  final Color corTexto;
  final Color corBotao;

  const BotaoCalculadora({
    super.key,
    required this.texto,
    required this.callback,
    required this.corTexto,
    required this.corBotao,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          backgroundColor: corBotao,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Botões arredondados
          ),
        ),
        child: Text(
          texto,
          style: TextStyle(
            fontSize: 32,
            color: corTexto,
          ),
        ),
      ),
    );
  }
}
