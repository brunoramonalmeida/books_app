import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  final String name = 'Bruno Ramon';
  final String linkedinUrl = 'https://www.linkedin.com/in/brunoramonalmeida/';
  final String githubUrl = 'https://github.com/brunoramonalmeida';

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir a URL: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Desenvolvido por:',
            style: TextStyle(fontSize: 24),
          ),
          Text(
            '$name',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 16),
          InkWell(
            child: Text(
              'LinkedIn',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
            onTap: () {
              _launchURL(linkedinUrl);
            },
          ),
          SizedBox(height: 8),
          InkWell(
            child: Text(
              'GitHub',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
            onTap: () {
              _launchURL(githubUrl);
            },
          ),
        ],
      ),
    );
  }
}
