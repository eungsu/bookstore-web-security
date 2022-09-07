<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/tags.jsp" %>
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
<c:set var="menu" value="book" />
<%@ include file="../common/nav.jsp" %>
<div class="container my-3">
    <div class="row mb-3">
        <div class="col">
            <h1>주문이 완료되었습니다.</h1>
        </div>
    </div>
    <div class="row mb-3">
    	<div class="col">
    		<p>주문정보를 확인하세요</p>
    		<div class="border bg-light p-3">
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
    				<tbody>
    					<tr>
    						<td>${order.id }</td>
							<td>${order.title}</td>
    						<td><fmt:formatDate value="${order.createdDate}" pattern="yyyy년 M월 d일"/> </td>
							<td>${order.totalQuantity}</td>
							<td><strong class="text-danger"><fmt:formatNumber value="${order.paymentPrice}" /></strong> 원</td>
							<td><fmt:formatNumber value="${order.depositPoint}"/> 점</td>
							<td>${order.status}</td>
    					</tr>
    				</tbody>
    			</table>
    		</div>
    	</div>
    </div>
	<div class="row mb-3">
		<div class="col">
			<p>주문 아이템을 확인하세요.</p>
			<div class="border bg-light p-3">
				<table class="table">
					<colgroup>
						<col width="7%">
						<col width="*">
						<col width="15%">
						<col width="10%">
						<col width="12%">
						<col width="20%">
					</colgroup>
					<thead>
						<tr>
							<th>순번</th>
							<th>제목</th>
							<th>출판사</th>
							<th>수량</th>
							<th>가격</th>
							<th>구매가격</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="orderItem" items="${orderItems}" varStatus="loop">
							<tr>
								<td>${loop.count}</td>
								<td>${orderItem.book.title}</td>
								<td>${orderItem.book.publisher} </td>
								<td>${orderItem.quantity}</td>
								<td><fmt:formatNumber value="${orderItem.price}" /> 원 </td>
								<td>
									<fmt:formatNumber value="${orderItem.totalOrderPrice}" /> 원
									<small>(<fmt:formatNumber value="${orderItem.totalDiscountPrice}" /> 원 할인)</small>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col">
			<div class="text-end">
				<a href="/book/list" class="btn btn-primary">쇼핑 계속하기</a>
			</div>
		</div>
	</div>
</div>
</body>
</html>