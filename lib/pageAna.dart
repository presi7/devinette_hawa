import 'package:flutter/material.dart';

void main() {
  runApp(MonApp());
}

class MonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anagrammes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnagrammesPage(),
    );
  }
}

class AnagrammesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anagrammes'),
      ),
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('images/A.png', fit: BoxFit.cover),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LevelsPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 62, 11, 182),
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
                    backgroundColor: Color.fromARGB(255, 62, 11, 182),
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

class LevelsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choisissez un niveau'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            'images/A.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GamePage(level: Level.Facile)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 62, 11, 182),
                    foregroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.shuffle),
                      SizedBox(width: 40),
                      Text('Facile'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GamePage(level: Level.Moyen)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 62, 11, 182),
                    foregroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.shuffle),
                      SizedBox(width: 40),
                      Text('Moyen'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GamePage(level: Level.Difficile)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 62, 11, 182),
                    foregroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.shuffle),
                      SizedBox(width: 40),
                      Text('Difficile'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum Level {
  Facile,
  Moyen,
  Difficile,
}

class AnagramGame {
  final List<Word> easyWords = [
    Word(original: 'Table', shuffled: 'Balte'),
    Word(original: 'Chien', shuffled: 'Inche'),
    Word(original: 'Livre', shuffled: 'Viler'),
    Word(original: 'Fleur', shuffled: 'Rufle'),
  ];

  final List<Word> mediumWords = [
    Word(original: 'Banane', shuffled: 'Aanenb'),
    Word(original: 'Avion', shuffled: 'Niova'),
    Word(original: 'Girafe', shuffled: 'Fagire'),
    Word(original: 'Jardin', shuffled: 'Nardij'),
  ];

  final List<Word> difficultWords = [
    Word(original: 'Algorithme', shuffled: 'Rhotalgime'),
    Word(original: 'Javascript', shuffled: 'Jitvaspcra'),
    Word(original: 'Informatique', shuffled: 'Fauqomritine'),
    Word(original: 'Université', shuffled: 'Tinsvireéu'),
  ];

  List<Word> getWords(Level level) {
    switch (level) {
      case Level.Facile:
        return easyWords;
      case Level.Moyen:
        return mediumWords;
      case Level.Difficile:
        return difficultWords;
      default:
        return easyWords;
    }
  }
}

class Word {
  final String original;
  final String shuffled;

  Word({required this.original, required this.shuffled});
}

class GamePage extends StatefulWidget {
  final Level level;

  GamePage({required this.level});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late List<Word> words;
  late Word currentWord;
  int currentIndex = 0;
  int score = 0;
  TextEditingController answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    words = AnagramGame().getWords(widget.level);
    currentWord = words[currentIndex];
  }

  void checkAnswer(String userAnswer) {
    if (userAnswer.trim().toLowerCase() == currentWord.original.toLowerCase()) {
      setState(() {
        score++;
        if (currentIndex < words.length - 1) {
          currentIndex++;
          currentWord = words[currentIndex];
          answerController.clear();
        } else {
          showEndGameDialog();
        }
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Mauvaise réponse'),
            content: Text('Essayez à nouveau !'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void showEndGameDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Niveau Terminé'),
          content: Text('Votre score : $score / ${words.length}. Félicitations ! Continuez au niveau suivant.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (widget.level == Level.Facile) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GamePage(level: Level.Moyen)),
                  );
                } else if (widget.level == Level.Moyen) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GamePage(level: Level.Difficile)),
                  );
                } else {
                  Navigator.of(context).popUntil(ModalRoute.withName('/'));
                }
              },
              child: Text('Niveau Suivant'),
            ),
          ],
        );
      },
    );
  }

  Widget buildGameButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: Text('Quitter'),
        ),
        SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            if (currentIndex < words.length - 1) {
              setState(() {
                currentIndex++;
                currentWord = words[currentIndex];
                answerController.clear();
              });
            } else {
              showEndGameDialog();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: Text('Passer au mot suivant'),
        ),
      ],
    );
  }

  Widget buildScore() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(score, (index) => Icon(Icons.monetization_on, color: Colors.yellow, size: 30)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jeu des Anagrammes'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/greenn.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildScore(),
              SizedBox(height: 20),
              Text('Définissez le mot correct : ${currentWord.shuffled}', style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              TextField(
                controller: answerController,
                decoration: InputDecoration(
                  hintText: 'Entrez votre réponse',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  checkAnswer(answerController.text);
                },
                child: Text('Valider'),
              ),
              SizedBox(height: 20),
              buildGameButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
