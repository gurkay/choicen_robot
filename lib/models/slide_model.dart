import 'package:flutter/material.dart';

class SliderModel {
  String? imageAssetPath;
  String? title;
  String? desc;

  SliderModel({
    this.imageAssetPath,
    this.title,
    this.desc,
  });

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String? getImageAssetPath() {
    return imageAssetPath;
  }

  String? getTitle() {
    return title;
  }

  String? getDesc() {
    return desc;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = <SliderModel>[];
  SliderModel sliderModel = SliderModel();

  //1
  sliderModel
      .setDesc("Discover a Food Courner offering the best fast food near you");
  sliderModel.setTitle("Search......");
  sliderModel.setImageAssetPath("assets/images/codeplayon.png");
  slides.add(sliderModel);

  sliderModel = SliderModel();

  //2
  sliderModel.setDesc(
      "Our food plan is filled with delicious seasonal vegetables, whole grains, fast food , burgger , pizza etc.");
  sliderModel.setTitle("Order..... ");
  sliderModel.setImageAssetPath("assets/images/codeplayon2.png");
  slides.add(sliderModel);

  sliderModel = SliderModel();

  //3
  sliderModel.setDesc(
      "Food delivery or pickup from local restaurants, Explore restaurants that deliver near you.");
  sliderModel.setTitle("Deliver........");
  sliderModel.setImageAssetPath("assets/images/codeplayon3.png");
  slides.add(sliderModel);

  sliderModel = SliderModel();

  return slides;
}
