// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_parking_ui_new/base/resizer/fetch_pixels.dart';
// import 'package:flutter_parking_ui_new/base/widget_utils.dart';
// import 'package:grocery/base/select_status_model.dart' as status_model;
// import 'color_data.dart';
//
//
// class SelectState extends StatefulWidget {
//   final ValueChanged<String> onCountryChanged;
//   final ValueChanged<String> onStateChanged;
//   final ValueChanged<String> onCityChanged;
//   final TextStyle? style;
//   final Color? dropdownColor;
//
//   const SelectState(
//       {Key? key,
//       required this.onCountryChanged,
//       required this.onStateChanged,
//       required this.onCityChanged,
//       this.style,
//       this.dropdownColor})
//       : super(key: key);
//
//   @override
//   _SelectStateState createState() => _SelectStateState();
// }
//
// class _SelectStateState extends State<SelectState> {
//   List<String> cities = ["Choose City"];
//   List<String> country = ["Choose Country"];
//   String _selectedCity = "Choose City";
//   String _selectedCountry = "Choose Country";
//   String _selectedState = "Choose State";
//   List<String> _states = ["Choose State"];
//
//   @override
//   void initState() {
//     getCounty();
//     super.initState();
//   }
//
//   Future getResponse() async {
//     var res = await rootBundle.loadString('assets/country.json');
//     return jsonDecode(res);
//   }
//
//   Future getCounty() async {
//     var countryres = await getResponse() as List;
//     for (var data in countryres) {
//       var model = status_model.StatusModel();
//       model.name = data['name'];
//       model.emoji = data['emoji'];
//       if (!mounted) return;
//       setState(() {
//         country.add(model.emoji! + "    " + model.name!);
//       });
//     }
//
//     return country;
//   }
//
//   Future getState() async {
//     var response = await getResponse();
//     var takestate = response
//         .map((map) => status_model.StatusModel.fromJson(map))
//         .where((item) => item.emoji + "    " + item.name == _selectedCountry)
//         .map((item) => item.state)
//         .toList();
//     var states = takestate as List;
//     for (var f in states) {
//       if (!mounted) return;
//       setState(() {
//         var name = f.map((item) => item.name).toList();
//         for (var statename in name) {
//           _states.add(statename.toString());
//         }
//       });
//     }
//
//     return _states;
//   }
//
//   Future getCity() async {
//     var response = await getResponse();
//     var takestate = response
//         .map((map) => status_model.StatusModel.fromJson(map))
//         .where((item) => item.emoji + "    " + item.name == _selectedCountry)
//         .map((item) => item.state)
//         .toList();
//     var states = takestate as List;
//     for (var f in states) {
//       var name = f.where((item) => item.name == _selectedState);
//       var cityname = name.map((item) => item.city).toList();
//       cityname.forEach((ci) {
//         if (!mounted) return;
//         setState(() {
//           var citiesname = ci.map((item) => item.name).toList();
//           for (var citynames in citiesname) {
//             cities.add(citynames.toString());
//           }
//         });
//       });
//     }
//     return cities;
//   }
//
//   void _onSelectedCountry(String value) {
//     if (!mounted) return;
//     setState(() {
//       _selectedState = "Choose State";
//       _states = ["Choose State"];
//       _selectedCountry = value;
//       widget.onCountryChanged(value);
//       getState();
//     });
//   }
//
//   void _onSelectedState(String value) {
//     if (!mounted) return;
//     setState(() {
//       _selectedCity = "Choose City";
//       cities = ["Choose City"];
//       _selectedState = value;
//       widget.onStateChanged(value);
//       getCity();
//     });
//   }
//
//   void _onSelectedCity(String value) {
//     if (!mounted) return;
//     setState(() {
//       _selectedCity = value;
//       widget.onCityChanged(value);
//     });
//   }
//
//   Widget getFonts(String title)
//   {
//     return getCustomFont(title,16,getFontColor(context),1,textAlign: TextAlign.start,fontWeight: FontWeight.w500,);
//   }
//   @override
//   Widget build(BuildContext context) {
//     FetchPixels(context, mockUpWidth1: 414, mockUpHeight1: 896);
//
//     Widget defVerSpace = getVerSpace(FetchPixels.getPixelHeight(20));
//
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         getTextFieldViewCustom(
//             context,
//             Center(
//               child: DropdownButton<String>(
//                 dropdownColor: widget.dropdownColor,
//                 isExpanded: true,
//                 itemHeight: null,
//                 isDense: true,
//                 underline: getVerSpace(0),
//                 items: country.map((String dropDownStringItem) {
//                   return DropdownMenuItem<String>(
//                     value: dropDownStringItem,
//                     child: Row(
//                       children: [
//                         getFonts(dropDownStringItem)
//
//                       ],
//                     ),
//                   );
//                 }).toList(),
//                 onChanged: (value) => _onSelectedCountry(value!),
//                 value: _selectedCountry,
//               ),
//             ),
//             false,
//             EdgeInsets.zero),
//         defVerSpace,
//         getTextFieldViewCustom(context, Center(
//           child: DropdownButton<String>(
//             dropdownColor: widget.dropdownColor,
//             isExpanded: true,
//             itemHeight: null,
//             isDense: true,
//             underline: getVerSpace(0),
//             items: _states.map((String dropDownStringItem) {
//               return DropdownMenuItem<String>(
//                 value: dropDownStringItem,
//                 child:getFonts(dropDownStringItem),
//               );
//             }).toList(),
//             onChanged: (value) => _onSelectedState(value!),
//             value: _selectedState,
//           ),
//         ), false,EdgeInsets.zero),
//         defVerSpace,
//         getTextFieldViewCustom(context,Center(
//           child: DropdownButton<String>(
//             dropdownColor: widget.dropdownColor,
//             isExpanded: true,
//             itemHeight: null,
//             underline: getVerSpace(0),
//             isDense: true,
//             items: cities.map((String dropDownStringItem) {
//               return DropdownMenuItem<String>(
//                 value: dropDownStringItem,
//                 child:getFonts(dropDownStringItem)
//               );
//             }).toList(),
//             onChanged: (value) => _onSelectedCity(value!),
//             value: _selectedCity,
//           ),
//         ),false,EdgeInsets.zero),
//         // const SizedBox(
//         //   height: 10.0,
//         // ),
//       ],
//     );
//   }
// }
