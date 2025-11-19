import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;

class Post {
  final String date;
  final String content;
  final String? imageUrl;

  Post({
    required this.date,
    required this.content,
    this.imageUrl,
  });
}

class MostPostsWidget extends StatefulWidget {
  const MostPostsWidget({super.key});

  @override
  State<MostPostsWidget> createState() => _MostPostsWidgetState();
}

class _MostPostsWidgetState extends State<MostPostsWidget> {
  List<Post> posts = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final response = await http.get(
        Uri.parse('https://most.salezjanie.pl/'),
      );

      if (response.statusCode == 200) {
        final document = html_parser.parse(response.body);
        final parsedPosts = _parsePosts(document);

        setState(() {
          posts = parsedPosts;
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Błąd pobierania danych: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Błąd połączenia: $e';
        isLoading = false;
      });
    }
  }

  List<Post> _parsePosts(dom.Document document) {
    List<Post> parsedPosts = [];

    final postElements = document.querySelectorAll('antml\\:span');

    for (var element in postElements) {
      try {
        final text = element.text;
        final lines = text.split('\n').where((l) => l.trim().isNotEmpty).toList();

        if (lines.length >= 2) {
          final date = lines.length > 1 ? lines[1] : '';
          final contentLines = lines.skip(2).toList();
          final content = contentLines.join('\n').trim();

          final images = element.querySelectorAll('img');
          String? imageUrl;
          if (images.isNotEmpty) {
            imageUrl = images.first.attributes['src'];
          }

          if (content.isNotEmpty) {
            parsedPosts.add(Post(
              date: date,
              content: content,
              imageUrl: imageUrl,
            ));
          }
        }
      } catch (e) {
        print('Błąd parsowania posta: $e');
      }
    }

    return parsedPosts;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(error!, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: fetchPosts,
              child: const Text('Spróbuj ponownie'),
            ),
          ],
        ),
      );
    }

    if (posts.isEmpty) {
      return const Center(child: Text('Brak postów'));
    }

    return RefreshIndicator(
      onRefresh: fetchPosts,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return _PostCard(post: post);
        },
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final Post post;

  const _PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Data
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  post.date,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Treść
            Text(
              post.content,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),

            // Obraz jeśli istnieje
            if (post.imageUrl != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  post.imageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.grey[200],
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image_not_supported, color: Colors.grey),
                          SizedBox(width: 8),
                          Text('Nie można załadować obrazu'),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// PRZYKŁAD UŻYCIA:
//
// class MyScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Posty MOST')),
//       body: MostPostsWidget(),
//     );
//   }
// }