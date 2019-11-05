import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/Perfil.dart';
import 'package:flutter_app/pages/Register.dart';
import 'package:flutter_app/pages/TrocaSenha.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  bool selected = false;
  double padValue = 100;
  double opacidade = 0.0;
  AnimationController _controller;
  List<Bubble> bubbles;
  final int numberOfBubbles = 400;
  final Color color = Colors.orange;
  final double maxBubbleSize = 12.0;

  _updatePadding(double value) => setState(() => padValue = value);

  void _changeOpacity() {
    setState(() => opacidade = opacidade == 0 ? 1.0 : 0.0);
  }

  void initState() {
    super.initState();

    setState(() {
      selected = !selected;
    });
    bubbles = List();
    int i = numberOfBubbles;
    while (i > 0) {
      bubbles.add(Bubble(color, maxBubbleSize));
      i--;
    }

    _controller = new AnimationController(
        duration: const Duration(seconds: 2000), vsync: this);
    _controller.addListener(() {
      updateBubblePosition();
      _updatePadding(0);
      _changeOpacity();
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: Container(
        padding: EdgeInsets.only(top: 10),
        child: Stack(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.transparent,
              maxRadius: 135,

              //Tentar fade in para colocar gif de "loading" Eclipse.gif

              backgroundImage: NetworkImage(
                  'https://i.kym-cdn.com/photos/images/original/001/551/110/769.gif'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 0),
              child: AnimatedOpacity(
                opacity: opacidade,
                duration: Duration(seconds: 2),
                child: Text(
                  'Otaku Library',
                  textScaleFactor: 2.0,
                  style: TextStyle(
                    color: Colors.orange,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 8.0,
                        color: Color.fromARGB(125, 0, 0, 255),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedPadding(
              padding: EdgeInsets.all(padValue),
              duration: const Duration(milliseconds: 1500),
              curve: Curves.easeInOut,
            ),
          ],
        ),
      ),
    );

    String _email, _password;
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    Future<String> signIn() async {
      final formState = _formkey.currentState;
      if (formState.validate()) {
        formState.save();
        //Login FIREBASE
        AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
            email: _email, password: _password);
        FirebaseUser user = result.user;
        Navigator.pushNamed(context, '/Library');
      }
    }

    final email = TextFormField(
      onSaved: (input) => _email = input,
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor, digite o email! ';
        }
      },
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: 'nezuko@gmail.com',
      decoration: InputDecoration(
        hintText: 'E-mail',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      onSaved: (input) => _password = input,
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor, digite a senha! ';
        }
      },
      style: TextStyle(
        color: Colors.white,
      ),
      autofocus: false,
      initialValue: 'some password',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Senha',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: signIn,
        padding: EdgeInsets.all(12),
        color: Colors.orangeAccent[900],
        child: Text('Log In', style: TextStyle(color: Colors.black)),
      ),
    );

    final forgotPassword = Padding(
      padding: EdgeInsets.only(top: 50.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TrocaSenha()),
          );
        },
        child: Center(
          child: Text(
            'Esqueceu sua senha?',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );

    final newUser = Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterPage()),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Novo por aqui?',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              ' Crie sua conta',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.orangeAccent,
            Colors.black54,
            Colors.black54,
            Colors.orangeAccent,
          ]),
        ),
        child: Stack(
          children: [
            CustomPaint(
              //This is Animation as shown in previous video
              foregroundPainter:
                  BubblePainter(bubbles: bubbles, controller: _controller),
              size: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height),
            ),
            Center(
                child: Form(
              key: _formkey,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                children: <Widget>[
                  logo,
                  SizedBox(height: 35.0),
                  email,
                  SizedBox(height: 8.0),
                  password,
                  SizedBox(height: 24.0),
                  loginButton,
                  newUser,
                  forgotPassword
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  void updateBubblePosition() {
    bubbles.forEach((it) => it.updatePosition());
    setState(() {});
  }
}

class BubblePainter extends CustomPainter {
  List<Bubble> bubbles;
  AnimationController controller;

  BubblePainter({this.bubbles, this.controller});

  @override
  void paint(Canvas canvas, Size canvasSize) {
    bubbles.forEach((it) => it.draw(canvas, canvasSize));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Bubble {
  Color colour;
  double direction;
  double speed;
  double radius;
  double x;
  double y;

  Bubble(Color colour, double maxBubbleSize) {
    this.colour = colour.withOpacity(Random().nextDouble());
    this.direction = Random().nextDouble() * 360;
    this.speed = 1;
    this.radius = Random().nextDouble() * maxBubbleSize;
  }

  draw(Canvas canvas, Size canvasSize) {
    Paint paint = new Paint()
      ..color = colour
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    assignRandomPositionIfUninitialized(canvasSize);

    randomlyChangeDirectionIfEdgeReached(canvasSize);

    canvas.drawCircle(Offset(x, y), radius, paint);
  }

  void assignRandomPositionIfUninitialized(Size canvasSize) {
    if (x == null) {
      this.x = Random().nextDouble() * canvasSize.width;
    }

    if (y == null) {
      this.y = Random().nextDouble() * canvasSize.height;
    }
  }

  updatePosition() {
    var a = 180 - (direction + 90);
    direction > 0 && direction < 180
        ? x += speed * sin(direction) / sin(speed)
        : x -= speed * sin(direction) / sin(speed);
    direction > 90 && direction < 270
        ? y += speed * sin(a) / sin(speed)
        : y -= speed * sin(a) / sin(speed);
  }

  randomlyChangeDirectionIfEdgeReached(Size canvasSize) {
    if (x > canvasSize.width || x < 0 || y > canvasSize.height || y < 0) {
      direction = Random().nextDouble() * 360;
    }
  }
}
