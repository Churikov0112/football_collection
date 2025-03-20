//  flutter3dController.onModelLoaded.addListener(() {
//         debugPrint('model is loaded : ${flutter3dController.onModelLoaded.value}');
//       });
      
        // Flutter3DController flutter3dController = Flutter3DController();
  // String srcGlb = 'assets/3d/card-pack.glb';
  
    // child: Flutter3DViewer(
                                //   //If you pass 'true' the flutter_3d_controller will add gesture interceptor layer
                                //   //to prevent gesture recognizers from malfunctioning on iOS and some Android devices.
                                //   // the default value is true
                                //   activeGestureInterceptor: false,
                                //   //If you don't pass progressBarColor, the color of defaultLoadingProgressBar will be grey.
                                //   //You can set your custom color or use [Colors.transparent] for hiding loadingProgressBar.
                                //   progressBarColor: Colors.orange,
                                //   //You can disable viewer touch response by setting 'enableTouch' to 'false'
                                //   enableTouch: false,
                                //   //This callBack will return the loading progress value between 0 and 1.0
                                //   onProgress: (double progressValue) {
                                //     debugPrint('model loading progress : $progressValue');
                                //   },
                                //   //This callBack will call after model loaded successfully and will return model address
                                //   onLoad: (String modelAddress) async {
                                //     // debugPrint('model loaded : $modelAddress');
                                //     // presenter.flutter3dController.playAnimation();
                                //     // await Future.delayed(const Duration(seconds: 3));
                                //     // presenter.flutter3dController.pauseAnimation();
                                //   },

                                //   //this callBack will call when model failed to load and will return failure error
                                //   onError: (String error) {
                                //     debugPrint('model failed to load : $error');
                                //   },
                                //   //You can have full control of 3d model animations, textures and camera
                                //   controller: presenter.flutter3dController,
                                //   src: presenter.srcGlb,
                                //   //src: 'assets/business_man.glb', //3D model with different animations
                                //   //src: 'assets/sheen_chair.glb', //3D model with different textures
                                //   //src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb', // 3D model from URL
                                // ),