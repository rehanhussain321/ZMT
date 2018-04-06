// JScript File


var keysPressed = [];

function selectAsYouType(e)
{
    var keyChar; var keyNum;
    var comboBox;
    if (window.event) // IE
    {
        keyNum = e.keyCode;            
    }
    else
    {
        return true; // browser doesn't support DOM, do default processing.
    }
    
    keyChar = String.fromCharCode(keyNum);
    comboBox = e.srcElement;
    
    
    if (!comboBox)
    {
        return true; // if DOM didn't work, do default processing
    }
    if (keyNum == 27) // Esc key
    {
        clearKeysPressed(comboBox);
    }
    else
    {
        return selectElement(comboBox, keyChar);
    }
    return true;
}

function clearKeysPressed(e)
{
    if (e.srcElement)
        keysPressed[e.srcElement]="";
}

function selectElement(comboBox, keyChar)
{
    var i = 0;
    var keysPressedSoFar =     keysPressed[comboBox] || "";
    keysPressedSoFar += keyChar;
    keysPressed[comboBox] = keysPressedSoFar;
    var options = comboBox.options;
    for (i = 0; i<options.length; ++i)
    {
        if (options[i].text.toUpperCase().indexOf(keysPressedSoFar.toUpperCase(), 0) == 0)
        {
            comboBox.selectedIndex = i;
            return false; // don't do default processing
        }
    }
    keysPressed[comboBox] = String(keyChar); // didn't match start of any option, so reset keysPressed to just this key
    return true;   
      
}
   function CalculateQtyIssue(CalulateAmtfor,idQty,yarnweight,idWeight,BalQty)
   {
        var wtperQty=eval(yarnweight)/eval(BalQty);
        if (CalulateAmtfor=="Issue")
        {   
            var qtyissue=document.getElementById(idQty).value;
            document.getElementById(idWeight).value=wtperQty*qtyissue;
        }
        else
        {
            var issueWeight=document.getElementById(idWeight).value;
            document.getElementById(idQty).value=eval(issueWeight)/eval(wtperQty);
        }
   }
   // =============== COMBO TOOLTIP ============================== // 
      function settooltip(dropdown) { 
        

        var obj = document.getElementById(dropdown.name);
        document.getElementById("tooltip").innerHTML =    obj.options[obj.selectedIndex].text;
        if(event.type == "mouseout")
        {
        document.getElementById("tooltip").style.display = "none";
        }
        else
        {
        document.getElementById("tooltip").style.display = "inline-block";
        document.getElementById("tooltip").style.top = event.y;
        document.getElementById("tooltip").style.left = event.x;
        var str = obj.options[obj.selectedIndex].text;
        var str1 = "%";
        var str2 = str.length;
        document.getElementById("tooltip").style.width = str2+100;
        document.getElementById("tooltip").style.zIndex = 1;
        
        }

    } 

