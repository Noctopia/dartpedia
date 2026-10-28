// // import 'package:cli/cli.dart' as cli;
// import 'dart:io';

// import 'package:http/http.dart' as http;

import 'package:cli/cli.dart';
import 'package:command_runner/command_runner.dart';

void main(List<String> arguments) async {
  final errorLogger = initFileLogger('errors');
  final app =
      CommandRunner(
          onOutput: (String output) async {
            await write(output);
          },
          onError: (Object error) {
            if (error is Error) {
              errorLogger.severe(
                '[Error] ${error.toString()}\n${error.stackTrace}',
              );
              throw error;
            }
            if (error is Exception) {
              errorLogger.warning(error);
              print(error);
            }
          },
        )
        ..addCommand(HelpCommand())
        ..addCommand(SearchCommand(logger: errorLogger))
        ..addCommand(GetArticleCommand(logger: errorLogger));

  app.run(arguments);
}

// // const version = '0.0.1';
// // void main(List<String> arguments) {
// //   if (arguments.isEmpty || arguments.first == 'help') {
// //     printUsage();
// //   } else if (arguments[0] == 'version') {
// //     print('Dartpedia CLI version: $version');
// //   } else if (arguments.first == 'wikipedia') {
// //     final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
// //     searchWikipedia(inputArgs); // no need for await
// //   } else {
// //     printUsage();
// //   }
// // }

// void main(List<String> arguments) async {
//   // main is now async and awaits the runner
//   var runner = CommandRunner(); // Create an instance of your new CommandRunner
//   await runner.run(arguments); // Call its run method, awaiting its Future<void>
// }

// void searchWikipedia(List<String>? arg) async {
//   final String articleTitle;

//   if (arg == null || arg.isEmpty) {
//     print('Please provide an article title to search for.');
//     final inputFromStdin = stdin.readLineSync();

//     if (inputFromStdin == null || inputFromStdin.isEmpty) {
//       return;
//     }
//     articleTitle = inputFromStdin;
//   } else {
//     articleTitle = arg.join(' '); // join les chaînes de caractères
//   }
//   print('Searching for article $articleTitle...');
//   print('Here ya go my dude!');
//   final String articleContent = await getWikipediaArticle(articleTitle);
//   print('Article content: $articleContent');
// }

// void printUsage() {
//   print(
//     "The following commands are valid: 'help', 'version', 'search <ARTICLE-TITLE>'",
//   );
// }

// // A Future is like a promise. It represents a value that isn't available yet but will be once an asynchronous operation (like a network request) finishes.
// Future<String> getWikipediaArticle(String articleTitle) async {
//   final url = Uri.https(
//     'en.wikipedia.org',
//     '/api/rest_v1/page/summary/$articleTitle',
//   );
//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     return response.body;
//   }

//   return 'Error: Failed to fetch article "$articleTitle". Status code: ${response.statusCode}';
// }
