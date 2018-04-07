<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Patient.aspx.cs" Inherits="ZMTClinics.patient_copy" %>

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
    <link rel="stylesheet" href="../style/grid.css" />
	<link rel="stylesheet" href="../assets/css/custom.css"/>
    <link rel="stylesheet" href="../assets/form.css" />
     <link rel="stylesheet" href="../Content/forms.css" />
    <link href="../style/calendar-win2k-1.css" rel="stylesheet" />
   <script src="../assets/js/jquery-1.11.0.min.js"></script>
    <script src="../dist/jquery.inputmask.bundle.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
    <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js" type="text/javascript"></script>
    <script src="../assets/calendar-en.min.js"></script>
    <link href="../assets/calendar-blue.css" rel="stylesheet" />
<%--    <link href="../gridcss/grid.css" rel="stylesheet" />
    <link href="../gridcss/table.css" rel="stylesheet" />
    <link href="../gridcss/footable.css" rel="stylesheet" />--%>
	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
		<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->   
<script type="text/javascript">
    function patientValid() {
        var suffix, fname, guardian, FatherName, Gender, Religion, Maritial, City, Area, Province, Country,ageinYear,ageinMonths;
        Suffix = document.getElementById("ddSuffix").value;
        fname = document.getElementById("txtFirstName").value;
        guardian = document.getElementById("ddGurdian").value;
        FatherName = document.getElementById("txtFatherName").value;
        Religion = document.getElementById("ddReligion").value;
        Maritial = document.getElementById("ddMaritialStatus").value;
        City = document.getElementById("ddlCity").value;
        Area = document.getElementById("ddlArea").value;
        Province = document.getElementById("ddlProvince").value;
        Country = document.getElementById("ddlCountry").value;
        ageinYear = document.getElementById("txtAge").value;
        ageinMonths = document.getElementById("txtAgeMonth").value;
        if (Suffix == 0 && fname == "" && guardian == 0 && FatherName == "" && Religion == 0 && Maritial == 0  && Area == 0) {
            alert("Enter All Fields");
            return false;
        }
        if (fname == "") {
            alert("Please Enter First Name of Patient");
            return false;
        }
        if (Suffix == 0) {
            alert("Please Select Suffix");
            return false;
        }
        if (guardian == 0) {
            alert("Please Select Guardian of Patient");
            return false;
        }
        if (FatherName == "") {
            alert("Please Enter Father Name of Patient");
            return false;
        }
        if (Maritial == 0) {
            alert("Please Select Maritial Status of Patient");
            return false;
        }
      
        if (Area == 0) {
            alert("Please Select Area of Patient");
            return false;
        }

        if (ageinYear == "" || ageinMonths == "") {
            alert("Please Enter Age of Patient");
            return false;
        }
}
</script>


    <style>
        .hideCol
        {
          display:none;
            }
    </style>

 <script>
     $(document).ready(function () {
         $("#txtContactNo").inputmask();
     });
</script>
    <script >
        function ShowConfirmationBox() {
            alert('checking');
        }


    </script>
    <script>
        $(function () {
            $('#btnSearch').click(function () {
            $('.search').css("display", "block");
        });
       })
    </script>
    <script type = "text/javascript">
        function Confirm() {
            if (confirm("Do you want to print slip?")) {
                //window.location.href = 'reciept.aspx';
                window.location.href = 'reciept.aspx';
            } else {
                //alert('No');
                window.location.href = 'patient.aspx';
                return false;
            }
        }
    </script>
     <script>
         function CalculateAge(id)
         {
             var d = new Date();

             document.getElementById("txtDOB").value = [d.getDate(), d.getMonth() + 1, d.getFullYear() - id.value].join('-');
             
         }
         function CalculateAgeinMonths(date,id)
         {
             // document.getElementById("txtDOB").value = [d.getDate(), d.getMonth() + 1 - id.value].join('-');
            
         }
         function CalculateDOB(id) {
             var d = new Date();
             document.getElementById("txtAge").value = d.getFullYear()- Right(document.getElementById("txtDOB").value, 4);

         }
         function Right(str, n) {
             if (n <= 0)
                 return "";
             else if (n > String(str).length)
                 return str;
             else {
                 var iLen = String(str).length;
                 return String(str).substring(iLen, iLen - n);
             }
         }
         
    </script>
    <script>
        $(document).ready(function ()
        {
            console.log($(document).width());
            $('#txtDOB').datepicker
           ({
               dateFormat: 'yyyy/mm/dd',
               changeMonth: true,
               changeYear: true,
               yearRange: '1900:2150',
               maxDate: new Date(),
               inline: true,

               onSelect: function () {
                   var birthDay = document.getElementById("#txtDOB").value;
                   var DOB = new Date(birthDay);
                   var today = new Date();
                   var age = today.getTime() - DOB.getTime();
                   age = Math.floor(age / (1000 * 60 * 60 * 24 * 365.25));

                   document.getElementById('#txtAge').value = age;
               }
           });

        });
    </script>
    <script>
        $(document).ready(function () {
            alert("ready");
        });
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

    <link href="../style/interface.css" rel="stylesheet" type="text/css" />
    <link href="../style/calendar-win2k-1.css" type="text/css" rel="stylesheet" />
    <script src="../Javascript/calendar.js" type="text/javascript"></script>
    <script src="../Javascript/calendar-en.js" type="text/javascript"></script>
    <script src="../Javascript/calendar-setup.js" type="text/javascript"></script>
    <script src="../Javascript/calendar-stripped.js" type="text/javascript"></script>
    <script src="../Javascript/calendar-setup_stripped.js" type="text/javascript"></script>

</head>
<body class="page-body">
    <form id="form1" runat="server">
                   <div class="navbar navbar-default">
                <div class="container-fluid">
                 <div class="row">
                 <div class="col-md-2">
                     <asp:Image ID="ImgUser" runat="server"/>
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
      <%-- <div class="sidebar-menu">
        <div class ="sidebar-menu-inner">
        <header class="logo-env">

				s<!-- logo --><div class="logo">
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
                            
						</a>           
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
               <%-- <div class="col-md-10 col-md-offset-1" >
                     <table  Class="mydatagrid header " style="width:90%;"  >
                        <tr>
                            <td style="width:150px;text-align:left;padding-left:1%;">Select</td>
                            <td style="width:200px;text-align:center">MrNo</td>
                            <td style="width:250px;text-align:right;margin-left:2%;padding-left:4%;">Registration Date</td>
                            <td style="width:250px;text-align:right;padding-left:2%;">First Name</td>
                            <td style="width:150px;text-align:center;padding-left:4%;">Guardian	</td>
                            <td style="width:200px;text-align:center;padding-left:4%;">Father Name</td>
                            <td style="width:150px;text-align:center">Age	</td>
                            <td style="width:150px;text-align:center">Present Area</td>
                            <td style="width:150px;text-align:center">Mobile#1</td>
                            
                        </tr>
                    </table>
                </div>--%>
                
                <div class="col-md-12 search" id="search" style="height:300px;overflow:auto;">
                    
                        <asp:GridView ID="gvPatients" runat="server" 
                            CssClass="mydatagrid" PagerStyle-CssClass="pager" HeaderStyle-CssClass="header" 
                            RowStyle-CssClass="rows"  DataKeyNames="Registration_No" 
                            OnSelectedIndexChanged="gvPatients_SelectedIndexChanged"  AutoGenerateColumns="False" 
                            EmptyDataText="No Record(s) Found" AutoGenerateSelectButton="True" ForeColor="Black" ShowHeader="true">
                            <Columns>
                                <asp:BoundField DataField ="Registration_No" HeaderText="MrNo" HeaderStyle-CssClass="align-right"  >
                                    <HeaderStyle CssClass="header" />
                                    <ItemStyle HorizontalAlign="left" CssClass="row" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Registration_Date" HeaderText=" Registration Date" HeaderStyle-CssClass="align-left" DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="False">
                                    <HeaderStyle CssClass="header" /> 
                                    <ItemStyle HorizontalAlign ="left" CssClass="row" />
                                </asp:BoundField>
                                <asp:BoundField DataField="First_Name" HeaderText="First Name" HeaderStyle-CssClass="align-left" >
                                    <HeaderStyle CssClass="header" />
                                    <ItemStyle HorizontalAlign ="left" CssClass="row" />
                                </asp:BoundField>
                                <asp:BoundField DataField="PatientOf_Name" HeaderText="Guardian" HeaderStyle-CssClass="align-left" >
                                    <HeaderStyle CssClass="header" />
                                    <ItemStyle HorizontalAlign ="Left" CssClass="row" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Father_Name" HeaderText="Guardian Name" HeaderStyle-CssClass="align-left" >
                                    <HeaderStyle CssClass="header" />
                                    <ItemStyle HorizontalAlign ="left" CssClass="row" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Age" HeaderText="Age" HeaderStyle-CssClass="align-left" >
                                    <HeaderStyle CssClass="header" />
                                    <ItemStyle HorizontalAlign ="left" CssClass="row" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Present_Area_Name" HeaderText="Present Area" HeaderStyle-CssClass="align-left" >
                                    <HeaderStyle CssClass="header" />
                                    <ItemStyle HorizontalAlign ="Left" CssClass="row" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Mobile_1" HeaderText="Mobile#1" HeaderStyle-CssClass="align-left">
                                    <HeaderStyle CssClass="header" />
                                    <ItemStyle HorizontalAlign ="Center" CssClass="row" />
                                </asp:BoundField>
                            </Columns>

                            <HeaderStyle CssClass="header"></HeaderStyle>

                            <PagerStyle CssClass="pager"></PagerStyle>

                            <RowStyle CssClass="rows"></RowStyle>
                            </asp:GridView>
                    </div>
		
		</div>
		<hr />			
            <Table border="0" width="100%">
                <td>
                    <td><h2>Patient Registration</h2></td>
                    <td><asp:Button runat="server" ID="btn_Clear"  CssClass="btn btn-blue" style="width:100%;" Text="Clear" ValidationGroup="PatientRegistration" OnClick="btn_Clear_Click1" /></td>
                </td>
            </Table>
		<br/>
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
                      <div class="form-inline">
                            <div class="form-group">
                                <asp:Label runat="server" ID="lblMrNo" style="font-weight:bold;font-size:12px;color:red;float:left">MR Number:</asp:Label>
                                <div class ="col-md-4  ">
                                <%--<asp:TextBox runat="server" ID="txtMrNo" type="text" placeholder="MR Number" style="font-size:12px;" CssClass="form-control"></asp:TextBox>--%>
                                <asp:Label runat ="server" ID="lblPatientMrNo" style="font-size:12px;background-color:#F0F0F0;width:200px;margin-left:1px;font-weight:bold" CssClass="form-control" ></asp:Label>
                            </div>
                        </div>
                            <div class="form-group">
                                <asp:Label runat="server" ID="Label2" style="font-weight:bold;font-size:12px;color:red;float:left;">Token #:</asp:Label>
                               <div class ="col-md-4  ">
                                <%--<asp:TextBox runat="server" ID="txtToken" type="text" placeholder="Token Number" style="font-size:12px;" CssClass="form-control"></asp:TextBox>--%>
                                <asp:Label runat="server" ID="lblPatientToken" style="font-size:12px;background-color:#F0F0F0;width:200px;margin-left:10px;font-weight:bold" CssClass="form-control"></asp:Label>
                            </div>
                        </div>
                            <div class="form-group">
                                <asp:Label runat="server" ID="lblRegistrationDate" style="font-weight:bold;font-size:12px;color:red;float:left;">Regd Date:</asp:Label>
                                 <div class="col-md-4">
                                <%--<asp:TextBox runat="server" ID="txtRegtDate" type="text" placeholder="Registration Date" CssClass="form-control" style="font-size:12px;"></asp:TextBox>--%>
                                <asp:Label runat="server" ID="lblPatientRegistrationDate" style="font-size:12px;background-color:#F0F0F0;width:200px;margin-left:20px;font-weight:bold" CssClass="form-control"></asp:Label>
                            </div>
                        </div>
                     </div>
                        
                    </div>
                </div>
                <div class="panel panel-primary" data-collapsed ="0">
                    <div class="panel-heading" style="background-color:#2E3192; color:whitesmoke;">
                        <div class="panel-title" style="font-family:Arial;">
                            Personal Information
                        </div>
                        <div class="panel-options">
							<a href="#" data-rel="collapse"><i class="entypo-down-open"></i></a>
							<a href="#" data-rel="reload"><i class="entypo-arrows-ccw"></i></a>
						 <!--	<a href="#" data-rel="close"><i class="entypo-cancel"></i></a>!-->
						</div>
                      </div>
                        <div class="panel-body">
                          <div class="row">
                     <div class="form-inline">
                            <div class="form-group">
                                <asp:Label runat="server" ID="Label4" CssClass="control-label" style="font-weight:bold;font-size:12px;color:red;float:left">Suffix:</asp:Label>
                                <div class ="col-md-3">
                                <asp:DropDownList ID="ddSuffix" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:150px;margin-left:15px;" AppendDataBoundItems="true">
                                            <asp:ListItem Text="Select Suffix" Value="0"></asp:ListItem>
								</asp:DropDownList>
                            </div>
                        </div>
                            <div class="form-group">
                                <asp:Label runat="server" ID="Label11" CssClass="control-label" style="font-weight:bold;font-size:12px;color:red;float:left;">First Name:</asp:Label>
                               <div class ="col-md-3 inputGroupContainer">
                                   <div class="input-group">
                                       <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                       <asp:TextBox runat="server" type="text" CssClass="form-control" ID="txtFirstName" placeholder="First Name" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:150px;" ></asp:TextBox>
                                   </div>
                                <%--<asp:TextBox runat="server" ID="txtToken" type="text" placeholder="Token Number" style="font-size:12px;" CssClass="form-control"></asp:TextBox>--%>
                                
                            </div>
                                
                        </div>
                            <div class="form-group">
                                <asp:Label runat="server" CssClass="control-label" ID="Label13" style="font-weight:bold;font-size:12px;color:blue;float:left;">Last Name:</asp:Label>
                                 <div class="col-md-3 inputGroupContainer">
                                  <div class="input-group">
                                      <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                      <asp:TextBox runat="server" type="text" CssClass="form-control" ID="txtMiddleName" placeholder="Middle Name" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:120px;"></asp:TextBox>
                                  </div>  
                            </div>
                        </div>
                         <div class="form-group">
                                    <asp:label runat="server" for="field-2" ID="Label9" style="font-weight:bold;font-size:12px;color:red;float:left;">Guardian</asp:label>
                                    <div class="col-md-3">
                                    <asp:DropDownList ID="ddGurdian" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:150px;" AppendDataBoundItems="true">
                                        <asp:ListItem Text="Select Guardian" Value="0">Select Guardian</asp:ListItem>
								    </asp:DropDownList>
                                </div>
                                </div>
                                
                     </div>
                         <!-- <div class="form-inline">
                            <div class="form-group">
                                <asp:label runat="server" for="field-2"  ID="lblLastName" style="font-weight:bold;font-size:12px;color:blue;float:left;">Last Name:</asp:label>
                              <div class="col-md-3">
                                  <asp:TextBox runat="server" type="text" CssClass="form-control" ID="txtLastName" placeholder="Last Name" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:150px;"></asp:TextBox>
                              </div>
                            </div>
                            </div>-->
                            <div class="form-inline">
                                    
                                    <div class="form-group">
                                        <asp:Label runat="server" ID="lblFatherName" style="font-weight:bold;font-size:12px;color:red;float:left">Fthr/Hus:</asp:Label>
                                        <div class="col-md-3 inputGroupContainer">
                                            <div class="input-group">
                                                 <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                                <asp:TextBox runat="server" type="text" CssClass="form-control" ID="txtFatherName" placeholder="Father Name" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:112px;"></asp:TextBox>
                                            </div>  
                                        </div>
                                        </div> 
                                <div class="form-group">
                                    <asp:label runat="server" for="field-2" ID="lblReligion" style="font-weight:bold;font-size:12px;color:red;float:left;">Religion:</asp:label>
                                    <div class="col-md-3">
                                    <asp:DropDownList ID="ddReligion" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:188px;margin-left:12px;" AppendDataBoundItems="true">
                                            <asp:ListItem Text="Select Religion" Value="0"></asp:ListItem>
                                           
								</asp:DropDownList>
                                
                                </div>
                                </div> 
                                    <div class="form-group">
                                         <asp:Label runat="server" ID="lblGender" class="control-label " style="width: 83px; font-weight:bold;font-size:12px;color:red;float:left">Gender:</asp:Label>
                                         <div style="float:left;">
                     
                                                    <label class="radio-inline">
                                                    <asp:RadioButton GroupName="Gender" ID="rbnMale" runat="server" Text="Male" Checked style="font-weight:bold;font-size:10px;"/>
                                                    </label>
                                           
                                                   <label class="radio-inline" style="margin-left:0px;">
                                                   <asp:RadioButton GroupName="Gender" ID="rbnFemale"  runat="server" Text="Female" style="font-weight:bold;font-size:10px;" />
                                                  </label>
                                            
                                        </div>
                                    </div>
                                <div class="form-group">
                                        <asp:label runat="server" for="field-2" ID="lblMaritialStatus" style="font-weight:bold;font-size:12px;color:red;float:left;;margin-left:40px;">Maritial St:</asp:label>
                                        <div class="col-md-3">
                                    <asp:DropDownList ID="ddMaritialStatus" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:150px;margin-left:8px;" AppendDataBoundItems="true" >
                                            <asp:ListItem Text="Select Maritial Status" Value="0"></asp:ListItem>
                                             <asp:ListItem Text="Single" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Married" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Divorce" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Widow" Value="4"></asp:ListItem>
                                            <asp:ListItem Text="Orphan" Value="5"></asp:ListItem>
                                            <asp:ListItem Text="Disabled" Value="5"></asp:ListItem>
								</asp:DropDownList>
                                         
                                    </div>
                                </div>
                                    </div>
                               </div>
                               <div class="form-inline">
                                  
                                    
                            </div>
                            <div class="form-inline">
                                 
                                    <div class="form-group">
                                    <asp:Label runat="server" ID="lblAge" style="font-weight:bold;font-size:12px;color:red;float:left;">Age:</asp:Label>
                                     <div style="   width: 207px;  float: left; padding-left: 19px;">
                                       <asp:TextBox runat="server" ID="txtAge" type="text" CssClass="form-control" placeholder="Year" Height="100%" style="width: 80px;font-size:12px;background-color:#F0F0F0;" onKeyUp="CalculateAge(this)">0</asp:TextBox>   
                                     <asp:TextBox runat="server" ID="txtAgeMonth" type="text" CssClass="form-control" placeholder="Month" Height="100%" style="    width: 67px;font-size:12px;background-color:#F0F0F0;">0</asp:TextBox>
                                     </div>
                                </div>
                                <!--<div class="form-group">
                                    <asp:Label runat="server" ID="Label6" style="font-weight:bold;font-size:12px;color:red;float:left;">Age Month:</asp:Label>
                                    <div class="col-md-3">
                                        
                                    </div>
                                </div> -->
                                
                                    <div class="form-group">
                                      <asp:Label runat="server" ID="lblDateOfBirth" style="font-weight:bold;font-size:12px;color:blue;float:left;" >DOB:</asp:Label>
                                        <div style="float: left; width: 212px; padding-left: 15px; ">
                                        <asp:TextBox 
                                                runat="server" 
                                                ID="txtDOB" 
                                                type="text"  
                                                Height="100%" 
                                                style="font-size:12px;margin-left:15px;"
                                                Width="159px"
                                                CssClass="form-control"
                                                onChange="CalculateDOB(this)">
                                        </asp:TextBox>
                                        <img style="cursor: hand;border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px"
                                            alt="Data Entry Date"
                                            id="f_trigger_a"
                                            onmouseout="this.style.background=''"
                                            onmouseover="this.style.background='red';"
                                            src="calendar.gif"
                                            title="Date selector" />
     

                                        <script type="text/javascript">
                                            Calendar.setup({
                                                inputField: "txtDOB",
                                                ifFormat: "%d-%b-%Y",
                                                button: "f_trigger_a",
                                                align: "Tl",
                                                singleClick: true
                                            });
                                        </script>

                                         
                                    </div>
                            </div>
                                <div class="form-group">
                                        <asp:Label runat="server" ID="lblCNICNo" style="font-weight:bold;font-size:12px;color:blue;float:left;margin-left:20px;" >CNIC No:</asp:Label>
                                        <div class="col-md-3">
                                       <asp:TextBox runat="server" ID="txtCNICNO" type="text" MaxLength="15" CssClass="form-control" placeholder="CNIC Number Here" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:160px;margin-left:12px;" onKeyUp="CheckTextLength(this,15)" onChange="CheckTextLength(this,15)"></asp:TextBox>
                                          <span id="error" style="color: Red; display: none">* Input digits (0 - 9)</span>
                                        <script type="text/javascript">
                                            function CheckTextLength(text, long) {
                                                var maxlength = new Number(long); // Change number to your max length.
                                                if (text.value.length > maxlength) {
                                                    text.value = text.value.substring(0, maxlength);
                                                    alert(" Only " + long + " characters allowed");
                                                }
                                            }
                                     </script>
                                    </div>
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
                                 <div>
                                    <span id="errorMobileNo" style="color: Red; display: none">* Input digits (0 - 9)</span>
                                    <span id="errorContactNo" style="color: Red; display: none">* Input digits (0 - 9)</span>
                                    <span id="errorMobileNoTwo" style="color: Red; display: none">* Input digits (0 - 9)</span>
                                     <span id="errorRegisterByContactNo" style="color: Red; display: none">* Input digits (0 - 9)</span>
                                </div>
                        <div class="form-inline">
                                <div class="form-group">
                                     <asp:label runat="server" for="field-2"  ID="lblContactNo" style="font-weight:bold;font-size:12px;color:blue;float:left;">Contact No:</asp:label>
                                    <div class="col-md-4">
                                <asp:TextBox runat="server" type="tel" MaxLength="13" size="11" CssClass="form-control" ID="txtContactNo" placeholder="Contact Number" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:150px;margin-left:10px;" onkeypress="return IsNumericContactNo(event);" ondrop="return false;" onpaste="return false;"></asp:TextBox>
                                
                                        <script type="text/javascript">
                                            var specialKeys = new Array();
                                            specialKeys.push(8); //Backspace
                                            function IsNumericContactNo(e) {
                                                var keyCode = e.which ? e.which : e.keyCode
                                                var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1);
                                                document.getElementById("errorContactNo").style.display = ret ? "none" : "inline";
                                                return ret;
                                            }
                                     </script>
                                </div>
                               </div>
                                <div class="form-group">
                                <asp:label runat="server" for="field-2"  ID="lblMobile1" style="font-weight:bold;font-size:12px;color:blue;float:left;">Mobile #1:</asp:label>
                                <div class="col-md-4">
                                <asp:TextBox runat="server" type="tel" size="11" MaxLength="12" CssClass="form-control" ID="txtMobile1" placeholder="Mobile Number" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:150px;margin-left:20px;" onkeypress="return IsNumericMobileNo(event);" ondrop="return false;" onpaste="return false;"></asp:TextBox>
                                     
                                    
                                        <script type="text/javascript">
                                            var specialKeys = new Array();
                                            specialKeys.push(8); //Backspace
                                            function IsNumericMobileNo(e) {
                                                var keyCode = e.which ? e.which : e.keyCode
                                                var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1);
                                                document.getElementById("errorMobileNo").style.display = ret ? "none" : "inline";
                                                return ret;
                                            }
                                     </script>
                                </div>
                            </div>
                                <div class="form-group">
                                <asp:label runat="server" for="field-2"  ID="Label3" style="font-weight:bold;font-size:12px;color:blue;float:left;">Mobile #2:</asp:label>
                                    <div class="col-md-4">
                               <asp:TextBox runat="server" type="tel" size="11" MaxLength="12" CssClass="form-control" ID="txtMobile2" placeholder="Mobile Number" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:150px;margin-left:10px;" onkeypress="return IsNumericMobileNoTwo(event);" ondrop="return false;" onpaste="return false;"></asp:TextBox>
                               
                                        <script type="text/javascript">
                                            var specialKeys = new Array();
                                            specialKeys.push(8); //Backspace
                                            function IsNumericMobileNoTwo(e) {
                                                var keyCode = e.which ? e.which : e.keyCode
                                                var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1);
                                                document.getElementById("errorMobileNoTwo").style.display = ret ? "none" : "inline";
                                                return ret;
                                            }
                                     </script>
                                </div>
                            </div>
                            <div class="form-group">
                                        <asp:Label runat="server" ID="lblRegisterRelation" style="font-weight:bold;font-size:12px;color:blue;float:left;">Attdant Rel:</asp:Label>
                                        <div class="col-md-3">
                                         <asp:DropDownList  runat="server" ID="ddRegisterRelation" class="form-control" Width="100%" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:130px;" AppendDataBoundItems="true"  AutoPostBack="true">   
								</asp:DropDownList>
                                         
                                    </div>
                                </div>
                        </div>
                            <div class="form-inline">
                                
                                    
                                
                                    <div class="form-group">
                                    <asp:Label runat="server" ID="lblRegisterBy" style="font-weight:bold;font-size:12px;color:blue;float:left;">Attdant By:</asp:Label>
                                        <div class="col-md-4">
                                    <asp:TextBox runat="server" ID="txtRegisterBy" type="text" CssClass="form-control" placeholder="Register By Person Name" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:150px;margin-left:16px;"></asp:TextBox>
                                     
                                    </div>
                                </div>
                                
                                    <div class="form-group">
                                       <asp:Label runat="server" ID="Label7" style="font-weight:bold;font-size:12px;color:blue;float:left;" >Attdant No:</asp:Label>
                                        <div class="col-md-4">
                                       <asp:TextBox runat="server" ID="txtRegisterByContactNo" MaxLength="12" type="text" CssClass="form-control" placeholder="Register By Person Contact Number" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:150px;margin-left:12px;" onkeypress="return IsNumericRegisterByContactNo(event);" ondrop="return false;" onpaste="return false;"></asp:TextBox>
                                        
                                        <script type="text/javascript">
                                            var specialKeys = new Array();
                                            specialKeys.push(8); //Backspace
                                            function IsNumericRegisterByContactNo(e) {
                                                var keyCode = e.which ? e.which : e.keyCode
                                                var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1);
                                                document.getElementById("errorRegisterByContactNo").style.display = ret ? "none" : "inline";
                                                return ret;
                                            }
                                     </script>
                                    </div>
                                </div>
                                
                            </div>
                            
                        </div>
               
                      </div>
                <script>
                    function FillPermanentAddress(f) {
                        if (document.getElementById("addresstoo").checked == true) {
                           
                            document.getElementById("ddlPermanentCity").value = document.getElementById("ddlCity").value
                            document.getElementById("ddlPermanentProvince").value =document.getElementById("ddlProvince").value;
                            document.getElementById("ddlPermanentCountry").value = document.getElementById("ddlCountry").value;
                            document.getElementById("ddPermanentArea").value = document.getElementById("ddlArea").value;
                            document.getElementById("txtPermanentBlock").value = document.getElementById("txtAddress").value;
                        }
                    }
                </script>
                <div class="panel panel-primary" data-collapsed="0">
                    <div class="panel-heading" style="background-color:#2E3192; color:whitesmoke;">
                    <div class="panel-title" style="font-family:Arial;">
                        Present Address
                    </div>
                        <div class="panel-options">
							<a href="#" data-rel="collapse"><i class="entypo-down-open"></i></a>
							<a href="#" data-rel="reload"><i class="entypo-arrows-ccw"></i></a>
							<!--<a href="#" data-rel="close"><i class="entypo-cancel"></i></a>!-->
						</div>
                    </div>
                    <div class="panel-body">
                        <div class="form-inline">
                                           <div class="form-group">
                                        <asp:Label runat="server" ID="lblCity" style="font-weight:bold;font-size:12px;color:red;float:left;">City:</asp:Label>
                                               <div class="col-md-4">
                                         <asp:DropDownList ID="ddlCity" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:150px;margin-left:50px;">
                                            <asp:ListItem Text="Karachi" Value="0"></asp:ListItem>
								</asp:DropDownList>
                                    </div>
                                       </div>
                                        
                                              <div class="form-group">
                                        <asp:Label runat="server" ID="lblProvince" style="font-weight:bold;font-size:12px;color:red;float:left;">Province:</asp:Label>
                                                  <div class="col-md-4">
                                         <asp:DropDownList ID="ddlProvince" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:150px;margin-left:8px;">
                                            <asp:ListItem Text="Sindh" Value="0"></asp:ListItem>
								</asp:DropDownList>
                                    </div>
                                        </div>
                                        
                                            <div class="form-group">
                                        <asp:Label runat="server" ID="Label1" style="font-weight:bold;font-size:12px;color:red;float:left;">Country:</asp:Label>
                                                <div class="col-md-4">
                                         <asp:DropDownList ID="ddlCountry" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:150px;margin-left:8px;">
                                            <asp:ListItem Text="Pakistan" Value="0"></asp:ListItem>
								</asp:DropDownList>
                                    </div>
                                        </div>
                             <div class="form-group">
                                                    <asp:Label runat="server" ID="Label8" style="font-weight:bold;font-size:12px;color:red;float:left;margin-left:21px;">Area:</asp:Label>
                                                   <div class="col-md-4">
                                                    <asp:DropDownList ID="ddlArea" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:150px;margin-left:30px;" AppendDataBoundItems="true">
                                                     <asp:ListItem Text="Select Area" Value="0"></asp:ListItem>
								                    </asp:DropDownList>
                                               </div>
                                           </div>
                                          
                            </div>
                                       <div class ="form-inline">
                                           
                                              
                                               <div class="form-group">
                                                    
                                                   <asp:Label runat="server" ID="lblAddress" style="font-weight:bold;font-size:12px;color:blue;float:left;">Address:</asp:Label>
                                                   <div class="col-md-6">
                                                   <asp:TextBox runat="server" ID="txtAddress" CssClass="form-control"  style="font-size:12px;background-color:#F0F0F0;width:150px;margin-left:25px;" placeholder="Adress"></asp:TextBox>
                                               </div>
                                          </div>
                                       </div>
                                 <div class="row">
                                     <div class="col-md-12">
                                         <div class="checkbox">
                                         <label><input type="checkbox" id="addresstoo" value="" onclick="FillPermanentAddress()"/>Same As Above</label>
                                         </div>
                                     </div>
                                 </div>
                    </div>
                </div>                <div class="panel panel-primary" data-collapsed="0">
                    <div class="panel-heading" style="background-color:#2E3192; color:whitesmoke;">
                    <div class="panel-title" style="font-family:Arial;">
                        Permanent Address
                    </div>
                        <div class="panel-options">
							<a href="#" data-rel="collapse"><i class="entypo-down-open"></i></a>
							<a href="#" data-rel="reload"><i class="entypo-arrows-ccw"></i></a>
							<!--<a href="#" data-rel="close"><i class="entypo-cancel"></i></a>!-->
						</div>
                    </div>
                    <div class="panel-body">
                       
                                       <div class="form-inline">
                                       
                                           <div class="form-group">
                                        <asp:Label runat="server" ID="lblPermanentCity" style="font-weight:bold;font-size:12px;color:blue;float:left">City:</asp:Label>
                                        <div class="col-md-4">
                                         <asp:DropDownList ID="ddlPermanentCity" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:150px;margin-left:50px;">
                                            <asp:ListItem Text="Karachi" Value="0"></asp:ListItem>
                                           <%-- <asp:ListItem Text="Karachi" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Hyderabad" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Sukkur" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="MirPurKhas" Value="4"></asp:ListItem>
                                            <asp:ListItem Text="Sakhru" Value="5"></asp:ListItem>
                                            <asp:ListItem Text="Others" Value="6"></asp:ListItem>--%>
								</asp:DropDownList>
                                    </div>
                                       </div>
                                        
                                              <div class="form-group">
                                                  
                                        <asp:Label runat="server" ID="lblPermanentProvince" style="font-weight:bold;font-size:12px;color:blue;float:left;">Province:</asp:Label>
                                                  <div class="col-md-4">
                                         <asp:DropDownList ID="ddlPermanentProvince" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:150px;margin-left:8px;">
                                            <asp:ListItem Text="Sindh" Value="0"></asp:ListItem>
                                           <%-- <asp:ListItem Text="Sindh" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Punjab" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Balochistan" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="KPK" Value="4"></asp:ListItem>--%>
								</asp:DropDownList>
                                    </div>
                                        </div>
                                        
                                            <div class="form-group">
                                        <asp:Label runat="server" ID="lblPermanentCountry" style="font-weight:bold;font-size:12px;color:blue;float:left;">Country:</asp:Label>
                                                <div class="col-md-4">
                                         <asp:DropDownList ID="ddlPermanentCountry" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:150px;margin-left:8px;">
                                            <asp:ListItem Text="Pakistan" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                        </div>
                                           <div class="form-group">
                                                   <asp:Label runat="server" ID="lblPermanentAddress" style="font-weight:bold;font-size:12px;color:blue;float:left;margin-left:21px;">Area:</asp:Label>
                                                   <div class="col-md-4">
                                                    <asp:DropDownList ID="ddPermanentArea" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:150px;margin-left:50px;margin-left:30px;" AppendDataBoundItems="true">
                                                    <asp:ListItem Text="Select Area" Value="0"></asp:ListItem>
								                    </asp:DropDownList>
                                               </div>
                                           </div>
                                        </div>
                                       <div class="form-inline">
                                           
                                               
                                           
                                               <div class="form-group">
                                                    <asp:Label runat="server" ID="lblPermanentBlock" style="font-weight:bold;font-size:12px;color:blue;float:left;">Address:</asp:Label>
                                                   <div class="col-md-4">
                                                   <asp:TextBox runat="server" ID="txtPermanentBlock" CssClass="form-control"  style="font-size:12px;background-color:#F0F0F0;width:150px;margin-left:25px;" placeholder="Address"></asp:TextBox>
                                               </div>
                                           </div>
                                           
                                       </div>
                </div>
                    </div>
                </div>
                    
                <div class="panel panel-primary" data-collapsed="0">
                    <div class="panel-heading" style="background-color:#2E3192; color:whitesmoke;">
                    <div class="panel-title" style="font-family:Arial;">
                        Services
                    </div>
                        <div class="panel-options">
							<a href="#" data-rel="collapse"><i class="entypo-down-open"></i></a>
							<a href="#" data-rel="reload"><i class="entypo-arrows-ccw"></i></a>
							<!--<a href="#" data-rel="c lose"><i class="entypo-cancel"></i></a>!-->
						</div>
                    </div>
                    <div class="panel-body">
                        <div class="form-inline">
                        
                            <div class="form-group">
                                <asp:Label runat="server" ID="lblServices" style="font-weight:bold;font-size:12px;color:blue;float:left;">Services:</asp:Label>
                                <div class ="col-md-4">
                                <asp:DropDownList ID="ddlServices" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:200px;" AutoPostBack="true" OnSelectedIndexChanged="ddlServices_SelectedIndexChanged" AppendDataBoundItems="true" ViewStateMode="Enabled" >
                                            <asp:ListItem Text="Select Services" Value="0"></asp:ListItem>
								</asp:DropDownList>
                            </div>
                        </div>
                        
                            <div class="form-group">
                                <asp:Label runat="server" ID="Label5" style="font-weight:bold;font-size:12px;color:blue;float:left;margin-left:1px;">Details:</asp:Label>
                                <div class="col-md-6">
                                <asp:DropDownList ID="ddServicesDetail" runat="server" class="form-control" Width="100%" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:200px;" AutoPostBack="true" OnSelectedIndexChanged="ddServicesDetail_SelectedIndexChanged" >
                                            <asp:ListItem Text="Select Details" Value="0"></asp:ListItem>
								</asp:DropDownList>

                            </div>
                        </div>
                           <div class="form-group">
                                        <asp:Label runat="server" ID="lblStatus" style="font-weight:bold;font-size:12px;color:blue;float:left;">Status:</asp:Label>
                                         <div class="col-md-6">
                                        <asp:DropDownList runat="server" ID="ddPatientPayingStatus" CssClass="form-control" Width="100%" Height="100%" style="font-size:12px;background-color:#F0F0F0;width:100px;" AutoPostBack="true" OnSelectedIndexChanged="ddPatientPayingStatus_SelectedIndexChanged">
                                            <asp:ListItem Text="Select Paying Status" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                                         
                                <div class="form-group">
                                    <asp:Label runat="server" ID="Label15" style="font-weight:bold;font-size:12px;color:blue;float:left;">Charges:</asp:Label>
                                    <div class="col-md-3">
                                    <asp:Label runat="server" ID="lblServiceCharges" CssClass="form-control" style="font-size:12px;background-color:#F0F0F0;width:65px;"></asp:Label>
                                </div>
                                <div class="col-md-3">
                                    <asp:Button runat="server" ID="btnAdd"  style="width:55px;margin-left:15px;" Text="Add " OnClick="btnAdd_Click"  CssClass="btn btn-block" />
                                </div>
                            </div>      
                            </div>
                         <div class="form-inline">                        
                                 
                                <div class="form-group">
                                    <div class="col-md-3">
                                    
                                </div>
                            </div>               
                            </div>
                        <div class="row">
                                <div class="col-md-12">
                                    <asp:GridView ID="gvServiceDetail" runat="server" CssClass="table" style="font-size:12px;font-weight:900" AutoGenerateColumns="False" EmptyDataText="No Service Added" ForeColor="White" OnRowDeleting="gvServiceDetail_RowDeleting" OnRowDataBound="gvServiceDetail_RowDataBound" ShowFooter="True">
                                  <Columns>
                                     <asp:BoundField DataField ="sysTicketDetailNo" HeaderText="SNo"  HeaderStyle-BackColor="#599adb" >
                                    <ItemStyle CssClass="hideCol" />
                                     <HeaderStyle CssClass="hideCol" />
                                     <FooterStyle CssClass="hideCol" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Service_Code" HeaderText="Service Code"  HeaderStyle-BackColor="#599adb">
                                    <ItemStyle CssClass="hideCol" />
                                    <FooterStyle CssClass="hideCol" />                                    
                                    <ControlStyle BackColor="Violet"></ControlStyle>
                                     <HeaderStyle CssClass="hideCol" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Service_DetailNo" HeaderText="Service Detail No"  HeaderStyle-BackColor="#599adb">
                                    <ItemStyle CssClass="hideCol" />
                                     <HeaderStyle CssClass="hideCol" />
                                     <FooterStyle CssClass="hideCol" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Service_Name" HeaderText="Service" HeaderStyle-BackColor="#599adb" HeaderStyle-CssClass="text-center">
                                    <HeaderStyle BackColor="#599adb" CssClass="align-left"></HeaderStyle>
                                    <ItemStyle HorizontalAlign ="left" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="Service_DetailName" HeaderText="Name"  HeaderStyle-BackColor="#599adb" >
                                    <HeaderStyle BackColor="#599adb" CssClass="align-left"></HeaderStyle>
                                    <ItemStyle HorizontalAlign ="left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Charges" HeaderText="Charges"  HeaderStyle-BackColor="#599adb" HeaderStyle-CssClass="text-right">
                                    <HeaderStyle BackColor="#599adb"></HeaderStyle>
                                    <ItemStyle HorizontalAlign ="right" />    
                                </asp:BoundField>
                                       <asp:CommandField ButtonType="Image" HeaderText="Remove" DeleteImageUrl="~/Images/DeleteHS.png" DeleteText="Remove"
                                              ShowDeleteButton="True" HeaderStyle-BackColor="#599adb" >
                                       <HeaderStyle BackColor="#599adb"></HeaderStyle>
                                </asp:CommandField>
                                </Columns>
                                    <FooterStyle BackColor="#CCCCCC" HorizontalAlign="Right"/>
                                    <HeaderStyle Font-Bold="True" />
                                </asp:GridView>
                                </div>
                                
                                
                                
                            </div>
                        <span style="color:red;font-size:15px;margin-left:50%"><asp:Literal runat="server" ID="lblErrMsg"></asp:Literal></span>
                        </div>
                             <br />                  
                        <div class="row">
                            <div class="col-md-4">
                              <div id="dialog-confirm">
                                <div id ="content">
                                    
                                </div>
                                  </div>
                                <asp:Label runat="server" CssClass="hideCol" ID="Label14"></asp:Label>
                                 <asp:Label runat="server" CssClass="hideCol" ID="lblSrNo"></asp:Label>
                                <asp:Label runat="server" CssClass="hideCol" ID="lblTicketNo"></asp:Label>  
                                <asp:Button runat="server" ID="btn_Submit"  CssClass="btn btn-blue" style="width:100%;" OnClick="btn_Submit_Click"  ValidationGroup="PatientRegistration" OnClientClick="return patientValid();" />
                                <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                            </div>
                           <%-- <div class="col-md-6">
                                <asp:Button runat="server" ID="btn_Update" CssClass="btn btn-black" style="width:100%;" Text="Update Patient" ValidationGroup="PatientRegistration" OnClick="btn_Update_Click" />
                            </div>--%>
                            <div class="col-md-4 col-md-offset-4"">
                                <asp:Button runat="server" ID="btn_Cancel" CssClass="btn btn-blue" style="width:100%;" Text="Cancel" ValidationGroup="PatientRegistration" />
                                <asp:Label runat="server" ID="lblstn" CssClass="hideCol"></asp:Label>
                                <asp:Label runat="server" ID="lblTicketDate" CssClass="hideCol"></asp:Label>
                            </div>
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
</html>
