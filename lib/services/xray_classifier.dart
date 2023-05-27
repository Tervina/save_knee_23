import 'dart:io';

import 'package:tflite/tflite.dart';

loadModelFiles() async {
  String? res = await Tflite.loadModel(
    // model file
    model: "assets/model/my_model.tflite",
    // labels file
    labels: "assets/model/labels.txt",
    // defaults to 1
    numThreads: 1,
    // defaults to true, set to false to load resources outside assets
    isAsset: true,
    // defaults to false, set to true to use GPU delegate
    useGpuDelegate: false,
  );

  //for testing and debugging
  print(res);
}

Future<String> doImageClassification(File? image) async {
  String result = '';
  var recognitions = await Tflite.runModelOnImage(
    // required
    path: image!.path,
    // defaults to 117.0
    imageMean: 0.0,
    // defaults to 1.0
    imageStd: 255.0,
    // defaults to 5
    numResults: 2,
    // defaults to 0.1
    threshold: 0.1,
    // defaults to true
    asynch: true,
  );

  //for testing and debugging
  print(recognitions!.length.toString());

  //update result string
  recognitions.forEach((recog) {
    //for testing and debugging
    print(recog.toString());

    String label = recog["label"];
    double conf = recog["confidence"] as double;
    conf = conf * 100;

    result += '$label with confidence of ${conf.toStringAsPrecision(2)} %\n';
  });
  return result;
}
