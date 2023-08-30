import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdDsiplay{

  bool displayRealAd=true;


  final adUnitIdInterstitial = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';
  final adUnitIdRewarded = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712485313';
  final adUnitIdRewardedInterstitial = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5354046379'
      : 'ca-app-pub-3940256099942544/6978759866';
  String adUnitIdOpenApp = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/3419835294'
      : 'ca-app-pub-3940256099942544/5662855259';

  loadInterstitial(){
    InterstitialAd.load(
        adUnitId: adUnitIdInterstitial,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            showInterstitial(ad);
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  void showInterstitial(InterstitialAd ad) {
    ad.show();
  }

  loadRewarded(){
    RewardedAd.load(
        adUnitId: adUnitIdRewarded,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            showRewarded(ad);
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedAd failed to load: $error');
          },
        ));
}
  void showRewarded(RewardedAd ad) {
    ad.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
      // Reward the user for watching an ad.
    });
  }

  loadRewardedInterstitialAd(){
    RewardedInterstitialAd.load(
        adUnitId: adUnitIdRewardedInterstitial,
        request: const AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            showRewardedInterstitialAd(ad);
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedInterstitialAd failed to load: $error');
          },
        ));
  }

  void showRewardedInterstitialAd(RewardedInterstitialAd ad) {
    ad.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
      // Reward the user for watching an ad.
    });
  }

  void loadopenAppAd() {
    AppOpenAd.load(
      adUnitId: adUnitIdOpenApp,
      orientation: AppOpenAd.orientationPortrait,
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
         showOPenAppAd(ad);
        },
        onAdFailedToLoad: (error) {
          print('AppOpenAd failed to load: $error');
          // Handle the error.
        },
      ),
    );
  }

  void showOPenAppAd(AppOpenAd ad) {
    ad.show();
  }

}