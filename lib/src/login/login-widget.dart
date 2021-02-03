import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meus_carros/src/login/login-bloc.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
        bloc: LoginBloc(context),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.network(
                "https://i.pinimg.com/originals/82/84/f2/8284f20aa493854176b2fefd93ba45bc.png",
                fit: BoxFit.cover),
            _LoginContent(),
          ],
        ));
  }
}

class _LoginContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: Container(
            padding: EdgeInsets.all(48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Meus Carros",
                      style: GoogleFonts.zcoolXiaoWei(
                          textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                      ))),
                ),
                Spacer(),
                StreamBuilder(
                    initialData: false,
                    stream: bloc.outLoading,
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      return snapshot.hasData && snapshot.data
                          ? CircularProgressIndicator()
                          : _botaoLogin(context);
                    })
              ],
            )));
  }

  _botaoLogin(context) {
    final bloc = BlocProvider.of<LoginBloc>(context);
    return OutlineButton(
      onPressed: bloc.onClickLogin,
      splashColor: Colors.blue[900],
      highlightedBorderColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      borderSide: BorderSide(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Icon(FontAwesomeIcons.google, color: Colors.blue)),
          Padding(
            padding: EdgeInsets.all(11.0),
            child: Text("Login com o Google",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                )),
          )
        ],
      ),
    );
  }
}
