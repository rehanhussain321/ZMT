<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NursingReciept.aspx.cs" Inherits="ZMTClinics.NursingReciept" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Nursing Reciept</title>
    <script src="../assets/js/jquery-1.11.0.min.js"></script>
    <link href="../assets/css/bootstrap.css" rel="stylesheet" />
    <script src="../assets/js/bootstrap.min.js"></script>
    <link href="gistfile1.css" rel="stylesheet" />
    <style>
        .header {
            height: 125px;
            background-color: #7f7f7f;
            color: white;
            
        }
        .side{
            height:25px;
            background-color:#7f7f7f;
            width:65%;
        }
        .no-gutter > [class*='col-'] {
        padding-right:0;
        padding-left:0;
        }
        .header-top{
        margin-top:1%;
        }
        .header-form > [class*='col-']{
            padding-right:-1%;
            padding-left:8%;
        }
        .naminglabel{
            width:10%;
            
        }
       
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="container">
    <div class="row no-gutter">
      <div class="col-xs-2 header">
          <img src="logo1.png" /><strong style="font-size:10px">ZMT Clinics</strong>
      </div>
      <div class="col-xs-4">
          <div class="side"></div>
          <div class="header-top">
              <div class="row header-top">
            <div class="row header-form">
              <div class="col-xs-4">
                  <asp:Label runat="server" CssClass="form-control" style="font-size:8px;">Token No:</asp:Label>
              </div>
                  <div class="col-xs-4" style="padding-left:0;">
                      <asp:Label runat="server" ID="lblPatientTokenNumber" CssClass="form-control" style="font-size:10px;">Token</asp:Label>
                  </div>
            </div>
                  <div class="row header-form">
                      <div class="col-xs-4">
                          <asp:Label runat="server" ID="lblPatientDate" CssClass="form-control"  style="font-size:10px;">Date</asp:Label>
                      </div>
                      <div class="col-xs-4" style="padding-left:0;">
                          <asp:Label runat="server" ID="lblPatientTriageDate" CssClass="form-control"  style="font-size:10px;">Date</asp:Label>
                      </div>
                  </div>
                  
                  <div class="row header-form">
                      <div class="col-xs-4">
                          <asp:Label runat="server" ID="lblMRNo" CssClass="form-control" style="font-size:10px;">MR#</asp:Label>
                      </div>
                      <div class="col-xs-4" style="padding-left:0;">
                          <asp:Label runat="server" ID="lblPatientMrNo" CssClass="form-control" style="font-size:10px;">MR#</asp:Label>
                      </div>
                  </div>
             </div>
          </div>
      </div>
    </div>
        <div class="row no-gutter" style="padding-top:2%;">
            <div class="col-xs-2" style="padding-left:0;width:120px;">
                <asp:Label runat="server" ID="lblPatientName" CssClass="naminglabel">Patient Name</asp:Label>
            </div>
            <div class="col-xs-2" style="padding-left:0;width:120px;">
                <asp:Label runat="server" ID="lblTriagePatientName" CssClass="naminglabel">Rehan Hussain</asp:Label>
            </div>
            <div class="col-xs-2" style="padding-left:0;width:50px;">
                <asp:Label runat="server" ID="lblGurdian" CssClass="naminglabel">S/O</asp:Label>
            </div>
            <div class="col-xs-2" style="padding-left:0;">
                <asp:Label runat="server" ID="lblGurdianName" CssClass="naminglabel">Intezar Hussain</asp:Label>
            </div>
        </div>
        <div class="row no-gutter" style="padding-top:2%">

        </div>
    </div>

    </form>
</body>
</html>
