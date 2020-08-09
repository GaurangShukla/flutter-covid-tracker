import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

getListOfLoadingShimmer() {
  return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey[100],
      enabled: true,
      child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            if (index == 0 || index == 1) {
              return Container(
                  margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  height: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 15.0,
                        ),
                      ]));
            }
            return Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 15.0,
                    ),
                  ]),
            );
          }));
}

getNewsShimmerLoading() {
  return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey[100],
      enabled: true,
      child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return Container(
                margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                height: 220,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 15.0,
                      ),
                    ]));
          }));
}
