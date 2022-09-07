<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common/tags.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>애플리케이션</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<c:set var="menu" value="login" />
<%@ include file="common/nav.jsp" %>
<div class="container my-3">
    <div class="row mb-3">
        <div class="col">
            <h1>로그인 폼</h1>
        </div>
    </div>
    <div class="row mb-3">
        <div class="col-8">
            <p>이메일, 비밀번호를 입력하세요.</p>
            
            <c:if test="${param.error eq 'failure' }">
            	<div class="alert alert-danger">
            		<strong>로그인 실패</strong> 이메일 혹은 비밀번호가 올바르지 않습니다.
            	</div>
            </c:if>
            <form class="border bg-light p-3" method="post" action="login">
            	<%-- 
            		POST, PUT 방식의 요청에 대해서 CSRF(Cross-Site Request Forgery) 사이트 간 요청 위조 공격을 방어하기 위해서
            		csrf토큰을 폼에 포함시킨다.
            	 --%>
            	<sec:csrfInput/>
                <div class="mb-3">
                	<label for="email-field" class="form-label">이메일</label>
                	<input type="text" class="form-control" name="email" id="email-field" value="hong@gmail.com"/>
                </div>
                <div class="mb-3">
                	<label for="password-field" class="form-label">비밀번호</label>
                	<input type="password" class="form-control" name="password" id="password-field" value="zxcv1234"/>
                </div>
                <div class="text-end">
                	<a href="/register" class="btn btn-secondary">회원가입</a>
                	<button type="submit" class="btn btn-primary">로그인</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>