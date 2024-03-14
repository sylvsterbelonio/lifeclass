import 'package:flutter/material.dart';
import 'package:lifeclass/classes/clsThemes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lifeclass/classes/clsApp.dart';
import 'package:url_launcher/url_launcher.dart';

class Copyright extends StatefulWidget {
  const Copyright({super.key});
  @override
  State<Copyright> createState() => _CopyrightState();
}

class _CopyrightState extends State<Copyright> {
  late String colorTheme = clsApp.defaultColorThemes;

  @override
  void initState() {
    // TODO: implement initState
    initTheme();
    super.initState();
  }
  void initTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      colorTheme = prefs.getString('colorThemes') ?? clsApp.defaultColorThemes;
    });
  }

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url,mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_url');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Copyright'),
        backgroundColor: clsThemes.getColor(colorTheme),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  width: 150.0,
                  height: 150.0,
                  child:
                  Image.asset('assets/images/g12.png'),
                ),
              ),
              Text('This resources belongs to',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              Text('CESAR CASTELLANOS D. \u00a9 2013',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),),
              Text('\nAll rights reserved. Total or partial reproduction of this content in apps is prohibited without prior written permission from the owner.',textAlign: TextAlign.justify,  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),),
              Text('\nUnless otherwise indicated, Scripture quotations used in this book are from the New International Version 1984 Copyright © 1973, 1978, 1984 by International Bible Society.',textAlign: TextAlign.justify,  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),),
              Text('\nSpanish version',textAlign: TextAlign.justify,  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),),
              Text('EL PODER DE UNA VISIÓN',textAlign: TextAlign.justify,  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              Text('\nTranslation_Richard Harding_Roxanna Bayat_Doris Perla Mora - G12 Media. ',textAlign: TextAlign.center,  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),),
              Text('Editing_Manuela Castellanos_Claudia Wilches_Doris Perla Mora Design_Julian Gamba_Esteban Rios_Daniel Durán Impreso en Colombia por G12 Editores_2013',textAlign: TextAlign.justify,  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),),
              Text('G12 Editores - Sur América Calle 22 C # 31-01 Bogotá, Colombia (571) 269 34 20 G12 Editors - USA. 8950 Stirling Rd. Hollywood Fl. 33024',textAlign: TextAlign.justify,  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),),
              Text('',textAlign: TextAlign.justify,  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),),
              Text('To learn more, visit ',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),),
              InkWell(
                  onTap: (){
                    _launchUrl('https://www.visiong12.com');
                  },
                  child: Text('www.visiong12.com', style: TextStyle(fontWeight: FontWeight.normal, color:Colors.blue,  fontSize: 16, decoration: TextDecoration.underline),)),
              InkWell(
                  onTap: (){
                    _launchUrl('https://www.mci12.com');
                  },
                  child: Text('www.mci12.com',style: TextStyle(fontWeight: FontWeight.normal,color:Colors.blue, fontSize: 16, decoration: TextDecoration.underline),)),


            ],
          ),
        ),
      ),
    );
  }
}
