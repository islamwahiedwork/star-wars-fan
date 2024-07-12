import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:star_wars_app/core/utils/global.dart';
import 'package:star_wars_app/features/home/presentation/controller/home_cubit.dart';
import 'package:star_wars_app/features/home/presentation/controller/home_state.dart';

class SearchBox extends StatefulWidget {
  final void Function(String)? onChanged;
  final TextEditingController txtSearchController;
  bool showClearIcon = false;

  SearchBox({
    super.key,
    required this.onChanged,
    required this.txtSearchController,
  });

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  late stt.SpeechToText _speech;


  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!Global.isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {

        },
        onError: (val) {
          setState(() {
             Global.isListening = false;
             HomeCubit.get(context).emit(RefreshDataSearchResultsCountSuccessState());
          });
        },
      );
      if (available) {
        setState(() {
          Global.isListening = true;
          HomeCubit.get(context).emit(RefreshDataSearchResultsCountSuccessState());
        } );
        _speech.listen(
          onResult: (val) => setState(() {
            widget.txtSearchController.text = val.recognizedWords;
            widget.onChanged!(val.recognizedWords);
            Global.isListening = false;

              widget.showClearIcon = widget.txtSearchController.text.isNotEmpty;

            widget.onChanged!(widget.txtSearchController.text);
            HomeCubit.get(context).emit(RefreshDataSearchResultsCountSuccessState());

          }),
        );
      }
    } else {
      setState(() {
        Global.isListening = false;
        HomeCubit.get(context).emit(RefreshDataSearchResultsCountSuccessState());
      }  );
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
              if (widget.txtSearchController.text .isNotEmpty)
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.txtSearchController.clear();
                      widget.showClearIcon = false;
                      Global.isListening = false;
                    });
                    widget.onChanged!('');
                  },
                  icon: const Icon(Icons.clear, color: Colors.white),
                ),
              IconButton(
                icon: Icon(
                  Global.isListening ? Icons.mic : Icons.mic_none,
                  color: Colors.white,
                ),
                onPressed: _listen,
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ],
          ),
        ),
        hintText: "Search",
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
