import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

@Deprecated("not used")
class RewardedAdWidget extends StatefulWidget {
  @override
  _RewardedAdWidgetState createState() => _RewardedAdWidgetState();
}

class _RewardedAdWidgetState extends State<RewardedAdWidget> {
  RewardedAd? _rewardedAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917',
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
          _isAdLoaded = true;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }

  void _showAd() {
    if (_isAdLoaded && _rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print('User earned reward: ${reward.amount} ${reward.type}');
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isAdLoaded ? _showAd : null,
      child: Text("Show Rewarded Ad"),
    );
  }
}
