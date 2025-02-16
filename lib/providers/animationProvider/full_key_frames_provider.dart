// // this provider will keep track of all the full keyframe indices in the app helps with tweening of course


// import 'package:flutter/material.dart';

// class FullKeyFramesProvider extends ChangeNotifier{
//   final List<int> _fullKeyFrameIndices = [0];

//   get fullKeyFrameIndices => _fullKeyFrameIndices;

//   void addFullKeyFrameIndex(int index){
//     _fullKeyFrameIndices.add(index);
//     _fullKeyFrameIndices.sort();
//     notifyListeners();
//   }
//   void removeFullKeyFrameIndex(int index){
//     _fullKeyFrameIndices.remove(index);
//     notifyListeners();
//   }

// }