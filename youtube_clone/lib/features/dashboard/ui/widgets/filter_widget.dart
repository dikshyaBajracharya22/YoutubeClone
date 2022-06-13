import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/common/constants/theme.dart';
import 'package:youtube_clone/common/widgets/buttons/custom_rounded_button.dart';
import 'package:youtube_clone/features/dashboard/cubit/video_cubit.dart';
import 'package:youtube_clone/features/dashboard/ui/widgets/selectable_button.dart';

class FilterWidget extends StatefulWidget {
  final ValueNotifier<String> orders;
  final ValueNotifier<String> videoTypes;
    final Function(String, String) onApply;


  FilterWidget({Key? key, required this.orders, required this.videoTypes, required this.onApply})
      : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  String _selectedOrders = "";
  String _selectedVideoType = "";

  List<String> ordersItems=["Latest", "Popular"];
   List<String> videoTypes=["All", "Film", "Animation"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedOrders = widget.orders.value;
    _selectedVideoType = widget.videoTypes.value;
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: CustomTheme.horixontalPadding, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close)),
                Text(
                  "Filters",
                  style: _textTheme.headline6,
                ),
              ],
            ),
            Text(
              "Orders",
              style: _textTheme.subtitle1,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: ordersItems.map((e){
                return  SelectableButton(
                  label: e,
                  onPressed: () {
                    setState(() {
                      if(_selectedOrders==e.toLowerCase()){
                        _selectedOrders="";
                      }else{
                      _selectedOrders = e.toLowerCase();
                      }
                    });
                  },
                  isSelected: _selectedOrders == e.toLowerCase(),
                  rightMargin: 10,
                );
              }).toList(),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Video Types",
              style: _textTheme.subtitle1,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: videoTypes.map((e) {
                return SelectableButton(
                  label: e,
                  onPressed: () {
                    setState(() {
                      if(_selectedVideoType==e.toLowerCase()){
                        _selectedVideoType="";
                      }else{
                      _selectedVideoType = e.toLowerCase();
                      }
                    });
                  },
                  isSelected: _selectedVideoType == e.toLowerCase(),
                  rightMargin: 10,
                );
              }).toList(),
            ),
            Spacer(),
            CustomRoundedButton(title: "Apply", 
            onPressed: (){
              widget.orders.value=_selectedOrders.toLowerCase();
              widget.videoTypes.value=_selectedVideoType.toLowerCase();
              widget.onApply(widget.orders.value,widget.videoTypes.value);
              Navigator.of(context).pop();
            },)
          ],
        ));
  }
}
