﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pharmasy.aspx.cs" Inherits="ZMTClinics.Pharmasy" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ZMT Clinics::Pharmacy</title>
    <link rel="stylesheet" href="../assets/js/jquery-ui/css/no-theme/jquery-ui-1.10.3.custom.min.css"/>
	<link rel="stylesheet" href="../assets/css/font-icons/entypo/css/entypo.css"/>
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Noto+Sans:400,700,400italic"/>
	<link rel="stylesheet" href="../assets/css/bootstrap.css"/>
	<link rel="stylesheet" href="../assets/css/neon-core.css"/>
	<link rel="stylesheet" href="../assets/css/neon-theme.css"/>
	<link rel="stylesheet" href="../assets/css/neon-forms.css"/>
	<link rel="stylesheet" href="../assets/css/custom.css"/>
    <link rel="stylesheet" href="../assets/form.css" />
    <link href="../style/calendar-win2k-1.css" rel="stylesheet" />
    <script src="../assets/js/jquery-1.11.0.min.js"></script>
    <script src="../assets/js/jquery-1.11.0.min.js"></script>
    
    <script src="dist/jquery.inputmask.bundle.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
    <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js" type="text/javascript"></script>
    <%--    <script src="Scripts/calendar-en.js"></script>
    <script src="Scripts/calendar-setup.js"></script>
    <script src="Scripts/calendar-setup_stripped.js"></script>
    <script src="Scripts/calendar_stripped.js"></script>
    <script src="Scripts/CalendarPopup.js"></script>--%><%-- <script src="assets/jquery-1.4.1.min.js"></script>--%>
    <script src="../assets/jquery.dynDateTime.min.js"></script>
    <script src="../assets/calendar-en.min.js"></script>
    <link href="../assets/calendar-blue.css" rel="stylesheet" />
        <link href="../gridcss/grid.css" rel="stylesheet" />
    <link href="../gridcss/table.css" rel="stylesheet" />
    <link href="../gridcss/footable.css" rel="stylesheet" />
    <%--<link href="grid.css" rel="stylesheet" />
    <link href="table.css" rel="stylesheet" />
    <link href="footable.css" rel="stylesheet" /> --%>
     <link href="../DatePicker/bootstrap-datepicker.css" rel="stylesheet" />
    <script src="../DatePicker/bootstrap-datepicker.js"></script>
    <%--<script>$.noConflict();</script>
	<!--[if lt IE 9]><script src="assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
		<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->
   <%--<script>
       $(document).ready(function () {
           $(".datepicker").datepicker({ format: 'dd/mm/yyyy', autoclose: true, todayBtn: 'linked' })
       });
</script>--%>
    
    <style>
        .hideCol
        {
          display:none;
            }
        .text-right{
            text-align:right;
            
            
        }
    </style>
        <style>

 
.table > tbody > tr > .no-line {
    border-top: none;
}
.table > th > .text-center {
    text-align:center;
}
.table > th > .text-left {
    text-align:left;
}
.table > thead > tr > .no-line {
    border-bottom: none;
}

.table > tbody > tr > .thick-line {
    border-top: 2px solid;
}
.table > tbody > tr > td .{
    color:black;
    font-weight:900;
}
.table>tbody > tr:hover{
    background-color:burlywood;
}
    </style>

    <script type = "text/javascript">
        function Confirm() {
            if (confirm("Do you want to print slip?")) {
                window.location.href = 'PharmacyReciept.aspx';
            } else {
                //alert('No');
                window.location.href = 'Pharmasy.aspx';
                return false;
            }
        }
    </script>
    <script>
        function sumQuantity() {
            var ddUnit = document.getElementById('ddUnit').value;
            var ddDosage = document.getElementById('ddDosage').value;
            var ddDays = document.getElementById('ddDays').value;
            var DosageQuantity = document.getElementById('txtQuantity');
            if (ddUnit == '5') {
                
                DosageQuantity.value = parseInt(ddDosage) * parseInt(ddDays);
            }
            else {
                DosageQuantity.value = 1;
            }
            
        }
    </script>
    <link href="style/interface.css" rel="stylesheet" type="text/css" />
    <link href="style/calendar-win2k-1.css" type="text/css" rel="stylesheet" />
    <script src="Javascript/calendar.js" type="text/javascript"></script>
    <script src="Javascript/calendar-en.js" type="text/javascript"></script>
    <script src="Javascript/calendar-setup.js" type="text/javascript"></script>
    <script src="Javascript/calendar-stripped.js" type="text/javascript"></script>
    <script src="Javascript/calendar-setup_stripped.js" type="text/javascript"></script>
    <script>
        function showDetailAdded() {
            if (document.getElementById('lblPatientMrNo').innerHTML = '') {
                document.getElementById('ServiceAddedPanel').display = 'none';

            }
        }

    </script>
</head>
<body class="page-body">
    <form id="form1" runat="server">
    <div class="page-container">
       <div class="sidebar-menu">
        <div class ="sidebar-menu-inner">
        <header class="logo-env">

				<!-- logo -->
				<div class="logo">
					<a href="grid.aspx">
						<img src="logo.png" class="img-circle" Width="150" />
					</a>
				</div>

				<!-- logo collapse icon -->
				<div class="sidebar-collapse">
					<a href="#" class="sidebar-collapse-icon">
                        <!-- add class "with-animation" if you want sidebar to have animation during expanding/collapsing transition -->
						<i class="entypo-menu"></i>
					</a>
				</div>

								
				<!-- open/close menu icon (do not remove if you want to enable menu on mobile devices) -->
				<div class="sidebar-mobile-menu visible-xs">
					<a href="#" class="with-animation"><!-- add class "with-animation" to support animation -->
						<i class="entypo-menu"></i>
					</a>
				</div>

			</header>
            
        <asp:Panel ID="Panel1" runat="server" CssClass="main-menu">
           
        </asp:Panel>
                
        </div>
    </div>
        <div class="main-content">
            <div class="row">
		
			<!-- Profile Info and Notifications -->
			<div class="col-md-6 col-sm-8 clearfix">
		
				<ul class="user-info pull-left pull-none-xsm">
		
					<!-- Profile Info -->
					<li class="profile-info dropdown"><!-- add class "pull-right" if you want to place this from right -->
		
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <%--<img src="assets/images/thumb-1@2x.png" alt="" class="img-circle" width="44" />--%>
                            <asp:Image ID="ImgUser" runat="server"  Width="50" CssClass="img-circle"  />
							<asp:Label runat="server" ID="lblUserName"></asp:Label>
						</a>
		
						<ul class="dropdown-menu">
		
							<!-- Reverse Caret -->
                            <%--<li class="caret"></li>
		
							<!-- Profile sub-links -->
							<li>
								<a href="extra-timeline.html">
									<i class="entypo-user"></i>
									Edit Profile
								</a>
							</li>
		
							<li>
								<a href="mailbox.html">
									<i class="entypo-mail"></i>
									Inbox
								</a>
							</li>
		
							<li>
								<a href="extra-calendar.html">
									<i class="entypo-calendar"></i>
									Calendar
								</a>
							</li>
		
							<li>
								<a href="#">
									<i class="entypo-clipboard"></i>
									Tasks
								</a>
							</li>
						</ul>
					</li>--%>
		
				</ul>
				
				<ul class="user-info pull-left pull-right-xs pull-none-xsm">
		
					<!-- Raw Notifications -->
                   
					</li>
		
				</ul>
		
			</div>
		
		
			<!-- Raw Links -->
			<div class="col-md-6 col-sm-4 clearfix hidden-xs" >
		
				<ul class="list-inline links-list pull-right">
		                    <asp:DropDownList ID="ddClinic" runat="server" class="form-control" disabled ="disabled"></asp:DropDownList><br /><br />
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtPatientSearch"></asp:TextBox>
                            <asp:Button runat="server" ID="btnSearch" Text="Search" CssClass="btn btn-block btn-blue" OnClick="Unnamed1_Click" /><br /><br />
                    
                    
					
						</ul>
		
					</li>
		
					
				</ul>
		
			</div>
                <div class="col-md-10 col-md-offset-1" id="search">
                       <asp:GridView ID="gvPatients" runat="server" CssClass="footable large-only" style="font-size:12px;color:white;" OnSelectedIndexChanged="gvPatients_SelectedIndexChanged"  DataKeyNames="Registration_No" OnRowDataBound="gvPatients_RowDataBound" AutoGenerateColumns="False" EmptyDataText="No Record(s) Found" AutoGenerateSelectButton="True" ForeColor="White">
                            <Columns>
                                <asp:BoundField DataField="Ticket_Date" HeaderText="Ticket Date" HeaderStyle-CssClass="align-center" HeaderStyle-BackColor="#fd8d68"  ControlStyle-BackColor="Violet">
<ControlStyle BackColor="Violet"></ControlStyle>

<HeaderStyle BackColor="#FD8D68" CssClass="align-center"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Ticket_Number" HeaderText="Ticket#" HeaderStyle-CssClass="align-right" HeaderStyle-BackColor="#fd8d68">
<HeaderStyle BackColor="#FD8D68" CssClass="align-right"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField ="Registration_No" HeaderText="MrNo" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68" >
<HeaderStyle BackColor="#FD8D68" CssClass="align-left"></HeaderStyle>

                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="First_Name" HeaderText="First Name" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
<HeaderStyle BackColor="#FD8D68" CssClass="align-left"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Father_Name" HeaderText="Father Name" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
<HeaderStyle BackColor="#FD8D68" CssClass="align-left"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Age" HeaderText="Age" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
<HeaderStyle BackColor="#FD8D68" CssClass="align-left"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Mobile_1" HeaderText="Mobile#1" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
<HeaderStyle BackColor="#FD8D68" CssClass="align-left"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="sys_PatientSno" HeaderText="Patient Sno" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
                                    <ItemStyle CssClass="hideCol" />
                                     <HeaderStyle CssClass="hideCol" />
                                </asp:BoundField>
                            </Columns>
                            </asp:GridView>
                    </div>
		
		</div>
		
		<hr />
		
					<ol class="breadcrumb bc-3" >
								<li>
						<a href="dashboard.aspx"><i class="fa-home"></i>Home</a>
					</li>
							<li>
		
									<a href="forms-main.html">Services</a>
							</li>
						<li class="active">
		
									<strong>Pharmacy</strong>
							</li>
							</ol>
					
		<h2>Pharmacy</h2>
		<br />
        <div class="row">
            <section id="contact">
                        <div class="col-md-12">
                <div class="panel panel-primary disabled" data-collapsed="0">
                    <div class="panel-heading" style="background-color:#2E3192; color:whitesmoke;">
                    <div class="panel-title" style="font-family:Arial;">
                        Services Info 
                    </div>
                        <div class="panel-options">
							<a href="#" data-rel="collapse"><i class="entypo-down-open"></i></a>
							<a href="#" data-rel="reload"><i class="entypo-arrows-ccw"></i></a>
							<!--<a href="#" data-rel="close"><i class="entypo-cancel"></i></a>!-->
						</div>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-12">
                                <asp:GridView ID="gvPatientService" runat="server" CssClass="footable large-only" style="font-size:12px;color:white;"  AutoGenerateColumns="False" EmptyDataText="No Record(s) Found" AutoGenerateSelectButton="True" ForeColor="White" OnSelectedIndexChanged="gvPatientService_SelectedIndexChanged">
                            <Columns>
                                <asp:BoundField DataField ="MR_No" HeaderText="MrNo" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68" >
<HeaderStyle BackColor="#FD8D68" CssClass="align-left"></HeaderStyle>

                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="sysTicketMasterNo" HeaderText="STN" />
                                <asp:BoundField DataField="Patient_Name" HeaderText="Name" HeaderStyle-CssClass="align-center" HeaderStyle-BackColor="#fd8d68"  ControlStyle-BackColor="Violet">
<ControlStyle BackColor="Violet"></ControlStyle>

<HeaderStyle BackColor="#FD8D68" CssClass="align-center"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Ticket_Number" HeaderText="Ticket_Number" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
<HeaderStyle BackColor="#FD8D68" CssClass="align-left"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Ticket_Date" HeaderText="Ticket Date" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
<HeaderStyle BackColor="#FD8D68" CssClass="align-left"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="NoOfServices" HeaderText="No Of Services" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
<HeaderStyle BackColor="#FD8D68" CssClass="align-left"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Total_Amount" HeaderText="Total Amount" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
<HeaderStyle BackColor="#FD8D68" CssClass="align-left"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Left" />
                                </asp:BoundField>
                            </Columns>
                            </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
                </div>
            <div class="col-md-12">
                <div class="panel panel-primary" data-collapsed="0">
                    <div class="panel-heading" style="background-color:#2E3192; color:whitesmoke;">
                    <div class="panel-title" style="font-family:Arial;">
                        Patient Information
                    </div>
                        <div class="panel-options">
							<a href="#" data-rel="collapse"><i class="entypo-down-open"></i></a>
							<a href="#" data-rel="reload"><i class="entypo-arrows-ccw"></i></a>
							<!--<a href="#" data-rel="close"><i class="entypo-cancel"></i></a>!-->
						</div>
                    </div>
                    <div class="panel-body" style="background-color:#E0E0E0  ;">
                        <div class="row">
                            <div class="col-md-12">
                                
                            </div>
                        </div>
                        <div class="row">
                          <!-- <div class ="col-md-4 "> -->
                            <div class="form-inline">
                                <div class="form-group">
                                        <asp:Label runat="server" ID="lblMrNo"  style="font-weight:bold;font-size:12px;color:red;float:left">Patient MR #:</asp:Label>
                                      <div class="col-md-4">
                                           <asp:Label runat ="server" ID="lblPatientMrNo" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:150px;" CssClass="form-control input-sm" ></asp:Label>
                                      </div>  
                                </div>
                          <!-- </div> -->
                          <!-- <div class ="col-md-4  "> -->
                               <div class="form-group">
                                <asp:Label runat="server" ID="Label2" style="font-weight:bold;font-size:12px;color:red;float:left">Token #:</asp:Label>
                                <div class="col-md-4">
                                    <asp:Label runat="server" ID="lblPatientToken" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:150px;margin-left:29px;" CssClass="form-control"></asp:Label>
                                </div>
                                
                               </div>
                          <!--</div>-->
                          
                            <div class="form-group">
                                <asp:Label runat="server" ID="lblRegistrationDate" style="font-weight:bold;font-size:12px;color:red;float:left;">Regd Date:</asp:Label>
                                <div class="col-md-4">
                               <asp:Label runat="server" ID="lblPatientRegistrationDate" BorderColor="#C8C8C8" style="font-size:11px;background-color:#F0F0F0;width:155px;" CssClass="form-control"></asp:Label>
                            </div>
                                </div>
                            </div>
                  
                       <!-- </div>
                        <div class="row"> -->
                        <div class="form-inline">
                                <div class="form-group">
                                <asp:label runat="server" for="field-2"  ID="lblFirstName" style="font-weight:bold;font-size:12px;color:red;float:left;">Name:</asp:label>
                              <div class="col-md-4">
                                <asp:Label runat="server" ID="lblPatientFirstName" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:150px;margin-left:40px;" CssClass="form-control"></asp:Label>
                              </div>
                            </div>
                                <div class="form-group">
                               <asp:Label runat="server" ID="lblFatherName" style="font-weight:bold;font-size:12px;color:red;float:left;">Father Name:</asp:Label>
                              <div class="col-md-4">
                               <asp:Label runat="server" ID="lblPatientFatherName" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:150px;" CssClass="form-control"></asp:Label>
                                </div>
                            </div>
                              <div class="form-group">
                               <asp:Label runat="server" ID="lblAge" style="font-weight:bold;font-size:12px;color:red;float:left">Age:</asp:Label>
                                 <div class="col-md-4">
                                     <asp:Label runat="server" ID="lblPatientAge" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:150px;margin-left:36px;" CssClass="form-control"></asp:Label>
                            </div>
                                  </div>
                    </div>


                    <!-- <div class="row">-->
                            <div class="form-inline">
                                    <div class="form-group">
                                         <asp:Label runat="server" ID="lblGender" style="font-weight:bold;font-size:12px;color:red;float:left;">Gender:</asp:Label>
                                    <div class="col-md-4">
                                          <asp:Label runat="server" ID="lblPatientGender" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:150px;margin-left:30px;" CssClass="form-control"></asp:Label>        
                                    </div>
                                        </div>
                                    <div class="form-group">
                                        <asp:label runat="server" for="field-2" ID="lblReligion" style="font-weight:bold;font-size:12px;color:red;float:left;">Religion:</asp:label>
                                    <div class="col-md-4">
                                        <asp:Label runat="server" ID="lblPatientReligion" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:150px;margin-left:28px;;" CssClass="form-control"></asp:Label>        
                                    </div>
                                  </div>
                                    <div class="form-group">
                                       <asp:label runat="server" for="field-2" ID="lblMaritialStatus" style="font-weight:bold;font-size:12px;color:red;float:left;">Maritial St:</asp:label>
                                    <div class="col-md-4">
                                    <asp:Label runat="server" ID="lblPatientMaritialStatus" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:150px;" CssClass="form-control"></asp:Label>   
                                    </div>
                                </div>
                            </div>
                            </div>
                    </div>
                </div>
                </div>
                <div class="col-md-12">
                <asp:Panel runat="server" ID="ServiceAdded">
                <div class="panel panel-primary" data-collapsed="0" id="ServiceAddedPanel">
                    <div class="panel-heading" style="background-color:#2E3192; color:whitesmoke;">
                    <div class="panel-title" style="font-family:Arial;">
                        Medicine Detail
                    </div>
                        <div class="panel-options">
							<a href="#" data-rel="collapse"><i class="entypo-down-open"></i></a>
							<a href="#" data-rel="reload"><i class="entypo-arrows-ccw"></i></a>
							<!--<a href="#" data-rel="c lose"><i class="entypo-cancel"></i></a>!-->
						</div>
                    </div>
                    
                    <div class="panel-body">
                        <div>
                              
                                <asp:Label runat="server" ID="lblMedical" style="font-weight:bold;font-size:12px;color:red;float:left;margin-top:5px;">Medicine:</asp:Label>
                                
                                <asp:DropDownList ID="ddlMedicine" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;width:160px;margin-left:5px;margin-bottom:4px;float:left;" AutoPostBack="true"  AppendDataBoundItems="true">
                                            <asp:ListItem Text="Select Medicine Unit" Value="0"></asp:ListItem>
								</asp:DropDownList>
                                

                                <asp:Label runat="server" ID="Label5" style="font-weight:bold;font-size:12px;color:red;float:left;margin-top:5px;margin-left:10px;">Unit:</asp:Label>
                              
                                <asp:DropDownList ID="ddUnit" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;margin-left:5px;float:left;width:78px;" AutoPostBack="true" onchange="sumQuantity();">
                                            <asp:ListItem Text="Select Medicine" Value="0"></asp:ListItem>
								</asp:DropDownList>
                                <asp:Label runat="server" CssClass="hideCol" ID="lblSrNo"></asp:Label>

                                    <asp:Label runat="server" ID="Label6" style="font-weight:bold;font-size:12px;color:red;float:left;margin-top:5px;margin-left:10px;">Dosage:</asp:Label>
                                    <%--<asp:TextBox runat="server" ID="txtPatientMedicineDosage" CssClass="form-control" style="font-size:12px;background-color:#F0F0F0;width:120px;margin-left:0;">1+1+1</asp:TextBox>--%>
                                     <asp:DropDownList ID="ddDosage" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;margin-left:5px;float:left;width:78px;" AutoPostBack="true" onchange="sumQuantity();">
                                            <asp:ListItem Text="Select Dosage" Value="0"></asp:ListItem>
								</asp:DropDownList>
                                    <asp:Label runat="server" ID="Label4" style="font-weight:bold;font-size:12px;color:red;float:left;margin-top:5px;margin-left:10px;">Days:</asp:Label>
                                    <%--<asp:TextBox runat="server" ID="txtPatientMedicineDosage" CssClass="form-control" style="font-size:12px;background-color:#F0F0F0;width:120px;margin-left:0;">1+1+1</asp:TextBox>--%>
                                     <asp:DropDownList ID="ddDays" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;margin-left:5px;float:left;width:70px;" AutoPostBack="true" onchange="sumQuantity();">
                                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                            <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                            <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                            <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                            <asp:ListItem Text="9" Value="9"></asp:ListItem>
                                            <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                            <asp:ListItem Text="11" Value="11"></asp:ListItem>
                                            <asp:ListItem Text="12" Value="12"></asp:ListItem>
                                            <asp:ListItem Text="13" Value="13"></asp:ListItem>
                                            <asp:ListItem Text="14" Value="14"></asp:ListItem>
                                            <asp:ListItem Text="15" Value="15"></asp:ListItem>
                                            <asp:ListItem Text="16" Value="16"></asp:ListItem>
                                            <asp:ListItem Text="17" Value="17"></asp:ListItem>
                                            <asp:ListItem Text="18" Value="18"></asp:ListItem>
                                            <asp:ListItem Text="19" Value="19"></asp:ListItem>
                                            <asp:ListItem Text="20" Value="20"></asp:ListItem>
                                            <asp:ListItem Text="21" Value="21"></asp:ListItem>
                                            <asp:ListItem Text="22" Value="22"></asp:ListItem>
                                            <asp:ListItem Text="23" Value="23"></asp:ListItem>
                                            <asp:ListItem Text="24" Value="24"></asp:ListItem>
                                            <asp:ListItem Text="25" Value="25"></asp:ListItem>
                                            <asp:ListItem Text="26" Value="26"></asp:ListItem>
                                            <asp:ListItem Text="27" Value="27"></asp:ListItem>
                                            <asp:ListItem Text="28" Value="28"></asp:ListItem>
                                            <asp:ListItem Text="29" Value="29"></asp:ListItem>
                                            <asp:ListItem Text="30" Value="30"></asp:ListItem>
                                            <asp:ListItem Text="31" Value="31"></asp:ListItem>
								</asp:DropDownList>
                                    <asp:Label runat="server" ID="Label3" style="font-weight:bold;font-size:12px;color:red;float:left;margin-top:5px;margin-left:10px;">Quantity:</asp:Label>
                                    <asp:TextBox runat="server" ID="txtQuantity" CssClass="form-control" style="font-size:12px;background-color:#F0F0F0;width:80px;margin-left:5px;float:left;" >1</asp:TextBox>
                                    <asp:Button runat="server" ID="btnAdd"  style="width:50px;margin-left:800px;" Text="Add " OnClick="btnAdd_Click" CssClass="btn btn-block" />
                               
                            
                            

                            </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:GridView ID="gvServiceDetail" runat="server" CssClass="table" style="font-size:12px;font-weight:900" AutoGenerateColumns="False" EmptyDataText="No Service Added" ForeColor="White" OnRowDeleting="gvServiceDetail_RowDeleting" OnRowDataBound="gvServiceDetail_RowDataBound" ShowFooter="True">
                                  <Columns>
                                     <asp:BoundField DataField ="sysIssueDetailNo" HeaderText="SNo"  HeaderStyle-BackColor="#599adb" >
                                    <ItemStyle CssClass="hideCol" />
                                     <HeaderStyle CssClass="hideCol" />
                                     <FooterStyle CssClass="hideCol" />
                                </asp:BoundField>
                                      <asp:BoundField DataField ="Unit_Code" HeaderText="UnitCode"  HeaderStyle-BackColor="#599adb" >
                                    <ItemStyle CssClass="hideCol" />
                                     <HeaderStyle CssClass="hideCol" />
                                     <FooterStyle CssClass="hideCol" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Item_Name" HeaderText="Medicine" HeaderStyle-BackColor="#599adb" HeaderStyle-CssClass="text-center">
                                    <HeaderStyle BackColor="#599adb" CssClass="align-left"></HeaderStyle>
                                    <ItemStyle HorizontalAlign ="left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Description" HeaderText="Description" HeaderStyle-BackColor="#599adb" HeaderStyle-CssClass="text-right">
                                    <HeaderStyle BackColor="#599adb" CssClass="text-right"></HeaderStyle>
                                    <ItemStyle HorizontalAlign ="right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Days" HeaderText="Days" HeaderStyle-BackColor="#599adb" HeaderStyle-CssClass="text-right">
                                    <HeaderStyle BackColor="#599adb" CssClass="text-right"></HeaderStyle>
                                    <ItemStyle HorizontalAlign ="right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Quantity_Required" HeaderText="Quantity" HeaderStyle-BackColor="#599adb" HeaderStyle-CssClass="text-right">
                                    <HeaderStyle BackColor="#599adb" CssClass="text-right"></HeaderStyle>
                                    <ItemStyle HorizontalAlign ="right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Unit_Name" HeaderText="Unit"  HeaderStyle-BackColor="#599adb" HeaderStyle-CssClass="text-left">
                                    <HeaderStyle BackColor="#599adb"></HeaderStyle>
                                    <ItemStyle HorizontalAlign ="left" />    
                                </asp:BoundField>
                                       <asp:CommandField ButtonType="Image" HeaderText="Remove" DeleteImageUrl="~/Images/DeleteHS.png" DeleteText="Remove"
                                              ShowDeleteButton="True" HeaderStyle-BackColor="#599adb" >
                                       <HeaderStyle BackColor="#599adb"></HeaderStyle>
                                </asp:CommandField>
                                <asp:BoundField DataField ="sysItemCodeSno" HeaderText="SysItemCodeSno"  HeaderStyle-BackColor="#599adb" >
                                    <ItemStyle CssClass="hideCol" />
                                     <HeaderStyle CssClass="hideCol" />
                                     <FooterStyle CssClass="hideCol" />
                                </asp:BoundField>
                                <asp:BoundField DataField ="Dosage_Code" HeaderText="DosageCode"  HeaderStyle-BackColor="#599adb" >
                                    <ItemStyle CssClass="hideCol" />
                                     <HeaderStyle CssClass="hideCol" />
                                     <FooterStyle CssClass="hideCol" />
                                </asp:BoundField>
                                </Columns>
                                    <FooterStyle BackColor="#CCCCCC" HorizontalAlign="Right"/>
                                    <HeaderStyle Font-Bold="True" />
                                </asp:GridView> 
                            </div>
                        </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                              <div id="dialog-confirm">
                                <div id ="content">
                                    
                                </div>
                                  </div>
                                
                                <span align="center" style="text-align:center;color:red;align-content:center;font-size:18px;padding-left:20%;margin-left:20%;"><asp:Literal ID="Literal1" runat="server"></asp:Literal></span>  
                            </div>
                            </div> 
                    <asp:Label ID="lblHide" runat="server" CssClass="hideCol"></asp:Label>
                    <br />
                           <%-- <asp:CheckBox ID="chkPrint" runat="server" Text="Do You Want Slip" style="color:black;font-size:12px;"/><br />--%>
                            <div class="row">
                            <div class="col-md-4">
                                <asp:Button runat="server" ID="btn_Submit" OnClick="btn_Submit_Click" CssClass="btn btn-blue" style="width:100%;" Text="Generate Token" ValidationGroup="Generate Token" />
                            </div>
                            <div class="col-md-4 col-md-offset-4">
                                <asp:Button runat="server" ID="btn_Cancel" CssClass="btn btn-blue" style="width:100%;" Text="Cancel" ValidationGroup="PatientRegistration" OnClick="btn_Cancel_Click" />
                            </div>
                        </div>
                        
                    </div>
                </div>
                    </asp:Panel>
            </div>
            <asp:Label ID="lblDeptCode" runat="server" Text=""></asp:Label>
            <asp:Label ID="lblLocationCode" runat="server" Text=""></asp:Label>
            <asp:Label ID="lblsysTicketMasterNo" runat="server" Text=""></asp:Label>
            <asp:Label runat="server" CssClass="hideCol" ID="lblTicketNo"></asp:Label> 
        </div>
        </div>
   
    </form>
     <script src="../assets/js/gsap/main-gsap.js"></script>
	<script src="../assets/js/jquery-ui/js/jquery-ui-1.10.3.minimal.min.js"></script>
	<script src="../assets/js/bootstrap.js"></script>
	<script src="../assets/js/joinable.js"></script>
	<script src="../assets/js/resizeable.js"></script>
	<script src="../assets/js/neon-api.js"></script>


	<!-- Imported scripts on this page -->
	<script src="../assets/js/bootstrap-switch.min.js"></script>
	<script src="../assets/js/neon-chat.js"></script>


	<!-- JavaScripts initializations and stuff -->
	<script src="../assets/js/neon-custom.js"></script>


	<!-- Demo Settings -->
	<script src="../assets/js/neon-demo.js"></script>
</body>
</html>