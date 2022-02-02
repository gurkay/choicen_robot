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
  sliderModel.setDesc(
      "Bu uygulamanın amacı bir çok kriterli karar verme problemlerinde en çok fayda sağlayan kriteri seçmeyi hedeflemektedir.");
  sliderModel.setTitle("Tespit Edilir ...");
  sliderModel.setImageAssetPath("assets/images/problemDetect.png");
  slides.add(sliderModel);

  sliderModel = SliderModel();

  //2
  sliderModel.setDesc(
      "Günümüzün karmaşık ve zor koşulları, problemleri hızlı ve kolay çözüm üreterek objektif bir seçim yapmayı amacıyla seçenekler ve kriterler belirlenir.");
  sliderModel.setTitle("Seçenekleri ve Kriterleri Belirle ... ");
  sliderModel.setImageAssetPath("assets/images/criterias.jpeg");
  slides.add(sliderModel);

  sliderModel = SliderModel();

  //3
  sliderModel.setDesc(
      " MAUT (Multi Attribute 	Utility Theory) hesaplama yöntemini kullanarak karar vermenize yardımcı olacaktır.");
  sliderModel.setTitle("Hesaplama ...");
  sliderModel.setImageAssetPath("assets/images/calculate.png");
  slides.add(sliderModel);

  sliderModel = SliderModel();

  return slides;
}
