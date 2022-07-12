// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:matrix_gesture_mb/model/project.dart';
import 'package:matrix_gesture_mb/ui/activity/activity_paint_image.dart';

import 'ui/activity/activity_scene.dart';

List<Demo> demos = [
  Demo(
      'Scene',
      'Demo Koudous pour t\'expliquer comment ça marche',
      const ActivityScene()),
  Demo(
      'DrawImage',
      'Demo pour dessiner une photo avec le Painter',
      const ActivityPaintImage()),
];

void main() => runApp(MaterialApp(
  title: 'GestureDetector',
  home: Scaffold(
    appBar: AppBar(
      title: const Text('GestureDetector'),
    ),
    body: Builder(
      builder: (BuildContext ctx) {
        return Center(
          child: SingleChildScrollView(
            child: Column(
              children: demos.map((demo) => ListTile(
                onTap: () => showDemo(ctx, demo),
                leading: const Icon(Icons.image),
                title: Text(demo.title),
                subtitle: Text(demo.subtitle),
              ))
                  .toList(),
            ),
          ),
        );
      },
    ),
  ),
));


showDemo(BuildContext ctx, Demo demo) {
  if(Project.bDebugMode) { print("------------   initProject    --------------");}
  initProject();
  if(Project.bDebugMode){ print('showing ${demo.title}...'); }
  Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx) => demo.widget));
}


class Demo {

  String title;
  String subtitle;
  Widget widget;

  Demo(this.title, this.subtitle, this.widget);
}


initProject(){
  Project();
  ///en bas il s'agit de test en plus
  // Project().addFloor();
  // Project().setUpdateSizeScreen(300,300);
  // Floor floor = Project().getFloor(0);
  // floor.hauteurFloor = 7;
}

