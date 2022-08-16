import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grupo_5_b_/providers/providers.dart';
import 'package:grupo_5_b_/screens/form.dart';
import 'package:grupo_5_b_/themes/theme.dart';
import 'package:provider/provider.dart';

class RequestListScreen extends StatelessWidget {
  const RequestListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final requestsProvider = Provider.of<RequestsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/Logot2.png',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Solicitudes')),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            // tooltip: 'Comment Icon',
            onPressed: () {
              Navigator.pushNamed(context, 'home');
            },
          ),
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => SizedBox(
            height:125,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
             color: Color.fromARGB(139, 28, 79, 247), 
            margin: const EdgeInsets.all(5),
            elevation: 10,
              child: ListTile(
                    leading: const Icon(Icons.document_scanner_sharp, color: Color.fromARGB(255, 255, 255, 255)),
                    title: Text('Solicitante: ${requestsProvider.requests[index].name}'),
                    subtitle: ListView(
                      children: [
                        Text(
                            'Razon: ${requestsProvider.requests[index].reason}'),
                        RatingBar.builder(
                        initialRating: requestsProvider.requests[index].scorereply!.toDouble(),
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 4 ,
                        itemSize: 25.0,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                        },
                      ),
                      
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Ink(
                          decoration: const ShapeDecoration(
                            color: Color.fromARGB(216, 255, 9, 9),
                              shape:  CircleBorder(),
                        ),
                          child: IconButton(
                            icon: const Icon(Icons.delete),
                              color: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              'home',
                            );
                            const snackBar = SnackBar(
                              backgroundColor: Color.fromARGB(220, 255, 0, 0),
                              content: Text('Eliminado Exitosamente'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                           var id = requestsProvider.requests[index].id.toString();
                             requestsProvider.deleteRequest(id);
                              print(id);
                          },
                          ),
                        ),
                      ],
                    ),


                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FormScreen(
                                    request: requestsProvider.requests[index],
                                  )));
                    },
                    //trailing: const Icon(Icons.arrow_circle_right_outlined),
                  ),
                ),
              ),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: requestsProvider.requests.length),   
      floatingActionButton: 
      Row(
         mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
         [
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, 'request-form');
            },
          ),
        ],
      ),
    );
  }
}
