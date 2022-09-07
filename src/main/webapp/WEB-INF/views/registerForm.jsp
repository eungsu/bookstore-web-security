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
<c:set var="menu" value="register" />
<%@ include file="common/nav.jsp" %>
<div class="container my-3">
    <div class="row mb-3">
        <div class="col">
            <h1>회원가입 폼</h1>
        </div>
    </div>
    <div class="row mb-3">
        <div class="col">
            <p>이메일, 비밀번호, 이름, 전화번호를 입력하세요.</p>
            <form:form class="border bg-light p-3" method="post" modelAttribute="userRegisterForm" action="register">
                <div class="mb-3">
                	<label for="email-field" class="form-label">이메일</label>
                	<form:input class="form-control" path="email" id="email-field" placeholder="sample@abc.com"/>
                	<form:errors path="email" cssClass="text-danger"></form:errors>
                </div>
                <div class="mb-3">
                	<label for="password-field" class="form-label">비밀번호</label>
                	<form:password class="form-control" path="password" id="password-field" placeholder="비밀번호는 영어 대소문자와 숫자로 8글자 ~ 20글자입니다."/>
                	<form:errors path="password" cssClass="text-danger"></form:errors>
                </div>
                <div class="mb-3">
                	<label for="name-field" class="form-label">이름</label>
                	<form:input class="form-control" path="name" id="name-field" placeholder="이름은 한글로 2글자 이상입니다."/>
                	<form:errors path="name" cssClass="text-danger"></form:errors>
                </div>
                <div class="mb-3">
                	<label for="tel-field" class="form-label">전화번호</label>
                	<form:input class="form-control" path="tel" id="tel-field" placeholder="010-1234-5678"/>
                	<form:errors path="tel" cssClass="text-danger"></form:errors>
                </div>
                <div class="text-end">
                	<a href="/" class="btn btn-secondary">취소</a>
                	<button type="submit" class="btn btn-primary">회원가입</button>
                </div>
            </form:form>
        </div>
    </div>
</div>
</body>
</html>