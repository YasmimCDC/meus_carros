import 'package:flutter/material.dart';
import 'package:meus_carros/src/home/home-bloc.dart';
import 'package:meus_carros/src/login/login-widget.dart';
import 'package:meus_carros/src/model/car.dart';
import 'package:meus_carros/src/model/user.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final HomeBloc bloc = HomeBloc();

  @override
  void initState() {
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.yellow[400],
            title: Text(
              "Meus carros",
              style: TextStyle(color: Colors.black),
            ),
            leading: Builder(builder: (BuildContext context) {
              return IconButton(
                  icon: const Icon(Icons.account_circle_outlined),
                  color: Colors.black,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip);
            })),
        drawer: _creatDrawerWithUserInfo(),
        backgroundColor: Colors.grey[900],
        body: Column(children: <Widget>[
          Expanded(
              child: StreamBuilder(
                  stream: bloc.carros,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Car>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return _buildListCars(context, snapshot.data[index]);
                        });
                  }))
        ]));
  }

  _creatDrawerWithUserInfo() {
    return StreamBuilder(
        stream: bloc.user,
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("Nenhum usuário logado."),
            );
          }
          var user = snapshot.data;
          return Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.grey[900]),
              child: Drawer(
                  child: ListView(
                padding: EdgeInsets.all(0.0),
                children: <Widget>[
                  _createHeader(user),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20.0,
                      left: 20.0,
                      bottom: 10,
                    ),
                    child: Text(user.nome,
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white.withOpacity(0.8))),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        left: 30.0,
                        bottom: 270.0,
                      ),
                      child: Text(
                        user.email,
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12, color: Colors.white.withOpacity(0.6)),
                      )),
                  Container(
                      color: Colors.yellow[400], child: _createFooterItem())
                ],
              )));
        });
  }

  _createHeader(User user) {
    return DrawerHeader(
      padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
      decoration: BoxDecoration(
          color: Colors.yellow[400],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0))),
      child: CircleAvatar(
        radius: 80,
        child: Container(
          width: 140.0,
          height: 140.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.fill, image: NetworkImage(user.foto))),
        ),
      ),
    );
  }

  _createFooterItem() {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(Icons.exit_to_app_outlined),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text("LogOut"),
          )
        ],
      ),
      onTap: _onClickLogout,
    );
  }

  _onClickLogout() async {
    await bloc.signOut();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginWidget()));
  }

  Widget _buildListCars(BuildContext context, Car carro) {
    return Container(
        padding: EdgeInsets.all(6),
        child: Center(
            child: Column(
          children: <Widget>[
            Card(
              elevation: 5,
              color: Colors.white.withOpacity(0.8),
              child: Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                      carro.fot,
                      height: 140,
                      width: 140,
                      fit: BoxFit.scaleDown,
                    ),
                    Container(
                        padding: EdgeInsets.all(20),
                        child: Column(children: <Widget>[
                          Text(
                            carro.model + " - " + carro.anoMod,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                          Text("Fabricação: " + carro.anoFabri,
                              style: TextStyle(fontSize: 12)),
                          Text(
                            "Placa: " + carro.plac,
                            style: TextStyle(fontSize: 12),
                          )
                        ]))
                  ],
                ),
              ),
            )
          ],
        )));
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
