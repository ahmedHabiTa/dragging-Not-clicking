import 'package:fiction_team_task/components/Animation/FadeAnimation.dart';
import 'package:fiction_team_task/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class MyInfoScreen extends StatefulWidget {
  static const routeName = 'AuthenticationScreen';

  @override
  _MyInfoScreenState createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  String image = 'assets/images/shopping3.jpg';

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            '$image',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
            alignment: FractionalOffset(_animation.value, 0),
          ),
          Center(
            child: FadeAnimation(
              2,
              SizedBox(
                width: MediaQuery.of(context).size.width*0.4,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blue[900]),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: Colors.blue[900]),
                      ),
                    ),
                  ),
                  onPressed: () =>Navigator.of(context).pushReplacementNamed(HomeScreen.routeName),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Run App',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 35,
      ),
    );
  }
}
