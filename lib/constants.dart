import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


Color whiteColor = Color(0xffffffff);
Color Green1 = Color(0xff57bfa6);
Color Green2= Color(0xff40b8b8);
Color Grey1= Color(0xffe2e3e7);
Color Green3= Color(0xff009688);
Color Green4= Color(0xff159d99);
Color Orange1= Color(0xffFFC107);
Color Green5= Color(0xff207066);
Color Grey2= Color(0xff808070);
Color Grey3= Color(0xffF2F2F2);

Color Green6= Color(0xff05b6a6);
Color Green7= Color(0xff00cc66);
Color blue1= Color(0xff001fc9);
Color blue2= Color(0xff006bb3);
Color grey4= Color(0xffd3d6d6);
Color grey5= Color(0xff717373);
Color black1= Color(0xff000000);
Color green8= Color(0xff7ee4aa);
Color red1= Color(0xffff0000);
Color green9= Color(0xff4caf50);
Color blue3= Color(0xff3f51b5);
Color red2= Color(0xffff5722);
Color blue4= Color(0xff000099);
Color blue5= Color(0xff3a7bb3);
Color blue6= Color(0xff00e1ff);
Color purple1= Color(0xff4456b6);
Color pink1= Color(0xffe02e69);
Color purple2= Color(0xffedd7ec);
Color green10= Color(0xff5bb14b);
Color yellow1= Color(0xfff4ee50);
Color yellow2= Color(0xffffeb3b);
Color yellow3= Color(0xfffbcb3d);
Color blue7= Color(0xff154f7f);
Color green11= Color(0xffb8f985);
Color blue8= Color(0xffe9f1f8);
Color green12= Color(0xff2fcece);
Color red3= Color(0xfffb5d5d);
Color orange2= Color(0xfff4d375);
Color green13= Color(0xff88ffcc);
Color pink2= Color(0xfff3ccf0);
Color green14= Color(0xffccf3e3);
Color yellow4= Color(0xffefef91);
Color blue9= Color(0xff50adf7);
Color pink3= Color(0xffde3e83);
Color green15= Color(0xffc9ffca);
Color blue10= Color(0xffb3ebf1);
Color Orange3= Color(0xfff1e0b3);
Color green16= Color(0xff9eefc0);
Color purple3= Color(0xffcfaefd);
Color purple4= Color(0xff9900cc);
Color blue11= Color(0xff175481);
Color green17= Color(0xff398D3C);
Color blue12= Color(0xff111F84);
Color blue13= Color(0xff293189);
Color purple5= Color(0xff93268f);
Color green18= Color(0xff149b48);
Color blue14= Color(0xff154f7f);
Color blue15= Color(0xff2775bb);
Color blue16= Color(0xff2e9ed6);
Color blue17= Color(0xff334782);
Color green19= Color(0xff206a3e);
Color purple6= Color(0xff642166);
Color blue18= Color(0xff0000Fe);
Color Orange4= Color(0xfff26722);
Color grey6= Color(0xff757575);
Color green20= Color(0xff0f9184);
Color green21= Color(0xff20B7A9);
Color grey7= Color(0xffEEEEEE);
Color grey8= Color(0xff939191);
Color grey9= Color(0xff949494);
Color grey10= Color(0xffd9dddb);
Color green22= Color(0xff1cb8a9);
Color green23= Color(0xff29bcae);
Color black2= Color(0xff151a1e);
Color green24= Color(0xff57918B);
Color grey11= Color(0x74E6E6E6);
Color Grey3dark= Color(0xff232c31);
Color Carddark= Color(0xff29343a);
Color green25= Color(0xff086a5f);
Color green20dark= Color(0xff17b16c);
Color iconselect= Color(0xff757575);
Color iconselectdark= Color(0xffbfbebe);
Color grey7dark= Color(0xff151e25);
Color listItemdark= Color(0xff262E39);
Color itemgriddark= Color(0xff0a0a0a);
Color starborderdark= Color(0xffe4e2e2);
Color stardark= Color(0xfff9e65c);
Color itemTab= Color(0xffb3b1b1);
Color btn= Color(0xff01c8b5);
Color btndisabledark= Color(0xffc9c8c8);
Color btndisable= Color(0x61000000);
Color textHint= Color(0xffafb0b1);
Color textHintdark= Color(0xffa4a3a3);
Color green26= Color(0xff5d7e5e);
Color grey12= Color(0xfff5f5f5);
Color green27= Color(0xff57bfa6);
Color grey13= Color(0xffa9a9a9);
Color grey14= Color(0xffbebebe);
Color red= Color(0xffB02D43);
Color grey15= Color(0xff666666);
Color yellow= Color(0xffe8cd1e);
Color green32= Color(0xff69caa7);
Color green33= Color(0xff1eb0bd);
Color white2= Color(0xfff8f9fd);
Color green34= Color(0xff0a7b78);
Color grey16= Color(0xff555555);
Color green35= Color(0xff019696);
Color blue19= Color(0xff2c93ed);
Color green36= Color(0xff2FBCAE);
Color green37= Color(0xff97eee1);
Color green38= Color(0xff10598f);
Color grey17= Color(0xff373737);
Color orange= Color(0xffcaa741);
Color orange1= Color(0xff383837);
Color grey18= Color(0xff71868f);
Color white1= Color(0xfff5fcfd);
Color orange3= Color(0xfff6c436);
Color orange4= Color(0xfffbb039);
Color orange5= Color(0xfff9a31c);
Color blue20= Color(0xff1f4167);
Color blue21= Color(0xff5f9cd1);
Color blue22= Color(0xff06b4c0);
Color orange6= Color(0xffffa840);
Color orange7= Color(0xfffdb056);
Color pink= Color(0xfffe2e9f);
Color green39= Color(0xffd5f5f0);
Color green40= Color(0xff2aafa4);
Color orange8= Color(0xfffff3db);
Color orange9= Color(0xffecc960);
Color orange10= Color(0xfffed12e);
Color orange11= Color(0xffecc960);
Color green41= Color(0xff43cd93);
Color green42= Color(0xff5ee9cf);
Color green43= Color(0xff57ab93);
Color orange12= Color(0xffe78b42);
Color black= Color(0xff1e1f23);
Color grey= Color(0xffdde5e1);
Color green44= Color(0xff2bc09b);
Color green45= Color(0xff2abb97);
Color white3= Color(0xfffaf5ec);
Color black3= Color(0xff3b3732);
Color grey19= Color(0xff8b9a9e);
Color orange13= Color(0xfff8aa77);
Color pink5= Color(0xffff80b3);
Color pink4= Color(0xffff4d94);

const double kDefaultPadding = 20.0;

const MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);

List<String> sectionList = ["siemens","schneider","Omron","ls","abb","delta","danfuss","vacon","yaskawa","gefran","control",
  "hyundai","santerno","invt","rich","sanyu","mitsubishi", "fuji","imaster","teco","lenze",
  "keb","sew","Allen","invertek","enc","veichi","v&t","loher","enda","hitachi", "raysan","toshiba","inovance",
  "vat","hpmont","holip","baldor","yolico","ssi","qma","astar","kemron","xima","samco","chnt","panasonic",
  "toptek","adt","powtran","sinee","ager","emotron","frecon","winner","parker","borna","teta","kcly","prostar","vortex","easydrive","soft",
  "rhymebus", "meiden","other"];

List<String>  names = [
  "Siemens",
  "Schneider",
  "Omron",
  "ls",
  "ABB",
  "Delta",
  "Danfuss",
  "Vacon",
  "Yaskawa",
  "Gefran",
  "Control Techniques",
  "Hyundai",
  "Santerno",
  "Invt",
  "Rich",
  "Sanyu",
  "Mitsubishi Electric",
  "Fuji Electric",
  "iMaster",
  "Teco",
  "Lenze",
  "Keb",
  "Sew",
  "Allen-Bradley",
  "Invertek Drives",
  "ENC",
  "Veichi",
  "V&T Drive",
  "Loher",
  "Enda",
  "Hitachi",
  "Raysan Partosanat",
  "Toshiba",
  "Inovance",
  "Vat",
  "Hpmont",
  "Holip",
  "Baldor",
  "Yolico",
  "Ssi",
  "Qma",
  "Astar",
  "Kemron",
  "Xima",
  "Samco",
  "Chnt",
  "Panasonic",
  "Toptek",
  "Adt",
  "Powtran",
  "Sinee",
  "Ager",
  "Emotron",
  "Frecon",
  "Winner",
  "parker",
  "Borna",
  "Teta",
  "Kcly",
  "Prostar",
  "Vortex",
  "Easy Drive",
  "Soft",
  "Rhymebus",
  "Meiden",
  "Other",
];
//List<String> partDownload = ["part1","part2","part3", "part4"];
//List<String> partDownloadCheck=["0","0","0","0"];





/*const g = async () =>{

}*/
late Directory? appDocDirectory;
late String destinationPathAssets;
late String destinationPathDownload;






Future<Directory?> initAppDocDirectory() async {
  appDocDirectory = Platform.isAndroid?  await getExternalStorageDirectory():  await getApplicationDocumentsDirectory();
  return appDocDirectory;
}

Future<String> initDestinationPath() async {
  var appDocDirectory = await initAppDocDirectory();
  destinationPathAssets = appDocDirectory!.path+"/IDBAssets";
  return destinationPathAssets;
}

Future<String> initDestinationPathDownload() async {
  var appDocDirectory = await initAppDocDirectory();
  destinationPathDownload = appDocDirectory!.path+"/IDBDownloads";
  return destinationPathDownload;
}



