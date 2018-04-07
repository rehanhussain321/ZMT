<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pharmasy.aspx.cs" Inherits="ZMTClinics.Pharmasy" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ZMT Clinics::Pharmacy</title>
    <link rel="stylesheet" href="../assets/js/jquery-ui/css/no-theme/jquery-ui-1.10.3.custom.min.css"/>
    <script type="text/javascript" src="http://cdn.ucb.org.br/Scripts/formValidator/js/languages/jquery.validationEngine-en.js"
        charset="utf-8"></script>
    <script type="text/javascript" src="http://cdn.ucb.org.br/Scripts/formValidator/js/jquery.validationEngine.js"
        charset="utf-8"></script>
	<link rel="stylesheet" href="../assets/css/font-icons/entypo/css/entypo.css"/>
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Noto+Sans:400,700,400italic"/>
	<link rel="stylesheet" href="../assets/css/bootstrap.css"/>
	<link rel="stylesheet" href="../assets/css/neon-core.css"/>
	<link rel="stylesheet" href="../assets/css/neon-theme.css"/>
	<link rel="stylesheet" href="../assets/css/neon-forms.css"/>
    <link rel="stylesheet" href="../style/grid.css" />
    <link rel="stylesheet" href="../style/subGrid.css" />
	<link rel="stylesheet" href="../assets/css/custom.css"/>
    <link rel="stylesheet" href="../assets/form.css" />
    <link href="../style/calendar-win2k-1.css" rel="stylesheet" />
    <script src="dist/jquery.inputmask.bundle.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css"/>
    <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js" type="text/javascript"></script>
    <script src="../assets/jquery.dynDateTime.min.js"></script>
    <script src="../assets/calendar-en.min.js"></script>
    <link href="../assets/calendar-blue.css" rel="stylesheet" />
        <link href="../gridcss/grid.css" rel="stylesheet" />
    <link href="../gridcss/table.css" rel="stylesheet" />
    <link href="../gridcss/footable.css" rel="stylesheet" />
     <link href="../DatePicker/bootstrap-datepicker.css" rel="stylesheet" />
    <script src="../DatePicker/bootstrap-datepicker.js"></script>
    <%--<script>$.noConflict();</script>
	<!--[if lt IE 9]><script src="assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
		<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->
   <%--<link rel="stylesheet" href='http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.min.css' media="screen" />--%>
   <script type="text/javascript" src='http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js'></script>
   <script type="text/javascript" src='http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js'></script>
   <script type="text/javascript" src="http://cdn.rawgit.com/bassjobsen/Bootstrap-3-Typeahead/master/bootstrap3-typeahead.min.js"></script>
   <link rel="Stylesheet" href="https://twitter.github.io/typeahead.js/css/examples.css" />
    <style>
        .hideCol
        {
          display:none;
            }
        .text-right{
            text-align:right;
            
            
        }
    </style>
<script type="text/javascript">
    $(function () {
        $("[id*=gvPatientService] td").hover(function () {
            $("td", $(this).closest("tr")).addClass("hover_row");
        }, function () {
            $("td", $(this).closest("tr")).removeClass("hover_row");
        });
    });
    </script>
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
    <script type="text/javascript">
    $(function () {
        $('[id*=txtMedicine]').typeahead({
            hint: true,
            highlight: true,
            minLength: 1
            ,source: function (request, response) {
                $.ajax({
                    url: '<%=ResolveUrl("Pharmasy.aspx/GetMedicines") %>',
                    data: "{ 'prefix': '" + request + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        items = [];
                        map = {};
                        $.each(data.d, function (i, item) {
                            var id = item.split('~')[1];
                            var name = item.split('~')[0];
                            map[name] = { id: id, name: name };
                            items.push(name);
                        });
                        response(items);
                        $(".dropdown-menu").css("height", "auto");
                        $(".dropdown-menu").css("font-size", "12px");
                        $(".dropdown-menu").css("width", "200px");
                        $(".dropdown-menu").css("font-color", "yellow");
                    },
                    error: function (response) {
                        alert(response.responseText);
                    },
                    failure: function (response) {
                        alert(response.responseText);
                    }
                });
            },
            updater: function (item) {
                $('[id*=hfMedicine]').val(map[item].id);
                return item;
            }
        });
    });
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
                    <div class="row">
                 <div class="col-md-2">
                     <asp:Image ID="Image1" runat="server"/>
                 </div>
                 <div class="col-md-2">
                     <asp:Label runat="server" ID="lblUserName"></asp:Label>
                 </div>
                 <div class="col-md-10 col-sm-offset-2">
                     <asp:DropDownList ID="ddClinic" runat="server" class="form-control" width="15%" style="margin-left:85%;"  AutoPostBack="true" disabled="disabled"></asp:DropDownList>
                 </div>
                 </div>
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                                        aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span><span
                                        class="icon-bar"></span><span class="icon-bar"></span>
                        </button>
                    <a class="navbar-brand" href="grid.aspx">ZMT Clinics</a>
                    </div>
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <asp:Menu ID="Menu1" runat="server" Orientation="Horizontal" RenderingMode="List"
                                IncludeStyleBlock="false" StaticMenuStyle-CssClass="nav navbar-nav" DynamicMenuStyle-CssClass="dropdown-menu" style="background-color:aqua">
                        </asp:Menu>
                   </div>
              </div>
        </div>
    <div class="page-container">
         
     
        <div class="main-content">
            <div class="row">
		
			<!-- Profile Info and Notifications -->
			<div class="col-md-6 col-sm-8 clearfix">
		
				<ul class="user-info pull-left pull-none-xsm">
		
					<!-- Profile Info -->
					<li class="profile-info dropdown"><!-- add class "pull-right" if you want to place this from right -->
		
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <%--<img src="assets/images/thumb-1@2x.png" alt="" class="img-circle" width="44" />--%>
                            <%--<asp:Image ID="ImgUser" runat="server"  Width="50" CssClass="img-circle"  />
							<asp:Label runat="server" ID=""></asp:Label>--%>
						</a>
		
						<ul class="dropdown-menu">
		
				</ul>
				
				<ul class="user-info pull-left pull-right-xs pull-none-xsm">
		
					<!-- Raw Notifications -->
                   
					</li>
		
				</ul>
		
			</div>
		
		
			<!-- Raw Links -->
			<div class="col-md-12" style="margin-top:0px;">
				<ul class="col-md-12">
                           <div class="ui-widget">
                            <asp:TextBox runat="server" CssClass="form-control" style="float:left;width:55%;" ID="txtPatientSearch" placeholder="Enter patient name for search" ></asp:TextBox>
                        </div>
                            <asp:Button runat="server" id="btnSearch" Text="Search" CssClass="btn btn-blue btn-block" style="width:45%" OnClick="Unnamed1_Click"/>
						</ul>
		
					</li>
		
					
				</ul>
		
			</div>
                <div class="col-md-12 " id="search" style="height:352px;margin-left:0px;overflow:scroll;">
                       <asp:GridView ID="gvPatients" runat="server" CssClass="mydatagrid" PagerStyle-CssClass="pager" HeaderStyle-CssClass="header" RowStyle-CssClass="rows"  OnSelectedIndexChanged="gvPatients_SelectedIndexChanged"  DataKeyNames="Registration_No" OnRowDataBound="gvPatients_RowDataBound" AutoGenerateColumns="False" EmptyDataText="No Record(s) Found" AutoGenerateSelectButton="True" ForeColor="Black">
                            <Columns>
                               <asp:BoundField DataField="Ticket_Date" HeaderText="Ticket Date" HeaderStyle-CssClass="align-right" >
                                <ControlStyle></ControlStyle>
                                <HeaderStyle CssClass="header"></HeaderStyle>
                                 <ItemStyle HorizontalAlign ="Center" CssClass="row"  />
                               </asp:BoundField>
                               <asp:BoundField DataField="Ticket_Number" HeaderText="Ticket#" HeaderStyle-CssClass="text-center">
                                  <HeaderStyle  CssClass="header"></HeaderStyle>
                                  <ItemStyle HorizontalAlign ="Center" CssClass="row"  />
                               </asp:BoundField>
                               <asp:BoundField DataField ="Registration_No" HeaderText="MrNo" HeaderStyle-CssClass="align-left">
                                 <HeaderStyle  CssClass="header"></HeaderStyle>
                                 <ItemStyle HorizontalAlign="Left" CssClass="row"  />
                               </asp:BoundField>
                               <asp:BoundField DataField="First_Name" HeaderText="First Name" HeaderStyle-CssClass="align-left">
                                 <HeaderStyle  CssClass="header"></HeaderStyle>
                                 <ItemStyle HorizontalAlign ="Left" CssClass="row"  />
                               </asp:BoundField>
                                <asp:BoundField DataField="Father_Name" HeaderText="Father Name" HeaderStyle-CssClass="align-left">
                                  <HeaderStyle  CssClass="header"></HeaderStyle>
                                  <ItemStyle HorizontalAlign ="Left" CssClass="row"  />
                                </asp:BoundField>
                                <asp:BoundField DataField="Age" HeaderText="Age" HeaderStyle-CssClass="align-left">
                                  <HeaderStyle  CssClass="header"></HeaderStyle>
                                  <ItemStyle HorizontalAlign ="Left" CssClass="row"  />
                                </asp:BoundField>
                                <asp:BoundField DataField="Mobile_1" HeaderText="Mobile#1" HeaderStyle-CssClass="align-left">
                                  <HeaderStyle  CssClass="header"></HeaderStyle>
                                  <ItemStyle HorizontalAlign ="Left"  />
                                </asp:BoundField>
                                <asp:BoundField DataField="sys_PatientSno" HeaderText="Patient Sno" HeaderStyle-CssClass="align-left">
                                  <ItemStyle CssClass="hideCol" />
                                  <HeaderStyle CssClass="hideCol" />
                                </asp:BoundField>
                            </Columns>
                     </asp:GridView>
                    </div>
		
		</div>
		
		<hr />			
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
                    <div class="panel-body" style="padding:0px;padding-top:10px;padding-left:0px;padding-right:0px;">
                        <div class="row">
                            <div class="col-md-12">
                                <asp:GridView ID="gvPatientService" runat="server" CssClass="table" style="font-size:12px;color:black;"  AutoGenerateColumns="False" EmptyDataText="No Record(s) Found" ForeColor="Black" OnRowDataBound = "OnRowDataBound" OnSelectedIndexChanged="gvPatientService_SelectedIndexChanged" OnRowCommand="gvPatientService_RowCommand" DataKeyNames="sysTicketMasterNo">
                            <Columns>
                                <asp:BoundField DataField ="MR_No" HeaderText="MrNo" HeaderStyle-CssClass="text-right" HeaderStyle-BackColor="#c5c5d8" >
                                    <HeaderStyle BackColor="#c5c5d8" CssClass="text-right"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="sysTicketMasterNo" HeaderText="STN" HeaderStyle-CssClass="text-center">
                                    <ItemStyle CssClass="hideCol" />
                                     <HeaderStyle CssClass="hideCol" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Patient_Name" HeaderText="Name" HeaderStyle-CssClass="text-left" HeaderStyle-BackColor="#c5c5d8"  ControlStyle-BackColor="#c5c5d8">
                                <ControlStyle BackColor="#c5c5d8"></ControlStyle>
                                <HeaderStyle BackColor="#c5c5d8" CssClass="text-left"></HeaderStyle>
                                <ItemStyle HorizontalAlign ="left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Ticket_Number" HeaderText="Ticket" HeaderStyle-CssClass="text-right" HeaderStyle-BackColor="#fd8d68">
                                <HeaderStyle BackColor="#c5c5d8" CssClass="text-right"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Ticket_Date" HeaderText="Ticket Date" HeaderStyle-CssClass="text-center" HeaderStyle-BackColor="#fd8d68">
                                <HeaderStyle BackColor="#c5c5d8" CssClass="text-center"></HeaderStyle>
                                <ItemStyle HorizontalAlign ="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="NoOfServices" HeaderText="No Of Services" HeaderStyle-CssClass="text-right" HeaderStyle-BackColor="#fd8d68">
                                 <HeaderStyle BackColor="#c5c5d8" CssClass="text-right"></HeaderStyle>
                                <ItemStyle HorizontalAlign ="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Collapse_ServiceName" HeaderText="Name Of Services" HeaderStyle-CssClass="text-left" HeaderStyle-BackColor="#fd8d68">
                                 <HeaderStyle BackColor="#c5c5d8" CssClass="text-left"></HeaderStyle>
                                <ItemStyle HorizontalAlign ="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Total_Amount" HeaderText="Total Amount" HeaderStyle-CssClass="text-center" HeaderStyle-BackColor="#fd8d68">
                                <HeaderStyle BackColor="#c5c5d8" CssClass="text-center"></HeaderStyle>
                                <ItemStyle HorizontalAlign ="Center" />
                                </asp:BoundField>
                                <%--<asp:CommandField ShowSelectButton="True" ControlStyle-CssClass="hideCol" >
                                <ControlStyle CssClass="hideCol"></ControlStyle>
                                </asp:CommandField>--%>
                                <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="btnrefund" CssClass="btn" runat="server" OnClick="ChangeStatus" Text='<%# "Amount Return"  %>' />
                                </ItemTemplate>
                                <HeaderTemplate>Amount Return</HeaderTemplate>
                                <HeaderStyle BackColor="#c5c5d8" Width="25" />
                                </asp:TemplateField>
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
                                           <asp:Label runat ="server" ID="lblPatientMrNo" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:220px;" CssClass="form-control input-sm" ></asp:Label>
                                      </div>  
                                </div>
                          <!-- </div> -->
                          <!-- <div class ="col-md-4  "> -->
                               <div class="form-group">
                                <asp:Label runat="server" ID="Label2" style="font-weight:bold;font-size:12px;color:red;float:left">Token #:</asp:Label>
                                <div class="col-md-4">
                                    <asp:Label runat="server" ID="lblPatientToken" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:220px;margin-left:29px;" CssClass="form-control"></asp:Label>
                                </div>
                                
                               </div>
                          <!--</div>-->
                          
                            <div class="form-group">
                                <asp:Label runat="server" ID="lblRegistrationDate" style="font-weight:bold;font-size:12px;color:red;float:left;">Regd Date:</asp:Label>
                                <div class="col-md-4">
                               <asp:Label runat="server" ID="lblPatientRegistrationDate" BorderColor="#C8C8C8" style="font-size:11px;background-color:#F0F0F0;width:220px;" CssClass="form-control"></asp:Label>
                            </div>
                                </div>
                            </div>
                  
                       <!-- </div>
                        <div class="row"> -->
                        <div class="form-inline">
                                <div class="form-group">
                                <asp:label runat="server" for="field-2"  ID="lblFirstName" style="font-weight:bold;font-size:12px;color:red;float:left;">Name:</asp:label>
                              <div class="col-md-4">
                                <asp:Label runat="server" ID="lblPatientFirstName" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:220px;margin-left:40px;" CssClass="form-control"></asp:Label>
                              </div>
                            </div>
                                <div class="form-group">
                               <asp:Label runat="server" ID="lblFatherName" style="font-weight:bold;font-size:12px;color:red;float:left;">Father Name:</asp:Label>
                              <div class="col-md-4">
                               <asp:Label runat="server" ID="lblPatientFatherName" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:220px;" CssClass="form-control"></asp:Label>
                                </div>
                            </div>
                              <div class="form-group">
                               <asp:Label runat="server" ID="lblAge" style="font-weight:bold;font-size:12px;color:red;float:left">Age:</asp:Label>
                                 <div class="col-md-4">
                                     <asp:Label runat="server" ID="lblPatientAge" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:220px;margin-left:36px;" CssClass="form-control"></asp:Label>
                            </div>
                                  </div>
                    </div>


                    <!-- <div class="row">-->
                            <div class="form-inline">
                                    <div class="form-group">
                                         <asp:Label runat="server" ID="lblGender" style="font-weight:bold;font-size:12px;color:red;float:left;">Gender:</asp:Label>
                                    <div class="col-md-4">
                                          <asp:Label runat="server" ID="lblPatientGender" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:220px;margin-left:30px;" CssClass="form-control"></asp:Label>        
                                    </div>
                                        </div>
                                    <div class="form-group">
                                        <asp:label runat="server" for="field-2" ID="lblReligion" style="font-weight:bold;font-size:12px;color:red;float:left;">Religion:</asp:label>
                                    <div class="col-md-4">
                                        <asp:Label runat="server" ID="lblPatientReligion" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:220px;margin-left:28px;;" CssClass="form-control"></asp:Label>        
                                    </div>
                                  </div>
                                    <div class="form-group">
                                       <asp:label runat="server" for="field-2" ID="lblMaritialStatus" style="font-weight:bold;font-size:12px;color:red;float:left;">Maritial St:</asp:label>
                                    <div class="col-md-4">
                                    <asp:Label runat="server" ID="lblPatientMaritialStatus" BorderColor="#C8C8C8" style="font-size:12px;background-color:#F0F0F0;width:220px;" CssClass="form-control"></asp:Label>   
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
                        Medicine Detail  <span style="font-size:16px;color:#FFFF00;font-weight:bold;"><asp:Literal runat="server" id="ltrMedicine"></asp:Literal></span>
                    </div>
                        <div class="panel-options">
							<a href="#" data-rel="collapse"><i class="entypo-down-open"></i></a>
							<a href="#" data-rel="reload"><i class="entypo-arrows-ccw"></i></a>
							<!--<a href="#" data-rel="c lose"><i class="entypo-cancel"></i></a>!-->
						</div>
                    </div>
                    
                    <div class="panel-body">
                        <div>
                              
                                <asp:Label runat="server" ID="lblMedical" style="font-weight:bold;font-size:12px;color:red;float:left;margin-top:5px;margin-left:30px;">Medicine:</asp:Label>
                                
                                <%--<asp:DropDownList ID="ddlMedicine" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;width:250px;margin-left:5px;margin-bottom:4px;float:left;" AutoPostBack="true"  AppendDataBoundItems="true">
                                            <asp:ListItem Text="Select Medicine Unit" Value="0"></asp:ListItem>
								</asp:DropDownList>--%>

                                 <asp:TextBox runat="server"  id="txtMedicine"  class="form-control" autocomplete="off" style="font-size:12px;width:250px;margin-left:5px;margin-bottom:4px;float:left;" placeholder="Enter medicine name to search"/>
                                 <asp:TextBox runat="server"  id="hfMedicine" CssClass="hideCol" />

                                <asp:Label runat="server" ID="Label5" style="font-weight:bold;font-size:12px;color:red;float:left;margin-top:5px;margin-left:25px;">Unit:</asp:Label>
                              
                                <asp:DropDownList ID="ddUnit" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;margin-left:5px;float:left;width:100px;" AutoPostBack="true" onchange="sumQuantity();">
                                            <asp:ListItem Text="Select Medicine" Value="0"></asp:ListItem>
								</asp:DropDownList>
                                <asp:Label runat="server" CssClass="hideCol" ID="lblSrNo"></asp:Label>

                                    <asp:Label runat="server" ID="Label6" style="font-weight:bold;font-size:12px;color:red;float:left;margin-top:5px;margin-left:25px;">Dosage:</asp:Label>
                                    <%--<asp:TextBox runat="server" ID="txtPatientMedicineDosage" CssClass="form-control" style="font-size:12px;background-color:#F0F0F0;width:120px;margin-left:0;">1+1+1</asp:TextBox>--%>
                                     <asp:DropDownList ID="ddDosage" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;margin-left:5px;float:left;width:100px;" AutoPostBack="true" onchange="sumQuantity();">
                                            <asp:ListItem Text="Select Dosage" Value="0"></asp:ListItem>
								</asp:DropDownList>
                                    <asp:Label runat="server" ID="Label4" style="font-weight:bold;font-size:12px;color:red;float:left;margin-top:5px;margin-left:25px;">Days:</asp:Label>
                                    <%--<asp:TextBox runat="server" ID="txtPatientMedicineDosage" CssClass="form-control" style="font-size:12px;background-color:#F0F0F0;width:120px;margin-left:0;">1+1+1</asp:TextBox>--%>
                                     <asp:DropDownList ID="ddDays" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;margin-left:15px;float:left;width:100px;" AutoPostBack="true" onchange="sumQuantity();">
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
                                    <asp:Label runat="server" ID="Label3" style="font-weight:bold;font-size:12px;color:red;float:left;margin-top:5px;margin-left:25px;">Quantity:</asp:Label>
                                    <asp:TextBox runat="server" ID="txtQuantity" CssClass="form-control" style="font-size:12px;background-color:#F0F0F0;width:100px;margin-left:5px;float:left;" >1</asp:TextBox>
                                    <asp:Button runat="server" ID="btnAdd"  style="width:75px;margin-left:1050px;" Text="Add " OnClick="btnAdd_Click" CssClass="btn btn-block" />
                               
                            
                            

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