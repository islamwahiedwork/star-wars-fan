import 'package:flutter/material.dart';



class SearchBox extends StatefulWidget {
    void Function(String)? onChanged;
  final  TextEditingController txtSearchController ;
   bool showClearIcon = false;
    SearchBox({super.key,required this.onChanged,required this.txtSearchController});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return   TextFormField(
      controller: widget.txtSearchController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      onChanged: (value) {
        setState(() {
          widget.showClearIcon = value.isNotEmpty;
        });
        widget.onChanged!(value);
      },
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
      decoration: InputDecoration(

        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
           mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if(widget.txtSearchController.text.isNotEmpty)
              IconButton(
                onPressed: () {
                  setState(() {
                    widget.txtSearchController.clear();
                    // Clear text field and hide the clear icon
                    widget.showClearIcon = false;
                  });
                  // Clear text field
                  widget.onChanged!('');

                },
                icon: const Icon(Icons.clear, color: Colors.white),
              ),
              const SizedBox(width: 10,),
              const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ],
          ),
        ),
        hintText:"Search",
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 10.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

