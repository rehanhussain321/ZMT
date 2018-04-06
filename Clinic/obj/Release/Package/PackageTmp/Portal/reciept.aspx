<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="reciept.aspx.cs" Inherits="ZMTClinics.reciept_copy" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reciept</title>
    <link rel="stylesheet" href="../assets/js/jquery-ui/css/no-theme/jquery-ui-1.10.3.custom.min.css"/>
	<link rel="stylesheet" href="../assets/css/font-icons/entypo/css/entypo.css"/>
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Noto+Sans:400,700,400italic"/>
    <link rel="stylesheet" href="fonts/c39hrp24dhtt_0.ttf" />
	<link rel="stylesheet" href="../assets/css/bootstrap.css"/>
    <link href="../style/calendar-win2k-1.css" rel="stylesheet" />
   <script src="../assets/js/jquery-1.11.0.min.js"></script>
    <script src="../assets/js/jquery-1.11.0.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <style type="text/css" media="print">
       @page{
           size:auto;
           margin-top:2%;
           margin-left:2%;
           margin-right:3%;
           font-size:12px;
           margin-bottom:0px;
           font-weight:bold;
           max-height:99%;
            
       }
        @media all {
	     .page-break	{ display: none; }
       }

      @media print {
	    .page-break	{ display: block; page-break-before: always; }
      }
    </style>
    <script>
        function myFunction() {
            document.getElementById('btnPrint').style.visibility = "hidden";
            document.getElementById('btnBack').style.visibility = "hidden";
            document.getElementById('chkRemove').style.visibility = "hidden";
            document.getElementById('lblChk').style.visibility = "hidden";
            document.getElementById('CheckNursing').style.visibility = "hidden";
            document.getElementById('CheckPayment').style.visibility = "hidden";
            document.getElementById('lblNursingHide').style.visibility = "hidden";
            document.getElementById('lblPaymentHide').style.visibility = "hidden";
            document.getElementById('CheckFooter').style.visibility = "hidden";
            document.getElementById('lblFooterHide').style.visibility = "hidden";
           // document.getElementById('gvServices_id6_h').style.visibility = "hidden";
           // document.getElementById('gvServices_id6_i_1').style.visibility = "hidden";
            //document.getElementById('gvServices_id6_i_2').style.visibility = "hidden";
            //document.getElementById('gvServices_id6_i_3').style.visibility = "hidden";
            //document.getElementById('gvServices_id6_i_4').style.visibility = "hidden";
            //document.getElementById('gvServices_id6_i_5').style.visibility = "hidden";
            //document.getElementById('gvServices_id6_i_6').style.visibility = "hidden";

            //document.getElementById('gvServices_id6_f_6').style.visibility = "hidden";
            
            
            
            window.print();
            
        }
        function showHide()
        {
            if (document.getElementById('CheckNursing').checked) {
                document.getElementById('tblNursing').style.visibility = "hidden";
            }

        }
</script>
     <script type="text/javascript">
         $(function () {
             $("[id*=chkRemove]").click(function () {
                 var isChecked = !$(this).is(":checked");
                 var th = $("[id*=gvServices] th:contains('Remove')");
                 th.css("display", isChecked ? "" : "none");
                 $("[id*=gvServices] tr").each(function () {
                     $(this).find("td").eq(th.index()).css("display", isChecked ? "" : "none");
                 });
             });
         });
              </script>
    <script>
        function HideColumn(objectRef) {
            //Get the Row based on checkbox
            var row = objectRef.parentNode.parentNode;
            if (objectRef.checked) {
                //If checked hide the column
                row.cells[1].style.display = "none";
                row.cells[2].style.display = "none";
                row.cells[3].style.display = "none";
                row.cells[4].style.display = "none";
                row.cells[5].style.display = "none";
                row.cells[0].style.display = "none";
                // alert($('#gvServices_id5_i_1').val());
                //$('#gvServices_id5_f').html('500');
                
            }
            else {
                //If not checked show the column
                row.cells[1].style.display = "block";
                row.cells[2].style.display = "block";
                row.cells[3].style.display = "block";
                row.cells[4].style.display = "block";
                row.cells[5].style.display = "block";

            }
            GrossTotal();
        }

        function GrossTotal() {
            gross = 0;
            $("[id*=gvServices_][id*=id5_i_]").each(function (index, item) {
                gross = gross + parseInt($(item).text());
                alert(gross);
            });
            $('#gvServices_id5_f').text(gross);

            
            
        }
    </script>
    <script>
        $(function () {
            $("#CheckNursing").click(function () {
                if ($(this).is(":checked")) {
                    $("#tblNursing").hide();
                } else {
                    $("#tblNursing").show();
                }
            });
        }); 
    </script>
    <script>
        $(function () {
            $("#CheckPayment").click(function () {
                if ($(this).is(":checked")) {
                    $("#gvServices").hide();
                } else {
                    $("#gvServices").show();
                }
            });
        });
    </script>
    <script>
        $(function () {
            $("#CheckFooter").click(function () {
                if ($(this).is(":checked")) {
                    $("#tblFooter").hide();
                } else {
                    $("#tblFooter").show();
                }
            });
        });
    </script>
    <script>
        $(document).ready(function () {
            $('input:checkbox').prop('checked', false);
        });
    </script>
    <style>
        .hideCol
        {
          display:none;
            }

        .patientStyle {

            color: black;
            font-weight:bolder; 
            border: black solid 1px; 
            font-size: 16px; 
            padding-top: 0px; 
            height: 1px;
            padding-left:5px;
        }
        .patientinputstyle{
            color: black; 
            border: black solid 1px; 
            font-size: 16px; 
            padding-top: 0px; 
            height: 1px;
            padding-left:5px;
        }
         .NursingStyle {

            color: black;
            font-weight: bold; 
            border: black solid 1px; 
            font-size: 16px; 
            padding-top: 0px; 
            height: 30px;
            width:12%;
            text-align:center;
        }
         .Complain {

            color: black;
            font-weight: bold; 
            border: black solid 1px; 
            font-size: 16px; 
            padding-top: 0px; 
            height: 30px;
            width:30%;
            text-align:center;
        }
        .RxStyle {

            color: black;
            font-weight: bold; 
            border: black solid 1px; 
            font-size: 16px; 
            padding-top: 0px; 
            margin-top:0px;
            height: 200px;
            width:12%;
            border-bottom:none;
            border-top:none;
            border-right:none;
            border-left:none;
        }
        .align-right{
            text-align:right;
        }
       .align-left{
           padding-left:5px;
       }
      
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div class="container">
        <div class="row" >
            <div class="col-md-6" id="print">
                <table class="table" style="margin-top:2%;margin-left:1%;margin-right:1%;" >
                <tr>
                    <td style="color:black;font-weight:bold;"><asp:label runat="server" ID="lblClinic" style="font-weight:bolder;font-size:20px">ZMT Clinics</asp:label><br /><asp:label ID="lblClinicAddress" runat="server"></asp:label></td>
                    <td style="text-align:right;color:black;font-weight:bold;" colspan="3"><asp:label runat="server" style="font-weight:bolder; font-size:16px">Token#</asp:label><asp:label runat="server" ID="lbltokenNo" style="font-weight:bolder; font-size:16px"></asp:label><br /><asp:Label runat="server">Dated:</asp:Label><asp:label runat="server" ID="lblDate"></asp:label></td>
                </tr>
                </table>
                <table style="margin-left: 1%; margin-right: 1%; width: 100%">
                   
                <tr style="max-height: 2px;">
                        <td class="patientStyle" >MR#:</td>
                        <td class="patientinputstyle"><asp:Label runat="server" ID="lblMrNo"></asp:Label></td>
                        <td class="patientStyle">Paying</td>
                        <td class="patientinputstyle"><asp:Label runat="server" ID="lblPayingStatus"></asp:Label></td>
                    </tr>
                  <tr>
                    <td class="patientStyle">Patient</td>
                    <td class="patientinputstyle"><asp:label runat="server" ID="lblPatientName"></asp:label></td>
                    <td class="patientStyle"><asp:label runat="server" ID="lblGuardian"></asp:label></td>
                    <td class="patientinputstyle"><asp:label runat="server" ID="lblPatientFatherName"></asp:label></td>
                </tr>

                 <tr>
                    <td class="patientStyle">Age:</td>
                    <td class="patientinputstyle"><asp:Label runat="server" ID="lblAgeYear"></asp:Label>.<asp:Label runat="server" ID="lblAgeMonth"></asp:Label>&nbsp;Year</td>
                    <td class="patientStyle">Gender</td>
                    <td class="patientinputstyle"><asp:Label runat="server" ID="lblGender"></asp:Label></td>
                </tr>
                <tr>
                    <td class="patientStyle">Address</td>
                    <td colspan="3" class="patientinputstyle"><asp:label runat="server" ID="lblAddress"></asp:label></td>
                </tr>
                </table>

                 <table style="margin-left: 1%; margin-right: 1%; width: 100%" id="tblNursing" >
                <%--<tr>
                      <td class="patientStyle" colspan="8" style="background-color:#808080" >Nursing Triage</td>
                </tr>--%>

                     
                <tr >
                    <td class="NursingStyle">Temp</td>  <td class="NursingStyle" >&nbsp;</td>
                    <td class="NursingStyle">B.P</td>   <td class="NursingStyle" >&nbsp;</td>
                    <td class="NursingStyle">RR </td>   <td class="NursingStyle" >&nbsp;</td>
                    
                </tr>

                <tr>
                    <td class="NursingStyle">Pulse</td> <td class="NursingStyle" >&nbsp;</td>
                    <td class="NursingStyle">Weight</td><td class="NursingStyle" >&nbsp;</td>
                    <td class="NursingStyle">Height</td><td class="NursingStyle" >&nbsp;</td>
                    
                </tr>
                <tr>
                    <td class="Complain">Chief Complain</td><td  colspan="6" class="NursingStyle" >&nbsp;</td>
                </tr>
                </table> 




                

              
                
             <asp:GridView ID="gvServices" runat="server" AutoGenerateColumns="False" Width="100%" CellPadding="4" Font-Bold="True" Font-Size="10pt" ForeColor="Black" BackColor="Black" BorderColor="Black" BorderStyle="None" BorderWidth="1px" CellSpacing="2" OnRowDataBound="gvServices_RowDataBound" ShowFooter="True" style="margin-top:0px;padding-top:0px;font-size:16px;margin-left:1%;margin-right:1%;" OnRowDeleting="gvServices_RowDeleting">
                <Columns>
                    <asp:TemplateField  ControlStyle-Width="0" Visible="false">
                       <ItemTemplate  >
                          <asp:CheckBox ID="chkRow" runat="server" onclick="HideColumn(this);" Visible="false" CssClass="hideCol"  />
                       </ItemTemplate>

                       <ControlStyle Width="0px"></ControlStyle>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Service_Name" HeaderStyle-BackColor="Black" HeaderStyle-CssClass="align-left" HeaderStyle-Font-Bold="true" HeaderText=" Services" HeaderStyle-ForeColor="White">
                    <HeaderStyle BackColor="Black" CssClass="align-left" />
                    <ItemStyle HorizontalAlign="Left" CssClass="align-left" Font-Bold="false" />
                    </asp:BoundField>
                    <asp:BoundField  DataField="Service_DetailName" HeaderStyle-BackColor="black" HeaderStyle-CssClass="align-left" HeaderStyle-Font-Bold="true" HeaderText="Service Detail" HeaderStyle-ForeColor="White">
                    <ControlStyle BackColor="white" />
                    <HeaderStyle BackColor="Black" CssClass="align-left" />
                    <ItemStyle HorizontalAlign="left" CssClass="align-left" Font-Bold="false" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Qty" HeaderStyle-BackColor="Black" HeaderStyle-CssClass="align-right" HeaderText= "Qty" HeaderStyle-Font-Bold="true" HeaderStyle-ForeColor="White">
                    <HeaderStyle BackColor="Black" CssClass="align-right"/>
                    <ItemStyle HorizontalAlign="right" Font-Bold="false" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Charges" HeaderStyle-BackColor="Black" HeaderStyle-CssClass="align-right" HeaderText=" Rate" HeaderStyle-Font-Bold="true" HeaderStyle-ForeColor="White">
                    <HeaderStyle BackColor="Black" CssClass="align-right" />
                    <ItemStyle HorizontalAlign="right" Font-Bold="false" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Amount" HeaderStyle-BackColor="Black" HeaderStyle-CssClass="align-right" HeaderText=" Amount" HeaderStyle-Font-Bold="true" HeaderStyle-ForeColor="White">
                    <HeaderStyle BackColor="Black" CssClass="align-right" />
                    <ItemStyle HorizontalAlign="Right" Font-Bold="false" />
                    
                    </asp:BoundField>
                    <asp:CommandField           
                        HeaderText="Remove"
                        ControlStyle-CssClass=""
                                                ShowDeleteButton="True" >
                                       <HeaderStyle BackColor="Black" ForeColor="White"></HeaderStyle>
                                </asp:CommandField>
                </Columns>
                              <FooterStyle BackColor="#CCCCCC" HorizontalAlign="Right"/>
                              <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                              <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                              <RowStyle BackColor="White" />
                              <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                              <SortedAscendingCellStyle BackColor="#F1F1F1" />
                              <SortedAscendingHeaderStyle BackColor="#808080" />
                              <SortedDescendingCellStyle BackColor="#CAC9C9" />
                              <SortedDescendingHeaderStyle BackColor="#383838" />
            </asp:GridView>
            <table style="margin-left: 1%; margin-right: 1%; width: 100%;border-bottom:none;border-left:none;border-right:none;height:90%">
                <tr>
                    <td style="border-bottom: none;color:black;font-size:50px;font-weight:bold;padding-top:1px;"><span>&#8478;</span></td>
                </tr>
                <tr>
                    <td class="RxStyle"></td>
                </tr>
                
            </table>  
            <table style="margin-top:480px;margin-left: 1%; margin-right: 1%; width: 100%;border-bottom:none;border-left:none;border-right:none;" id="tblFooter">
                <tr>
                    <td style="text-align:center;"><asp:label ID="lblfooter" runat="server" style="text-align:center;font-weight:bold;">Computer genertated report doesn't requiered any signature</asp:label></td>
                </tr>
            </table>
    </div>
    </div>
        <div id="page-break"></div>
         <div class="row">
        <div class="col-md-5 pull-right-md">
            <asp:Button ID="btnPrint" runat="server" Text="Print" Class="btn btn-blue" OnClientClick ="myFunction()" OnClick="btnPrint_Click" /><br />
            <asp:CheckBox ID="chkRemove" runat="server"/><asp:Label runat="server" ID="lblChk">Click on Button to enable/disable remove option</asp:Label><br />
            <asp:CheckBox ID="CheckNursing" runat="server" /><asp:Label runat="server" ID="lblNursingHide">Click To Hide Nursing Triage</asp:Label><br />
            <asp:CheckBox ID="CheckPayment" runat="server" /><asp:Label runat="server" ID="lblPaymentHide">Click To Hide Payment</asp:Label><br />
            <asp:CheckBox ID="CheckFooter" runat="server"  /><asp:Label runat="server" ID="lblFooterHide" >Click To Enable Disable Footer Message</asp:Label>
        </div> 
        <div class="col-md-4 row ">
           <a href="Patient.aspx"<asp:Button ID="btnBack" runat="server" Text="Back To Main" Class="btn btn-blue" />Back To Patient</a>
        </div>   
        </div>
    </form>
</body>
</html>
