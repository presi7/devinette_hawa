import 'package:flutter/material.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Devine le Pays',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaysPage(),
    );
  }
}

class PaysPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Devine le Pays'),
      ),
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('images/day.png', fit: BoxFit.cover),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CategoriesPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color(0xFF107516),
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
                    backgroundColor: Color(0xFF107516),
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

class Category {
  final String name;
  final String imagePath;

  Category({required this.name, required this.imagePath});
}

class CategoriesPage extends StatelessWidget {
  final List<Category> categories = [
    Category(name: 'Facile', imagePath: 'assets/easy.jpg'),
    Category(name: 'Moyen', imagePath: 'assets/medium.jpg'),
    Category(name: 'Difficile', imagePath: 'assets/hard.jpg'),
  ];

  void navigateToCategory(BuildContext context, Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GamePage(category: category.name)),
    );
  }

  void navigateToHomePage(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choisissez un niveau'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/day.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    navigateToHomePage(context);
                  },
                  child: Text(
                    'Retour à l\'Accueil',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 25),
                ...categories.map((category) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => navigateToCategory(context, category),
                        child: Text(
                          category.name,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 25),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class GamePage extends StatefulWidget {
  final String category;

  GamePage({required this.category});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final Map<String, List<Map<String, String>>> questions = {
    'Facile': [
      {'question': 'Capitale de la France', 'answer': 'Paris', 'flag': 'images/france.png'},
       {'question': 'Capitale de la Belgique', 'answer': 'Bruxelles', 'flag': 'images/belgique.png'},
        {'question': 'Capitale de l\'Autriche', 'answer': 'Vienne', 'flag': 'images/australie.png'},
      {'question': 'Capitale de la Norvège', 'answer': 'Oslo', 'flag': 'images/oslo.png'},
      {'question': 'Capitale de la Suède', 'answer': 'Stockholm', 'flag': 'images/sto.png'},
      {'question': 'Capitale de la Hollande', 'answer': 'Amsterdam', 'flag': 'images/amsterdam.png'},
      {'question': 'Capitale de l\'Irlande', 'answer': 'Dublin', 'flag': 'images/dublin.png'},
      {'question': 'Capitale de la Pologne', 'answer': 'Varsovie', 'flag': 'images/varsovie.png'},
      {'question': 'Capitale du Danemark', 'answer': 'Copenhague', 'flag': 'images/copen.png'},
      {'question': 'Capitale de la Finlande', 'answer': 'Helsinki', 'flag': 'images/hels.png'},
      {'question': 'Capitale de la Hongrie', 'answer': 'Budapest', 'flag': 'images/budapest.png'},
      {'question': 'Capitale de la Turquie', 'answer': 'Ankara', 'flag': 'images/ankara.png'},
      {'question': 'Capitale de la Grèce', 'answer': 'Athènes', 'flag': 'images/athene.png'},
      {'question': 'Capitale de l\'Iran', 'answer': 'Téhéran', 'flag': 'images/teheran.png'},
      {'question': 'Capitale de la Corée du Sud', 'answer': 'Séoul', 'flag': 'images/seoul.png'},
      
       // Add more questions for the 'Facile' category
    ],
    'Moyen': [
       {'question': 'Capitale de la Belgique', 'answer': 'Bruxelles', 'flag': 'images/belgique.png'},
       {'question': 'Capitale de l\'Espagne', 'answer': 'Madrid', 'flag': 'images/espagne.png'},
      {'question': 'Capitale de l\'Italie', 'answer': 'Rome', 'flag': 'images/italie.png'},
      {'question': 'Capitale du Portugal', 'answer': 'Lisbonne', 'flag': 'images/portugal.png'},
      {'question': 'Capitale de l\'Allemagne', 'answer': 'Berlin', 'flag': 'images/allemagne.png'},
      {'question': 'Capitale de l\'Angleterre', 'answer': 'Londres', 'flag': 'images/englais.png'},
      {'question': 'Capitale de la Chine', 'answer': 'Pékin', 'flag': 'images/chine.png'},
      {'question': 'Capitale des Etats-Unis', 'answer': 'Washington', 'flag': 'images/usa.png'},
      {'question': 'Capitale de l\'Inde', 'answer': 'New Delhi', 'flag': 'images/inde.png'},
      {'question': 'Capitale de la Russie', 'answer': 'Moscou', 'flag': 'images/russie.png'},
      {'question': 'Capitale du Japon', 'answer': 'Tokyo', 'flag': 'images/japon.png'},
      {'question': 'Capitale du Canada', 'answer': 'Ottawa', 'flag': 'images/canada.png'},
      {'question': 'Capitale du Brésil', 'answer': 'Brasilia', 'flag': 'images/brazil.png'},
      {'question': 'Capitale de l\'Argentine', 'answer': 'Buenos Aires', 'flag': 'images/argentine.png'},
      {'question': 'Capitale de l\'Egypte', 'answer': 'Le Caire', 'flag': 'images/egypte.png'},
    ],
    'Difficile': [
      {'question': 'Capitale de l\'Arabie Saoudite', 'answer': 'Riyad', 'flag': 'images/arabie.png'},
  {'question': 'Capitale de la Mongolie', 'answer': 'Oulan-Bator', 'flag': 'images/mongolie.png'},
        {'question': 'Capitale du Kazakhstan', 'answer': 'Astana', 'flag': 'images/astana.png'},
      {'question': 'Capitale du Botswana', 'answer': 'Gaborone', 'flag': 'images/botswana.png'},
      {'question': 'Capitale du Kirghizistan', 'answer': 'Bichkek', 'flag': 'images/bich.png'},
      {'question': 'Capitale du Tadjikistan', 'answer': 'Douchanbé', 'flag': 'images/dou.png'},
      {'question': 'Capitale de l\'Ouganda', 'answer': 'Kampala', 'flag': 'images/kampala.png'},
      {'question': 'Capitale de la Nouvelle-Zélande', 'answer': 'Wellington', 'flag': 'images/wel.png'},
      {'question': 'Capitale du Guatemala', 'answer': 'Guatemala', 'flag': 'images/gua.png'},
      {'question': 'Capitale de l\'Ethiopie', 'answer': 'Addis-Abeba', 'flag': 'images/adis.png'},
      {'question': 'Capitale de la Guinée', 'answer': 'Conakry', 'flag': 'images/conakry.png'},
      {'question': 'Capitale de la Bolivie', 'answer': 'La Paz', 'flag': 'images/bolivie.png'},
      {'question': 'Capitale du Paraguay', 'answer': 'Asuncion', 'flag': 'images/para.png'},
      {'question': 'Capitale de Madagascar', 'answer': 'Antananarivo', 'flag': 'images/mada.png'},
      {'question': 'Capitale de la Thaïlande', 'answer': 'Bangkok', 'flag': 'images/bangkok.png'},
    ],
  };

  int currentQuestionIndex = 0;
  int score = 0;
  TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> selectedQuestions = questions[widget.category] ?? [];
    final Map<String, String> currentQuestion = selectedQuestions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Jeu ${widget.category}'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(219, 1, 130, 18), // Couleur rose en fond d'écran
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  currentQuestion['flag'] ?? '',
                  width: 500,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20),
                Text(
                  currentQuestion['question'] ?? '',
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: answerController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Votre réponse',
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (answerController.text.trim().toLowerCase() == currentQuestion['answer']!.toLowerCase()) {
                          setState(() {
                            score++;
                          });
                        }

                        if (currentQuestionIndex < selectedQuestions.length - 1) {
                          setState(() {
                            currentQuestionIndex++;
                            answerController.clear();
                          });
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Jeu Terminé'),
                                content: Text('Votre score: $score/${selectedQuestions.length}'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop(); // Sortir du jeu et revenir à l'écran de sélection
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text('Valider'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (currentQuestionIndex < selectedQuestions.length - 1) {
                          setState(() {
                            currentQuestionIndex++;
                            answerController.clear();
                          });
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Jeu Terminé'),
                                content: Text('Votre score: $score/${selectedQuestions.length}'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop(); // Sortir du jeu et revenir à l'écran de sélection
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text('Passer'),
                    ),
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
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Oui'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Quitter'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Score: $score',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
