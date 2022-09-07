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
<c:set var="menu" value="home" />
<%@ include file="common/nav.jsp" %>
<div class="container my-3">
    <div class="row mb-3">
        <div class="col">
            <div class="border p-3 bg-light">
                <h1 class="mb-4">샘플 애플리케이션 입니다.</h1>
                <p class="">스프링부트, 스프링 시큐리티, 오라클, mybatis를 활용한 샘플 애플리케이션입니다.</p>

                <sec:authorize access="!isAuthenticated()">
                    <div>
                        <a href="/register" class="btn btn-primary">회원가입</a>
                        <a href="/login" class="btn btn-primary">로그인</a>
                    </div>
                </sec:authorize>
            </div>
        </div>
    </div>
</div>
</body>
</html>