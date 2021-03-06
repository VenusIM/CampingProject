<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	

<!DOCTYPE html>

<html lang="ko">

<head>

	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
  	<style>
	  body {
            padding-top : 50px;
        }
    </style>

	<script type="text/javascript">
	
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/campBusiness/listSubSite").submit();

	}

	$(function() {
		 
		$( "button.btn.btn-default"  ).on("click" , function() {
			fncGetList(1);
		}); 
		 
		$( "td:nth-child(3)" ).on("click" , function() {
			self.location ="/campBusiness/getSubSite?subSiteNo="+$(this).attr("data-subSiteNo");
		});
					
		//==> LINK Event End User 에게 보일수 있도록 
		$( "td:nth-child(3)" ).css("color" , "red");		
	
	});	
    
</script>
</head>

<body>

	<!-- ToolBar -->
	<jsp:include page="/view/common/headerCampBusiness.jsp" />
   	
   	<!-- Page Start -->
	<div class="container">
		<div class="page-header text-info">
			<h3>부가시설 목록</h3>
	    </div>
	    
	    <!-- 상단 -->
	    <div class="row">
	    
	    	<div class="col-md-6 text-left">
				<p class="text-primary">
		    		전체  ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
			</div>
		
			<div class="col-md-6 text-right">
				<form class="form-inline" name="detailForm">				
				<input type="hidden" name="campNo" value="${campSession.campNo}">
				<input type="hidden" name="role" value="${campSession.user.role}">
				
			    
					<div class="form-group">
						<select class="form-control" name="searchCondition" >
							<c:if test="${ campSession.user.role eq 'ADMIN' }">
            					<option value="0" ${! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>캠핑장명</option>
            				</c:if> 
							<option value="1" ${! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>부가시설명</option>
							<option value="2" ${! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>유형</option>
						</select>
					</div>
					  
					<div class="form-group">
						<label class="sr-only" for="searchKeyword">검색어</label>
					    <input type="text"  class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
					    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
					</div>
										
					<button type="button" class="btn btn-default">검색</button>
					  
					<!-- PageNavigation Page value -->
					<input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    
	    </div>
	    
		<!-- 하단 -->
		<table class="table table-hover table-striped" >
      
			<thead>
				<tr>
            		<th align="left">No</th>
            		<c:if test="${ campSession.user.role eq 'ADMIN' }">
            			<th align="left">캠핑장명</th>
            		</c:if>            		
            		<th align="left">부가시설명</th>
          			<th align="left">유형</th>       			         			
				</tr>
       		</thead>
       		
       		<tbody>      		
				<c:set var="i" value="0" />
		  		<c:forEach var="subSite" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr>
			  			<td align="left">${ i }</td>
			  			<c:if test="${ campSession.user.role eq 'ADMIN' }">
			  				<td align="left" data-campNo="${subSite.campNo}">${subSite.campName}</td>	
			  			</c:if>  				
			  			<td align="left" data-subSiteNo="${subSite.subSiteNo}">${subSite.subSiteName}</td>
          				<td align="left">${subSite.subSiteType}</td>
					</tr>
          		</c:forEach>
        	</tbody>
      
      </table>
	  
 	</div>
 	
 	<!-- PageNavigation -->
	<jsp:include page="../common/pageNavigator.jsp"/>
	
</body>

</html>
	