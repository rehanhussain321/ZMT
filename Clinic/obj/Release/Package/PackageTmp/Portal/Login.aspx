<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ZMTClinics.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ZMT Login</title>
    <meta charset="utf-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="Neon Admin Panel" />
	<meta name="author" content="" />
	<link rel="stylesheet" href="../assets/js/jquery-ui/css/no-theme/jquery-ui-1.10.3.custom.min.css"/>
	<link rel="stylesheet" href="../assets/css/font-icons/entypo/css/entypo.css"/>
	<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Noto+Sans:400,700,400italic"/>
	<link rel="stylesheet" href="../assets/css/bootstrap.css"/>
	<link rel="stylesheet" href="../assets/css/neon-core.css"/>
	<link rel="stylesheet" href="../assets/css/neon-theme.css"/>
	<link rel="stylesheet" href="../assets/css/neon-forms.css"/>
	<link rel="stylesheet" href="../assets/css/custom.css"/>

	<script src="../assets/js/jquery-1.11.0.min.js"></script>
	<script>$.noConflict();</script>

	<!--[if lt IE 9]><script src="assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
		<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->
</head>
<body class="page-body login-page login-form-fall">
    <form id="form1" runat="server">
    <div class="login-container">
      <div class="login-header login-caret">
       <div class="login-content">
           <h1>ZMT Clinics</h1>
           <p class="description">Welcome to ZMT Clinics</p>
           <img src="../Images/logo.png" class="img-circle" />
           <div class="login-progressbar-indicator">
               
               <span>Logging in...</span>
           </div>
       </div>
    </div>
        <div class="login-progressbar">
            <div></div>
        </div>
        <div class="login-form">
            <div class="login-content">
                <div class="form-login-error">
				<h3>Invalid login</h3>
				<p>Enter <strong>UserName</strong>/<strong>Password</strong> for login.</p>
			</div>
                <div class="form-group">
					
					<div class="input-group">
						<div class="input-group-addon">
							<i class="entypo-user"></i>
						</div>
						
						<asp:textbox runat="server" type="text" class="form-control" name="username" ID="txtusername" placeholder="Username" autocomplete="off" />
					</div>
					
				</div>
                <div class="form-group">
					
					<div class="input-group">
						<div class="input-group-addon">
							<i class="entypo-key"></i>
						</div>
						
						<asp:textbox runat="server" type="password" class="form-control" name="password" ID="txtpassword" placeholder="Password" autocomplete="off" />
					</div>
				
				</div>
                <div class="form-group">
					<asp:button runat="server" ID="btnlogin" type="submit" class="btn btn-primary btn-block btn-login" Text="Login" OnClick="btnlogin_Click">
						
					</asp:button>
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
	<script src="../assets/js/jquery.validate.min.js"></script>
	<script src="../assets/js/neon-login.js"></script>
</body>
</html>
