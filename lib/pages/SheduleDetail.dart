import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../service/storage_service.dart';

class SheduleDetail extends StatefulWidget {
  final Text match;
  const SheduleDetail(this.match, {Key? key}) : super(key: key);

  @override
  State<SheduleDetail> createState() => _SheduleDetail();
}

class _SheduleDetail extends State<SheduleDetail> {
  var Country1 = Text('aa');
  var Country2 = Text('bb');
  final Storage storage = Storage();

  final CollectionReference _sheduless =
      FirebaseFirestore.instance.collection('shedules');
  final CollectionReference _teamss =
      FirebaseFirestore.instance.collection('teams');
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();
  final TextEditingController _country1ScoreController =
      TextEditingController();
  final TextEditingController _country2ScoreController =
      TextEditingController();
  final TextEditingController _country1overController = TextEditingController();
  final TextEditingController _country2overController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Shedule'),
        backgroundColor: Color.fromARGB(255, 127, 219, 244),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: SafeArea(
        child: StreamBuilder(
          stream: _sheduless
              .where('time', isEqualTo: widget.match.data)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot4 =
                      streamSnapshot.data!.docs[index];
                  Text cn1 = Text(documentSnapshot4['country1']);
                  Country1 = cn1;
                  Text cn2 = Text(documentSnapshot4['country2']);
                  Country2 = cn2;
                  final Text res = Text(documentSnapshot4['result']);
                  final Text cn1score =
                      Text(documentSnapshot4['country1Score']);
                  final Text cn2score =
                      Text(documentSnapshot4['country2Score']);
                  return Column(children: [
                    Card(
                      child: Column(children: [
                        GestureDetector(
                          onTap: () => FocusScope.of(context).unfocus(),
                          child: Container(
                            width: 400,
                            height: 150,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color.fromARGB(255, 6, 0, 114),
                                  Color.fromARGB(255, 255, 255, 255),
                                ],
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 3,
                                  color: Color(0x32000000),
                                  offset: Offset(0, 1),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(60),
                                      bottomRight: Radius.circular(60),
                                      topLeft: Radius.circular(60),
                                      topRight: Radius.circular(60),
                                    ),
                                    child: StreamBuilder(
                                        stream: _teamss
                                            .where('countryName',
                                                isEqualTo: Country1.data)
                                            .snapshots(),
                                        builder: (context,
                                            AsyncSnapshot<QuerySnapshot>
                                                streamSnapshot) {
                                          if (!streamSnapshot.hasData) {
                                            return const Text("Loading");
                                          }
                                          var userDocument =
                                              streamSnapshot.data;
                                          final DocumentSnapshot
                                              documentSnapshot1 =
                                              streamSnapshot.data!.docs[index];
                                          final Text Countryimg =
                                              Text(documentSnapshot1['img']);
                                          return FutureBuilder(
                                              future: storage.downloadURL(
                                                  Countryimg.data.toString()),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<String>
                                                      snapshot) {
                                                if (snapshot.connectionState ==
                                                        ConnectionState.done &&
                                                    snapshot.hasData) {
                                                  //padding: EdgeInsets.only(bottom: 5),
                                                  return Image.network(
                                                    snapshot.data!,
                                                    width: 120,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                  );
                                                }

                                                return Container();
                                              });
                                        })),
                                const Spacer(
                                  flex: 1,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 0),
                                            child: cn1score,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    40, 0, 0, 0),
                                            child: cn2score,
                                          ),

                                          /* Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 3, 0, 0),
                                      child: Text(documentSnapshot4['date']),
                                    ),*/
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 20, 0, 0),
                                            child: res,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(60),
                                      bottomLeft: Radius.circular(60),
                                      topRight: Radius.circular(60),
                                      topLeft: Radius.circular(60),
                                    ),
                                    child: StreamBuilder(
                                        stream: _teamss
                                            .where('countryName',
                                                isEqualTo: Country2.data)
                                            .snapshots(),
                                        builder: (context,
                                            AsyncSnapshot<QuerySnapshot>
                                                streamSnapshot) {
                                          if (!streamSnapshot.hasData) {
                                            return new Text("Loading");
                                          }
                                          var userDocument =
                                              streamSnapshot.data;
                                          final DocumentSnapshot
                                              documentSnapshot1 =
                                              streamSnapshot.data!.docs[index];
                                          final Text Countryimg =
                                              Text(documentSnapshot1['img']);
                                          return FutureBuilder(
                                              future: storage.downloadURL(
                                                  Countryimg.data.toString()),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<String>
                                                      snapshot) {
                                                if (snapshot.connectionState ==
                                                        ConnectionState.done &&
                                                    snapshot.hasData) {
                                                  return Image.network(
                                                    snapshot.data!,
                                                    width: 120,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                  );
                                                }

                                                return Container();
                                              });
                                        })),
                              ],
                            ),
                          ),
                        )
                      ]),
                    ),
                    Card(
                      color: Color.fromARGB(255, 62, 5, 143),
                      shadowColor: Colors.purpleAccent,
                      elevation: 7,
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        textColor: Colors.white,
                        title: Text('Country'
                            '                        '
                            'Runs'
                            '                  '
                            'Overs'
                            '      '),
                        subtitle: Text(documentSnapshot4['country1'] +
                            "                          " +
                            documentSnapshot4['country1Score'] +
                            "                      " +
                            documentSnapshot4['country1Over']),
                      ),
                    ),
                    Card(
                      color: Color.fromARGB(255, 62, 5, 143),
                      shadowColor: Colors.purpleAccent,
                      elevation: 7,
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        textColor: Colors.white,
                        title: Text('Country'
                            '                        '
                            'Runs'
                            '                  '
                            'Overs'
                            '      '),
                        subtitle: Text(documentSnapshot4['country2'] +
                            "                                   " +
                            documentSnapshot4['country2Score'] +
                            "                       " +
                            documentSnapshot4['country2Over']),
                      ),
                    ),
                  ]);
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
