// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AdExampleApp());
}

class AdExampleApp extends StatelessWidget {
  const AdExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const AdsPage(),
    );
  }
}

class AdsPage extends StatefulWidget {
  const AdsPage({Key? key,}) : super(key: key);

  @override
  AdsPageState createState() => AdsPageState();
}

class AdsPageState extends State<AdsPage> {
  bool _isInterstitialAdLoaded = false;

  @override
  void initState() {
    super.initState();
    FacebookAudienceNetwork.init(
      testingId: "a77955ee-3304-4635-be65-81029b0f5201",
      iOSAdvertiserTrackingEnabled: true,
    );
    _loadInterstitialAd();
  }

  void _loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617",
      listener: (result, value) {
        print(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED) {
          _isInterstitialAdLoaded = true;
        }
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          _isInterstitialAdLoaded = false;
          _loadInterstitialAd();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FacebookBannerAd(
        placementId:  'IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047',
        bannerSize: BannerSize.STANDARD,
        listener: (result, value) {
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text("Facebook Ads",style: TextStyle(fontSize: 15),),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _nativeBannerAd(),
              ElevatedButton(
                onPressed: (){
                  _showInterstitialAd();
                },
                child: const Text("Intestitial Ad")
              ),
            ],
          ),
        ),
      ),
    );
  }


  _showInterstitialAd() {
      if (_isInterstitialAdLoaded == true)
        FacebookInterstitialAd.showInterstitialAd();
      else
        print("Interstial Ad not yet loaded!");
    }

  Widget _nativeBannerAd() {
    return FacebookNativeAd(
      placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2964953543583512",
      adType: NativeAdType.NATIVE_BANNER_AD,
      bannerAdSize: NativeBannerAdSize.HEIGHT_120,
      width: double.infinity,
      backgroundColor: Colors.white,
      titleColor: Colors.black,
      descriptionColor: Colors.black,
      buttonColor: Colors.green,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
      },
    );
  }
}