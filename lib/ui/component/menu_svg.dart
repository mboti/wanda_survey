import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuSvg{

  double widthIcon = 0;


  MenuSvg(this.widthIcon);

  //une Row pour alligner les bouttons
  buildRowForButtons(){


    List<Widget> iconsK = [
      build_ico_floorButton(),
      build_ico_fullplanButton(),
      build_ico_heatmapButton(),
      //build_ico_ruler_lockButton(),
      build_ico_ruler_unlockButton(),
      build_ico_saveButton(),
      build_ico_heatmap_Button(),
      build_ico_importplanButton()
    ];
    return Column(
      children: [
        SizedBox(
          height: widthIcon,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          child:
          ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children:
              iconsK
          ),
        )
      ],
    );
  }

  build_ico_floorButton(){
    const String assetName = 'images/ico/ico_floor.svg';
    return IconButton(
      onPressed: () {  },
      icon: SvgPicture.asset(
        assetName,
        color: Colors.blueAccent,
        semanticsLabel: 'A red up arrow',
      ),
    );
  }
  build_ico_fullplanButton(){
    const String assetName = 'images/ico/ico_fullplan.svg';
    return IconButton(
      onPressed: () {  },
      icon: SvgPicture.asset(
        assetName,
        color: Colors.blueAccent,
        semanticsLabel: 'A red up arrow',
      ),
    );
  }
  build_ico_heatmapButton(){
    const String assetName = 'images/ico/ico_heatmap.svg';
    return IconButton(
      onPressed: () {  },
      icon: SvgPicture.asset(
        assetName,
        color: Colors.blueAccent,
        semanticsLabel: 'A red up arrow',
      ),
    );
  }
  build_ico_importplanButton(){
    const String assetName = 'images/ico/ico_importplan.svg';
    return IconButton(
      onPressed: () {  },
      icon: SvgPicture.asset(
        assetName,
        color: Colors.blueAccent,
        semanticsLabel: 'A red up arrow',
      ),
    );
  }

  build_ico_ruler_lockButton(){
    const String assetName = 'images/ico/ico_ruler_lock.svg';
    return IconButton(
      onPressed: () {  },
      icon: SvgPicture.asset(
        assetName,
        color: Colors.white60,
        semanticsLabel: 'A red up arrow',
      ),
    );
  }


  build_ico_ruler_unlockButton(){
    const String assetName = 'images/ico/ico_ruler_unlock.svg';
    return IconButton(
      onPressed: () {  },
      icon: SvgPicture.asset(
        assetName,
        color: Colors.blueAccent,
        semanticsLabel: 'A red up arrow',
      ),
    );
  }

  build_ico_saveButton(){
    const String assetName = 'images/ico/ico_save.svg';
    return IconButton(
      onPressed: () {  },
      icon: SvgPicture.asset(
        assetName,
        color: Colors.blueAccent,
        semanticsLabel: 'A red up arrow',
      ),
    );
  }

  build_ico_save2Button(){
    const String assetName = 'images/ico/ico_save2.svg';
    return IconButton(
      onPressed: () {  },
      icon: SvgPicture.asset(
        assetName,
        color: Colors.tealAccent,
        semanticsLabel: 'A red up arrow',
      ),
    );
  }

  build_ico_heatmap_Button(){
    const String assetName = 'images/ico/ico_heatmap.svg';
    return IconButton(
      onPressed: () {  },
      icon: SvgPicture.asset(
        assetName,
        color: Colors.redAccent,
        semanticsLabel: 'A red up arrow',
      ),
    );
  }


/*
  buildRowForLockUnluckButtons(){
    List<Widget> iconsK = [
      //build_ico_ruler_lockButton(),
      build_ico_ruler_lockButton(),
    ];
    return Column(
      children: [
        SizedBox(
          height: 50,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          child:
          ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children:
              iconsK
          ),
        )
      ],
    );
  }
*/

}