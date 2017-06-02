<%@ page contentType="text/html; charset=utf-8" %>
<%@ page pageEncoding="utf-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="utf-8">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	/*  $(function() {
		 $("span.updateCareer").on("click" , function() {
				var careerNo=$(this).attr('careerNo');
				alert(careerNo);
			self.location ="/profile/updateCareer?careerNo="+careerNo;
			
			});
		 
		 $("span.deleteCareer").on("click" , function() {
				alert("ㅇㅇ" );
				var careerNo=$(this).attr('careerNo');
				alert(careerNo);
			self.location ="/profile/deleteCareer?careerNo="+careerNo;
			
			});
		 
		$("span.addCareer").on("click" , function() {
		 		self.location = "/profile/addCareerView";
			}); 
	});	 */
</script>
</head>

<body>
	
	<div class="container">
	<div class="page-header text-center">
	       <h5 class=" text-left" >팔로우한 회원 목록</h5>
	    </div>

      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="center" >회원명</th>
            <th align="center">팔로우 삭제/등록</th>
            <th align="center">쪽지</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  	<c:forEach var="follow" items="${list}">
				<c:set var="i" value="${ i+1 }" />
				<tr>
					<td align="center">${ i }</td>
					<td align="center">${follow.targetUserId}</td>
					<td align="center">
			 			<c:if test="${follow.followNo != null}">
			 				<div class="col-sm-offset-4  col-sm-4 text-center">
					 			<span class="follow" targetUserId="${user.userId}" id="follow">
		      						<button type="button" class="btn btn-primary" id="profile" >언팔로우</button>
		      					</span>
		     				</div>
		      			</c:if>
		      
		      			<c:if test="${follow.followNo == null}">
		      				<div class="col-sm-offset-4  col-sm-4 text-center">
					 			<span class="follow" targetUserId="${user.userId}" id="follow">
		      						<button type="button" class="btn btn-primary" id="profile" >팔로우</button>
		      					</span>
		      				</div>
		      			</c:if>
			 		</td>
			 
			  <td align="center">
			  <div class="col-sm-offset-4  col-sm-4 text-center">
				<span class="follow" targetUserId="${user.userId}" id="follow">
		      		<button type="button" class="btn btn-primary" id="profile" >쪽지작성</button>
		      	</span>
		      </div>
			  </td>
			  
			 
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	
 	
	
</body>

</html>