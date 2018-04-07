<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="nursing.aspx.cs" Inherits="ZMTClinics.nursing" enableEventValidation="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Nursing Triage::Patient Info</title>
    <link rel="stylesheet" href="../assets/js/jquery-ui/css/no-theme/jquery-ui-1.10.3.custom.min.css"/>
	<link rel="stylesheet" href="../assets/css/font-icons/entypo/css/entypo.css"/>
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Noto+Sans:400,700,400italic"/>
	<link rel="stylesheet" href="../assets/css/bootstrap.css"/>
	<link rel="stylesheet" href="../assets/css/neon-core.css"/>
	<link rel="stylesheet" href="../assets/css/neon-theme.css"/>
	<link rel="stylesheet" href="../assets/css/neon-forms.css"/>
	<link rel="stylesheet" href="../assets/css/custom.css"/>
    <link rel="stylesheet" href="../assets/form.css" />
     <link rel="stylesheet" href="../Content/forms.css" />
    <link href="style/calendar-win2k-1.css" rel="stylesheet" />
   <script src="../assets/js/jquery-1.11.0.min.js"></script>
    <script src="dist/jquery.inputmask.bundle.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
    <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js" type="text/javascript"></script>
    <script src="../assets/calendar-en.min.js"></script>
    <link href="../assets/calendar-blue.css" rel="stylesheet" />
    <link href="../gridcss/grid.css" rel="stylesheet" />
    <link href="../gridcss/table.css" rel="stylesheet" />
    <link href="../gridcss/footable.css" rel="stylesheet" />
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
    </style>
    <link href="style/interface.css" rel="stylesheet" type="text/css" />
    <link href="style/calendar-win2k-1.css" type="text/css" rel="stylesheet" />
    <script src="Javascript/calendar.js" type="text/javascript"></script>
    <script src="Javascript/calendar-en.js" type="text/javascript"></script>
    <script src="Javascript/calendar-setup.js" type="text/javascript"></script>
    <script src="Javascript/calendar-stripped.js" type="text/javascript"></script>
    <script src="Javascript/calendar-setup_stripped.js" type="text/javascript"></script>
    <script type = "text/javascript">
        function Confirm() {
            if (confirm("Do you want to print slip?")) {
                window.location.href = 'NursingTriageReciept.aspx';
            } else {
                //alert('No');
                window.location.href = 'nursing.aspx';
                return false;
            }
        }
    </script>
     <script type="text/javascript">
         //Disable the default MouseOver functionality of ASP.Net Menu control.
         Sys.WebForms.Menu._elementObjectMapper.getMappedObject = function () {
             return false;
         };
         $(function () {
             //Remove the style attributes.
             $(".navbar-nav li, .navbar-nav a, .navbar-nav ul").removeAttr('style');

             //Apply the Bootstrap class to the Submenu.
             $(".dropdown-menu").closest("li").removeClass().addClass("dropdown-toggle");

             //Apply the Bootstrap properties to the Submenu.
             $(".dropdown-toggle").find("a").eq(0).attr("data-toggle", "dropdown").attr("aria-haspopup", "true").attr("aria-expanded", "false").append("<span class='caret'></span>");

             //Apply the Bootstrap "active" class to the selected Menu item.
             $("a.selected").closest("li").addClass("active");
             $("a.selected").closest(".dropdown-toggle").addClass("active");
         });
</script>
</head>
<body class="page-body">
    <form id="form1" runat="server">
         <div class="navbar navbar-default">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                                        aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span><span
                                        class="icon-bar"></span><span class="icon-bar"></span>
                        </button>
                    <a class="navbar-brand" href="#">ZMT Clinics</a>
                    </div>
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <asp:Menu ID="Menu1" runat="server" Orientation="Horizontal" RenderingMode="List"
                                IncludeStyleBlock="false" StaticMenuStyle-CssClass="nav navbar-nav" DynamicMenuStyle-CssClass="dropdown-menu" style="background-color:aqua">
                        </asp:Menu>
                   </div>
              </div>
        </div>
    <div class="page-container">
<%--       <div class="sidebar-menu">
        <div class ="sidebar-menu-inner">
        <header class="logo-env">
				<!-- logo -->
				<div class="logo">
					<a href="grid.aspx">
						<img src="../Images/logo.png" class="img-circle" Width="150" />
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
    </div>--%>
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
                  </li>
				</ul>
		
			</div>
			<!-- Raw Links -->
			<div class="col-md-6 col-sm-4 clearfix hidden-xs" >
		
				<ul class="list-inline links-list pull-right">
                            <strong>ZMT Clinic</strong>
		                    <asp:DropDownList ID="ddClinic" runat="server" class="form-control" disabled="disabled" AutoPostBack="true"></asp:DropDownList><br /><br />
                            <asp:TextBox runat="server" CssClass="form-control" ID="txtPatientSearch"></asp:TextBox>
                            <asp:Button runat="server" ID="btnSearch" Text="Search" CssClass="btn btn-blue btn-block" OnClick="Unnamed1_Click" /><br /><br />
			   </ul>
			</div>
            <div class="col-md-10 col-md-offset-1" id="search">
                        <asp:GridView ID="gvPatients" runat="server" CssClass="footable large-only" style="font-size:12px;color:white;" OnSelectedIndexChanged="gvPatients_SelectedIndexChanged"  DataKeyNames="MR_No" OnRowDataBound="gvPatients_RowDataBound" AutoGenerateColumns="False" EmptyDataText="No Record(s) Found" AutoGenerateSelectButton="True" ForeColor="White">
                            <Columns>
                                <asp:BoundField DataField ="sysNursingTriageSNo" HeaderText="Nrs#" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68" >
                                <HeaderStyle BackColor="#FD8D68" CssClass="align-left"></HeaderStyle>

                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:BoundField DataField ="MR_No" HeaderText="MrNo" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68" >
                                <HeaderStyle BackColor="#FD8D68" CssClass="align-left"></HeaderStyle>

                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Ticket_Date" HeaderText="Ticket Date" HeaderStyle-CssClass="align-center" HeaderStyle-BackColor="#fd8d68"  ControlStyle-BackColor="Violet">
                                <ControlStyle BackColor="Violet"></ControlStyle>

                                <HeaderStyle BackColor="#FD8D68" CssClass="align-center"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Patient_Name" HeaderText="Name" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
                                <HeaderStyle BackColor="#FD8D68" CssClass="align-left"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Left" />
                                </asp:BoundField> 
                                <asp:BoundField DataField="Ticket_Number" HeaderText="Ticket Number" HeaderStyle-CssClass="align-right" HeaderStyle-BackColor="#fd8d68">
                                <HeaderStyle BackColor="#FD8D68" CssClass="align-right"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Patient_Bp" HeaderText="Patient BP" HeaderStyle-CssClass="align-right" HeaderStyle-BackColor="#fd8d68">
                                <HeaderStyle BackColor="#FD8D68" CssClass="align-right"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Patient_Pulse" HeaderText="Patient Pulse" HeaderStyle-CssClass="align-right" HeaderStyle-BackColor="#fd8d68">
                                <HeaderStyle BackColor="#FD8D68" CssClass="align-right"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Patient_Temperature" HeaderText="Patient Temperature" HeaderStyle-CssClass="align-right" HeaderStyle-BackColor="#fd8d68">
                                <HeaderStyle BackColor="#FD8D68" CssClass="align-right"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Patient_Weight" HeaderText="Patient Weight" HeaderStyle-CssClass="align-right" HeaderStyle-BackColor="#fd8d68">
                                <HeaderStyle BackColor="#FD8D68" CssClass="align-right"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Patient_Height_ft" HeaderText="Patient Height Ft" HeaderStyle-CssClass="align-right" HeaderStyle-BackColor="#fd8d68">
                                <HeaderStyle BackColor="#FD8D68" CssClass="align-right"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Patient_Height_inc" HeaderText="Patient Height Inc" HeaderStyle-CssClass="align-right" HeaderStyle-BackColor="#fd8d68">
                                <HeaderStyle BackColor="#FD8D68" CssClass="align-right"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Blood_Group" HeaderText="Blood Group" HeaderStyle-CssClass="align-right" HeaderStyle-BackColor="#fd8d68">
                                <HeaderStyle BackColor="#FD8D68" CssClass="align-right"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Disease" HeaderText="Disease" HeaderStyle-CssClass="align-right" HeaderStyle-BackColor="#fd8d68">
                                <HeaderStyle BackColor="#FD8D68" CssClass="align-right"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Family_Disease" HeaderText="Family Disease" HeaderStyle-CssClass="align-right" HeaderStyle-BackColor="#fd8d68">
                                <HeaderStyle BackColor="#FD8D68" CssClass="align-right"></HeaderStyle>

                                    <ItemStyle HorizontalAlign ="Right" />
                                </asp:BoundField>
                            </Columns>
                            </asp:GridView>
                            <asp:Label ID="lblTicketmasterNo" runat="server" CssClass="hideCol"></asp:Label>
                         </div>
		            </div>
		<hr />	
		<h2>Nursing Triage</h2>
		<br />
        <div class="row">
            <section id="contact">
            <div class="col-md-12">
                <div class="panel panel-primary" data-collapsed="0">
                    <div class="panel-heading" style="background-color:#2E3192; color:whitesmoke;">
                    <div class="panel-title" style="font-family:Arial;">
                       Nursing Triage Registration
                    </div>
                        <div class="panel-options">
							<a href="#" data-rel="collapse"><i class="entypo-down-open"></i></a>
							<a href="#" data-rel="reload"><i class="entypo-arrows-ccw"></i></a>
						</div>
                    </div>
                    <div class="panel-body" style="background-color:#E0E0E0  ;">
                            <div class="row">
                                <div class="col-md-12">
                                         <asp:GridView ID="gvNursingTriage" runat="server" CssClass="footable large-only" style="font-size:12px;color:white;"  DataKeyNames="MR_No" OnRowDataBound="gvPatients_RowDataBound" AutoGenerateColumns="False" EmptyDataText="No Record(s) Found" AutoGenerateSelectButton="True" ForeColor="White" OnSelectedIndexChanged="gvNursingTriage_SelectedIndexChanged">
                                        <Columns>
                                            <asp:BoundField DataField ="sysTicketMasterNo" HeaderText="Tkt#" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68" >
                                        <HeaderStyle BackColor="#FD8D68" CssClass="align-left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>

                                        <asp:BoundField DataField ="MR_No" HeaderText="MrNo" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68" >
                                        <HeaderStyle BackColor="#FD8D68" CssClass="align-left"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Patient_Name" HeaderText="Patient Name" HeaderStyle-CssClass="align-center" HeaderStyle-BackColor="#fd8d68"  ControlStyle-BackColor="Violet"><ControlStyle BackColor="Violet"></ControlStyle>

                                        <HeaderStyle BackColor="#FD8D68" CssClass="align-center"></HeaderStyle>
                                            <ItemStyle HorizontalAlign ="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Ticket_Number" HeaderText="Token Number" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
                                            <HeaderStyle BackColor="#FD8D68" CssClass="align-left"></HeaderStyle>
                                            <ItemStyle HorizontalAlign ="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Ticket_Date" HeaderText="Token Date" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
                                            <HeaderStyle BackColor="#FD8D68" CssClass="align-left"></HeaderStyle>
                                            <ItemStyle HorizontalAlign ="Left" />
                                        </asp:BoundField>
                                        </Columns>
                                        </asp:GridView>
                                </div>
                        </div>
                        <div class="row">
                          <!-- <div class ="col-md-4 "> -->
                            <div class="form-inline">
                                <div class="form-group">
                                        <asp:Label runat="server" ID="lblMrNo"  style="font-weight:bold;font-size:12px;color:red;float:left">Patient MR #:</asp:Label>
                                      <div class="col-md-4">
                                           <asp:Label runat ="server" ID="lblPatientMrNo" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:200px;" CssClass="form-control input-sm" ></asp:Label>
                                      </div>  
                                </div>
                          <!-- </div> -->
                          <!-- <div class ="col-md-4  "> -->
                               <div class="form-group">
                                <asp:Label runat="server" ID="Label2" style="font-weight:bold;font-size:12px;color:red;float:left">Token #:</asp:Label>
                                <div class="col-md-4">
                                    <asp:Label runat="server" ID="lblPatientToken" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:200px;margin-left:29px;" CssClass="form-control"></asp:Label>
                                </div>
                                
                               </div>
                          <!--</div>-->
                          
                            <div class="form-group">
                                <asp:Label runat="server" ID="lblRegistrationDate" style="font-weight:bold;font-size:12px;color:red;float:left;">Regd Date:</asp:Label>
                                <div class="col-md-4">
                               <asp:Label runat="server" ID="lblPatientRegistrationDate" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:200px;" CssClass="form-control"></asp:Label>
                            </div>
                                </div>
                            </div>
                  
                       <!-- </div>
                        <div class="row"> -->
                        <div class="form-inline">
                                <div class="form-group">
                                <asp:label runat="server" for="field-2"  ID="lblFirstName" style="font-weight:bold;font-size:12px;color:red;float:left;">Name:</asp:label>
                              <div class="col-md-4">
                                <asp:Label runat="server" ID="lblPatientFirstName" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:200px;margin-left:40px;" CssClass="form-control"></asp:Label>
                              </div>
                            </div>
                                <div class="form-group">
                               <asp:Label runat="server" ID="lblFatherName" style="font-weight:bold;font-size:12px;color:red;float:left;">Father Name:</asp:Label>
                              <div class="col-md-4">
                               <asp:Label runat="server" ID="lblPatientFatherName" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:200px;" CssClass="form-control"></asp:Label>
                                </div>
                            </div>
                              <div class="form-group">
                               <asp:Label runat="server" ID="lblAge" style="font-weight:bold;font-size:12px;color:red;float:left">Age:</asp:Label>
                                 <div class="col-md-4">
                                     <asp:Label runat="server" ID="lblPatientAge" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:200px;margin-left:36px;" CssClass="form-control"></asp:Label>
                            </div>
                                  </div>
                    </div>


                    <!-- <div class="row">-->
                            <div class="form-inline">
                                    <div class="form-group">
                                         <asp:Label runat="server" ID="lblGender" style="font-weight:bold;font-size:12px;color:red;float:left;">Gender:</asp:Label>
                                    <div class="col-md-4">
                                          <asp:Label runat="server" ID="lblPatientGender" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:200px;margin-left:30px;" CssClass="form-control"></asp:Label>        
                                    </div>
                                        </div>
                                    <div class="form-group">
                                        <asp:label runat="server" for="field-2" ID="lblReligion" style="font-weight:bold;font-size:12px;color:red;float:left;">Religion:</asp:label>
                                    <div class="col-md-4">
                                        <asp:Label runat="server" ID="lblPatientReligion" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:200px;margin-left:28px;;" CssClass="form-control"></asp:Label>        
                                    </div>
                                  </div>
                                    <div class="form-group">
                                       <asp:label runat="server" for="field-2" ID="lblMaritialStatus" style="font-weight:bold;font-size:12px;color:red;float:left;">Maritial St:</asp:label>
                                    <div class="col-md-4">
                                    <asp:Label runat="server" ID="lblPatientMaritialStatus" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:200px;" CssClass="form-control"></asp:Label>   
                                    </div>
                                </div>
                            </div>
                            </div>
                </div>
                <div class="panel panel-primary" data-collapsed="0">
                    <div class="panel-heading" style="background-color:#2E3192; color:whitesmoke;">
                    <div class="panel-title" style="font-family:Arial;">
                        Nursing Triage
                    </div>
                        <div class="panel-options">
							<a href="#" data-rel="collapse"><i class="entypo-down-open"></i></a>
							<a href="#" data-rel="reload"><i class="entypo-arrows-ccw"></i></a>
							<!--<a href="#" data-rel="close"><i class="entypo-cancel"></i></a>!-->
						</div>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                          <div class="form-inline">
                             <div class="form-group">
                                 <asp:Label runat="server" ID="lblPatientBp" style="font-weight:bold;font-size:12px;color:blue;float:left">B.P:</asp:Label>
                                 <div class="col-md-4">
                                <asp:TextBox runat="server" ID="txtPatientBp" type="text" placeholder="Enter Patient Blood Pressure"  CssClass="form-control" style="font-size:14px;background-color:#F0F0F0;width:200px;margin-left:44px;"></asp:TextBox>
                             </div> 
                            </div>
                              <div class="form-group">
                                  <asp:Label runat="server" ID="lblPatientPulse" style="font-weight:bold;font-size:12px;color:blue;float:left;">Pulse:</asp:Label>
                                <div class="col-md-4">
                                <asp:TextBox runat="server" ID="txtPatientPulse" type="text" placeholder="Enter Patient Pulse" CssClass="form-control" style="font-size:12px;background-color:#F0F0F0;width:200px;margin-left:26px;"></asp:TextBox>
                              </div>
                            </div>
                              <div class="form-group">
                                   <asp:Label runat="server" ID="lblPatientTemperature" style="font-weight:bold;font-size:12px;color:blue;float:left">Temperature:</asp:Label>
                                 <div class="col-md-4">
                                   <asp:TextBox runat="server" ID="txtPatientTemperature" type="text" placeholder="Enter Patient Temperature" CssClass="form-control" style="font-size:12px;background-color:#F0F0F0;width:200px;margin-left:12px;"></asp:TextBox>
                              </div> 
                            </div>
                          </div>
                        <div class="form-inline">
                              <div class="form-group">
                                <asp:Label runat="server" ID="lblPatientWeight" style="font-weight:bold;font-size:12px;color:blue;float:left">Weight:</asp:Label>
                               <div class="col-md-4">
                                <asp:TextBox runat="server" ID="txtPatientWeight" type="text" placeholder="Enter Patient Weight" CssClass="form-control" style="font-size:14px;background-color:#F0F0F0;width:200px;margin-left:25px;"></asp:TextBox>
                              </div>
                            </div>
                              <div class="form-group">
                                  <asp:Label runat="server" ID="lblPatientHeightfeet" style="font-weight:bold;font-size:12px;color:blue;float:left;">Height(ft):</asp:Label>
                               <div class="col-md-4">
                                <asp:TextBox runat="server" ID="txtPatientHeightfeet" type="text" placeholder="Enter Patient Height in Feet" CssClass="form-control" style="font-size:12px;background-color:#F0F0F0;width:200px;margin-left:5px;"></asp:TextBox>
                              </div>
                            </div>
                              <div class="form-group">
                                  <asp:Label runat="server" ID="lblPatientHeightinch" style="font-weight:bold;font-size:12px;color:blue;float:left">Height(inc):</asp:Label>
                                <div class="col-md-4">
                                <asp:TextBox runat="server" ID="txtPatientHeightinch" type="text" placeholder="Enter Patient Height in inches" CssClass="form-control" style="font-size:12px;background-color:#F0F0F0;width:200px;margin-left:20px;"></asp:TextBox>
                              </div>
                            </div>
                        </div>
                     <div class="form-inline">
                         
                            <div class="form-group">
                                <asp:Label runat="server" ID="lblBloodGroup" style="font-weight:bold;font-size:12px;color:blue;float:left">Blood Gp:</asp:Label>
                                <div class ="col-md-4">
                                <asp:TextBox runat="server" ID="txtBloodGroup" type="text" placeholder="Enter Patient Blood Group" CssClass="form-control" style="font-size:12px;background-color:#F0F0F0;width:200px;margin-left:12px;"></asp:TextBox> 
                            </div>
                        </div>
                            <div class="form-group">
                                <asp:Label runat="server" ID="lblDesease" style="font-weight:bold;font-size:12px;color:blue;float:left">Disease:</asp:Label>
                            <div class="col-md-4">
                                <asp:TextBox runat="server" ID="txtDesease" type="text" placeholder="Registration Date" CssClass="form-control" style="font-size:12px;background-color:#F0F0F0;width:200px;margin-left:12px;" ></asp:TextBox>
                            </div>
                        </div>
                                <div class="form-group">
                                    <asp:Label runat="server" ID="LlblFamilyDesease" style="font-weight:bold;font-size:12px;color:blue;float:left">Family Dsc:</asp:Label>
                                     <div class="col-md-4">
                                    <asp:TextBox runat="server" ID="txtFamilyDesease" type="text" placeholder="Family Desease" CssClass="form-control"  style="font-size:12px;background-color:#F0F0F0;width:200px;margin-left:20px;"></asp:TextBox>
                                     
                                    <asp:Label runat="server" CssClass="hideCol" ID="lblSrNo"></asp:Label>
                                </div>
                            </div>
                        </div>
                        <div class="form-inline">
                            
                                <div class="form-group">
                                    <asp:Label runat="server" ID="lblRespirateryRate" style="font-weight:bold;font-size:12px;color:blue;float:left">Resp Rate:</asp:Label>
                                <div class="col-md-4">
                                    <asp:TextBox runat="server" ID="txtRespirateryRate" type="text" placeholder="Respiratery Rate" CssClass="form-control"  style="font-size:12px;background-color:#F0F0F0;width:200px;margin-left:8px;"></asp:TextBox>
                                     
                                    <asp:Label runat="server" CssClass="hideCol" ID="Label3"></asp:Label>
                                </div>
                            </div>
                        </div>
                        <br />
                      <!-- </div>
                           <div class="row">-->
                            <div class="col-md-4">
                                <asp:Button runat="server" ID="btn_Submit" OnClick="btn_Submit_Click" CssClass="btn btn-blue" style="width:100%;"  ValidationGroup="Medicalhistory" />
                                <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                            </div>
                            <div class="col-md-4 col-md-offset-4"">
                                <asp:Button runat="server" ID="btn_Cancel" CssClass="btn btn-blue" style="width:100%;" Text="Cancel" ValidationGroup="PatientRegistration" OnClick="btn_Cancel_Click" />
                            </div>
                            </div>
                           <br />
                        </div>
                    </div>
                </div>
            </div>
            </section>
        </div>
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
