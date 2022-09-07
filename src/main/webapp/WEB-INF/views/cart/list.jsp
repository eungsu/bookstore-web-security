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
<c:set var="menu" value="cart" />
<%@ include file="../common/nav.jsp" %>
<div class="container my-3">
    <div class="row mb-2">
		<div class="col">
			<p>장바구니에 담기 책 목록을 확인하세요</p>
			<form id="form-cart-item-list" method="get" action="order">
				<table class="table" id="table-cart-items">
					<colgroup>
						<col width="5%">
						<col width="*">
						<col width="12%">
						<col width="10%">
						<col width="10%">
						<col width="17%">
						<col width="10%">
					</colgroup>
					<thead>
						<tr>
							<th><input type="checkbox" ${not empty cartItems ? 'checked' : '' } /></th>
							<th>제목</th>
							<th>가격</th>
							<th>판매가격</th>
							<th>수량</th>
							<th>구매가격</th>
							<th></th>
						</tr>
					</thead>
					<c:if test="${not empty cartItems }">
						<tbody>
							<c:forEach var="cartItem" items="${cartItems }" varStatus="loop">
								<tr>
									<td><input type="checkbox" name="id" value="${cartItem.id }" checked /></td>
									<td><a href="/book/detail?id=${cartItem.book.id }">${cartItem.book.title }</a></td>
									<td><fmt:formatNumber value="${cartItem.book.price }" /> 원</td>
									<td><strong class="text-danger"><fmt:formatNumber value="${cartItem.book.discountPrice }" /></strong> 원</td>
									<td class="pe-4">
										<div class="input-group input-group-sm">
											<button class="btn btn-outline-secondary" type="button" data-cartitem-id="${cartItem.id }"><i class="bi bi-dash-lg"></i></button>
											<input type="text" class="form-control border-secondary" id="quantity-${cartItem.id }" value="${cartItem.quantity }" readonly="readonly">
											<button class="btn btn-outline-secondary" type="button" data-cartitem-id="${cartItem.id }"><i class="bi bi-plus-lg"></i></button>
										</div>
									</td>
									<td>
										<strong class="text-danger"><fmt:formatNumber value="${cartItem.quantity * cartItem.book.discountPrice }" /></strong> 원
										<small>(<fmt:formatNumber value="${cartItem.itemDiscountPrice }"/> 원 할인)</small>
									</td>
									<td>
										<a href="/cart/delete?id=${cartItem.id }" class="btn btn-outline-secondary btn-sm">삭제</a>
										<a href="/cart/order?id=${cartItem.id }" class="btn btn-outline-secondary btn-sm">주문</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</c:if>
				</table>
				<c:if test="${empty cartItems }">
					<div class="pt-3">
						<div class="text-center mb-3">
							<strong>장바구니에 담긴 상품이 없습니다.</strong>
						</div>
						<div class="text-center">
							<a href="/book/list" class="btn btn-outline-primary btn-lg">쇼핑 계속하기</a>
						</div>
					</div>
				</c:if>
			</form>
		</div>
	</div>
	<c:if test="${not empty cartItems }">
		<div class="row mb-2">
			<div class="col">
				<div class="row mb-3">
					<div class="col">
						<div class="card">
							<div class="card-body">
								<p>총 상품금액을 확인하세요</p>
								<div class="d-flex justify-content-between mb-2"><strong>총 상품금액</strong> <span><strong><fmt:formatNumber value="${totalPrice }"/></strong> 원</span></div>
								<div class="d-flex justify-content-between mb-3"><strong>총 할인금액</strong> <span><strong><fmt:formatNumber value="${totalDiscountPrice }"/></strong> 원</span></div>
								<hr/>
								<div class="d-flex justify-content-between"><strong>총 결재금액</strong> <span><strong class="text-danger"><fmt:formatNumber value="${totalPaymentPrice }"/></strong> 원</span></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row mb-3">
			<div class="col text-end">
				<button class="btn btn-outline-secondary" type="button" id="btn-delete-cart-items">삭제하기</button>
				<button class="btn btn-primary" type="button"  id="btn-order-cart-items">주문하기</button>
			</div>
		</div>
	</c:if>
</div>
<script type="text/javascript">
$(function() {
	
	var $theadCheckbox = $("#table-cart-items thead :checkbox");
	var $tbodyCheckboxes = $("#table-cart-items tbody :checkbox");
	
	$theadCheckbox.change(function() {
		$tbodyCheckboxes.prop("checked", $(this).prop("checked"))
	});
	
	$tbodyCheckboxes.change(function() {
		if ($tbodyCheckboxes.filter(":not(':checked')").length) {
			$theadCheckbox.prop("checked", false);
		} else {
			$theadCheckbox.prop("checked", true);
		}
	})
	
	$("#table-cart-items .btn:has('.bi-dash-lg')").click(function() {
		var cartItemId = $(this).attr("data-cartitem-id");
		var $quantityField = $(this).next();
		var quantity = parseInt($quantityField.val());
		
		quantity--;
		if (quantity < 1) {
			quantity = 1;
		}
		
		location.href = "/cart/update?id=" + cartItemId + "&quantity=" + quantity
	});
	
	$("#table-cart-items .btn:has('.bi-plus-lg')").click(function() {
		var cartItemId = $(this).attr("data-cartitem-id");
		var $quantityField = $(this).prev();
		var quantity = parseInt($quantityField.val());
		
		quantity++;			
		if (quantity > 10) {
			quantity = 10;
		}
		
		location.href = "/cart/update?id=" + cartItemId + "&quantity=" + quantity
	});
	
	$("#btn-delete-cart-items").click(function() {
		if ($tbodyCheckboxes.filter(":checked").length == 0) {
			alter("선택된 상품이 없습니다.");
			return;
		}
		$("#form-cart-item-list").attr("action", "/cart/delete").trigger("submit");
	});
	
	$("#btn-order-cart-items").click(function() {
		if ($tbodyCheckboxes.filter(":checked").length == 0) {
			alter("선택된 상품이 없습니다.");
			return;
		}
		$("#form-cart-item-list").trigger("submit");
	});
	
})
</script>
</body>
</html>