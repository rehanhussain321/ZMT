// JScript File

// Comments : 
// Added by Rehan 
// Select All Checkbox In GridView
// Add Below Line to Code to Call this function
// onclick="javascript:SelectAllCheckboxesSpecific(this);" 

function SelectAllCheckboxesSpecific(spanChk)

       {

           var IsChecked = spanChk.checked;

           var Chk = spanChk;

              Parent = document.getElementById('grdDetail');           

              var items = Parent.getElementsByTagName('input');                          

              for(i=0;i<items.length;i++)

              {                

                  if(items[i].id != Chk && items[i].type=="checkbox")
                  {            
                      if(items[i].checked!= IsChecked)

                      {     
                          items[i].click();     

                      }

                  }

              }             

       }
// Comments : 
// Added by Rehan 
// Row Highlighting In GridView
// Use:
//                    <ItemTemplate>
//                        <asp:CheckBox ID="chk_I" runat="server" onclick="javascript:HighlightRow(this);" />
//                    </ItemTemplate>
  function HighlightRow(chkB) 

{

var IsChecked = chkB.checked;            

if(IsChecked)

  {
       chkB.parentElement.parentElement.style.backgroundColor='#228b22';  
       chkB.parentElement.parentElement.style.color='white'; 
  }else 

  {
       chkB.parentElement.parentElement.style.backgroundColor='white'; 
       chkB.parentElement.parentElement.style.color='black'; 

  }

}

// Comments : 
// Added by Rehan 
// On Mouse Over Colour Highlighting
// Use: 
//        Event: grdDetail_RowDataBound    
//        If e.Row.RowType = DataControlRowType.DataRow Then
//            e.Row.Attributes("onmouseover") = "javascript:setMouseOverColor(this);"
//            e.Row.Attributes("onmouseout") = "javascript:setMouseOutColor(this);"
//        End If

        var oldgridSelectedColor;

        function setMouseOverColor(element)
        {
            oldgridSelectedColor = element.style.backgroundColor;
            element.style.backgroundColor='LightBlue';
            element.style.cursor='hand';
            
        }

        function setMouseOutColor(element)
        {
            element.style.backgroundColor=oldgridSelectedColor;
            element.style.textDecoration='none';
        }

