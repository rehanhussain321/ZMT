function hideSearch(objdiv){
	objdiv.style.display='none'
}
function showSearch(objdiv){
	objdiv.style.display='block'
}

function ToggleSearch (l_Div, l_button) 
{
	var objDiv = document.getElementById(l_Div);
	var objBut = document.getElementById(l_button);
	
	if (objDiv.style.display == 'none' ) 
	{
		//objBut.document.value = "TESTING";
		//alert(objBut.document.value);
		showSearch ( objDiv ) ;
	
	}
	else if (objDiv.style.display == 'block' ) 
	{
		hideSearch  ( objDiv ) ;
	}
}

function confirmDelete()
			{
				if(confirm("Are you sure you want to Delete?"))
				{
					return true;					
				}
				else
				{
					return false;					
				}
			}

function ShowTPResult()    
{
    ShowDiv('TPResult'); 
}
function ShowDiv(DivName)
{
   if(document.layers)
   {
      document.layers[DivName].visibility="visible"; 
   }
   else if (document.getElementById)
   {
      document.getElementById(DivName).style.display="";
      document.getElementById(DivName).style.visibility="visible";
   }
   else if (document.all)
   {
      document.all(DivName).style.display="";
      document.all(DivName).style.visibility="visible";	
   }                    		
  if(DivName == 'Ctrlbtn')
  {
      hidden = false;
  }
}
function HideDiv(DivName) 
{           
  if(document.layers)
  {
     document.layers[DivName].visibility="hidden"; 
  }
  else if (document.getElementById) 
  {
     document.getElementById(DivName).style.display="none";
     document.getElementById(DivName).style.visibility="hidden";
  } 
  else if (document.all) 
  {
     document.all(DivName).style.display="none";
     document.all(DivName).style.visibility="hidden";	
  }
                
 if(DivName == 'Ctrlbtn')
 {
     hidden = true;
 }
}
 function CheckInput(objName,minval,maxval,comma,period,hyphen)
    {
        var numberfield = objName;
	    if (chkNumeric(objName,minval,maxval,comma,period,hyphen) == false)
	    {
		    numberfield.select();
		    numberfield.focus();
		    return false;
	    }
	    else
	    {
		    return true;
	    }
     }   
     function chkNumeric(objName,minval,maxval,comma,period,hyphen)
     {
        // only allow 0-9 be entered, plus any values passed
        // (can be in any order, and don't have to be comma, period, or hyphen)
        // if all numbers allow commas, periods, hyphens or whatever,
        // just hard code it here and take out the passed parameters
        var checkOK = "0123456789" + comma + period + hyphen;
        var checkStr = objName;
        var allValid = true;
        var decPoints = 0;
        var allNum = "";

        for (i = 0;  i < checkStr.value.length;  i++)
        {
            ch = checkStr.value.charAt(i);
            for (j = 0;  j < checkOK.length;  j++)
            if (ch == checkOK.charAt(j))
                break;
            if (j == checkOK.length)
            {
                allValid = false;
                break;
            }
            if (ch != ",")
                allNum += ch;
         }
            if (!allValid)
            {	
                alertsay = "Please enter only these values \""
                //alertsay = alertsay + checkOK + "\" in the \"" + checkStr.name + "\" field."
                alertsay = alertsay + checkOK
                alert(alertsay);
                return (false);
            }

            // set the minimum and maximum
            var chkVal = allNum;
            var prsVal = parseInt(allNum);
            if (chkVal != "" && !(prsVal >= minval && prsVal <= maxval))
            {
                alertsay = "Please enter a value greater than or "
                alertsay = alertsay + "equal to \"" + minval + "\" and less than or "
                //alertsay = alertsay + "equal to \"" + maxval + "\" in the \"" + checkStr.name + "\" field."
                alertsay = alertsay + "equal to \"" + maxval + "\""
                alert(alertsay);
                return (false);
            }
        }
        
        




 function minVal(Arr)
 {
    var mn=Arr[0];
    for(i=0;i<Arr.length;i++)
       {
            if (Arr[i] < mn){
               mn = Arr[i];
            }
       }
       return mn;
 }


/*
Function For Open grid Window
*/
function ShowList()
 {
    document.onkeydown = function(e) {
    e=e||window.event;
    if (event.keyCode == 76 && event.ctrlKey) {
        ShowTPResult();
        return false
    }
   } 
 }
function ShowTPResult(value)    
{
    ShowDiv('TPResult'); 
    window.frames['tpFrame'].document.getElementById("txtSearch").focus();
    
    var fr=frames['tpFrame'];
    fr=fr.document.forms[0];
    
 //    fr.elements['txtTypeCode'].value = value;
    
}
function ShowDiv(DivName)
{
   if(document.layers)
   {
      document.layers[DivName].visibility="visible"; 
   }
   else if (document.getElementById)
   {
      document.getElementById(DivName).style.display="";
      document.getElementById(DivName).style.visibility="visible";
   }
   else if (document.all)
   {
      document.all(DivName).style.display="";
      document.all(DivName).style.visibility="visible";	
   }                    		
  if(DivName == 'Ctrlbtn')
  {
      hidden = false;
  }
}
function HideDiv(DivName) 
{           
  if(document.layers)
  {
     document.layers[DivName].visibility="hidden"; 
  }
  else if (document.getElementById) 
  {
     document.getElementById(DivName).style.display="none";
     document.getElementById(DivName).style.visibility="hidden";
  } 
  else if (document.all) 
  {
     document.all(DivName).style.display="none";
     document.all(DivName).style.visibility="hidden";	
  }
                
 if(DivName == 'Ctrlbtn')
 {
     hidden = true;
 }
}