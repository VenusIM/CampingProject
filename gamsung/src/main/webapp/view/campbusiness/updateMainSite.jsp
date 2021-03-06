<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	

<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="utf-8">

	<!-- Bootstrap, jQuery CDN -->
	<meta name="viewport" content="width=device-width, initial-scale=1">	
	<script src="/resources/lib/jquery/jquery.js"></script>
    <script src="/resources/lib/bootstrap/js/bootstrap.min.js"></script>
  	<script src="/resources/lib/imagesloaded/imagesloaded.pkgd.js"></script>
  	<link rel="stylesheet" href="/resources/lib/bootstrap/css/bootstrap.min.css"></link>  	
  	
  	
  	<!-- ### headerCampBusiness resources Start ### -->
  	<script src="/resources/lib/jquery/jquery.js"></script>
    
    <!-- Favicons -->
    <meta name="msapplication-TileImage" content="/resources/images/favicons/ms-icon-144x144.png">    
    <meta name="msapplication-TileColor" content="#ffffff">  
    <meta name="theme-color" content="#ffffff">
   
    <!-- Stylesheets -->
    
    <!-- Default stylesheets-->
    <link href="/resources/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Template specific stylesheets-->
    <link href="/resources/lib/animate.css/animate.css" rel="stylesheet">
    <link href="/resources/lib/components-font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="/resources/lib/et-line-font/et-line-font.css" rel="stylesheet">
    <link href="/resources/lib/flexslider/flexslider.css" rel="stylesheet">
    <link href="/resources/lib/owl.carousel/dist/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="/resources/lib/owl.carousel/dist/assets/owl.theme.default.min.css" rel="stylesheet">
    <link href="/resources/lib/magnific-popup/magnific-popup.css" rel="stylesheet">
    <link href="/resources/lib/simple-text-rotator/simpletextrotator.css" rel="stylesheet">       
    
    <!-- Main stylesheet and color file-->
    <link href="/resources/css/style.css" rel="stylesheet">
    <link id="color-scheme" href="/resources/css/colors/default.css" rel="stylesheet">  
  	<!-- ### headerCampBusiness resources End ### -->
	
	<!-- CSS -->
	<style>
		body > div.container{
			margin-top: 30px;
		}
		
		.form-horizontal .control-label{
    		text-align: left;
		}
    </style>

	<!-- JavaScript -->
	<script type="text/javascript">

		// ??????
		$(function() {
			
			$("#update").on("click" , function() {
				alert("???????????? ????????? ???????????????.");
				$("form").attr("method" , "POST").attr("action" , "/campBusiness/updateMainSite").attr("enctype","multipart/form-data").submit();
			});
			
			$("#cancle").on("click" , function() {
				alert("????????? ?????? ???????????????.");
				history.go(-1);
			});			
	
		});	

</script>		

</head>

<body>

	<!-- ToolBar -->
	<jsp:include page="/view/common/headerCampBusiness.jsp" />

	<!-- Page Start -->
	<div class="container">
	
	<div class="col-sm-2"></div>
		<div class="col-sm-10">

		<div class="page-header">
	       <h1 class=" text-info">???????????? ??????</h1>
	    </div>

		<!-- Form Start -->
		<form class="form-horizontal" >
		
		<input type="hidden" name="campNo" id="campNo" value="${campSession.campNo}">
		
		<div class="form-group">
			<label for="mainSiteType" class="col-sm-offset-1 col-sm-3 control-label">???????????? ??????</label>
			<div class="col-sm-4">
				<select name="mainSiteType" class="form-control" >
					<option value="????????????" ${! empty mainSite.mainSiteType && mainSite.mainSiteType eq '????????????' ? "selected" : "" }>????????????</option>
					<option value="?????????" ${! empty mainSite.mainSiteType && mainSite.mainSiteType eq '?????????' ? "selected" : "" }>?????????</option>
					<option value="?????????" ${! empty mainSite.mainSiteType && mainSite.mainSiteType eq '?????????' ? "selected" : "" }>?????????</option>
					<option value="?????????" ${! empty mainSite.mainSiteType && mainSite.mainSiteType eq '?????????' ? "selected" : "" }>?????????</option>
					<option value="??????" ${! empty mainSite.mainSiteType && mainSite.mainSiteType eq '??????' ? "selected" : "" }>??????</option>
					<option value="??????????????????" ${! empty mainSite.mainSiteType && mainSite.mainSiteType eq '??????????????????' ? "selected" : "" }>??????????????????</option>
				</select>
			</div>
		</div>
		
		<div class="form-group">
			<label for="mainSiteNo" class="col-sm-offset-1 col-sm-3 control-label">?????? ??????</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="mainSiteNo" name="mainSiteNo" value="${mainSite.mainSiteNo}">
				</div>
		</div>
		
		<div class="form-group">
			<label for="mainSiteRegDate" class="col-sm-offset-1 col-sm-3 control-label">?????? ??????</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="mainSiteRegDate" name="mainSiteRegDate" value="${mainSite.mainSiteRegDate}" readonly>
				</div>
		</div>		
		
		<div class="form-group">
			<label for="mainSiteName" class="col-sm-offset-1 col-sm-3 control-label">???????????? ??????</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="mainSiteName" name="mainSiteName" value="${mainSite.mainSiteName}">
				</div>
		</div>

		<div class="form-group">
			<label for="mainSiteSize" class="col-sm-offset-1 col-sm-3 control-label">???????????? ??????</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="mainSiteSize" name="mainSiteSize" value="${mainSite.mainSiteSize}">
				</div>
		</div>
		
		<div class="form-group">
			<label for="mainSiteSection" class="col-sm-offset-1 col-sm-3 control-label">???????????? ??????(????????????)</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="mainSiteSection" name="mainSiteSection" value="${mainSite.mainSiteSection}">
				</div>
		</div>
		
		<div class="form-group">
			<label for="mainSiteMinCapacity" class="col-sm-offset-1 col-sm-3 control-label">?????? ???????????????</label>
				<div class="col-sm-4">
					<input type="number" class="form-control" id="mainSiteMinCapacity" name="mainSiteMinCapacity" value="${mainSite.mainSiteMinCapacity}">
				</div>
		</div>
		
		<div class="form-group">
			<label for="mainSiteMaxCapacity" class="col-sm-offset-1 col-sm-3 control-label">?????? ???????????????</label>
				<div class="col-sm-4">
					<input type="number" class="form-control" id="mainSiteMaxCapacity" name="mainSiteMaxCapacity" value="${mainSite.mainSiteMaxCapacity}">
				</div>
		</div>
		
		<div class="form-group">
			<label for="mainSiteMinPrice" class="col-sm-offset-1 col-sm-3 control-label">???????????? ??????</label>
				<div class="col-sm-4">
					<input type="number" class="form-control" id="mainSiteMinPrice" name="mainSiteMinPrice" value="${mainSite.mainSiteMinPrice}">
				</div>
		</div>
		
		<div class="form-group">
			<label for="mainSiteAddPrice" class="col-sm-offset-1 col-sm-3 control-label">???????????? ??????</label>
				<div class="col-sm-4">
					<input type="number" class="form-control" id="mainSiteAddPrice" name="mainSiteAddPrice" value="${mainSite.mainSiteAddPrice}">
				</div>
		</div>
		
		<div class="form-group">
			<label for="mainSiteParkingSize" class="col-sm-offset-1 col-sm-3 control-label">???????????? ??????</label>
				<div class="col-sm-4">
					<input type="number" class="form-control" id="mainSiteParkingSize" name="mainSiteParkingSize" value="${mainSite.mainSiteParkingSize}">
				</div>
		</div>
		
		<div class="form-group">
			<label for="mainSiteImgFile1" class="col-sm-offset-1 col-sm-3 control-label">???????????? ?????????(1/3)</label>				
				<div class="col-sm-4">
					<img src="/uploadFiles/campimg/campbusiness/mainSite/${mainSite.mainSiteImg1}" />
					<span>????????????<input type="file"  id="mainSiteImgFile1" name="mainSiteImgFile1" ></span>			
				</div>
		</div>
		
		<div class="form-group">
			<label for="mainSiteImgFile2" class="col-sm-offset-1 col-sm-3 control-label">???????????? ?????????(2/3)</label>				
				<div class="col-sm-4">
					<img src="/uploadFiles/campimg/campbusiness/mainSite/${mainSite.mainSiteImg2}" />
					<span>????????????<input type="file"  id="mainSiteImgFile2" name="mainSiteImgFile2" ></span>			
				</div>
		</div>
		
		<div class="form-group">
			<label for="mainSiteImgFile3" class="col-sm-offset-1 col-sm-3 control-label">???????????? ?????????(3/3)</label>				
				<div class="col-sm-4">
					<img src="/uploadFiles/campimg/campbusiness/mainSite/${mainSite.mainSiteImg3}" />
					<span>????????????<input type="file"  id="mainSiteImgFile3" name="mainSiteImgFile3" ></span>			
				</div>
		</div>
		
		<div class="form-group">
			<label for="mainSiteInfo" class="col-sm-offset-1 col-sm-3 control-label">???????????? ??????</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="mainSiteInfo" name="mainSiteInfo" value="${mainSite.mainSiteInfo}">
				</div>
		</div>

		</form>
		<!-- Form End -->
		
		<br>
		<div class="row">
			<div class="form-group">		
				<div class="col-xs-1 col-xs-offset-1">
					<button id="cancle" type="button" class="btn btn-danger">??????</button>
				</div>
				
				<div class="col-xs-1 col-xs-offset-5">
					<button id="update" type="button" class="btn btn-primary">??????</button>
				</div>			
			</div>
		</div>	
		
	</div>
	
 	</div>
	<!-- Page End -->

</body>

</html>