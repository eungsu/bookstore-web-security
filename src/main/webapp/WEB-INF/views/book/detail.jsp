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
    <div class="row">
    	<div class="col-12">
			<p>도서 정보를 확인하세요</p>
    	</div>
    </div>
    <div class="row mb-3">
		<div class="col-10">
			<div class="row">
				<div class="col">
					<table class="table">
						<colgroup>
							<col width="15%">
							<col width="35%">
							<col width="15%">
							<col width="35%">
						</colgroup>
						<tbody>
							<tr>
								<th>제목</th>
								<td colspan="3">${book.title }</td>
							</tr>
							<tr>
								<th>등록일</th>
								<td><fmt:formatDate value="${book.createdDate }" pattern="yyyy년 M월 d일"/> </td>
								<th>최종수정일</th>
								<td><fmt:formatDate value="${book.updatedDate }" pattern="yyyy년 M월 d일"/> </td>
							</tr>
							<tr>
								<th>리뷰평점</th>
								<td><strong class="text-danger">${book.reviewScore }</strong> </td>
								<th>리뷰갯수</th>
								<td><fmt:formatNumber  value="${book.reviewCount }" /> 개</td>
							</tr>
							<tr>
								<th>할인가격</th>
								<td><strong class="text-danger"><fmt:formatNumber value="${book.discountPrice }" pattern="#,###"/></strong> 원</td>
								<th>가격</th>
								<td><fmt:formatNumber value="${book.price }" pattern="#,###"/> 원</td>
							</tr>
							<tr>
								<th>저자</th>
								<td>${book.author }</td>
								<th>출판사</th>
								<td>${book.publisher }</td>
							</tr>
							<tr>
								<th>판매여부</th>
								<td>${book.onSell eq 'Y' ? '판매중' : '판매완료' }</td>
								<th>재고량</th>
								<td><fmt:formatNumber value="${book.stock }"/> 권</td>
							</tr>
							<tr>
								<th>설명</th>
								<td colspan="3">${book.description }</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="row mb-3">
			<c:forEach var="review" items="${reviews }">
				<div class="col-6">
					<div class="card mb-1">
						<div class="card-body">
							<div class="d-flex justify-content-between">
								<span>
									<fmt:formatDate value="${review.createdDate}" pattern="yyyy년 M월 d일"/> 
									<span class="ms-3">
										<i class="bi me-1 ${review.score gt 0 ? 'bi-star-fill text-danger' : 'bi-star' }"></i>
										<i class="bi me-1 ${review.score gt 1 ? 'bi-star-fill text-danger' : 'bi-star' }"></i>
										<i class="bi me-1 ${review.score gt 2 ? 'bi-star-fill text-danger' : 'bi-star' }"></i>
										<i class="bi me-1 ${review.score gt 3 ? 'bi-star-fill text-danger' : 'bi-star' }"></i>
										<i class="bi ${review.score gt 4 ? 'bi-star-fill text-danger' : 'bi-star' }"></i>
									</span>
								</span>
								<span class="text-muted">${review.user.name } </span>
							</div>
							<hr/>
							<div class="row">
								<div class="col-10">
									<p class="card-text">${review.content }</p>
								</div>
								<div class="col-2 text-end">
									<sec:authentication property="principal" var="user" />
									<sec:authorize access="isAuthenticated()">
										<c:if test="${user.id eq review.user.id }">
											<a href="/book/review/delete?id=${book.id }&rid=${review.id }"  class="btn btn-sm btn-outline-danger" >삭제</a>
										</c:if>
									</sec:authorize>
									<sec:authorize access="!isAuthenticated()">
											<a href="/book/review/delete?id=${book.id }&rid=${review.id }"  class="btn btn-sm disabled btn-outline-secondary" >삭제</a>
									</sec:authorize>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
			</div>
			<c:if test="${pagination.totalRows gt 0 }">
				<div class="row">
					<div class="col">
						<nav aria-label="Page navigation">
							<ul class="pagination justify-content-center">
								<li class="page-item ${pagination.firstBlock ? 'disabled' : '' }">
									<a class="page-link" href="/book/detail?id=${book.id }&page=${pagination.previousBlockPage }" data-page="${pagination.previousBlockPage }">이전</a>
								</li>
			
								<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
									<li class="page-item ${pagination.number eq num ? 'active' : '' }">
										<a class="page-link" href="/book/detail?id=${book.id }&page=${num }" data-page="${num }">${num }</a>
									</li>
								</c:forEach>
			
								<li class="page-item ${pagination.lastBlock ? 'disabled' : '' }">
									<a class="page-link" href="/book/detail?id=${book.id }&page=${pagination.nextBlockPage }" data-page="${pagination.nextBlockPage }">다음</a>
								</li>
							</ul>
						</nav>
					</div>
				</div>
			</c:if>
		</div>
		<div class="col-2">
			<div class="row mb-3">
				<div class="col">
					<div class="card">
						<div class="card-body">
							<p>수량을 선택하세요</p>
							<form id="form-order" class="row" method="get" action="/order/form">
								<input type="hidden" name="id" value="${book.id }" />
								<div class="mb-3">
									<div class="input-group mb-3">
										<button class="btn btn-outline-secondary" id="btn-minus-quantity" type="button"><i class="bi bi-dash-lg"></i></button>
										<input type="text" class="form-control border-secondary" style="padding-left: 32px;" name="quantity" value="1" readonly="readonly">
										<button class="btn btn-outline-secondary" id="btn-plus-quantity" type="button"><i class="bi bi-plus-lg"></i></button>
									</div>
								</div>
								<div class="d-grid gap-2 mb-2">
									<button class="btn btn-primary" type="button" id="btn-add-cart">카트에 담기</button>
								</div>
								<div class="d-grid gap-2">
									<button class="btn btn-success" type="submit">바로구매</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="row mt-3 mb-3">
				<div class="col">
					<div class="d-grid gap-2">
						<sec:authorize access="isAuthenticated()">
							<button class="btn btn-outline-primary" id="btn-open-review-modal">리뷰 작성하기</button>
						</sec:authorize>
						<sec:authorize access="!isAuthenticated()">
							<button class="btn btn-outline-primary" id="btn-open-review-modal" disabled>리뷰 작성하기</button>
						</sec:authorize>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="modal-review-form" class="modal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">새 리뷰 작성</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="form-review" class="border bg-light p-3" method="post" action="/book/review/add">
					<sec:csrfInput/>
					<input type="hidden" name="bookId" value="${book.id }" />
					<div class="mb-3">
						<label class="form-label">평점</label>
						<input type="hidden" name="score" value="5" />
						<div id="icon-scores">
							<i class="bi bi-star-fill fs-2 me-3" data-review-score="1"></i>
							<i class="bi bi-star-fill fs-2 me-3" data-review-score="2"></i>
							<i class="bi bi-star-fill fs-2 me-3" data-review-score="3"></i>
							<i class="bi bi-star-fill fs-2 me-3" data-review-score="4"></i>
							<i class="bi bi-star-fill fs-2" data-review-score="5"></i>
						</div>
					</div>
					<div class="mb-3">
						<label class="form-label">내용</label>
						<textarea rows="5" class="form-control" name="content"></textarea>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" id="btn-add-review">등록</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function() {
	let reviewFormModal = new bootstrap.Modal(document.getElementById("modal-review-form"));
	
	$("#icon-scores i.bi").hover(function() {
		let score = parseInt($(this).attr("data-review-score"));
		$("#icon-scores i.bi")
			.addClass("bi-star")
			.filter(":lt("+score+")")
			.removeClass("bi-star")
			.addClass("bi-star-fill");
	}, function() {
		let score = parseInt($(this).attr("data-review-score"));
		$("input[name=score]").val($(this).attr("data-review-score"));
	})
	
	$("#btn-open-review-modal").click(function() {
		reviewFormModal.show();
	});
	
	$("#btn-add-review").click(function() {
		if ($("textarea[name=content]").val()) {
			$("#form-review").trigger("submit");			
		}
	});
		
	var $quantityField = $("#form-order :input[name=quantity]");

	$("#btn-minus-quantity").click(function() {
		var quantity = parseInt($quantityField.val());
	
		if (quantity <= 1) {
			$quantityField.val("1");
			return;
		}
		$quantityField.val(quantity - 1);
	});
	
	$("#btn-plus-quantity").click(function() {
		var quantity = parseInt($quantityField.val());
		
		if (quantity >= 9) {
			$quantityField.val("10");
			return;
		}
		$quantityField.val(quantity + 1);
	});
	
	$("#btn-add-cart").click(function() {
		$("#form-order").attr("action", "/cart/add").trigger("submit");
	});
})
</script>
</body>
</html>