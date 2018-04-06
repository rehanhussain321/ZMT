
 function openme(namefile,winname, w, h,l,t){
  winDetail="width="+w+",height="+h+",dependent=yes,location=0,resizing=No,directories=0,status=1,toolbar=0,scrollbars=yes";
  var msgwin=open("",winname,winDetail);
  msgwin.document.write("<font size=2 face='Verdana'>Please Wait While Processing Data....</font>");
  msgwin.document.location=namefile;
}

