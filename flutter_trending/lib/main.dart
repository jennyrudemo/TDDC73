import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
        //primaryColor: Colors.white,
        //backgroundColor: Colors.black,
      ),
      home: const MyHomePage(title: 'Lab 3'),
    );
  }
}

class DetailedInfo extends StatelessWidget {
  DetailedInfo({
    Key? key,
    required this.title,
    required this.description,
    required this.licens,
    required this.commits,
    required this.branches,
  }) : super(key: key);

  String title = "";
  String description = "";
  String licens = "";
  int commits = 0;
  int branches = 0;

  @override
  //State<StatelessWidget> createState() => _DetailedInfo();
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade800,
        appBar: AppBar(
          title: const Text('Lab 3'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline3,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 20.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Licens",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      "Commits",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      "Branches",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      licens,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      commits.toString(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      branches.toString(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ],
            )
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [const Text("Licens"), Text(licens)],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [const Text("Commits"), Text(commits.toString())]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [const Text("branches"), Text(branches.toString())]),*/
          ],
        ));
  }
}

/*class _DetailedInfo extends State<DetailedInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Text(widget.title),
    );
  }
}*/

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
    query ReadRepositories(\$queryString: String!) {
      search(query: \$queryString, type: REPOSITORY, first: 10) {
        nodes {
          ... on Repository {
            name
            url
            description
            stargazers {
              totalCount
            }
            forkCount
            licenseInfo {
              name
            }
            object(expression: "master") {
              ... on Commit {
                history {
                  totalCount
                }
              }
            }
            refs(refPrefix: "refs/heads/") {
              totalCount
            }
          }
        }
      }
    }

     """;

  Widget box(dynamic repository) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailedInfo(
                      title: repository['name'],
                      description: repository['description'],
                      licens: repository['licenseInfo']['name'],
                      commits: repository['object']['history']['totalCount'],
                      branches: repository['refs']['totalCount'],
                    )));
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(repository['name'],
                  style: Theme.of(context).textTheme.headline6),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(repository['url']),
                    Text(
                      repository['description'],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Forks: " + repository['forkCount'].toString()),
                        const Text("    "),
                        Text("Stars: " +
                            repository['stargazers']['totalCount'].toString()),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget dropDown() {
    //String dropDownValue = "Python";
    return DropdownButton<String>(
      onChanged: (String? newValue) {
        _setSelectedLanguage(newValue!);
      },
      value: selectedLanguage,
      //Bakgrundsfärg så att den vita texten går att läsa
      dropdownColor: Colors.grey,
      items: languageList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            //Lägger till Expanded för att undvika problem med att query/listview expanderar för mycket (?)
            Expanded(
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

                        /*return Text(repository['name'] +
                          " " +
                          repository['stargazers']['totalCount'].toString());
                      */
                        return box(repository);
                        //repository['stargazers: totalCount']);
                        //här kan man returnera ett kort genom card.dart
                      });
                },
              ),
            ),
            dropDown(),
          ],
        ),
      ),
    );
  }
}
