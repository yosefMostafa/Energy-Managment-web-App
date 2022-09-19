


DateTime toDateTime(String date){

  List temp=date.split("-");

  return DateTime(int.parse(temp[0]),int.parse(temp[1]),int.parse(temp[2]));
}








int comparescending(int a,int b){
  if (a < b) {
    return -1;
  } else if (a > b) {
    return 1;
  } else {
    return 0;
  }
}
int compardescending(int a,int b){
  if (a < b) {
    return 1;
  } else if (a > b) {
    return -1;
  } else {
    return 0;
  }
}