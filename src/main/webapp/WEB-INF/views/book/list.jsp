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
    <div class="row mb-2">
		<div class="col">
			<div class="d-flex justify-content-between border-bottom border-dark border-2">
				<p>도서 목록을 확인하세요</p>
				<form id="form-paging" method="get" action="/book/list">
					<input type="hidden" name="option" value="${param.option }" />
					<input type="hidden" name="keyword" value="${param.keyword }" />
					<input type="hidden" name="page" value='<c:out value="${param.page }" default="1"/>' />
					<select class="form-select form-select-sm" name="sort">
						<option value="date" ${empty param.sort or param.sort eq 'date' ? 'selected' : '' }> 신상품순 </option>
						<option value="title" ${param.sort eq 'title' ? 'selected' : '' }> 제목순 </option>
						<option value="low" ${param.sort eq 'low' ? 'selected' : '' }> 최저가순 </option>
						<option value="high" ${param.sort eq 'high' ? 'selected' : '' }> 최고가순 </option>
					</select>
				</form>
			</div>
		</div>
	</div>
	<div class="row mb-2">
		<c:forEach var="book" items="${books }">
			<div class="col-4 mb-2">
				<div class="card">
					<div class="card-header">
						<div class="row">
							<div class="col-10"><a href="/book/detail?id=${book.id }" class="text-decoration-none text-dark">${book.title }</a> </div>
							<div class="col-2 text-end">
								<a href="/cart/add?id=${book.id }"class="btn text-success float-end"><i class="bi bi-bag-check-fill"></i></a>
							</div>
						</div>
					</div>
					<div class="card-body">
						<p class="mt-1 d-flex justify-content-between text-secondary">
							<span>${book.author }</span> <span>${book.publisher }</span>
						</p>
						<p class="mb-0 d-flex justify-content-between">
							<small class="text-decoration-line-through"><fmt:formatNumber value="${book.price }" pattern="#,###"/> 원</small> 
							<span><strong class="text-danger"><fmt:formatNumber value="${book.discountPrice }" pattern="#,###"/></strong> 원</span>
						</p>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	<div class="row mb-1">
		<div class="col-4 offset-4 mt-2">
			<c:if test="${not empty books }">
				<div class="row mb-1">
					<div class="col">
						<nav aria-label="Page navigation">
							<ul class="pagination justify-content-center">
								<li class="page-item ${pagination.firstBlock ? 'disabled' : '' }">
									<a class="page-link" href="/book/list?page=${pagination.previousBlockPage }" data-page="${pagination.previousBlockPage }">이전</a>
								</li>
			
								<c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
									<li class="page-item ${pagination.number eq num ? 'active' : '' }">
										<a class="page-link" href="/book/list?page=${num }" data-page="${num }">${num }</a>
									</li>
								</c:forEach>
			
								<li class="page-item ${pagination.lastBlock ? 'disabled' : '' }">
									<a class="page-link" href="/book/list?page=${pagination.nextBlockPage }" data-page="${pagination.nextBlockPage }">다음</a>
								</li>
							</ul>
						</nav>
					</div>
				</div>
			</c:if>
		</div>
		<div class="col-4 d-flex justify-content-end">
			<form class="row row-cols-lg-auto g-3 align-items-center">
				<div class="col-12">
					<select class="form-select" id="option-field">
						<option value="" selected="selected" disabled="disabled"> 검색조건</option>
						<option value="title" ${param.option eq 'title' ? 'selected' : '' }> 제목</option>
						<option value="author" ${param.option eq 'author' ? 'selected' : '' }> 저자</option>
						<option value="publisher" ${param.option eq 'publisher' ? 'selected' : '' }> 출판사</option>
					</select>
				</div>
				<div class="col-12">
					<input type="text" class="form-control" id="keyword-field" value="${param.keyword }">
				</div>
				<div class="col-12">
					<button type="button" class="btn btn-outline-primary" id="btn-search" >검색</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function() {
	$('.page-link').click(function(event) {
		event.preventDefault();
		let pageNo = $(this).attr("data-page");
		$(":input[name=page]").val(pageNo);
		
		$("#form-paging").trigger("submit");
	});
	
	$('select[name=sort]').change(function() {
		$(":input[name=page]").val(1);
		$("#form-paging").trigger("submit");
	});
	
	$('#btn-search').click(function() {
		let opt = $("#option-field").val();
		let keyword = $("#keyword-field").val();
		if (opt && keyword) {
			$(":input[name=option]").val(opt);
			$(":input[name=keyword]").val(keyword);
			
			$("#form-paging").trigger("submit");
		}
	});
})
</script>
</body>
</html>