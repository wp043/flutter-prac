import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslationPage extends StatefulWidget {
  const LanguageTranslationPage({super.key});

  @override
  State<LanguageTranslationPage> createState() =>
      LanguageTranslationPageState();
}

class LanguageTranslationPageState extends State<LanguageTranslationPage> {
  var languages = ['English', 'Spanish', 'Japanese', 'Korean'];
  var originalLanguage = "From";
  var destinationLanguage = "To";
  var output = "";
  TextEditingController languageController = TextEditingController();
  final GoogleTranslator translator = GoogleTranslator();

  void translate(String src, String dst, String input) async {
    try {
      if (src == '--' || dst == '--') {
        setState(() {
          output = "Please select languages to translate";
        });
        return;
      }

      var translation = await translator.translate(input, from: src, to: dst);
      setState(() {
        output = translation.text.toString();
      });
    } catch (e) {
      setState(() {
        output = "Translation error: ${e.toString()}";
      });
    }
  }

  String getLanguageCode(String language) {
    switch (language) {
      case 'English':
        return 'en';
      case 'Spanish':
        return 'es';
      case 'Japanese':
        return 'ja';
      case 'Korean':
        return 'ko';
      default:
        return '--';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: const Text(
          'Language Translation',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      originalLanguage,
                      style: const TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        originalLanguage = value!;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const Icon(
                    Icons.arrow_right_alt_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  DropdownButton<String>(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      destinationLanguage,
                      style: const TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        destinationLanguage = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  cursorColor: Colors.white,
                  autofocus: false,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Enter text to translate',
                    labelStyle:
                        const TextStyle(fontSize: 15, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1),
                    ),
                    errorStyle:
                        const TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  controller: languageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter text to translate';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      translate(
                          getLanguageCode(originalLanguage),
                          getLanguageCode(destinationLanguage),
                          languageController.text.toString());
                    },
                    child: const Text("Translate")),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "\n$output",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
