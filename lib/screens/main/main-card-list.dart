import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid19/components/ads-component.dart';
import 'package:covid19/components/country-card/country-card-today.dart';
import 'package:covid19/components/kgp-base-page.dart';
import 'package:covid19/components/kgp-flag.dart';
import 'package:covid19/models/country-model.dart';
import 'package:covid19/screens/main/main-callback.dart';
import 'package:covid19/screens/main/main.card.one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';

class MainCardList extends StatelessWidget {
  final Country data;
  const MainCardList({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return KgpBasePage(
      title: data.country,
      background: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: CachedNetworkImage(
              imageUrl: data.countryInfo.flag,
              imageBuilder: (context, imageProvider) => Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(),
              placeholder: (context, url) => Container(),
            ),
          ),
          Positioned(
            bottom: -1,
            left: 0,
            right: 0,
            top: 0,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 20,
                sigmaY: 20,
              ),
              child: Container(
                color: theme.backgroundColor.withOpacity(0.7),
              ),
            ),
          ),
          Positioned(
            bottom: -1,
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, theme.backgroundColor],
                ),
              ),
            ),
          ),
        ],
      ),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Stack(
                children: [
                  MainCardOne(data: data),
                  Positioned(
                    top: 108,
                    left: 80,
                    child: KgpFlag(
                      imageUrl: data.countryInfo.flag,
                      imageWidth: 70,
                      imageHeight: 70,
                    ),
                  ),
                ],
              ),
              AdsComponent(type: NativeAdmobType.banner),
              CountryCardToday(data: data),
              MainCallback(data: data),
            ],
          ),
        ),
      ],
    );
  }
}
