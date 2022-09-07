<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../common/tags.jsp" %>
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
<c:set var="menu" value="order" />
<%@ include file="../../common/nav.jsp" %>
<div class="container my-3">
    <div class="row mb-3">
        <div class="col">
            <p>주문내역을 확인하세요.</p>
            <table class="table">
                <colgroup>
                    <col width="7%">
                    <col width="*">
                    <col width="15%">
                    <col width="10%">
                    <col width="12%">
                    <col width="10%">
                    <col width="10%">
                </colgroup>
                <thead>
                    <tr>
                        <th>아이디</th>
                        <th>주문내용</th>
                        <th>주문일자</th>
                        <th>주문수량</th>
                        <th>결재금액</th>
                        <th>적립포인트</th>
                        <th>주문상태</th>
                    </tr>
                </thead>
                <c:if test="${not empty orders}">
                    <tbody>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td>${order.id }</td>
                                <td><a href="/user/order/detail?id=${order.id}">${order.title}</a></td>
                                <td><fmt:formatDate value="${order.createdDate}" pattern="yyyy년 M월 d일"/> </td>
                                <td>${order.totalQuantity}</td>
                                <td><strong class="text-danger"><fmt:formatNumber value="${order.paymentPrice}" /></strong> 원</td>
                                <td><fmt:formatNumber value="${order.depositPoint}"/> 점</td>
                                <td>${order.status}</td>
                            </tr>
                        </c:forEach>
                    </tbody>

                </c:if>
            </table>
            <c:if test="${empty orders }">
                <div class="pt-3">
                    <div class="text-center mb-3">
                        <strong>주문내역이 존재하지 않습니다.</strong>
                    </div>
                    <div class="text-center">
                        <a href="/book/list" class="btn btn-outline-primary btn-lg">쇼핑 계속하기</a>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>
