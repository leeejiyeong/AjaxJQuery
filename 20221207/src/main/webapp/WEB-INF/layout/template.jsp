<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Ajax JQuery Test</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<!-- 폰투 -->
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Dongle&family=Gowun+Batang:wght@400;700&display=swap')
	;

* {
	font-family: 'Dongle', sans-serif;
	font-family: 'Gowun Batang', serif;
}
</style>
</head>

<body>
	<div class="d-flex" id="wrapper">
		<!-- Sidebar-->
		<tiles:insertAttribute name="sidebar"></tiles:insertAttribute>

		<!-- Page content wrapper-->
		<div id="page-content-wrapper">

			<!-- Top navigation-->
			<tiles:insertAttribute name="top"></tiles:insertAttribute>

			<!-- Page content-->
			<tiles:insertAttribute name="body"></tiles:insertAttribute>
			
		</div>
		
	</div>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
</body>
</html>
