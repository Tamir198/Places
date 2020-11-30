import 'package:flutter/material.dart';
import 'package:flutter_app/providers/user_places.dart';
import 'package:flutter_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your places'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routName);
              }),
        ],
      ),
      body: Center(
        //Fist param child is what not to change
          child: FutureBuilder(
            future: Provider.of<UserPlacesProvider>(context, listen: false).getPlacesData(),
            builder: (context, res) => res.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<UserPlacesProvider>(
                child: Center(child: const Text('Start adding some places')),
                builder: (context, dataFromProvider, child) =>
                dataFromProvider.items.length <= 0
                    ? child
                    : ListView.builder(
                    itemCount: dataFromProvider.items.length,
                    itemBuilder: (BuildContext context, int index) =>
                    //Another way to display image that saved on a file
                    ListTile(
                      leading: CircleAvatar(backgroundImage: FileImage(
                          dataFromProvider.items[index].image)
                      ),
                      title: Text(dataFromProvider.items[index].title),
                      onTap: (){
                        //todo go to detail place
                      },
                    )
                )
            ),
          )
      ),
    );
  }
}
