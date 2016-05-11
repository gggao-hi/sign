<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge;charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>Home face</title>

<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="css/sb-admin.css" rel="stylesheet">

<!-- Morris Charts CSS -->
<link href="css/plugins/morris.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet"
	type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<%
	String teachername = new String(request.getParameter("teacher").getBytes("ISO-8859-1"), "utf-8");
	String teachernumber = request.getParameter("num");
%>
</head>

<body onload="initCourse();">

	<div id="wrapper" style="height: 1400px;">

		<!-- Navigation -->
		<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-ex1-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>

			</div>
			<!-- Top Menu Items -->
			<ul class="nav navbar-right top-nav">

				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" id="teachername"><i class="fa fa-user"></i><%=teachername%><b
						class="caret"></b></a>
					<ul class="dropdown-menu">

						<li><a href="index.html"><i class="fa fa-fw fa-power-off"></i>
								Log Out</a></li>
					</ul></li>
			</ul>

			<div class="collapse navbar-collapse navbar-ex1-collapse">
				<!-- 左侧树形菜单 -->
				<ul class="nav navbar-nav side-nav">
					<li><a href="javascript:;" data-toggle="collapse"
						data-target="#qrcode"><i class="fa fa-fw fa-arrows-v"></i>课程二维码<i
							class="fa fa-fw fa-caret-down"></i></a>
						<ul id="qrcode" class="collapse">

						</ul></li>
					<li><a href="javascript:;" data-toggle="collapse"
						data-target="#room"><i class="fa fa-fw fa-table"></i>教室定位<i
							class="fa fa-fw fa-caret-down"></i></a>
						<ul id="room" class="collapse">
						</ul></li>

					<li><a onclick='showabsenteeism()' style='cursor: pointer;'><i
							class="fa fa-fw fa-bar-chart-o"></i> 出勤统计</a></li>


					<li><a href="javascript:;" data-toggle="collapse"
						onclick="addCourseClick();" data-target="#addcourse"><i
							class="fa fa-fw fa-edit"></i>添加课程<i
							class="fa fa-fw fa-caret-down"></i></a>
						<ul id="addcourse" class="collapse">
						</ul></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</nav>

		<div id="page-wrapper" style="height: 100%;">

			<div class="container-fluid" style="height: 99.8%;">


				<div class="col-lg-12 col-md-12"
					style="height: 99.8%; position: relative;">
					<div class="panel panel-default"
						style="height: 99.8%; position: relative;">
						<div class="panel-heading">
							<h3 class="panel-title"></h3>
						</div>
						<div class="panel-body" style="height: 99.8%; position: relative;">
							<div class="col-lg-12 col-md-12"
								style="height: 99.8%; position: relative;">
								<iframe id="sidecontent" src="welcome.html"
									style="zoom: 0.6; width: 99.99%; height: 99.8%; position: relative;"
									frameBorder="0" width="99.99%"></iframe>
							</div>
						</div>
					</div>
				</div>

			</div>
			<!-- /.container-fluid -->

		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->

	<!-- jQuery -->
	<script Charset="UTF-8" src="js/jquery.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="js/bootstrap.min.js"></script>

	<!-- Morris Charts JavaScript -->
	<script src="js/plugins/morris/raphael.min.js"></script>
	<script src="js/plugins/morris/morris.js"></script>
	<script src="js/plugins/morris/morris-data.js"></script>
	<script Charset="UTF-8" type="text/javascript">
		var xmlhttp;
		var pid;
		var teachernum =
	<%=teachernumber%>
		;
		function initXmlHttp() {
			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
		};
		//利用Ajax请求后台加载课程数据
		function initCourse() {
			initXmlHttp();

			var teachername = teachernum;
			var url = "qrcode";

			var post = "type=initCourse&teacher=" + teachername;
			post = encodeURI(post);
			post = encodeURI(post); //最重要的部分,两次调用encodeURI ,就是编码两次
			xmlhttp.open("POST", url, true);
			xmlhttp.onreadystatechange = initCourseCallback;
			xmlhttp.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			xmlhttp.send(post);

		};
		//初始化课程， Ajax请求后台返回的数据处理
		function initCourseCallback() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

				var result = xmlhttp.responseXML;
				var course = result.documentElement
						.getElementsByTagName("course");
				for (var i = 0; i < course.length; i++) {
					var name = course[i].getElementsByTagName("name");
					var n = name[0].firstChild.nodeValue;
					var id = course[i].getElementsByTagName("id");
					var d = id[0].firstChild.nodeValue;

					var qrcode = "<li><a id='"
							+ d
							+ "'  onclick='showqrcode(this.id)' style='cursor:pointer;'>"
							+ n + "</a> ";

					$('#qrcode').append(qrcode);
					var room = "<li><a id='"
							+ d
							+ "'  onclick='showLocation(this.id)' style='cursor:pointer;'>"
							+ n + "</a> ";

					$('#room').append(room);

				}

			}

		};
		function addCourseClick() {
			initXmlHttp();
			debugger;
			var teachername = teachernum;
			var url = "qrcode";
			var post = "type=addcourse&teacher=" + teachername;
			post = encodeURI(post);
			post = encodeURI(post); //最重要的部分,两次调用encodeURI ,就是编码两次
			xmlhttp.open("POST", url, true);
			xmlhttp.onreadystatechange = addCourseCallBack;
			xmlhttp.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			xmlhttp.send(post);
		};
		function addCourseCallBack() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

				var result = xmlhttp.responseXML;
				var course = result.documentElement
						.getElementsByTagName("course");
				for (var i = 0; i < course.length; i++) {
					var name = course[i].getElementsByTagName("name");
					var n = name[0].firstChild.nodeValue;
					var id = course[i].getElementsByTagName("id");
					var d = id[0].firstChild.nodeValue;

					var addcourse = "<li><a id='"
							+ d
							+ "'  onclick='addcourse(this.id)' style='cursor:pointer;'>"
							+ n + "</a> ";

					$('#addcourse').append(addcourse);

				}
			}
		}
		function showLocation(id) {
			pid = id;
			var iframeCell = $('#sidecontent');
			var url = "location.html?cid=" + id;
			iframeCell.attr("src", url);

		}
		//显示未签到学生的信息
		function showabsenteeism() {

			var iframeCell = $('#sidecontent');
			var url = "signcount.jsp?cid=" + pid;
			iframeCell.attr("src", url);

		};
		//添加课程
		function addcourse(id) {
			debugger;
			var name = $('#' + id)[0].innerText;
			var iframeCell = $('#sidecontent');
			var url = "addcourse.jsp?cid=" + id + "&cname=" + name;
			iframeCell.attr("src", url);

		};
		function showqrcode(id) {
			initXmlHttp();
			var url = "qrcode";
			pid = id;

			var post = "type=initQrcode&courseid=" + id;
			post = encodeURI(post);
			post = encodeURI(post); //最重要的部分,两次调用encodeURI ,就是编码两次
			xmlhttp.open("POST", url, true);
			xmlhttp.onreadystatechange = initQrcodeCallback;
			xmlhttp.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			xmlhttp.send(post);

		};
		function initQrcodeCallback() {
			debugger;
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

				var uuid = xmlhttp.responseText;

				var iframeCell = $('#sidecontent');
				var url = "qrcode.jsp?id=" + pid + uuid;
				iframeCell.attr("src", url);

			}

		};
	</script>
</body>

</html>
