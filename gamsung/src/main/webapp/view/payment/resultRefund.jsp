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
  	
  	<script type="text/javascript">
  		
	  	$(function() {
			$("#refundOk").on("click" , function() {
				window.location = '/payment/listPayment';
			});
		});			
  	
  	</script>	
  	
	<style>
	    .form-horizontal .control-label{
	        text-align: left;
	    }	    
	</style> 		 		

</head>

<body>
	
	<!-- header -->
	<jsp:include page="/view/common/header.jsp"/>
	<!-- header End -->
	
	<!-- ?????? Controller Start -->  	
  	<input type="hidden" id="viewController" name="viewController" value="${payment.paymentCode}">
  	<!-- ?????? Controller End -->
				
	<!-- ?????? start-->
	<div id="campContainer" class="container">
		
		<br>
		<div class="row">
			<div class="page-header">
				<h4 class="text-info">???????????? ??????</h4>
			</div>					
		</div>
		
		<form id="campForm">
			<input type="hidden" id="campPaymentSender" name="campPaymentSender" value="${payment.paymentSender}">
			<input type="hidden" id="campPaymentReceiver" name="campPaymentReceiver" value="${payment.paymentReceiver}">
			<input type="hidden" id="campPaymentCode" name="campPaymentCode" value="${payment.paymentCode}">
		
				<div class="row">	
					<div class="col-xs-3">	
						<div class="row">
							<div class="image" style="width: 200px; height: 150px; border-radius: 10px; display: flex; justify-content: center; align-items: center">
	                        	<img src="/uploadfiles/campimg/campbusiness/camp/${campReservation.camp.campImg1}" onerror="this.src='/uploadfiles/campimg/campbusiness/camp/no_image.jpg'"  alt="????????? ???????????????" >
	                        </div>			
						</div>						
					</div>
					
					<div class="col-xs-9">					
						<div class="row">							
							<label class="col-xs-2">* ????????????</label>
							<div class="col-xs-3 form-group">
								${campReservation.reservationNo}
							</div>
							<label class="col-xs-2 col-xs-offset-1">* ???????????????</label>
							<div class="col-md-3 form-group">
								${campReservation.reservationRegDate}								
							</div>	
						</div>					
												
						<div class="row">
							<label class="col-xs-2">* ????????????</label>
							<div class="col-md-3 form-group">
								${campReservation.reservationUserName}
							</div>
							<label class="col-xs-2 col-xs-offset-1">* ??????????????????</label>
							<div class="col-md-3 form-group">
								${campReservation.totalPaymentPrice}
							</div>						
						</div>	
							
						<div class="row">
							<label class="col-xs-2">* ????????????</label>
							<div id="campName" data="${campReservation.camp.user.campName}" class="col-md-3 form-group">
								${campReservation.camp.user.campName}
							</div>
							<label class="col-xs-2 col-xs-offset-1">* ??????????????????</label>
							<div class="col-md-3 form-group">
								${campReservation.mainSite.mainSiteType}
							</div>
						</div>		
												
						<div class="row">
							<label class="col-xs-2">* ???????????????</label>
							<div class="col-md-3 form-group">
								${campReservation.reservationStartDate}
							</div>
							<label class="col-xs-2 col-xs-offset-1">* ???????????????</label>
							<div class="col-md-3 form-group">
								${campReservation.reservationEndDate}
							</div>	
						</div>								
					</div>
				</div>
		</form>
	</div>
	<!-- ?????? end-->
			
	<!-- ???????????? start -->	
	<div id="payformContainer" class="container">
		<div class="row">
			<div class="page-header">
				<h4 class="text-info">???????????? ????????????</h4>
			</div>					
		</div>
		
		<form id="payForm">
		
		<!-- camp start -->
		<input type="hidden" id="reservationNo" name="reservationNo" value="${campReservation.reservationNo}">
		<input type="hidden" id="reservationRegDate" name="reservationRegDate" value="${campReservation.reservationRegDate}">
		<input type="hidden" id="reservationStartDate" name="reservationStartDate" value="${campReservation.reservationStartDate}">
		<input type="hidden" id="reservationEndDate" name="reservationEndDate" value="${campReservation.reservationEndDate}">
		<input type="hidden" id="reservationUserName" name="reservationUserName" value="${campReservation.reservationUserName}">	
		<input type="hidden" id="reservationStatus" name="reservationStatus" value="${campReservation.reservationStatus}">
		<input type="hidden" id="camp.user.campName" name="camp.user.campName" value="${campReservation.camp.user.campName}">
		<input type="hidden" id="camp.campNo" name="camp.campNo" value="${campReservation.camp.campNo}">
		<input type="hidden" id="camp.campImg1" name="camp.campImg1" value="${campReservation.camp.campImg1}">
		<input type="hidden" id="mainSite.mainSiteNo" name="mainSite.mainSiteNo" value="${campReservation.mainSite.mainSiteNo}">
		<input type="hidden" id="mainSite.mainSiteType" name="mainSite.mainSiteType" value="${campReservation.mainSite.mainSiteType}">
		<input type="hidden" id="totalPaymentPrice" name="totalPaymentPrice" value="${campReservation.totalPaymentPrice}">			
		<!-- camp end -->
		
		
		
	
	<c:set var="i" value="0" />
	<c:forEach var="payment" items="${paymentList}">
		<div class="row" style="border: 1px solid gray; padding:20px;">	
		
			<!-- pay start -->
			<input type="hidden" id="paymentList[${i}].paymentSender" name="paymentList[${i}].paymentSender" value="${payment.paymentSender}" class="form-control" >
			<input type="hidden" id="paymentList[${i}].paymentReceiver" name="paymentList[${i}].paymentReceiver" value="${payment.paymentReceiver}" class="form-control" >
			<input type="hidden" id="paymentList[${i}].paymentPricePay" name="paymentList[${i}].paymentPricePay" value="${payment.paymentPricePay}" class="form-control" >
			<input type="hidden" id="paymentList[${i}].paymentPriceFee" name="paymentList[${i}].paymentPriceFee" value="${payment.paymentPriceFee}" class="form-control" >
			<input type="hidden" id="paymentList[${i}].paymentPricePaySecond" name="paymentList[${i}].paymentPricePaySecond" value="${payment.paymentPricePaySecond}" class="form-control" >
			<input type="hidden" id="paymentList[${i}].paymentPriceFeeSecond" name="paymentList[${i}].paymentPriceFeeSecond" value="${payment.paymentPriceFeeSecond}" class="form-control" >
			<input type="hidden" id="paymentList[${i}].paymentRefundPriceTotal" name="paymentList[${i}].paymentRefundPriceTotal" value="${payment.paymentRefundPriceTotal}" class="form-control" >
		    <input type="hidden" id="paymentList[${i}].paymentRefundPriceFee" name="paymentList[${i}].paymentRefundPriceFee" value="${payment.paymentRefundPriceFee}" class="form-control" >
		    <input type="hidden" id="paymentList[${i}].paymentRefundPriceTotalSecond" name="paymentList[${i}].paymentRefundPriceTotalSecond" value="${payment.paymentRefundPriceTotalSecond}" class="form-control" >
		    <input type="hidden" id="paymentList[${i}].paymentRefundPriceFeeSecond" name="paymentList[${i}].paymentRefundPriceFeeSecond" value="${payment.paymentRefundPriceFeeSecond}" class="form-control" >
		    <input type="hidden" id="paymentList[${i}].paymentCode" name="paymentList[${i}].paymentCode" value="${payment.paymentCode}" class="form-control" >
		    <input type="hidden" id="paymentList[${i}].paymentRefundCode" name="paymentList[${i}].paymentRefundCode" value="${payment.paymentRefundCode}" class="form-control" >
			<!-- pay end -->
				
			<div class="col-xs-1">	
				<h3>${i+1}</h3>			
			</div>
						
			<div class="col-xs-11">
			
				<div class="row">				
					<div class="row">
						<label class="col-xs-2" style="color:#162B8F;">* ????????????</label>
						<div class="col-xs-4 form-group"  style="color:blue;">
						    <c:choose>    
							    <c:when test="${payment.paymentCode eq 'P0'}">
							        ????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'P1'}">
							        ????????? ??????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'P2'}">
							        ????????? ??????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'R0'}">
							        ?????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'R1'}">
							        ?????? ??????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'R2'}">
							        ?????? ?????? ??????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'R3'}">
							        ?????? ???????????? 2??????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'R4'}">
							        ?????? ???????????? 3??????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'R5'}">
							        ?????? ???????????? 4??????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'R6'}">
							        ?????? ???????????? 5??????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'R7'}">
							        ?????? ???????????? 6??????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'R8'}">
							        ?????? ???????????? 7??????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'A0'}">
							        ?????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'A1'}">
							        ?????? A?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'A2'}">
							        ?????? B?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'A3'}">
							        ?????? C?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'A4'}">
							        ?????? D?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'A5'}">
							        ?????? E?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'A6'}">
							        ?????? A?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'A7'}">
							        ?????? B?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'A8'}">
							        ?????? C?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'A9'}">
							        ?????? D?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'A10'}">
							        ?????? E?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'A11'}">
							        ?????? A?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'A12'}">
							        ?????? B?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'A13'}">
							        ?????? C?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'A14'}">
							        ?????? D?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'A15'}">
							        ?????? E?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'A16'}">
							        ?????? A?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'A17'}">
							        ?????? B?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'A18'}">
							        ?????? C?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'A19'}">
							        ?????? D?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'A20'}">
							        ?????? E?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'T0'}">
							        ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentCode eq 'T1'}">
							        ????????????
							    </c:when>
							    <c:otherwise>
							    	?????????
							    </c:otherwise>
							</c:choose>
						</div>
						<label class="col-xs-2" style="color:#162B8F;">* ?????? ?????? ??????</label>
						<div class="col-xs-4 form-group">
						    <input type="text" id="paymentList[${i}].paymentProductPriceTotal" name="paymentList[${i}].paymentProductPriceTotal" value="${payment.paymentProductPriceTotal}" class="form-control" readonly>
						</div>		
					</div>
					
					<div class="row">
						<label class="col-xs-2" style="color:#162B8F;">* ????????????</label>
						<div class="col-xs-4 form-group">
						    <input type="text" id="paymentList[${i}].paymentNo" name="paymentList[${i}].paymentNo" value="${payment.paymentNo}" class="form-control" readonly>
						</div>					
						<label class="col-xs-2" style="color:#162B8F;">* ???????????????</label>
						<div class="col-xs-4 form-group">
						    <input type="text" id="paymentList[${i}].paymentRegTime" name="paymentList[${i}].paymentRegTime" value="${payment.paymentRegTime}" class="form-control" readonly>
						</div>
					</div>
					
					<div class="row">
						<label class="col-xs-2" style="color:#162B8F;">* ?????????</label>
						<div class="col-xs-4 form-group">
						    <input type="text" id="paymentList[${i}].paymentProduct" name="paymentList[${i}].paymentProduct" value="${payment.paymentProduct}" class="form-control" readonly>
						</div>	
						<label class="col-xs-2" style="color:#162B8F;">* ??????????????????</label>
						<div class="col-xs-4 form-group">
						    <input type="text" id="paymentList[${i}].paymentReferenceNum" name="paymentList[${i}].paymentReferenceNum" value="${payment.paymentReferenceNum}" class="form-control" readonly>
						</div>			
					</div>
					
					<c:if test="${ ! empty payment.paymentMethod || payment.paymentPriceTotal != '0' }">	
						<div class="row">
							<label class="col-xs-2" style="color:#162B8F;">* ??????????????????</label>
							<div class="col-xs-4 form-group">
							    <input type="text" id="paymentList[${i}].paymentMethod" name="paymentList[${i}].paymentMethod" value="${payment.paymentMethod}" class="form-control" readonly>
							</div>
							<label class="col-xs-2" style="color:#162B8F;">* ?????????????????????</label>
							<div class="col-xs-4 form-group">
							    <input type="text" id="paymentList[${i}].paymentPriceTotal" name="paymentList[${i}].paymentPriceTotal" value="${payment.paymentPriceTotal}" class="form-control" readonly>
							</div>				
						</div>
					</c:if>	
					
					<c:if test="${ ! empty payment.paymentMethodSecond && payment.paymentPriceTotalSecond != '0' }">					
						<div class="row">
							<label class="col-xs-2" style="color:#162B8F;">* ?????????????????????</label>
							<div class="col-xs-4 form-group">							
								<c:if test="${payment.paymentMethodSecond eq 'point'}">
									<input type="text" id="paymentList[${i}].paymentMethodSecond" name="paymentList[${i}].paymentMethodSecond" value="???????????????" class="form-control" readonly>
								</c:if>							    
							</div>
							<label class="col-xs-2" style="color:#162B8F;">* ????????????????????????</label>
							<div class="col-xs-4 form-group">
							    <input type="text" id="paymentList[${i}].paymentPriceTotalSecond" name="paymentList[${i}].paymentPriceTotalSecond" value="${payment.paymentPriceTotalSecond}" class="form-control" readonly>
							</div>
						</div>
					</c:if>		
				</div>		
				
				<div class="row" >								
					<div class="row">
						<label class="col-xs-2" style="color:#878F2B;">- ????????????</label>
						<div class="col-xs-4 form-group" style="color:Red;">
						    <c:choose>
							    <c:when test="${payment.paymentRefundCode eq 'P0'}">
							        ????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'P1'}">
							        ????????? ??????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'P2'}">
							        ????????? ??????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'R0'}">
							        ?????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'R1'}">
							        ?????? ??????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'R2'}">
							        ?????? ?????? ??????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'R3'}">
							        ?????? ???????????? 2??????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'R4'}">
							        ?????? ???????????? 3??????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'R5'}">
							        ?????? ???????????? 4??????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'R6'}">
							        ?????? ???????????? 5??????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'R7'}">
							        ?????? ???????????? 6??????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'R8'}">
							        ?????? ???????????? 7??????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'A0'}">
							        ?????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'A1'}">
							        ?????? A?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'A2'}">
							        ?????? B?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'A3'}">
							        ?????? C?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'A4'}">
							        ?????? D?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'A5'}">
							        ?????? E?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'A6'}">
							        ?????? A?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'A7'}">
							        ?????? B?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'A8'}">
							        ?????? C?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'A9'}">
							        ?????? D?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'A10'}">
							        ?????? E?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'A11'}">
							        ?????? A?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'A12'}">
							        ?????? B?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'A13'}">
							        ?????? C?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'A14'}">
							        ?????? D?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'A15'}">
							        ?????? E?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'A16'}">
							        ?????? A?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'A17'}">
							        ?????? B?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'A18'}">
							        ?????? C?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'A19'}">
							        ?????? D?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'A20'}">
							        ?????? E?????? ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'T0'}">
							        ???????????? ?????????
							    </c:when>
							    <c:when test="${payment.paymentRefundCode eq 'T1'}">
							        ????????????
							    </c:when>
							    <c:otherwise>
							        ?????????
							    </c:otherwise>
							</c:choose>
						</div>
						<label class="col-xs-2" style="color:#878F2B;">- ?????? ????????????</label>
						<div class="col-xs-4 form-group">
						    <input type="text" id="paymentList[${i}].paymentRefundReferenceNum" name="paymentList[${i}].paymentRefundReferenceNum" value="${payment.paymentRefundReferenceNum}" class="form-control" readonly>
						</div>					
					</div>
					
					<div class="row">	
						<label class="col-xs-2" style="color:#878F2B;">- ???????????? ????????????</label>
						<div class="col-xs-4 form-group">
						    <input type="text" id="paymentList[${i}].paymentRefundPricePay" name="paymentList[${i}].paymentRefundPricePay" value="${payment.paymentRefundPricePay}" class="form-control" readonly>
						</div>
						<label class="col-xs-2" style="color:#878F2B;">- ????????? ????????????</label>
						<div class="col-xs-4 form-group">
						    <input type="text" id="paymentList[${i}].paymentRefundPricePaySecond" name="paymentList[${i}].paymentRefundPricePaySecond" value="${payment.paymentRefundPricePaySecond}" class="form-control" readonly>
						</div>				
					</div>				
					
				</div>			
			</div>		
		</div>
		<br>
		<c:set var="i" value="${ i+1 }" />
		</c:forEach>
		
		<hr>
		
		<div class="row">				        
	        <label class="col-xs-2">* ?????? ?????????</label>
			<div class="col-md-4 form-group">
				<input type="text" id="name" name="name" value="${user.name}" class="form-control" readonly>
			</div>
			<label class="col-xs-2">* ?????? ???????????????</label>
			<div class="col-md-4 form-group">
				<input type="text" id="phone" name="phone" value="${user.phone}" class="form-control" readonly>
			</div>
			<label class="col-xs-2">* ?????? ???????????????</label>
			<div class="col-md-10 form-group">
				<input type="text" id="id" name="id" value="${user.id}" class="form-control" readonly>
			</div>
		</div>
			
		</form>	
	</div>
	<!-- ???????????? end -->
	
	
	<!-- ??????????????? ?????? start -->
	<div id="pointButtonContainer" class="container">
		<div class="row">		
			<div class="col-xs-2 col-xs-offset-10">
	            <button id="refundOk" type="button" class="btn btn-primary">??????</button>
	        </div>	        	    	        
		</div>
	</div>
	<!-- ??????????????? ?????? end -->
	
	
	<!-- ????????? ?????? -->
	<div class="container">			
		<div class="row">
			<br>
		</div>
	</div>		


</body>

</html>