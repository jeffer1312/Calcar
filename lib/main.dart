import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = 'ED066FA163898D7C3E92B010B72484C1';




void main() {
  runApp(new MaterialApp(
    home: new HomePage(),
  ));
}
//InterstitialAd myInterstitial;
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _index = 0;
  TextEditingController kmpController = TextEditingController();
  TextEditingController kmPlController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController qtdGasController = TextEditingController();
  TextEditingController alcoolController = TextEditingController();
  TextEditingController vlrController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _priceFinal = "Informe os dados";

  void _resetFields() {
    kmpController.text = "";
    kmPlController.text = "";
    priceController.text = "";
    qtdGasController.text = "";
    alcoolController.text = "";
    vlrController.text = "";

    setState(() {
      _priceFinal = "Informe Os Dados";
    });
  }

  void _calculate() {
    setState(() {

      double kmp = double.parse(kmpController.text);
      double kmPl = double.parse(kmPlController.text);
      double priceGasolina = double.parse(priceController.text);
      double price = (kmp / kmPl) * priceGasolina;

      _priceFinal = "Preço a Cobrar: ${price.toStringAsPrecision(4)} Reais";
    });
  }
  void _calculate1() {
    setState(() {
      double kmp = double.parse(kmpController.text);
      double qtd = double.parse(qtdGasController.text);
      double kmPL = kmp/qtd ;

      _priceFinal = "Seu carro faz: ${kmPL.toStringAsPrecision(2)} com 1 Litro";
    });
  }
  void _calculate2() {
    setState(() {
      double gas = double.parse(priceController.text);
      double alc = double.parse(alcoolController.text);
      double best = alc/gas ;


      if(best < 0.7){
        _priceFinal = "E melhor abaster Alcool";
      }else if(best > 0.7){
        _priceFinal = "E melhor abaster gasolina";
      }

    });
  }
  void _calculate3() {
    setState(() {
      double price = double.parse(priceController.text);
      double vlr = double.parse(vlrController.text);
      double lt = price/vlr ;
      _priceFinal = "Vai dar: ${lt.toStringAsPrecision(4)} Litros";




    });
  }

  Widget _switcherBody() {
    switch (_index) {

      case 0:
        return new Scaffold(
          appBar: AppBar(
            title: Text("Limpar Dados"),
            centerTitle: true,
            backgroundColor: Colors.blue,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: _resetFields,
              )
            ],
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.directions_car, size: 120.0, color: Colors.black),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Quilometros que ira Percorrer (km)",
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    controller: kmpController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira Quilometragem percorrida";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Quilometros por litro(km)",
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    controller: kmPlController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira Quantos Km seu Carro faz com um litro";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Valor do Combustivel ",
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    controller: priceController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira preço da gasolina";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10.0),
                    child: Container(
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _calculate();
                            }
                          },
                          child: Text(
                            "Calcular",
                            style: TextStyle(color: Colors.white, fontSize: 25.0),
                          ),
                          color: Colors.blue,
                        )),
                  ),
                  Text(
                    _priceFinal,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 25.0),
                  )
                ],
              ),
            ),
          ),
        );
    //tela km por litro do carro
      case 1:
        return new Scaffold(
          appBar: AppBar(
            title: Text("Limpar Dados"),
            centerTitle: true,
            backgroundColor: Colors.blue,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: _resetFields,
              )
            ],
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.local_gas_station, size: 120.0, color: Colors.black),

                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Quilometros percorridos(km)",
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 25.0),
                    controller: kmpController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira Quantos Km seu Carro faz com um litro";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Quantidade de gasolina(lt) ",
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 25.0),
                    controller: qtdGasController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira preço da gasolina";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10.0),
                    child: Container(
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _calculate1();
                            }
                          },
                          child: Text(
                            "Calcular",
                            style: TextStyle(color: Colors.white, fontSize: 25.0),
                          ),
                          color: Colors.blue,
                        )),
                  ),
                  Text(
                    _priceFinal,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 25.0),
                  )
                ],
              ),
            ),
          ),

        );
    //tela alcol ou gasolina
      case 2:
        return new Scaffold(
          appBar: AppBar(
            title: Text("Limpar Dados"),
            centerTitle: true,
            backgroundColor: Colors.blue,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: _resetFields,
              )
            ],
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.local_gas_station, size: 120.0, color: Colors.black),

                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "preço gasolina",
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 25.0),
                    controller: priceController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira Quantos Km seu Carro faz com um litro";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "preço Alcool ",
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 25.0),
                    controller: alcoolController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira preço da gasolina";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10.0),
                    child: Container(
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _calculate2();
                            }
                          },
                          child: Text(
                            "Calcular",
                            style: TextStyle(color: Colors.white, fontSize: 25.0),
                          ),
                          color: Colors.blue,
                        )),
                  ),
                  Text(
                    _priceFinal,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 25.0),
                  )
                ],
              ),
            ),
          ),

        );
      case 3:
        return new Scaffold(
          appBar: AppBar(
            title: Text("Limpar Dados"),
            centerTitle: true,
            backgroundColor: Colors.blue,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: _resetFields,
              )
            ],
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.local_gas_station, size: 120.0, color: Colors.black),

                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Valor a abastercer",
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 25.0),
                    controller: priceController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "valor a abastecer";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Preço do combustivel",
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 25.0),
                    controller: vlrController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira preço da gasolina";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10.0),
                    child: Container(
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _calculate3();
                            }
                          },
                          child: Text(
                            "Calcular",
                            style: TextStyle(color: Colors.white, fontSize: 25.0),
                          ),
                          color: Colors.blue,
                        )),
                  ),
                  Text(
                    _priceFinal,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 25.0),
                  )
                ],
              ),
            ),
          ),

        );



    }
    return null;
  }
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['Gasolina','Carro','Viagens','Games','PubG','Free fire'],
    contentUrl: 'https//flutter.io',
    childDirected: false,
    //testDevices: <String>[],
    //testDevices: testDevice != null ? <String>[testDevice] : null,
    //
   // nonPersonalizedAds: true,
    
   
  );
  
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;
  
   
  BannerAd createBannerAd(){
    return BannerAd(
      adUnitId: Platform.isAndroid
       ?  'ca-app-pub-1187165467162295/6300299790'
       :  'ID-IOS-banner',    
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event){
        print("BannerAd $event");
      }

    );
  }

  InterstitialAd createInterstitialAd(){
    return InterstitialAd(
      adUnitId: Platform.isAndroid
       ?  'ca-app-pub-1187165467162295/2345577065'
       :  'ID-IOS-Banneer',
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event){
        print("InterstitialAd $event");
      }

    );
  }
  
  @override
  void initState() {
     FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-1187165467162295~2498933389")
        .then((response){
          _bannerAd = createBannerAd()..load()..show(
            anchorType: AnchorType.bottom,
          );
          _interstitialAd = createInterstitialAd()..load()..show(
                anchorType: AnchorType.bottom,
                anchorOffset: 0.0,
                horizontalCenterOffset: 0.0,
          );
     /* myInterstitial
        ..load()
        ..show(
          anchorType: AnchorType.bottom,
          anchorOffset: 0.0,
          horizontalCenterOffset: 0.0,
        );
      myBanner
        ..load()
        ..show();*/
    });
    super.initState();
  }
  @override
  void dispose() {
    _bannerAd.dispose();
    _interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    return new Scaffold(
      appBar: new AppBar(title: new Text("Menu")),
      body: _switcherBody(),
      drawer: new Drawer(
        child: new ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Menu',style: TextStyle(color: Colors.white)),
                decoration: BoxDecoration(
                  color: Colors.black87,
                ),
              ),

              ListTile(
                title: Text('Quanto vou gastar(ou gastei) para percorrer'),
                onTap: () {
                  setState(() {
                    _index = 0;
                    _resetFields();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Quanto faço com 1 Lt. de Combustivel'),
                onTap: () {
                  setState(() {
                    _index = 1;
                    _resetFields();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Gasolina ou Alcool?'),
                onTap: () {
                  setState(() {
                    _index = 2;
                    _resetFields();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Quantos Lt.? vai dar'),
                onTap: () {
                  setState(() {
                    _index = 3;
                    _resetFields();
                  });
                  Navigator.pop(context);
                },
              ),

            ]),
      ),
    );
  }
}
/*MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['Carros', 'Combustivel','Games','Moda','Smartphones'],
  childDirected: false,
  testDevices: <String>[], // Android emulators are considered test devices
);*/

/*BannerAd myBanner = BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: 'ca-app-pub-1187165467162295/8642649840',//'ca-app-pub-1187165467162295/6300299790',
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);*/

