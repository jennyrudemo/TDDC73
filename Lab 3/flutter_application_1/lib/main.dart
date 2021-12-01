import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:dio/dio.dart';

// void getHttp() async {
//   try {
//     var response = await Dio().get('https://api.github.com/graphql');
//     print(response);
//   } catch (e) {
//     print(e);
//   }
//}

//import 'fetchmore/main.dart';
void main() async {
  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink(
    'https://api.github.com/graphql',
  );

  //hej

  final AuthLink authLink = AuthLink(
    getToken: () async =>
        'Bearer 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', //ändra denna från token
    // OR
    // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
  );

  final Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(store: HiveStore()), //Från store till cache
    ),
  );

  var app = GraphQLProvider(client: client, child: const MyApp());

  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Lab 3'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedLanguage = 'Python';
  List<String> languageList = [
    'Python',
    'Java',
    'C++',
    'TypeScript',
    'C',
    'Ruby',
    'C#',
    'PHP',
  ];

  void _setSelectedLanguage(String newLang) {
    setState(() {
      selectedLanguage = newLang;
    });
  }

  String readRepositories = """
    query ReadRepositories (\$queryString: String!) {
      search(query: \$queryString, type: REPOSITORY, first: 10) {
        nodes {
          ... on Repository {
            id
            name
            url
             owner {
              url
            }
            stargazers {
              totalCount
            }
            
           
  
            
          }
        }
      }
      
  }
     """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Query(
          options: QueryOptions(
            document: gql(
                readRepositories), // this is the query string you just created
            variables: {
              'nRepositories':
                  50, //querystring : 'language $selectedlanguage stars: >1000
              'queryString':
                  'sort:stars-desc language: $selectedLanguage stars:>1000',
            },
            pollInterval: const Duration(seconds: 10),
          ),
          // Just like in apollo refetch() could be used to manually trigger a refetch
          // while fetchMore() can be used for pagination purpose
          builder: (QueryResult result,
              {FetchMore? fetchMore, VoidCallback? refetch}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.isLoading) {
              return Text('Loading');
            }

            // it can be either Map or List
            List repositories = result.data?['search']['nodes'];

            return ListView.builder(
                itemCount: repositories.length,
                itemBuilder: (context, index) {
                  final repository = repositories[index];

                  return Text(repository['name']);
                  //här kan man returnera ett kort genom card.dart
                });
          },
        ),
      ),

      //lägga till en container
    );
  }
}
