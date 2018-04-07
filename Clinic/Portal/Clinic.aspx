<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Clinic.aspx.cs" Inherits="ZMTClinics.Clinic" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ZMT Clinics::Clinics Registration</title>
    <link rel="stylesheet" href="../assets/js/jquery-ui/css/no-theme/jquery-ui-1.10.3.custom.min.css"/>
	<link rel="stylesheet" href="../assets/css/font-icons/entypo/css/entypo.css"/>
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Noto+Sans:400,700,400italic"/>
	<link rel="stylesheet" href="../assets/css/bootstrap.css"/>
	<link rel="stylesheet" href="../assets/css/neon-core.css"/>
	<link rel="stylesheet" href="../assets/css/neon-theme.css"/>
	<link rel="stylesheet" href="../assets/css/neon-forms.css"/>
	<link rel="stylesheet" href="../assets/css/custom.css"/>
    <link rel="stylesheet" href="../assets/form.css" />
   <script src="../assets/js/jquery-1.11.0.min.js"></script>
    <script src="../assets/js/jquery-1.11.0.min.js"></script>
   <%-- <script src="assets/jquery-1.4.1.min.js"></script>--%>
    <script src="../assets/jquery.dynDateTime.min.js"></script>
    <script src="../assets/calendar-en.min.js"></script>
    <link href="../assets/calendar-blue.css" rel="stylesheet" />
        <link href="../grid.css" rel="stylesheet" />
    <link href="../table.css" rel="stylesheet" />
    <link href="../footable.css" rel="stylesheet" />
     <link href="DatePicker/bootstrap-datepicker.css" rel="stylesheet" />
    <script src="DatePicker/bootstrap-datepicker.js"></script>
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
    </style>
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
     
<%--    <div class="sidebar-menu">
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
    </div>--%>
        <div class="main-content">
            <div class="row">
		
			<!-- Profile Info and Notifications -->
		<!--	<div class="col-md-6 col-sm-8 clearfix">
		
				<ul class="user-info pull-left pull-none-xsm">
		
					<!-- Profile Info 
					<li class="profile-info dropdown"><!-- add class "pull-right" if you want to place this from right 
		
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							<%--<img src="assets/images/thumb-1@2x.png" alt="" class="img-circle" width="44" />
                            <asp:Image ID="ImgUser" runat="server"  Width="50" CssClass="img-circle"  />
							<asp:Label runat="server" ID="lblUserName"></asp:Label>
						</a>
		
						<ul class="dropdown-menu">
		
							<!-- Reverse Caret 
							<li class="caret"></li>
		
							<!-- Profile sub-links 
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
					</li>
		
				</ul>
				
				<ul class="user-info pull-left pull-right-xs pull-none-xsm">
		

					</li>
		
				</ul>
		
			</div>--%>
		
		
			<!-- Raw Links -->
			<div class="col-md-6 col-sm-4 clearfix hidden-xs">
		
				<ul class="list-inline links-list pull-left">
                       <Table>
                           <tr>
                               <td>
                                   <<asp:TextBox runat="server" CssClass="form-control" ID="txtPatientSearch"></asp:TextBox>
                               </td>
                               <td style="margin-top:4%;">
                                   <asp:Button runat="server" ID="btnSearch" Text="Search" CssClass="btn btn-block" OnClick="Search_Click" />
                               </td>
                           </tr>
                       </Table>
                            
                               
			    </ul>
			</div>
            <div class="col-md-6 col-sm-4 clearfix hidden-xs">
		
				<ul class="list-inline links-list pull-right">
		                  
				         <asp:DropDownList ID="ddClinic" runat="server" class="form-control"></asp:DropDownList><br /><br />
			    </ul>
			</div>
		  <div class="col-md-10 col-md-offset-1" id="search">
                <asp:GridView ID="gvClinics" runat="server" CssClass="footable large-only" style="font-size:12px;color:white;" OnSelectedIndexChanged="gvClinics_SelectedIndexChanged"  DataKeyNames="Clinic_Registration_No" OnRowDataBound="gvClinics_RowDataBound" AutoGenerateColumns="false" EmptyDataText="No Record(s) Found" AutoGenerateSelectButton="True" ForeColor="White">
                            <Columns>
                                <asp:BoundField DataField ="Clinic_Registration_No" HeaderText="Clinic No" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68" >
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Clinic_Name" HeaderText="Clinic Name" HeaderStyle-CssClass="align-center" HeaderStyle-BackColor="#fd8d68"  ControlStyle-BackColor="Violet">
                                    <ItemStyle HorizontalAlign ="Left" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="Clinic_Incharge" HeaderText="Clinic Incharge" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
                                    <ItemStyle HorizontalAlign ="Left" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="Clinic_ContactNumber" HeaderText="Clinic Contact Number" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
                                    <ItemStyle HorizontalAlign ="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Clinic_InchargeContactNUmber" HeaderText="Incharge Contact Number" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
                                     <ItemStyle HorizontalAlign ="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Clinic_City" HeaderText="Clinic City" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
                                    <ItemStyle CssClass="hideCol" />
                                     <HeaderStyle CssClass="hideCol" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Clinic_Province" HeaderText="Clinic Province" HeaderStyle-CssClass="align-right" HeaderStyle-BackColor="#fd8d68">
                                    <ItemStyle CssClass="hideCol" />
                                     <HeaderStyle CssClass="hideCol" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Clinic_Country" HeaderText="Clinic Country" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
                                    <ItemStyle CssClass="hideCol" />
                                     <HeaderStyle CssClass="hideCol" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Clinic_Address" HeaderText="Clinic Address" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
                                    <ItemStyle CssClass="hideCol" />
                                     <HeaderStyle CssClass="hideCol" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="Clinic_Area" HeaderText="Clinic Area" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
                                    <ItemStyle HorizontalAlign ="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="UserCode" HeaderText="User Code" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
                                    <ItemStyle CssClass="hideCol" />
                                     <HeaderStyle CssClass="hideCol" />
                                </asp:BoundField>
                                <asp:BoundField DataField="sysClinicSno" HeaderText="Clinic Sno" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
                                    <ItemStyle CssClass="hideCol" />
                                     <HeaderStyle CssClass="hideCol" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Created_Date" HeaderText="Date" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
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
						<a href="grid.aspx"><i class="fa-home"></i>Home</a>
					</li>
							<li>
		
									<a href="Clinic.aspx">Clinics</a>
							</li>
						<li class="active">
		
									<strong>Clinic Registration</strong>
							</li>
							</ol>
					
		<h2>Clinic Registration</h2>
		<br />
        <div class="row">
            <section id="contact">
            <div class="col-md-12">
                <div class="panel panel-primary" data-collapsed="0">
                    <div class="panel-heading" style="background-color:#2E3192; color:whitesmoke;">
                    <div class="panel-title" style="font-family:Arial;">
                        Registration
                    </div>
                        <div class="panel-options">
							<a href="#" data-rel="collapse"><i class="entypo-down-open"></i></a>
							<a href="#" data-rel="reload"><i class="entypo-arrows-ccw"></i></a>
							<!--<a href="#" data-rel="close"><i class="entypo-cancel"></i></a>!-->
						</div>
                    </div>
                    <div class="panel-body">
                        <div class ="col-md-6  ">
                            <div class="form-group">
                                <asp:Label runat="server" ID="lblMrNo" style="font-weight:bold;font-size:12px;color:red;">Clinic Number:</asp:Label>
                                <asp:TextBox runat="server" ID="txtClinicID" type="text" placeholder="Clinic Number" style="font-size:12px;" CssClass="form-control" ></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <asp:Label runat="server" ID="lblCLinicName" style="font-weight:bold;font-size:12px;color:red;">Registration Name:</asp:Label>
                                <asp:TextBox runat="server" ID="txtClinicName" type="text" placeholder="Clinic Name" CssClass="form-control" style="font-size:12px;" ></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidatorClinicName" runat="server" ErrorMessage="Enter Clinic Name" ControlToValidate="txtClinicName" ValidationGroup="ClinicRegistration" Font-Bold="True" Font-Names="Arial Black" Font-Size="10pt" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                </div>            
                <div class="panel panel-primary" data-collapsed ="0">
                    <div class="panel-heading" style="background-color:#2E3192; color:whitesmoke;">
                        <div class="panel-title" style="font-family:Arial;">
                            Contact Information
                        </div>
                        <div class="panel-options">
							<a href="#" data-rel="collapse"><i class="entypo-down-open"></i></a>
							<a href="#" data-rel="reload"><i class="entypo-arrows-ccw"></i></a>
							<!--<a href="#" data-rel="close"><i class="entypo-cancel"></i></a>!-->
						</div>
                      </div>
                        <div class="panel-body">
                          <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                     <asp:label runat="server" for="field-2"  ID="lblClinicHead" style="font-weight:bold;font-size:12px;color:blue;">Clinic Head:</asp:label>
                                <asp:TextBox runat="server" type="text" CssClass="form-control" ID="txtClinicHead" placeholder="Clinic Head" Height="100%" style="font-size:12px;"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                <asp:label runat="server" for="field-2"  ID="lblContacNo" style="font-weight:bold;font-size:12px;color:red;">Clinic Contact No:</asp:label>
                                <asp:TextBox runat="server" type="text" CssClass="form-control" ID="txtClinicContactNo" placeholder="Mobile Number" Height="100%" style="font-size:12px;"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidatorContactNo" runat="server" ErrorMessage="Enter Contact No" ControlToValidate="txtClinicContactNo" ValidationGroup="ClinicRegistration" Font-Bold="True" Font-Names="Arial Black" Font-Size="10pt" ForeColor="Red" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                <asp:label runat="server" for="field-2"  ID="lblClicicHeadContact" style="font-weight:bold;font-size:12px;color:blue;">Clinic Head Contact:</asp:label>
                                <asp:TextBox runat="server" type="text" CssClass="form-control" ID="txtClinicHeadContact" placeholder="Mobile Number" Height="100%" style="font-size:12px;"></asp:TextBox>
                                </div>
                            </div>
                              <div class="col-md-3">
                                <div class="form-group">
                                <asp:label runat="server" for="field-2"  ID="lblClinicEmail" style="font-weight:bold;font-size:12px;color:blue;">Clinic Email:</asp:label>
                                <asp:TextBox runat="server" type="text" CssClass="form-control" ID="txtClinicEmail" placeholder="Clinic Email" Height="100%" style="font-size:12px;"></asp:TextBox>
                                </div>
                            </div>
                            </div>
                      
                            <div class="row">
                                <div class="panel panel-gray" data-collapsed="1">
                                    <div class="panel-heading" style="color:whitesmoke;background-color:#B4472A">
                                          <div class="panel-title" style="font-family:Arial;">
                                             Present Address(Detail Contact Fields Click to open)
                                          </div>
                                 <div class="panel-options">
							       <a href="#" data-rel="collapse"><i class="entypo-down-open"></i></a>
							       <a href="#" data-rel="reload"><i class="entypo-arrows-ccw"></i></a>
							      <!--<a href="#" data-rel="close"><i class="entypo-cancel"></i></a>!-->
						       </div>
                              </div>
                                   <div class="panel-body">
                                    <div class="row">
                                       <div class="col-md-4">
                                           <div class="form-group">
                                        <asp:Label runat="server" ID="lblCity" style="font-weight:bold;font-size:12px;">City:</asp:Label>
                                         <asp:DropDownList ID="ddlCity" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;">
                                            <asp:ListItem Text="Select City" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Karachi" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Hyderabad" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Sukkur" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="MirPurKhas" Value="4"></asp:ListItem>
                                            <asp:ListItem Text="Sakhru" Value="5"></asp:ListItem>
                                            <asp:ListItem Text="Others" Value="6"></asp:ListItem>
								</asp:DropDownList>
                                    </div>
                                       </div>
                                        <div class="col-md-4">
                                              <div class="form-group">
                                        <asp:Label runat="server" ID="lblProvince" style="font-weight:bold;font-size:12px;">Province:</asp:Label>
                                         <asp:DropDownList ID="ddlProvince" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;">
                                            <asp:ListItem Text="Select Province" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Sindh" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Balochistan" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="KPK" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Punjab" Value="4"></asp:ListItem>
								</asp:DropDownList>
                                    </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                        <asp:Label runat="server" ID="Label1" style="font-weight:bold;font-size:12px;">Country:</asp:Label>
                                         <asp:DropDownList ID="ddlCountry" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;">
                                            <asp:ListItem Text="Select Country" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Pakistan" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="India" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="" Value="4"></asp:ListItem>
								</asp:DropDownList>
                                    </div>
                                        </div>
                                        </div>
                                       <div class="row">
                                           <div class="col-md-6">
                                               <div class="form-group">
                                                   <asp:Label runat="server" ID="lblAddress" style="font-weight:bold;font-size:12px;">Address:</asp:Label>
                                                   <asp:TextBox runat="server" ID="txtAddress" CssClass="form-control" TextMode="MultiLine" style="font-size:12px;"></asp:TextBox>
                                               </div>
                                           </div>
                                           <div class="col-md-6">
                                               <div class="form-group">
                                                    <asp:Label runat="server" ID="lblArea" style="font-weight:bold;font-size:12px;">Area/Block:</asp:Label>
                                                   <asp:TextBox runat="server" ID="txtArea" CssClass="form-control" TextMode="MultiLine" style="font-size:12px;"></asp:TextBox>
                                                   <asp:Label runat="server" CssClass="hideCol" ID="lblSrNo"></asp:Label>
                                               </div>
                                           </div>
                                       </div>
                                   </div>
                                </div>
                            </div> 
                        </div>
                    <div class="row">
                            <div class="col-md-12">
                                <asp:Button runat="server" ID="btn_Submit"  CssClass="btn btn-black" style="width:100%;" Text="ClinicRegister" OnClick="btn_Submit_Click" ValidationGroup="ClinicRegistration" />
                                <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                            </div><br />
                        <div class="col-md-6">
                                <asp:Button runat="server" ID="btn_Update" CssClass="btn btn-black" style="width:100%;" Text="Update Patient" ValidationGroup="PatientRegistration" OnClick="btn_Update_Click" />
                            </div>
                            <div class="col-md-6">
                                <asp:Button runat="server" ID="btn_Cancel" CssClass="btn btn-black" style="width:100%;" Text="Cancel" ValidationGroup="PatientRegistration" />
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
