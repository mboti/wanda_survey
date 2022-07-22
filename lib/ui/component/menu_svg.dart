import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrix_gesture_mb/model/floor.dart';
import 'package:matrix_gesture_mb/ui/activity/activity_scene.dart';
import 'package:matrix_gesture_mb/ui/component/MyCustumText.dart';

class MenuSvg {
  double widthIcon = 0;
  double iconeSize = 48;
  GlobalKey globalKey = GlobalKey();

  //ActivitySceneState activitySceneState = ActivitySceneState();


  MenuSvg(this.widthIcon);

  //une Row pour alligner les bouttons
  buildRowForButtons() {
    List<Widget> iconsK = [
      build_ico_importplanButton(),
      build_ico_ruler_unlockButton(),
      build_ico_fullplanButton(),
      build_ico_heatmapButton(),
      build_ico_floorButton(),
      //build_ico_ruler_lockButton(),
      //build_ico_saveButton(),
      //build_ico_heatmap_Button(),
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: widthIcon,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //width:  10.0 ,//MediaQuery.of(context).size.width,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            //padding: EdgeInsets.all(10.0),
            children: iconsK,
          ),
        )
      ],
    );
  }

  build_ico_floorButton() {
    const String assetName = 'images/ico/ico_floor.svg';
    return Column(
      children: [
        IconButton(
          onPressed: () {
            [
              _handleFloorButton(),
            ];
            //Text("Floor");
          },
          icon: SvgPicture.asset(
            assetName,
            //Text("hell"),
            color: Colors.blueAccent,
            semanticsLabel: 'A red up arrow',
          ),
          iconSize: iconeSize,
        ),
        MyCustumText('Floor', color: Colors.white60, factor: 1.0),
      ],
    );
  }

  build_ico_fullplanButton() {
    const String assetName = 'images/ico/ico_fullplan.svg';
    return Column(
      children: [
        IconButton(
          onPressed: () {
            [
              _handleFullPlanButton(),
            ];
          },
          icon: SvgPicture.asset(
            assetName,
            color: Colors.blueAccent,
            semanticsLabel: 'A red up arrow',
          ),
          iconSize: iconeSize,
        ),
        MyCustumText('Full plan', color: Colors.white60, factor: 1.0),
      ],
    );
  }

  build_ico_heatmapButton() {
    const String assetName = 'images/ico/ico_heatmap.svg';
    return Column(
      children: [
        IconButton(
          onPressed: () {
            [
              _handleHeatmap2Button(),
            ];
          },
          icon: SvgPicture.asset(
            assetName,
            color: Colors.blueAccent,
            semanticsLabel: 'A red up arrow',
          ),
          iconSize: iconeSize,
        ),
        MyCustumText('Heatmap', color: Colors.white60, factor: 1.0),
      ],
    );
  }

  build_ico_importplanButton() {
    const String assetName = 'images/ico/ico_importplan.svg';
    return Column(
      children: [
        IconButton(
          onPressed: () {
            [
              _handleImportPlanButton(),
            ];
          },
          icon: SvgPicture.asset(
            assetName,
            color: Colors.blueAccent,
            semanticsLabel: 'A red up arrow',
          ),
          iconSize: iconeSize,
        ),
        MyCustumText('Import', color: Colors.white60, factor: 1.0),
      ],
    );
  }

  build_ico_ruler_lockButton() {
    const String assetName = 'images/ico/ico_ruler_lock.svg';
    return Column(
      children: [
        IconButton(
          onPressed: () {
            [
              _handleRulerLockButton(),
            ];
          },
          icon: SvgPicture.asset(
            assetName,
            color: Colors.white60,
            semanticsLabel: 'A red up arrow',
          ),
          iconSize: iconeSize,
        ),
        MyCustumText('Ruler', color: Colors.white60, factor: 1.0),
      ],
    );
  }

  build_ico_ruler_unlockButton() {
    const String assetName = 'images/ico/ico_ruler_unlock.svg';
    return Column(
      children: [
        IconButton(
          onPressed: () {
            [
              _handleRulerUnlockButton(),
            ];
          },
          icon: SvgPicture.asset(
            assetName,
            color: Colors.blueAccent,
            semanticsLabel: 'A red up arrow',
          ),
          iconSize: iconeSize,
        ),
        MyCustumText('Ruler', color: Colors.white60, factor: 1.0),
      ],
    );
  }

  build_ico_saveButton() {
    const String assetName = 'images/ico/ico_save.svg';
    return Column(
      children: [
        IconButton(
          onPressed: () {
            [
              _handleSaveButton(),
            ];
          },
          icon: SvgPicture.asset(
            assetName,
            color: Colors.blueAccent,
            semanticsLabel: 'A red up arrow',
          ),
          iconSize: iconeSize,
        ),
        MyCustumText('Save', color: Colors.white60, factor: 1.0),
      ],
    );
  }

  build_ico_save2Button() {
    const String assetName = 'images/ico/ico_save2.svg';
    return IconButton(
          onPressed: () {
            [
              _handleSave2Button(),
            ];
          },
          icon: SvgPicture.asset(
            assetName,
            color: Colors.tealAccent,
            semanticsLabel: 'A red up arrow',
          ),
          iconSize: iconeSize,
    );
  }

  build_ico_heatmap_Button() {
    const String assetName = 'images/ico/ico_heatmap.svg';
    return Column(
      children: [
        IconButton(
          onPressed: () {
            [
              _handleHeatmapButton(),
            ];
          },
          icon: SvgPicture.asset(
            assetName,
            color: Colors.redAccent,
            semanticsLabel: 'A red up arrow',
          ),
          iconSize: iconeSize,
        ),
        MyCustumText('Heatmap', color: Colors.white60, factor: 1.0),
      ],
    );
  }

  void _handleHeatmapButton() {
    print("clic bouton heatmap");
  }

  void _handleSave2Button() {
    print("clic bouton save2");
  }

  void _handleSaveButton() {
    print("clic bouton save");
  }

  void _handleRulerUnlockButton() {
    print("clic bouton unluck ruler");
  }

  void _handleRulerLockButton() {
    print("clic bouton lock ruler");
  }

  void _handleImportPlanButton() {
    print("clic bouton import plan");
    //activitySceneState.buildShowDialogForChoiceCamOrGal();

  }

  void _handleHeatmap2Button() {
    print("clic bouton heatMap2");
  }

  void _handleFullPlanButton() {
    print("clic bouton full plan");
  }

  void _handleFloorButton() {
    print("clic bouton floor");
  }





}
