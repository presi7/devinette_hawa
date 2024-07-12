import 'package:flutter/material.dart';

void main() {
  runApp(MyPage());
}

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Devine le Pays',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Devine le Pays'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('images/anna.png', fit: BoxFit.cover),
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
                    backgroundColor: Color.fromARGB(235, 202, 145, 11),
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Commencer le jeu'),
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
                    backgroundColor: Color.fromARGB(235, 202, 145, 11),
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

class PageCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choisissez une catégorie'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/anna.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GuessImageGame(level: 'monuments')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(235, 202, 145, 11),
                  foregroundColor: Colors.white,
                ),
                child: Text('Monuments'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GuessImageGame(level: 'personnalités')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(235, 202, 145, 11),
                  foregroundColor: Colors.white,
                ),
                child: Text('Personnalités'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GuessImageGame(level: 'logiques')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(235, 202, 145, 11),
                  foregroundColor: Colors.white,
                ),
                child: Text('Animaux'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text('Quitter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GuessImageGame extends StatefulWidget {
  final String level;

  GuessImageGame({required this.level});

  @override
  _GuessImageGameState createState() => _GuessImageGameState();
}

class _GuessImageGameState extends State<GuessImageGame> {
  List<Map<String, dynamic>> gameData = [];

  int currentQuestionIndex = 0;
  int score = 0;
  bool answeredCorrectly = false;
  bool showCorrectAnswer = false;

  @override
  void initState() {
    super.initState();
    if (widget.level == 'monuments') {
      gameData = [
        {
          'indice': 'Je suis le monument le plus visité au monde avec près de 35 millions de visiteurs. Qui suis-je ?',
          'image1': 'images/square.png',
          'image2': 'images/dubai.png',
          'correctImageIndex': 0,
        },
        {
          'indice': 'Je suis la mosquée la plus grande au monde. Qui Suis-Je ?',
          'image1': 'images/haram.png',
          'image2': 'images/medine.png',
          'correctImageIndex': 1,
        },
        {
          'indice': 'J\'organise les Jeux Olympiques de 2024. Qui Suis-Je ?',
          'image1': 'images/france.png',
          'image2': 'images/allemagne.png',
          'correctImageIndex': 1,
        },
        {
          'indice': 'Je suis l\'un des monuments les plus célèbres de Paris situé à champs elysées l\'extrémité ouest de l\'avenue sur la place Charles-de-Gaulle, également connue sous le nom de Place de l\'Étoile. Qui Suis-Je ?',
          'image1': 'images/elisee.png',
          'image2': 'images/tour.png',
          'correctImageIndex': 1,
        },
        {
          'indice': 'Je suis un monument en métal emblématique de Paris, souvent appelé "La Dame de Fer". Qui suis-je ?',
          'image1': 'images/hello.png',
          'image2': 'images/tour.png',
          'correctImageIndex': 1,
        },
        {
          'indice': 'Je suis un symbole de liberté, offert par la France aux États-Unis. Je tiens une torche et un livre. Qui suis-je ?',
          'image1': 'images/statut.png',
          'image2': 'images/statute.png',
          'correctImageIndex': 1,
        },
        {
          'indice': 'Je suis un ancien amphithéâtre romain situé à Rome, connu pour les combats de gladiateurs. Qui suis-je ?',
          'image1': 'images/colise.png',
          'image2': 'images/colisee.png',
          'correctImageIndex': 1,
        },
        {
          'indice': 'Je suis un mausolée en marbre blanc, construit par un empereur moghol en mémoire de sa femme. Qui suis-je ?',
          'image1': 'images/mahal.png',
          'image2': 'images/mumbai.png',
          'correctImageIndex': 1,
        },
        {
          'indice': 'Je suis une série de fortifications en Chine, construite pour protéger contre les invasions. Qui suis-je ?',
          'image1': 'images/murail.png',
          'image2': 'images/muraille.png',
          'correctImageIndex': 1,
        },
        {
          'indice': 'Je suis un ancien temple grec situé sur l\'Acropole d\'Athènes. Qui suis-je ?',
          'image1': 'images/part.png',
          'image2': 'images/parte.png',
          'correctImageIndex': 1,
        },
      ];
    } else if (widget.level == 'personnalités') {
      gameData = [
        {
          'indice': 'Je suis un physicien théoricien qui a développé la théorie de la relativité. Qui suis-je ?',
          'image1': 'images/albert.png',
          'image2': 'images/martin.png',
          'correctImageIndex': 0,
        },
        {
          'indice': 'Je suis le créateur d\'un langage de programmation largement utilisé pour le développement web côté serveur. Mon langage a commencé comme un ensemble de scripts CGI écrits en C. Qui suis-je ?',
          'image1': 'images/php.png',
          'image2': 'images/javascript.png',
          'correctImageIndex': 1,
        },
        {
          'indice': 'Je suis le fondateur de Microsoft, une des entreprises les plus influentes dans l\'industrie du logiciel. Qui suis-je ?',
          'image1': 'images/gates.png',
          'image2': 'images/jobs.png',
          'correctImageIndex': 0,
        },
      ];
    } else if (widget.level == 'logiques') {
      gameData = [
        {
          'indice': 'Je suis une figure de la logique classique, connue pour mes paradoxes impliquant des ensembles et l\'auto-référence. Qui suis-je ?',
          'image1': 'images/turing.png',
          'image2': 'images/russell.png',
          'correctImageIndex': 1,
        },
        {
          'indice': 'Je suis connu pour ma machine, un modèle abstrait de computation qui a eu une grande influence sur l\'informatique théorique. Qui suis-je ?',
          'image1': 'images/turing.png',
          'image2': 'images/russell.png',
          'correctImageIndex': 0,
        },
        {
          'indice': 'Je suis un mathématicien qui a posé le problème des fondations des mathématiques et ai établi le premier modèle de l\'arithmétique. Qui suis-je ?',
          'image1': 'images/turing.png',
          'image2': 'images/peano.png',
          'correctImageIndex': 1,
        },
      ];
    }
  }

  void checkAnswer(int index) {
    setState(() {
      answeredCorrectly = index == gameData[currentQuestionIndex]['correctImageIndex'];
      showCorrectAnswer = true;
      if (answeredCorrectly) {
        score++;
      }
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          currentQuestionIndex++;
          answeredCorrectly = false;
          showCorrectAnswer = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex >= gameData.length) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Devine l\'image'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Jeu terminé! Votre score: $score', style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: Text('Retour à l\'accueil'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Devine l\'image'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/lola.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                gameData[currentQuestionIndex]['indice'],
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: showCorrectAnswer ? null : () => checkAnswer(0),
                    child: Container(
                      width:300,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: showCorrectAnswer
                              ? (gameData[currentQuestionIndex]['correctImageIndex'] == 0
                                  ? Colors.green
                                  : Colors.red)
                              : Colors.transparent,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          gameData[currentQuestionIndex]['image1'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: showCorrectAnswer ? null : () => checkAnswer(1),
                    child: Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: showCorrectAnswer
                              ? (gameData[currentQuestionIndex]['correctImageIndex'] == 1
                                  ? Colors.green
                                  : Colors.red)
                              : Colors.transparent,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          gameData[currentQuestionIndex]['image2'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (showCorrectAnswer)
                Text(
                  answeredCorrectly ? 'Bonne réponse!' : 'Mauvaise réponse!',
                  style: TextStyle(fontSize: 18, color: answeredCorrectly ? Colors.green : Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
