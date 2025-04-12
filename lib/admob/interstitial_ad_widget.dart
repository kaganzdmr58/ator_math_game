import 'package:ator_math_game/utils/tools.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdWidget extends StatefulWidget {
  final Widget nextPage;
  final bool isReplace;
  const InterstitialAdWidget({
    super.key,
    required this.nextPage,
    this.isReplace = false,
  });
  @override
  _InterstitialAdWidgetState createState() => _InterstitialAdWidgetState();
}

class _InterstitialAdWidgetState extends State<InterstitialAdWidget> {
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  void gotoNextPage() {
    _interstitialAd?.dispose();
    if (widget.isReplace) {
      gotoReplace(context, widget.nextPage);
    } else {
      goto(context, widget.nextPage);
    }
  }

  void _loadAd() {
    InterstitialAd.load(
      adUnitId: kDebugMode
          ? 'ca-app-pub-3940256099942544/1033173712'
          : "ca-app-pub-1209856865920457/2158875037",
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _isAdLoaded = true;

          _interstitialAd?.fullScreenContentCallback =
              FullScreenContentCallback(
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              gotoNextPage();
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError error) {
              ad.dispose();
              gotoNextPage();
            },
          );

          _showAd();
        },
        onAdFailedToLoad: (LoadAdError error) {
          gotoNextPage();
        },
      ),
    );
  }

  void _showAd() {
    if (_isAdLoaded && _interstitialAd != null) {
      _interstitialAd!.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/main_picture.png'),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 400),
            /*  Container(
              color: Colors.black.withOpacity(0.4),
              child: Text(
                AppLocalizations.of(context)?.admobText ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10), */
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  gotoNextPage();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  width: 120,
                  height: 44,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Next ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.skip_next_rounded,
                        size: 32,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
