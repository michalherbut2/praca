import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:url_launcher/url_launcher.dart';

class NewsFeedWidget extends StatefulWidget {
  const NewsFeedWidget({super.key});

  @override
  State<NewsFeedWidget> createState() => _NewsFeedWidgetState();
}

class _NewsFeedWidgetState extends State<NewsFeedWidget> {
  bool loading = true;
  List<Map<String, String>> posts = [];

  Future<void> fetchPosts() async {
    final url = Uri.parse('https://most.salezjanie.pl/');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final document = html_parser.parse(res.body);

      // Przykład: znajdź wszystkie linki i teksty w artykułach lub postach
      final articles = document.querySelectorAll('article, .post, .elementor-widget');
      final data = <Map<String, String>>[];

      for (var a in articles) {
        final title = a.querySelector('h2, h3, h4')?.text.trim() ?? 'Brak tytułu';
        final link = a.querySelector('a[href]')?.attributes['href'] ?? '';
        final desc = a.querySelector('p')?.text.trim() ?? '';

        if (link.isNotEmpty) {
          data.add({
            'title': title,
            'link': link,
            'desc': desc,
          });
        }
      }

      setState(() {
        posts = data;
        loading = false;
      });
    } else {
      setState(() => loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Aktualności Most Salezjanie")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : posts.isEmpty
          ? const Center(child: Text("Brak danych do wyświetlenia"))
          : ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(post['title'] ?? ''),
              subtitle: Text(post['desc'] ?? ''),
              trailing: const Icon(Icons.open_in_new),
              onTap: () async {
                final uri = Uri.parse(post['link']!);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
