class MonumentModel {
  //String SrNo;
  //String OrderID;
  //String DeviceSerialNumber;
  /*String Status;
  String Operations;
  String BranchID;
  */
  String TMARTBranch;
  String Comments;

  MonumentModel({
    //required this.SrNo,
    //required this.OrderID,
    //required this.DeviceSerialNumber,
    /*required this.Status,
    required this.Operations,
    required this.BranchID,
    */
    required this.TMARTBranch,
    required this.Comments,
  });

  factory MonumentModel.fromMap(Map<String, dynamic> json) {
    return MonumentModel(
      //SrNo: json['SrNo'],
      //OrderID: json['OrderID'],
      //DeviceSerialNumber: json['DeviceSerialNumber'],
      /*Operations: json['Operations'],
      BranchID: json['BranchID'],
      */
      TMARTBranch: json['TMARTBranch'],
      Comments: json['Comments'],
      /*Status: json['Status'],*/
    );
  }
}
