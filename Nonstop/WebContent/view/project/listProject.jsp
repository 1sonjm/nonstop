<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<link href="/css/animate.min.css" rel="stylesheet">
	<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link href="../../resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../resources/css/full.css" rel="stylesheet">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

	<style>
	
		table {
        	border-collapse: collapse;
		    border: collapse;
		    width: 100%;
            padding-left : 20px;
            table-layout : fixed;
		}
		
		th, tr {
		    padding: 8px;
		    text-align: left;
		  
		}
		
	   .thumbnail:hover{
	    	background-color:#ffffe6;
	    	border: 2px solid orange;
	    }
        
        .breadcrumb{
        	background-color:#fffffa;
        }
        
        .thumbnail{
        	/* background-color:#fffffa; */
        }
	</style>
	<!-- 筌�占쏙옙占쏙옙占� 占쏙옙占쏙옙 prev/next 甕곤옙占쏙옙 -->
	<script type="text/javascript">
		
		function d_day() {
			var nowDate = new Date();
			var projAnnoEnd = new Date($("#projAnnoEnd").val());
			var thatDay = projAnnoEnd.getTime() - nowDate.getTime('YYYY/MM/DD 00:00:00');
			var days = Math.abs(Math.floor(thatDay / (1000*60*60*24))+1);
			if (thatDay<0){
				days=0;
			}
			
			$("#thatDay").append('<font color=#ff607f>'+days+'</font>');
			
		}
		
		
		function expect_day() {
			var projStartDate = new Date($("#projStartDate").val());
			var projEndDate = new Date($("#projEndDate").val());
			var expectDay = projEndDate.getTime() - projStartDate.getTime();
			var days = Math.abs(Math.floor(expectDay / (1000*60*60*24))+1);
			$("#expectDay").append('<font>'+days+'</font>');
		}
		
	    
	</script>


</head>

<body>

<!-- Navigation -->
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Start Bootstrap</a>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li>
                    <a href="#">About</a>
                </li>
                <li>
                    <a href="#">Services</a>
                </li>
                <li>
                    <a href="#">Contact</a>
                </li>
            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container -->
</nav>

<!-- Second Navigation -->
<nav class="navbar navbar-default navbar-static-top" role="navigation">
	<div class="container"> <!-- <div class="container"> 獄�占쏙옙占쏙옙占� �⑨옙占쏙옙占쏙옙 ��占쏙옙占쏙옙��占쏙옙 / <div class="container-fluid"> ��怨�占싼�占쏙옙 占쏙옙筌ｋ��占쏙옙繹�占쏙�占� 占쏙옙占쎈��占쏙옙占쏙옙 筌ㅿ옙占쏙옙占쏙옙 ��占쏙옙占쏙옙��占쏙옙 -->
		
		<div class="margin-top-5">
			<!-- Search-bar -->
			<div class="input-group input-group-sm">
				<!-- 카테고리 선택 -->		
				<div class="input-group-btn">
	   				<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">검색어 <span class="caret"></span></button>
	       			<ul class="dropdown-menu" role="menu">
						<li><a href="#">제목</a></li>
						<li><a href="#">개발기술</a></li>
						<li><a href="#">기업명</a></li>
			       </ul>
				</div>
				<!-- 돋보기모양 -->
				<span class="input-group-addon"> 		            
					<span class="glyphicon glyphicon-search"></span>
				</span>
				<input type="text" class="form-control" aria-label="...">
				<!-- 검색버튼 -->
				<span class="input-group-btn">
					<button class="btn btn-default" type="button">검색</button>
				</span>			
			</div>	
		</div>
		
		<!-- ALL/WEB/APP 甕곤옙占쏙옙 -->
		<div class="row">	
			<div class="col-md-6 col-md-offset-3" align="center">
	        	<button class="button button-neutral" type="button">All</button>
	        	<button class="button button-neutral" type="button">Web</button>
	        	<button class="button button-neutral" type="button">App</button>
			</div>

			<!-- 占쏙옙占쏙옙 / 占쏙옙 占쏙옙占싼�占쏙옙 占쏙옙占쏙옙占쏙옙椰���占� 占쏙옙 占쏙옙 占쏙옙占쏙옙 
			<div class="col-md-3 col-md-offset-9" align="right">
				<ol class="breadcrumb">
				  <li class="active">筌ㅿ옙占쏙옙占쏙옙</li>
				  <li><a href="#">�곤옙筌ｏ옙占쏙옙</a></li>
				  <li><a href="#">鈺곌�占쏙옙占쏙옙</a></li>
				</ol>
			</div> -->
		</div>
		
	</div>
</nav>

<!-- Ranking -->
<!-- type -->
<div class="container">
  <div class="row">
	  <div class="margin-top-20">
		  <div class="text">	
		    <h2 class="text-left">Project</h2>
		    <h2 class="text-right">Project</h2>
		  </div>
	  </div>
  </div>
</div>

<div class="container">
	<hr class="margin-top-30"/>
</div>
            
<div class="container">
	<ol class="breadcrumb">
	  <li><a href="#" id="rmsid5">최신등록순</a></li>
	  <li><a href="#">마감임박순</a></li>
	  <li><a href="#">지원자순</a></li>
	  <li><a href="#">조회순</a></li>
	</ol>			
</div>


    <!-- Page Content -->
    <div class="margin-bottom-40">
    	<div class="container">   	
        	<div class="row">
	            <div class="col-md-6 col-sm-6 hero-feature" style="height:400px">
	            <input type="hidden" name="projNo" id="projNo" value="${project.projNo}" />
	            <input type="hidden" name="projAnnoEnd" id="projAnnoEnd" value="${project.projAnnoEnd}" />
				<input type="hidden" name="projStartDate" id="projStartDate" value="${project.projStartDate}" />
				<input type="hidden" name="projEndDate" id="projEndDate" value="${project.projEndDate}" />
	            <div class="thumbnail">
	                <table style="height:100%;">
					  <tr style="height:40px; border-bottom: 1px solid #ddd">
					    <th colspan="10" style="font-size:25px;">
					    	<p class="glyphicon glyphicon-star" style="font-size:25px"></p>
					    	&nbsp; &nbsp;sdfdsfdsafsdfsdafdsafsdfsdfsdfasdfsd
					   	</th>
					    <th colspan="2" style="text-align : center">모집중</th>
					  </tr>
					  
					  <tr style="height:10px; font-size:15px; text-align : center">
					  	<td colspan="3">공고기간</td>
					    <td colspan="3">예상기간</td>
					    <td colspan="3">지원자수</td>
					    <td colspan="3">개발지역</td>
					  </tr>
                      
					  <tr style="height:50px">
					  	
					  	<th colspan="3" style="border-right: 1px solid #ddd; text-align : center" id="thatDay"><script language=javascript>d_day()</script>일 남음</th>
					    <th colspan="3" style="border-right: 1px solid #ddd; text-align : center" id="expectDay"><script language=javascript>expect_day()</script>일</th>
					    <th colspan="3" style="border-right: 1px solid #ddd; text-align : center">sdsdfsdf</th>
					    <th colspan="3" style="text-align : center">${project.projLocation}</th>
					  </tr>
                      
                      <tr style="height:10px; border-bottom: 1px solid #ddd">
					  	<th colspan="12"></th>
					  </tr>
					  
					  <tr style="height:20px">
					 	 <th colspan="12">
					 	 <c:choose>
						  	<c:when test="${project.projDivision==11}">
						  		개발/WEB
						  	</c:when>
						  	<c:when test="${project.projDivision==12}">
						  		개발/APP
						  	</c:when>
						  	<c:when test="${project.projDivision==21}">
						  		디자이너/WEB
						  	</c:when>
						  	<c:when test="${project.projDivision==22}">
						  		디자이너/APP
						  	</c:when>
						  </c:choose>
					  	</th>
					  </tr>
					  
                      
                      <tr style="height:20px; border-bottom: 1px solid #ddd">
					  	<th colspan="12">java</th>
					  </tr>
					  
					  <tr style="height:150px; text-align : top-left" >
					  	<th colspan="12" >${project.projDetail}</th>
					  </tr>
					  
					  <tr>
					  	<th colspan="12" style= "background-color: #dddddd; text-align : center">상세보기</th>
					  </tr>
					 </table>
					 </div>
	            </div>
	            
	            
	         </div>
	      </div>
	    </div>
	        
	            
	            
	
	             
		
	<!-- pagination -->
       <nav align="center">
	  <ul class="pagination">
	    <li>
	      <a href="#" aria-label="Previous">
	        <span aria-hidden="true">&laquo;</span>
	      </a>
	    </li>
	    <li><a href="#">1</a></li>
	    <li><a href="#">2</a></li>
	    <li><a href="#">3</a></li>
	    <li><a href="#">4</a></li>
	    <li><a href="#">5</a></li>
	    <li>
	      <a href="#" aria-label="Next">
	        <span aria-hidden="true">&raquo;</span>
	      </a>
	    </li>
	  </ul>
	</nav>

    

    <!-- jQuery -->
    <script src="../../resources/javascript/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="../../resources/javascript/bootstrap.min.js"></script>

</body>

</html>





<!-- // 기술 제이슨으로 보내기

	function aaa(jsondata){
		for(i=0;i<jsondata;i++){
			'<input type="checkbox" value='+jsondata[i].techNo+'>'+jsondata[i]techName
		}
	}

 -->

