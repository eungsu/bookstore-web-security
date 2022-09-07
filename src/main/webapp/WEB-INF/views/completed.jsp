<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common/tags.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>애플리케이션</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css" rel="stylesheet">
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
                <h1 class="mb-4">회원가입 완료</h1>
                <p class="">회원가입이 완료되었습니다.</p>
                <div>
                    <a href="/login" class="btn btn-primary">로그인</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>