import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:payroll_app/helpers/Constant.dart';

class FormIconCustom extends StatelessWidget {
  const FormIconCustom({
    Key? key,
    required this.label,
    this.icon,
    this.controller,
    this.onTap,
    this.readOnly,
    this.initialValue,
    this.suffixIcon
  }) : super(key: key);

  final String label;
  final IconData? icon;
  final TextEditingController ?controller;
  final Function()? onTap;
  final bool? readOnly;
  final String? initialValue;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextFormField(
            initialValue: initialValue,
            controller: controller,
            onTap: onTap,
            readOnly: readOnly ?? false,
            decoration: InputDecoration(
              prefixIcon: Icon(icon),
              suffixIcon: suffixIcon,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 0.5, color: Color.fromARGB(255, 177, 177, 177)),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(width: 0.5, color: Colors.black),
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 0.5, color: Color.fromARGB(255, 177, 177, 177)),
              ),
              labelText: label,
            ),
          ),
        ),
      ],
    );
  }
}

class FormCustom extends StatelessWidget {
  const FormCustom({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextFormField(
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 0.5, color: Color.fromARGB(255, 177, 177, 177)),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(width: 0.5, color: Colors.black),
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 0.5, color: Color.fromARGB(255, 177, 177, 177)),
              ),
              labelText: label
            ),
          ),
        ),
      ],
    );
  }
}

class FormCustomBg extends StatefulWidget {
  const FormCustomBg({Key? key, this.helpText, this.label, this.controller, this.errorText}) : super(key: key);

  final String? label;
  final String? helpText;
  final String? errorText;
  final TextEditingController? controller;

  @override
  State<FormCustomBg> createState() => _FormCustomBgState();
}

class _FormCustomBgState extends State<FormCustomBg> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: TextFormField(
            controller: widget.controller,
            // obscuringCharacter: '&',
            obscureText: _isObscure,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              filled: true,
              errorText: widget.errorText,
              fillColor: const Color(0xFFE2E2E2),
              suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    }),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide.none,
              ),
              // labelText: '${widget.label}',
              hintText: '${widget.helpText}',
            ),
          ),
        ),
      ],
    );
  }
}


class OptionCustom extends StatefulWidget {

  const OptionCustom({Key? key, this.labelText, this.textHint, this.icon, required this.items, required this.onChanged}) : super(key: key);

  final String? labelText;
  final String? textHint;
  final IconData? icon;
  final List<String> items;
  final Function(int?) onChanged;

  @override
  State<OptionCustom> createState() => _OptionCustomState();
}

class _OptionCustomState extends State<OptionCustom> {
  // Initial Selected Value
  // String dropDownValue = 'Item 1';

  // List of items in our dropdown menu

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.only(
              right: 0,
              left: 0,
              bottom: 16
            ),
            width: double.infinity,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: DropdownButtonFormField(
                  icon:  const Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                  decoration: InputDecoration(
                    prefixIcon: Icon(widget.icon),
                    suffixIcon: const Icon(Icons.keyboard_arrow_down),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.5,
                          color: Color.fromARGB(255, 177, 177, 177)),
                    ),
                    labelText: widget.labelText,
                  ),
                  // dropdownColor: Colors.blueAccent,
                  // value: widget.items[0],
                  onChanged: widget.onChanged,
                  items: widget.items.asMap().entries.map((items) {
                    return DropdownMenuItem(
                      value: items.key,
                      child: Text(items.value),
                    );
                  }).toList(),
                ),)
              ],
            ))
      ],
    );
  }
}

class CheckboxCustom extends StatefulWidget {
  const CheckboxCustom({Key? key,  this.title, this.controller, required this.onChangeSelected, required this.checked}) : super(key: key);
  // final String? subtitle;
  final String? title;
  final TextEditingController? controller;

  final Function(bool?) onChangeSelected;
  final bool checked;

  @override
  State<CheckboxCustom> createState() => _CheckboxCustomState();
}

class _CheckboxCustomState extends State<CheckboxCustom> {
  bool isChecked = false;
  FocusNode textNode = FocusNode();

  setChecked(bool checked){
    setState(() {
      isChecked = checked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          CheckboxListTile(
            contentPadding: const EdgeInsets.all(0),
            selected: true,
            // title: Text('${widget.title}',style: const TextStyle(fontSize: 14,color: Color.fromARGB(255, 149, 149, 149)),),
            subtitle: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: widget.title,
                ),
                controller: widget.controller,
              ),
            ),
            checkColor: Colors.white,
            controlAffinity: ListTileControlAffinity.leading,
            value: widget.checked,
            onChanged: widget.onChangeSelected
          ),
          const Divider(height: 1, color: clLabel,)
        ],
      ),
    );
  }
}

class AutoCompleteCustom extends StatefulWidget {

  const AutoCompleteCustom({Key? key,  this.label, required this.onChanged, required this.icon, required this.suggestions, this.controller, this.hint, required this.onItemSelected, required this.onRemoved}) : super(key: key);

  final String? label;
  final IconData icon;
  final Function(String) onChanged;
  final Function(String) onItemSelected;
  final Function() onRemoved;
  final TextEditingController ?controller;
  final String? hint;
  final List<String> suggestions;

  @override
  State<AutoCompleteCustom> createState() => _AutoCompleteCustomState();
}

class _AutoCompleteCustomState extends State<AutoCompleteCustom> {
  bool isChecked = false;
  bool showBtnRemove = false;
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: RawAutocomplete(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  }else{
                    List<String> matches = <String>[];
                    matches.addAll(widget.suggestions);

                    matches.retainWhere((s){
                      return s.toLowerCase().contains(textEditingValue.text.toLowerCase());
                    });
                    return matches;
                  }
                },

                textEditingController: widget.controller,
                focusNode: _focusNode,

                fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: TextFormField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      onChanged: widget.onChanged,
                      readOnly: showBtnRemove,
                      decoration: InputDecoration(
                        suffixIcon: showBtnRemove?IconButton(icon: const Icon(Icons.remove_circle), onPressed: () {
                          textEditingController.text = '';
                          setState(() {
                            showBtnRemove = false;
                          });
                          widget.onRemoved;
                        },):null,
                        // enabled: !showBtnRemove,
                        hintText: widget.hint,
                        prefixIcon: Icon(widget.icon),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 0.5, color: Color.fromARGB(255, 177, 177, 177)),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 0.5, color: Colors.black),
                        ),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 0.5, color: Color.fromARGB(255, 177, 177, 177)),
                        ),
                        labelText: widget.label,
                      ),
                    ),
                  );
                },

                optionsViewBuilder: (BuildContext context, void Function(String) onSelected, Iterable<String> options) {
                  return Material(
                    color: Colors.white,
                      child:SizedBox(
                          height: 100,
                          child:SingleChildScrollView(
                              child: Column(
                                children: options.map((opt){
                                  return InkWell(
                                      onTap: (){
                                        onSelected(opt.split('~~')[1]);
                                        setState(() {
                                          showBtnRemove = true;
                                        });
                                        widget.onItemSelected(opt);
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.only(left:45, right: 16),
                                              child: ListTile(
                                                title: Text(opt.split('~~')[1]),
                                                subtitle: Text(opt.split('~~')[2]),
                                                trailing: const InkWell(
                                                  child: Icon(Icons.chevron_right),
                                                ),
                                              )
                                          ),
                                          const Divider(height: 1,)
                                        ],
                                      )
                                  );
                                }).toList(),
                              )
                          )
                      )
                  );
                }),
          ),
        ],
      );
  }
}
