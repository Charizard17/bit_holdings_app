import 'package:flutter/material.dart';

class AddCoinScreen extends StatefulWidget {
  const AddCoinScreen({Key? key}) : super(key: key);

  @override
  State<AddCoinScreen> createState() => _AddCoinScreenState();
}

class _AddCoinScreenState extends State<AddCoinScreen> {
  TextEditingController _quantity = TextEditingController();
  TextEditingController _buyPrice = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Future<void> _selectDate(BuildContext context) async {
      DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2009),
        lastDate: DateTime(DateTime.now().year + 1),
      );
      if (selectedDate != null && selectedDate != _selectedDate) {
        setState(() {
          _selectedDate = selectedDate;
        });
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(top: 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      'Add Coin',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 35,
                      color: Colors.transparent,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price per coin:',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: _buyPrice,
                        decoration: InputDecoration(
                          hintText: '\$40,000.00',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Quantity:',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        controller: _quantity,
                        decoration: InputDecoration(
                          hintText: '0.00',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transaction Date:',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    OutlinedButton(
                      child: Text(
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
