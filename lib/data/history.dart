import 'package:certificate_app/data/machine.dart';
import 'package:flutter/material.dart';


class Historydata{

    String /*machinename ='N/A',*/workspace ='N/A',datetime ='N/A';
    
    Historydata({/*required this.machinename,*/ required this.workspace,required this.datetime});

    Historydata.fromJson(Map<String, dynamic> json) {
        //machinename = json['machine_id']['stringValue'];
        workspace = json['WorkplaceID']['stringValue'];
        datetime = json['Date']['stringValue'];
}

