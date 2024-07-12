import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(MyAp());

class MyAp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Settings Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  void _showPrivacyPolicy(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
    );
  }

  void _showComments(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CommentsPage()),
    );
  }

  void _showSoundSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SoundSettingsPage()),
    );
  }

  void _showHelpFAQ(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HelpFAQPage()),
    );
  }

  void _showLegalMentions(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LegalMentionsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Politique de confidentialité'),
            onTap: () => _showPrivacyPolicy(context),
          ),
          ListTile(
            leading: Icon(Icons.comment),
            title: Text('Commentaires'),
            onTap: () => _showComments(context),
          ),
          ListTile(
            leading: Icon(Icons.volume_up),
            title: Text('Son'),
            onTap: () => _showSoundSettings(context),
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Aide et FAQ'),
            onTap: () => _showHelpFAQ(context),
          ),
          ListTile(
            leading: Icon(Icons.gavel),
            title: Text('Mentions légales'),
            onTap: () => _showLegalMentions(context),
          ),
        ],
      ),
    );
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Politique de confidentialité'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Paragraph(
            'Bienvenue dans notre jeu ! Avant de commencer à jouer, veuillez lire attentivement nos conditions d\'utilisation :'
            'Utilisation du jeu : '
            ' Vous pouvez utiliser notre jeu uniquement à des fins légales et conformément à ces conditions d\'utilisation.'
            'L\'essentiel est que vous vous amusez !'
            'Allez voir les jeux',
          ),
        ],
      ),
    );
  }
}

class Paragraph extends StatelessWidget {
  final String text;

  const Paragraph(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 16.0),
      textAlign: TextAlign.justify,
    );
  }
}

class CommentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commentaires'),
      ),
      body: Center(
        child: Text(
          'Ce jeu de devinettes a été créé pour vous amuser et vous instruire en même temps ! Une pierre deux coups.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class SoundSettingsPage extends StatefulWidget {
  @override
  _SoundSettingsPageState createState() => _SoundSettingsPageState();
}

class _SoundSettingsPageState extends State<SoundSettingsPage> with WidgetsBindingObserver {
  bool _isSoundOn = true;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isResumed = true;

  @override
  void initState() {
    super.initState();
    _loadSoundPreference();
    _initializeAudioPlayer();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _isResumed = true;
      if (_isSoundOn) {
        _audioPlayer.resume();
      }
    } else {
      _isResumed = false;
      _audioPlayer.pause();
    }
  }

  void _loadSoundPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isSoundOn = prefs.getBool('isSoundOn') ?? true;
      _toggleMusic(_isSoundOn);
    });
  }

  void _saveSoundPreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSoundOn', value);
  }

  void _toggleSound(bool value) {
    setState(() {
      _isSoundOn = value;
      _saveSoundPreference(value);
      _toggleMusic(value);
    });
  }

  void _initializeAudioPlayer() async {
    await _audioPlayer.setSource(AssetSource('sounds/son1.mp3'));  // Utiliser la méthode correcte pour charger le fichier audio
  }

  void _toggleMusic(bool play) {
    if (play && _isResumed) {
      _audioPlayer.resume();
    } else {
      _audioPlayer.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres du son'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Son'),
            Switch(
              value: _isSoundOn,
              onChanged: _toggleSound,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

class HelpFAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aide'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Paragraph(
            'Bienvenue dans notre jeu ! Le jeu est composé de plusieurs catégories où chaque catégorie a son propre concept de jeu.',
          ),
          SizedBox(height: 12.0),
          Paragraph(
            'Anagrammes : Ce jeu consiste à trouver le mot correct à partir d\'un mot mélangé.',
          ),
          SizedBox(height: 12.0),
          Paragraph(
            'Calculs : Ce jeu consiste à résoudre des calculs ou à trouver des formules parmi les résultats donnés.',
          ),
          SizedBox(height: 12.0),
          Paragraph(
            'Qui suis-je : Ce jeu consiste à deviner la bonne personne ou l\'image en fonction des questions posées.',
          ),
          SizedBox(height: 12.0),
          Paragraph(
            'Pays : Ce jeu consiste à deviner la capitale d\'un pays en se basant sur un monument ou un drapeau du pays.',
          ),
          SizedBox(height: 12.0),
          Paragraph(
            '4 images 1 mot : Ce jeu consiste à trouver un mot qui décrit les quatre images présentées.',
          ),
        ],
      ),
    );
  }
}

class LegalMentionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mentions légales'),
      ),
      body: Center(
        child: Text('Contenu des mentions légales.'),
      ),
    );
  }
}
