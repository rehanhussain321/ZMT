<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="grid.aspx.cs" Inherits="ZMTClinics.grid" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ZMT Clinics::Patient Info</title>
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
    <link href="../gridcss/grid.css" rel="stylesheet" />
    <link href="../gridcss/table.css" rel="stylesheet" />
    <link href="../gridcss/footable.css" rel="stylesheet" />
     <link href="DatePicker/bootstrap-datepicker.css" rel="stylesheet" />
    <script src="DatePicker/bootstrap-datepicker.js"></script>
            <style>
        .hideCol
        {
          display:none;
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
    <style>
        .padding-0{
    padding-right:0  !important;
    padding-left:0   !important;
}
    </style>
</head>
<body class="page-body  page-fade gray">>
    <form id="form1" runat="server">
    <div class="page-container">
        <div class="sidebar-menu">
        <div class ="sidebar-menu-inner">
        <header class="logo-env">

				<!-- logo -->
				<div class="logo">
					<a href="grid.aspx">
						<asp:Image ID="ImgUser" runat="server"  Width="50" CssClass="img-circle"  />
                        <asp:Label ID="lblUserName" runat="server"></asp:Label>
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
			<div class="col-md-3 col-sm-6">
				<div class="tile-stats tile-white stat-tile">
					<h3>1500 plus</h3>
					<p>Monthly visitor statistics</p>
					<span class="daily-visitors"></span>
				</div>		
			</div>
		
			<div class="col-md-3 col-sm-6">
				<div class="tile-stats tile-white stat-tile">
					<h3>327 OPD</h3>
					<p>Avg. OPD per day</p>
					<span class="monthly-sales"></span>
				</div>		
			</div>
		
		
			<div class="col-md-3 col-sm-6">
				<div class="tile-stats tile-white stat-tile">
					<h3>70000</h3>
					<p>Pharmacy</p>
					<span class="stock-market"></span>
				</div>		
			</div>
		
		
			<div class="col-md-3 col-sm-6">
				<div class="tile-stats tile-white stat-tile">
					<h3>6.5%</h3>
					<p>Affiliate Share</p>
					<span class="pie-chart"></span>
				</div>		
			</div>
		</div>
         <div class="row">
            <div class="col-md-6">
         <div class="panel panel-white">
             <div class="panel-heading" style="background-color:gray;color:white;">
                  <h4 class="panel-title text-primary" id="panel1" style="color:white;">Patient History<b></b></h4>
                 <div class="panel-tools">
                                    <a data-original-title="Collapse" data-toggle="tooltip" data-placement="bottom" class="btn btn-transparent btn-sm panel-collapse" href="#"><i class="fa fa-minus collapse-off"></i><i class="fa fa-plus collapse-on"></i></a>
                                    <a data-original-title="Refresh" data-toggle="tooltip" data-placement="bottom" class="btn btn-transparent btn-sm panel-refresh" href="#"><i class="fa fa-refresh"></i></a>
                                    <a data-original-title="Full Screen" data-toggle="tooltip" data-placement="bottom" class="btn btn-transparent btn-sm full-link" href="#"><i class="fa fa-expand"></i></a>
                                    <a data-original-title="Close" data-toggle="tooltip" data-placement="bottom" class="btn btn-transparent btn-sm panel-close" href="#"><i class="fa fa-close"></i></a>
                                    <div class="btn-group">
                                        <a data-original-title="DropDown" data-toggle="dropdown" data-placement="bottom" class="btn btn-transparent btn-sm toggle-dropdown" href="#"><i class="fa fa-chevron-down"></i></a>
                                        <ul class="dropdown-menu dropdown-menu-right" style="overflow-y:scroll;height:150px;">
                                           
                                            <li><a href="#" class="dropdown-anchor">Another action</a> </li>
                                        </ul>
                                    </div>
                                </div>
             </div>
             <div class="panel-body">
        <asp:GridView ID="grdPatient" runat="server" AutoGenerateColumns="False" CssClass="footable large-only"   GridLines="None" style="font-size:12px;color:white;">
            <Columns>
                <asp:BoundField DataField="RegistrationDate" HeaderText="Date"  HeaderStyle-BackColor="#fd8d68" HeaderStyle-CssClass="align-center" DataFormatString="{0: dd MMM yy}" HtmlEncode="False">
               <HeaderStyle BackColor="#fd8d68"></HeaderStyle>

                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="ClinicName" HeaderText="Clinic" HeaderStyle-CssClass="align-right" HeaderStyle-BackColor="#fd8d68">
                    <HeaderStyle BackColor="#fd8d68"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="No. of Patients" HeaderText="No. of Patients" HeaderStyle-CssClass="align-center"  HeaderStyle-BackColor="#fd8d68">
                    <HeaderStyle BackColor="#fd8d68"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
                 </div>
             </div>
                </div>
             <div class="col-md-6">
          <div class="panel panel-white">
             <div class="panel-heading" style="background-color:gray;color:white;">
                  <h4 class="panel-title text-primary" id="panel2" style="color:white;">Doctors<b></b></h4>
                 <div class="panel-tools">
                                    <a data-original-title="Collapse" data-toggle="tooltip" data-placement="bottom" class="btn btn-transparent btn-sm panel-collapse" href="#"><i class="fa fa-minus collapse-off"></i><i class="fa fa-plus collapse-on"></i></a>
                                    <a data-original-title="Refresh" data-toggle="tooltip" data-placement="bottom" class="btn btn-transparent btn-sm panel-refresh" href="#"><i class="fa fa-refresh"></i></a>
                                    <a data-original-title="Full Screen" data-toggle="tooltip" data-placement="bottom" class="btn btn-transparent btn-sm full-link" href="#"><i class="fa fa-expand"></i></a>
                                    <a data-original-title="Close" data-toggle="tooltip" data-placement="bottom" class="btn btn-transparent btn-sm panel-close" href="#"><i class="fa fa-close"></i></a>
                                    <div class="btn-group">
                                        <a data-original-title="DropDown" data-toggle="dropdown" data-placement="bottom" class="btn btn-transparent btn-sm toggle-dropdown" href="#"><i class="fa fa-chevron-down"></i></a>
                                        <ul class="dropdown-menu dropdown-menu-right" style="overflow-y:scroll;height:150px;">
                                           
                                            <li><a href="#" class="dropdown-anchor">Another action</a> </li>
                                        </ul>
                                    </div>
                                </div>
             </div>
              <div class="panel-body">
        <asp:GridView ID="grdPatientMaritialStatus" runat="server" AutoGenerateColumns="false" CssClass="footable large-only" GridLines="None" style="font-size:12px;color:white;" >
            <Columns>
               <%-- <asp:BoundField DataField="Doctor_Name" HeaderText=" Name" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
                    <ItemStyle HorizontalAlign="left" />
                </asp:BoundField>
                <asp:BoundField DataField="Doctor_Clinic" HeaderText="Clinic" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>--%>
            </Columns>
        </asp:GridView>
             </div>
              </div>
                </div>
             </div>
            <div class="row">
            <div class="col-md-6">
        <div class="panel panel-white">
             <div class="panel-heading" style="background-color:gray;color:white;">
                  <h4 class="panel-title text-primary" id="panel3" style="color:white;">Doctor<b></b></h4>
                 <div class="panel-tools">
                                    <a data-original-title="Collapse" data-toggle="tooltip" data-placement="bottom" class="btn btn-transparent btn-sm panel-collapse" href="#"><i class="fa fa-minus collapse-off"></i><i class="fa fa-plus collapse-on"></i></a>
                                    <a data-original-title="Refresh" data-toggle="tooltip" data-placement="bottom" class="btn btn-transparent btn-sm panel-refresh" href="#"><i class="fa fa-refresh"></i></a>
                                    <a data-original-title="Full Screen" data-toggle="tooltip" data-placement="bottom" class="btn btn-transparent btn-sm full-link" href="#"><i class="fa fa-expand"></i></a>
                                    <a data-original-title="Close" data-toggle="tooltip" data-placement="bottom" class="btn btn-transparent btn-sm panel-close" href="#"><i class="fa fa-close"></i></a>
                                    <div class="btn-group">
                                        <a data-original-title="DropDown" data-toggle="dropdown" data-placement="bottom" class="btn btn-transparent btn-sm toggle-dropdown" href="#"><i class="fa fa-chevron-down"></i></a>
                                        <ul class="dropdown-menu dropdown-menu-right" style="overflow-y:scroll;height:150px;">
                                           
                                            <li><a href="#" class="dropdown-anchor">Another action</a> </li>
                                        </ul>
                                    </div>
                                </div>
             </div>
            <div class="panel-body">
        <asp:GridView ID="grdPatientAdmissionRelation" runat="server" AutoGenerateColumns="false" CssClass="footable large-only" GridLines="None" style="font-size:12px;color:white;" >
            <Columns>
                <asp:BoundField DataField="Doctor_Name" HeaderText=" Name" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
                    <ItemStyle HorizontalAlign="left" />
                </asp:BoundField>
                <%--<asp:BoundField DataField="Doctor_Clinic" HeaderText="Clinic" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>--%>
            </Columns>
        </asp:GridView>
                </div>
             </div>
                </div>
             <div class="col-md-6">
        <div class="panel panel-white">
             <div class="panel-heading" style="background-color:gray;color:white;">
                  <h4 class="panel-title text-primary" id="panel4" style="color:white;">Clinic<b></b></h4>
                 <div class="panel-tools">
                                    <a data-original-title="Collapse" data-toggle="tooltip" data-placement="bottom" class="btn btn-transparent btn-sm panel-collapse" href="#"><i class="fa fa-minus collapse-off"></i><i class="fa fa-plus collapse-on"></i></a>
                                    <a data-original-title="Refresh" data-toggle="tooltip" data-placement="bottom" class="btn btn-transparent btn-sm panel-refresh" href="#"><i class="fa fa-refresh"></i></a>
                                    <a data-original-title="Full Screen" data-toggle="tooltip" data-placement="bottom" class="btn btn-transparent btn-sm full-link" href="#"><i class="fa fa-expand"></i></a>
                                    <a data-original-title="Close" data-toggle="tooltip" data-placement="bottom" class="btn btn-transparent btn-sm panel-close" href="#"><i class="fa fa-close"></i></a>
                                    <div class="btn-group">
                                        <a data-original-title="DropDown" data-toggle="dropdown" data-placement="bottom" class="btn btn-transparent btn-sm toggle-dropdown" href="#"><i class="fa fa-chevron-down"></i></a>
                                        <ul class="dropdown-menu dropdown-menu-right" style="overflow-y:scroll;height:150px;">
                                           
                                            <li><a href="#" class="dropdown-anchor">Another action</a> </li>
                                        </ul>
                                    </div>
                                </div>
             </div>
            <div class="panel-body">
        <asp:GridView ID="grdPatientDetail" runat="server" AutoGenerateColumns="false" CssClass="footable large-only" GridLines="None" style="font-size:12px;color:white;" >
            <Columns>
                <asp:BoundField DataField="Clinic_Name" HeaderText=" Name" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
                    <ItemStyle HorizontalAlign="left" />
                </asp:BoundField>
                <asp:BoundField DataField="Clinic_Incharge" HeaderText="Gender" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Clinic_Area" HeaderText="Desease" HeaderStyle-CssClass="align-left" HeaderStyle-BackColor="#fd8d68">
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
             </div>
                </div>
                </div>
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
