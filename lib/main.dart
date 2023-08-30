import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admob_ads/AdmobAds/AdDsiplay.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(

  );
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admob Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Admob Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BannerAd? banner_ad;

  bool _isLoaded=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            !_isLoaded?Container():Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: SizedBox(
                  width: banner_ad!.size.width.toDouble(),
                  height: banner_ad!.size.height.toDouble(),
                  child: AdWidget(ad: banner_ad!),
                ),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              DisplayBannerAd();
            }, child: Text("Show Banner Ad")),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              AdDsiplay().loadInterstitial();
            }, child: Text("Display an interstitial ad")),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              AdDsiplay().loadRewarded();
            }, child: Text("Display an rewarded ad")),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              AdDsiplay().loadRewardedInterstitialAd();
            }, child: Text("Display Rewarded Interstitial ad")),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              AdDsiplay().loadopenAppAd();
            }, child: Text("Display App Open Ad")),
          ],
        ),
      ),
    );
  }

  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716'
  ;
  final adUnitIdLive = Platform.isAndroid
      ? 'ca-app-pub-4816405694010595/9963563115'
      : 'ca-app-pub-3940256099942544/2934735716';

  DisplayBannerAd(){
    banner_ad=BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          print('$ad loaded.');
          setState(() {
            _isLoaded = true;
          });
          // setState(() {
          //   _isLoaded = true;
          // });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          print('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
    setState(() {

    });
  }
}
