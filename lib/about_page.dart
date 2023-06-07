import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final String name = 'Bruno Ramon Almeida';

  final String linkedinUrl = 'https://www.linkedin.com/in/brunoramonalmeida/';

  final String githubUrl = 'https://github.com/brunoramonalmeida';

  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
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
              _launchUrl(linkedinUrl);
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
              _launchUrl(githubUrl);
            },
          ),
        ],
      ),
    );
  }
}
