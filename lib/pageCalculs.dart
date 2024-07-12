import 'package:flutter/material.dart';

void main() {
  runApp(MyHome());
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jeu de Calculs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PageAccueil(),
    );
  }
}

class PageAccueil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculs'),
      ),
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('images/backcalculs.png', fit: BoxFit.cover),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PageCategories()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB4CA0B),
                    foregroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.public),
                      SizedBox(width: 40),
                      Text('Jouer'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Confirmation'),
                          content: Text('Voulez-vous vraiment quitter le jeu ?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Non'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.pop(context);
                              },
                              child: Text('Oui'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB4CA0B),
                    foregroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 40),
                      Text('Quitter'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Categorie {
  final String name;
  final List<Question> questions;

  Categorie({required this.name, required this.questions});
}

class Question {
  final String question;
  final List<String> answers;
  final int correctAnswerIndex;

  Question({required this.question, required this.answers, required this.correctAnswerIndex});
}

class PageCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choisissez un niveau'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/blackcalcul.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(categories.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ElevatedButton(
                    onPressed: () => naviguerVersCategorie(context, categories[index]),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 50),
                      backgroundColor: Color(0xFFB4CA0B),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(categories[index].name),
                  ),
                );
              }),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 50),
                  backgroundColor: Color(0xFFB4CA0B),
                  foregroundColor: Colors.white,
                ),
                child: Text('Retour à l\'accueil'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<Categorie> categories = [
  Categorie(
    name: 'Difficile',
    questions: [
      Question(question: '15 - 8', answers: ['6', '7', '8', '9'], correctAnswerIndex: 1),
      Question(question: '9 * 6', answers: ['52', '53', '54', '55'], correctAnswerIndex: 2),
      Question(question: '32 / 4', answers: ['6', '7', '8', '9'], correctAnswerIndex: 2),
      Question(question: '50 - 20', answers: ['28', '29', '30', '31'], correctAnswerIndex: 2),
    ],
  ),
  Categorie(
    name: 'Formules Chimiques',
    questions: [
      Question(question: 'H2O', answers: ['Oxygène', 'Hydrogène', 'Eau', 'Sel'], correctAnswerIndex: 2),
      Question(question: 'CO2', answers: ['Carbone', 'Dioxygène', 'Dioxyde de carbone', 'Oxyde de carbone'], correctAnswerIndex: 2),
      Question(question: 'NaCl', answers: ['Sucre', 'Sel', 'Acide', 'Base'], correctAnswerIndex: 1),
      Question(question: 'C6H12O6', answers: ['Fructose', 'Saccharose', 'Glucose', 'Lactose'], correctAnswerIndex: 2),
    ],
  ),
  Categorie(
    name: 'Formules Physiques',
    questions: [
      Question(question: 'E = mc^2', answers: ['Énergie', 'Masse', 'Lumière', 'Vitesse'], correctAnswerIndex: 0),
      Question(question: 'F = ma', answers: ['Force', 'Masse', 'Accélération', 'Vitesse'], correctAnswerIndex: 0),
      Question(question: 'V = IR', answers: ['Tension', 'Intensité', 'Résistance', 'Puissance'], correctAnswerIndex: 0),
      Question(question: 'P = IV', answers: ['Puissance', 'Intensité', 'Résistance', 'Tension'], correctAnswerIndex: 0),
    ],
  ),
];

void naviguerVersCategorie(BuildContext context, Categorie categorie) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PageJeu(categorie: categorie)),
  );
}

class PageJeu extends StatefulWidget {
  final Categorie categorie;

  PageJeu({required this.categorie});

  @override
  _PageJeuState createState() => _PageJeuState();
}

class _PageJeuState extends State<PageJeu> {
  int currentQuestionIndex = 0;
  int score = 0;
  String feedbackMessage = '';
  List<Color> buttonColors = [
    Color(0xFFB4CA0B),
    Color(0xFFB4CA0B),
    Color(0xFFB4CA0B),
    Color(0xFFB4CA0B)
  ];

  void verifierReponse(int selectedIndex) {
    setState(() {
      if (selectedIndex ==
          widget.categorie.questions[currentQuestionIndex]
              .correctAnswerIndex) {
        feedbackMessage = 'Correct!';
        buttonColors[selectedIndex] = Colors.green;
        score++;
      } else {
        feedbackMessage = 'Incorrect, essayez encore.';
        buttonColors[selectedIndex] = Colors.red;
        buttonColors[widget.categorie.questions[currentQuestionIndex]
                .correctAnswerIndex] =
            Colors.green;
      }
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          buttonColors = [
            Color(0xFFB4CA0B),
            Color(0xFFB4CA0B),
            Color(0xFFB4CA0B),
            Color(0xFFB4CA0B),
          ];
          currentQuestionIndex++;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${currentQuestionIndex + 1}'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 225, 226, 211), // Set background color to beige
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (currentQuestionIndex < widget.categorie.questions.length)
                  Column(
                    children: [
                      Text(
                        widget.categorie.questions[currentQuestionIndex]
                            .question,
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      ...widget.categorie.questions[currentQuestionIndex]
                          .answers
                          .asMap()
                          .entries
                          .map((entry) {
                        int index = entry.key;
                        String answerText = entry.value;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: ElevatedButton(
                            onPressed: () => verifierReponse(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColors[index],
                            ),
                            child: Text(answerText),
                          ),
                        );
                      }).toList(),
                      SizedBox(height: 20),
                      Text(
                        feedbackMessage,
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      Text(
                        'Vous avez complété toutes les questions!',
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Votre score: $score/${widget.categorie.questions.length}',
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(200, 50),
                          backgroundColor: Color(0xFFB4CA0B),
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Retour à l\'accueil'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}