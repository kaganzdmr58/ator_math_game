import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

@Deprecated("not used")
class AppOpenAdWidget extends StatefulWidget {
  @override
  _AppOpenAdWidgetState createState() => _AppOpenAdWidgetState();
}

class _AppOpenAdWidgetState extends State<AppOpenAdWidget> {
  AppOpenAd? _appOpenAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    AppOpenAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/3419835294',
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (AppOpenAd ad) {
          _appOpenAd = ad;
          _isAdLoaded = true;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('AppOpenAd failed to load: $error');
        },
      ),
     // orientation: AppOpenAd.orientationPortrait,
    );
  }

  @override
  void dispose() {
    _appOpenAd?.dispose();
    super.dispose();
  }

  void _showAd() {
    if (_isAdLoaded && _appOpenAd != null) {
      _appOpenAd!.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isAdLoaded ? _showAd : null,
      child: Text("Show App Open Ad"),
    );
  }
}
