import 'package:flutter/material.dart';

class WidgetHelper {
  Widget appbarcustom(BuildContext context, String judul) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        judul,
        style: TextStyle(color: Colors.black),
      ),
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black),
    );
  }

  Widget appbarHistory(BuildContext context, String judul) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        judul,
        style: TextStyle(color: Colors.black),
      ),
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black),
      bottom: const TabBar(labelColor: Colors.black, tabs: <Widget>[
        Tab(
          icon: Text('Berdasarkan Toko'),
        ),
        Tab(
          icon: Text('Berdasarkan Waktu'),
        ),
        Tab(
          icon: Text('Rincian Order'),
        ),
      ]),
    );
  }

  Widget appbarProfil(BuildContext context, String judul) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        judul,
        style: TextStyle(color: Colors.black),
      ),
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black),
      flexibleSpace: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                padding: EdgeInsets.all(12),
                child: Image(
                    image: AssetImage(
                        'assets/dashboard/noto_convenience-store.png')),
              ),
              Container(
                child:
                    ElevatedButton(onPressed: () {}, child: Text('Ganti Foto')),
              )
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Toko ABC',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
              Text(
                '4.0',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow.shade600,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow.shade600,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow.shade600,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow.shade600,
                  ),
                ],
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(right: 50))
        ],
      ),
      bottom: const TabBar(labelColor: Colors.black, tabs: <Widget>[
        Tab(
          icon: Text('Profil Toko'),
        ),
        Tab(
          icon: Text('Review Toko'),
        ),
      ]),
    );
  }
}
