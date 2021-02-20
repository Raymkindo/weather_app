import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MaterialApp(
      title: "Weather App",
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async {
    http.Response response = await http.get("http://api.openweathermap.org/data/2.5/weather?q=morogoro&units=metric&appid=50788e4aab3bb0443250aac03bd5de23");
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [],
        ),
        body: Column(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "Currently in Morogoro",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Text( 
                      temp != null ? temp.toString() + "\u00B0" + "C": "Loading",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.w600)),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                         description != null ? description.toString() : "Loading",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                )),
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temperature"),
                    trailing: Text(
                      temp != null ? temp.toString() + "\u00B0" : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Weather"),
                    trailing: Text(
                      description != null ? description.toString() : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Humidity"),
                    trailing: Text(
                      currently != null ? currently.toString() : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind Speed"),
                    trailing: Text(
                      windSpeed != null ? windSpeed.toString() +" " +"mph" : "Loading"),
                  ),
                ],
              ),
            ))
          ],
        ));
  }
}
