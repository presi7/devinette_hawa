import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(ImagesMot());
}

class ImagesMot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '4 images 1 mot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('4 images 1 mot'),
      ),
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'images/backima.png',
              fit: BoxFit.cover,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GameScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 205, 44, 8),
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
                    backgroundColor: Color.fromARGB(255, 205, 44, 8),
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

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<Map<String, dynamic>> puzzles = [
    {
      'word': 'transport',
      'images': [
        'images/voiture.png',
        'images/avion.png',
        'images/train.png',
        'images/moto.png',
      ]
    },
    {
      'word': 'Sénégal',
      'images': [
        'images/sn1.png',
        'images/sn2.png',
        'images/sn3.png',
        'images/sn4.png',
      ]
    },
    {
      'word': 'informatique',
      'images': [
        'images/py1.png',
        'images/py2.png',
        'images/py3.png',
        'images/py4.png',
      ],
    },
    {
      'word': 'Pensée',
      'images': [
        'images/pe1.png',
        'images/pe2.png',
        'images/pe3.png',
        'images/pe4.png',
      ],
    },
  ];

  final List<TextEditingController> _controllers = [];
  final List<String> _feedbacks = [];
  int _score = 0;
  Timer? _timer;
  int _timeLeft = 60;
  int _currentPuzzleIndex = 0;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < puzzles.length; i++) {
      _controllers.add(TextEditingController());
      _feedbacks.add('');
    }
    _startTimer();
  }

  void _startTimer() {
    _timeLeft = 60;
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void _checkGuess(int index) {
    setState(() {
      if (_controllers[index].text.toLowerCase() == puzzles[index]['word'].toLowerCase()) {
        _feedbacks[index] = 'Correct!';
        _score++;
        if (_currentPuzzleIndex < puzzles.length - 1) {
          _currentPuzzleIndex++;
        }
      } else {
        _feedbacks[index] = 'Incorrect, essayez encore.';
      }
    });
  }

  void _nextPuzzle() {
    if (_currentPuzzleIndex < puzzles.length - 1) {
      setState(() {
        _currentPuzzleIndex++;
        for (var controller in _controllers) {
          controller.clear();
        }
        for (var i = 0; i < _feedbacks.length; i++) {
          _feedbacks[i] = '';
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jeu de Devinettes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Text(
              'Temps restant: $_timeLeft secondes',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 5.0),
            Text(
              'Score: $_score',
              style: TextStyle(fontSize: 20.0),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _currentPuzzleIndex + 1,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 3.0,
                          childAspectRatio: 1,
                        ),
                        itemCount: puzzles[index]['images'].length,
                        itemBuilder: (context, imgIndex) {
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2.0),
                            ),
                            child: Image.asset(
                              puzzles[index]['images'][imgIndex],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                      TextField(
                        controller: _controllers[index],
                        decoration: InputDecoration(
                          labelText: 'Devinez le mot',
                        ),
                      ),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () => _checkGuess(index),
                        child: Text('Vérifier'),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        _feedbacks[index],
                        style: TextStyle(
                          color: _feedbacks[index] == 'Correct!' ? Colors.green : Colors.red,
                          fontSize: 18.0,
                        ),
                      ),
                      Divider(thickness: 1.0),
                      ElevatedButton(
                        onPressed: _nextPuzzle,
                        child: Text('Passer au suivant'),
                      ),
                    ],
                  );
                },
              ),
            ),
            if (_timeLeft <= 0)
              Column(
                children: <Widget>[
                  Text(
                    'Temps écoulé! Vous avez perdu.',
                    style: TextStyle(fontSize: 20.0, color: Colors.red),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _startTimer();
                        _score = 0;
                        _currentPuzzleIndex = 0;
                        for (var controller in _controllers) {
                          controller.clear();
                        }
                        _feedbacks.clear();
                        for (var i = 0; i < puzzles.length; i++) {
                          _feedbacks.add('');
                        }
                      });
                    },
                    child: Text('Recommencer'),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Êtes-vous sûr de vouloir quitter le jeu ?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Annuler'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: Text('Quitter'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Quitter'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
