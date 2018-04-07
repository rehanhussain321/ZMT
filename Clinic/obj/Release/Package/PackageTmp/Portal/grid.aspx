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
        .padding-0{
            padding-right:0  !important;
            padding-left:0   !important;
}
    </style>
    <style>
       .mydatagrid
            {
	            width: 100%;
	            /*border: solid 2px black;*/
	            min-width: 80%;
            }
       .header
            {
	            background-color: #2E3192;
	            font-family: Arial;
	            color: White;
	            border: none 0px transparent;
	            height: 25px;
	            text-align: center;
	            font-size: 16px;
            }

        .rows
            {
	            background-color: #fff;
	            font-family: Arial;
	            font-size: 14px;
	            color: #000;
	            min-height: 25px;
	            text-align: left;
	            border: none 0px transparent;
            }
      .rows:hover
            {
	            background-color: #ff8000;
	            font-family: Arial;
	            color: #fff;
	            text-align: left;
            }
     .selectedrow
            {
	            background-color: #ff8000;
	            font-family: Arial;
	            color: #fff;
	            font-weight: bold;
	            text-align: left;
            }
      .mydatagrid a /** FOR THE PAGING ICONS  **/
            {
	            background-color: Transparent;
	            padding: 5px 5px 5px 5px;
	            color: #fff;
	            text-decoration: none;
	            font-weight: bold;
            }

      .mydatagrid a:hover /** FOR THE PAGING ICONS  HOVER STYLES**/
            {
	            background-color: #000;
	            color: #fff;
            }
      .mydatagrid span /** FOR THE PAGING ICONS CURRENT PAGE INDICATOR **/
            {
	            background-color: #c9c9c9;
	            color: #000;
	            padding: 5px 5px 5px 5px;
            }
      .pager
            {
	            background-color: #646464;
	            font-family: Arial;
	            color: White;
	            height: 30px;
	            text-align: left;
            }

     .mydatagrid td
            {
	            padding: 5px;
            }
     .mydatagrid th
            {
	            padding: 5px;
            }
     .frame
            {
                width:100%;
                height:100%;
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
<body class="page-body  page-fade gray" >
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
        <header class="logo-env">

				<!-- logo -->
				<div class="logo">
					<a href="grid.aspx">
						<asp:Image ID="ImgUser" runat="server"  Width="50" CssClass="img-circle"  />
                        <asp:Label ID="lblUserName" runat="server"></asp:Label>
					</a>
				</div>

<%--				<!-- logo collapse icon -->
				<div class="sidebar-collapse">
					<a href="#" class="sidebar-collapse-icon">
                        <!-- add class "with-animation" if you want sidebar to have animation during expanding/collapsing transition -->
						<i class="entypo-menu"></i>
					</a>
				</div>--%>

								
				<!-- open/close menu icon (do not remove if you want to enable menu on mobile devices) -->
				<div class="sidebar-mobile-menu visible-xs">
					<a href="#" class="with-animation"><!-- add class "with-animation" to support animation -->
						<i class="entypo-menu"></i>
					</a>
				</div>

			</header>
       <%-- <div class="sidebar-menu">
        <div class ="sidebar-menu-inner">
        
            
        <asp:Panel ID="Panel1" runat="server" CssClass="main-menu">
           
        </asp:Panel>
                
        </div>
    </div>--%>
        <div class="main-content">
            <div class="row">
			<div class="col-md-3 col-sm-6">
				<div class="tile-stats tile-white-blue steps-progress">
					<h1><asp:Label ID="lblPatientLastMonth" runat="server" Text=""></asp:Label>   Patients</h1>
					<p>Last Month</p>
					<span class="daily-visitors"></span>
				</div>		
			</div>
		
			<div class="col-md-3 col-sm-6">
				<%--<div class="tile-stats tile-white stat-tile">--%>
                <div class="tile-stats tile-white-blue steps-progress">
					<h1><asp:Label ID="lblPatientThisMonth" runat="server" Text=""></asp:Label> Patients</h1>
					<p>This Month</p>
					<span class="monthly-sales"></span>
				</div>		
			</div>
		
		
			<div class="col-md-3 col-sm-6">
				<div class="tile-stats tile-white-blue steps-progress">
					<h1><asp:Label ID="lblMedicineIssuedThisMonth" runat="server" Text=""></asp:Label> Medicines</h1>
					<p>Pharmasy Issue This Month</p>
					<span class="stock-market"></span>
				</div>		
			</div>
		
		
			<div class="col-md-3 col-sm-6">
				<div class="tile-stats tile-white-blue steps-progress">
					<h1>6.5%</h1>
					<p>Affiliate Share</p>
					<span class="pie-chart"></span>
				</div>		
			</div>
		</div>
         <div class="row">
            <div class="col-md-6">
         <div class="panel panel-white">
             <div class="panel-heading" style="background-color:#2E3192;color:white;font-weight:bold">
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
             <div class="panel-body" style="padding:0px;padding-top:10px;">
        <asp:GridView ID="grdPatient" runat="server" AutoGenerateColumns="False" CssClass="mydatagrid" PagerStyle-CssClass="pager" HeaderStyle-CssClass="header" RowStyle-CssClass="rows"   GridLines="None">
            <Columns>
                <asp:BoundField DataField="Ticket_Date" HeaderText="Date" HeaderStyle-CssClass="align-center" DataFormatString="{0: dd MMM yy}" HtmlEncode="False">
               <HeaderStyle CssClass="header"></HeaderStyle>

                    <ItemStyle HorizontalAlign="Center" CssClass="row" />
                </asp:BoundField>
                <asp:BoundField DataField="ClinicName" HeaderText="Clinic" HeaderStyle-CssClass="align-right">
                    <HeaderStyle CssClass="header"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Center" CssClass="row" />
                </asp:BoundField>
                <asp:BoundField DataField="No. of Patients" HeaderText="No. of Patients" HeaderStyle-CssClass="align-center">
                    <HeaderStyle CssClass="header" ></HeaderStyle>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
                 </div>
             </div>
                </div>
             <div class="col-md-6">
          <div class="panel panel-white" style="height:700px;">
             <div class="panel-heading" style="background-color:#2E3192;color:white;">
                  <h4 class="panel-title text-primary" id="panel2" style="color:white;">Pharmasy(This Month)<b></b></h4>
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
              
                 <div style="background-color:white;height:550px;padding-left:0px;">
                     <iframe class="frame" style="background-color:white;padding-left:0;" src="PharmasyChart.aspx" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" onload="" allowtransparency="false"></iframe>
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
