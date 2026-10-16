// import 'package:cli/cli.dart' as cli;
import 'dart:io';

const version = '0.0.1';
void main(List<String> arguments) {
  if (arguments.isEmpty || arguments.first == 'help') {
    printUsage();
  } else if (arguments[0] == 'version') {
    print('Dartpedia CLI version: $version');
  } else if (arguments.first == 'search') {
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
    searchWikipedia(inputArgs);
  } else {
    printUsage();
  }
}

void searchWikipedia(List<String>? arg) {
  final String articleTitle;

  if (arg == null || arg.isEmpty) {
    print('Please provide an article title to search for.');
    articleTitle = stdin.readLineSync() ?? '';
  } else {
    articleTitle = arg.join(' '); // join les chaînes de caractères
  }
  print('Searching for article $articleTitle...');
  print('Here ya go my dude!');
  print('*pretending this is an article about $articleTitle*');
}

void printUsage() {
  print(
    "The following commands are valid: 'help', 'version', 'search <ARTICLE-TITLE>'",
  );
}
