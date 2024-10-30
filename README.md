# Descrição do Projeto

O Aplicativo de Calculadora Flutter foi desenvolvido para resolver o desafio da disciplina de Desenvolvimento Mobile II, é uma ferramenta prática e acessível, atendendo a diferentes perfis de usuários. Ele combina operações básicas, como adição e subtração, com funções avançadas, como potenciação e fatorial. Com um design simples e claro, facilitando a execução de cálculos diários.

## Funcionalidades
O aplicativo é uma ferramenta versátil para cálculos diários, oferecendo operações matemáticas básicas, como adição, subtração, multiplicação e divisão, além de funções avançadas como potenciação e cálculo de fatorial.
Com uma interface intuitiva, o aplicativo permite a entrada de números inteiros e decimais, contando com botões específicos para facilitar a inserção de valores. Um sistema de validação garante que expressões inválidas não sejam aceitas, evitando erros. 
Para maior comodidade, o botão C limpa a expressão atual, enquanto o botão = calcula e exibe instantaneamente o resultado, proporcionando uma experiência de uso fluida e eficiente.

## Instalações
Para instalar e rodar esse projeto:

1. Pré-requisitos:
Instale o Flutter SDK. Consulte o site oficial de como seguir a instalação. (https://docs.flutter.dev/get-started/install)
Use um editor de código como Visual Studio Code ou Android Studio.

2. Clonar o repositório:
     - git clone https://github.com/MarilaneMesquita/calculadora_flutter.git
     - Ou extrair de uma pasta .zip

3. Acesso ao diretório do projeto
cd calculadora-flutter

4. Instalando as dependências
flutter pub get

5. Iniciando o aplicativo
flutter run

## Instruções de Uso
Abrir o Aplicativo: Após a instalação, inicie o aplicativo em um dispositivo ou emulador.

**Inserir Números e Operações:**
Utilize os botões numéricos para digitar valores.
Adicione operadores matemáticos conforme necessário.
O visor mostrará a expressão à medida que você insere os dados.

**Calcular:**
Pressione = para obter o resultado da expressão.
O resultado aparecerá no visor.

**Limpar:**
Clique em C para limpar o visor e reiniciar a entrada.
Observações:
A calculadora verifica entradas para evitar expressões inválidas.
Não inicie expressões com operadores (exceto -).
Não são permitidos operadores ou pontos decimais consecutivos.


## Estrutura do Aplicativo
- O aplicativo é organizado em torno do arquivo main.dart, que serve como o núcleo da aplicação, contendo toda a lógica necessária. 
- A classe CalculadoraApp é o ponto de partida, e dentro dela, encontramos o CalculadoraHomePage, um StatefulWidget que representa a tela principal. 
- O estado da calculadora é gerenciado pela classe CalculadoraHomePageState, que armazena a expressão digitada pelo usuário na variável inputUser e o resultado do cálculo na variável resultado.
- Para construir a interface do usuário, a função build é utilizada, enquanto a interação com os botões é tratada pelo método cliqueBotao, que responde aos eventos de clique. 
- O método calcularResultado processa a expressão inserida e retorna o resultado, enquanto funções como getColorTexto e getColorBotao definem as cores do texto e do fundo dos botões. 
- Além disso, a função isOperador verifica se um caractere é um operador, e fatorial calcula o fatorial de números inteiros.
- Os botões da calculadora são implementados através do componente personalizado BotaoCalculadora, que permite uma melhor personalização da aparência. 
- Para avaliar as expressões matemáticas inseridas, o aplicativo depende do pacote math_expressions, que fornece as funcionalidades necessárias para analisar e calcular as operações.
- Essas dependências, juntamente com o Flutter SDK, são fundamentais para garantir o funcionamento correto e eficiente do aplicativo.

### Exemplos de utilização

A calculadora realizar as seguintes operações:
1. Potenciação (3^2 = 3*3 = 9)
2. Fatorial (5! = 5*4*3*2*1 = 120)
3. Divisão (6/3 = 2)
4. Multiplicação (2*4 = 8)
5. Subtração (5-3 = 2)
6. Soma (6.7+9.2 = 15.9)