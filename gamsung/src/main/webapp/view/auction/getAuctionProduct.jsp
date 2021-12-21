<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<link rel="stylesheet" href="/resources/css/animate.css">
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/css/custom.css">
    <link rel="stylesheet" href="/resources/css/flashy.min.css">
    <link rel="stylesheet" href="/resources/css/flaticon.css">
    <link rel="stylesheet" href="/resources/css/font-awesome.min.css">
    <link rel="stylesheet" href="/resources/css/magnific-popup.css">
    <link rel="stylesheet" href="/resources/css/pogo-slider.min.css">
    <link rel="stylesheet" href="/resources/css/responsive.css">
    <link rel="stylesheet" href="/resources/css/responsiveslides.css">
    <link rel="stylesheet" href="/resources/css/style.css">
    <link rel="stylesheet" href="/resources/css/timeline.css">  

<title>${auctionProduct.auctionProductName}</title>
</head>
<body>
	<jsp:include page="../common/header.jsp"></jsp:include>
	
	<div id="contact" class="contact-box" style="background: #f7f7f7;">
		<div class="container">
			<div class="row">
				<div class="col-lg-7 col-sm-7 col-xs-12">
				  <div class="contact-block">
					<form id="contactForm">
					  <div class="row">
						<div class="col-md-12 center">
							<div class="form-group text-center"> 
								<img src="/uploadfiles/auctionimg/product/${auctionProduct.productImg1}" width="440px" height="440px">
								<div class="help-block with-errors"></div>
							</div>
							<div class="submit-button text-center">
								<img src="/uploadfiles/auctionimg/product/${auctionProduct.productImg2}" width="100px" height="100px">
								<img src="/uploadfiles/auctionimg/product/${auctionProduct.productImg3}" width="100px" height="100px">
								<img src="/uploadfiles/auctionimg/product/${auctionProduct.productImg4}" width="100px" height="100px">
								<img src="/uploadfiles/auctionimg/product/${auctionProduct.productImg5}" width="100px" height="100px">
								
							</div>
						</div>
					  </div>            
					</form>
				  </div>
				</div>


				<div class="col-lg-5 col-sm-5 col-xs-12">
					<div class="left-contact">
						<div class="media cont-line">
							<div class="media-body dit-right">
								<h4>registrant info</h4>
								<a href="#">12345 67890</a><br>
								<a href="#">12345 67890</a>
							</div>
						</div>
						<div class="media cont-line">
							<div class="media-body dit-right">
								<h4>product info</h4>
								<a>��ǰ�� : ${auctionProduct.auctionProductName }</a><br>
								<a>���۰� : ${auctionProduct.startBidPrice }</a><br>
								<a>��� ������ : ${auctionProduct.hopefulBidPrice }</a><br>
								<a>���� ���� : ${auctionProduct.bidUnit }</a><br>
								<a>���� ���� ��� : ${auctionProduct.bidableGrade }</a>								
							</div>
						</div>
					</div>
				</div>

			</div>
			<div class="col-lg-5 col-sm-5 col-xs-12">
				<div class="submit-button text-center">
					<img src="/uploadfiles/auctionimg/product/${auctionProduct.auctionProductDatailA}" >
					<img src="/uploadfiles/auctionimg/product/${auctionProduct.auctionProductDatailB}" >		
				</div>
			</div>
		</div>
	</div>
</body>

	<script src="/resources/javascript/bootstrap.min.js"></script>
	<script src="/resources/javascript/contact-form-script.js"></script>
	<script src="/resources/javascript/custom.js"></script>
	<script src="/resources/javascript/form-validator.min.js"></script>
	<script src="/resources/javascript/images-loded.min.js"></script>
	<script src="/resources/javascript/isotope.min.js"></script>
	<script src="/resources/javascript/jquery.magnific-popup.min.js"></script>
	<script src="/resources/javascript/jquery.min.js"></script>
	<script src="/resources/javascript/jquery.pogo-slider.min.js"></script>
	<script src="/resources/javascript/popper.min.js"></script>
	<script src="/resources/javascript/responsiveslides.min.js"></script>
	<script src="/resources/javascript/slider-index.js"></script>
	<script src="/resources/javascript/smoothscroll.js"></script>

</html>