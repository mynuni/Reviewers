<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/mypage/mypage.css">
<script src="http://code.jquery.com/jquery-3.1.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/mypage/mypage.js"></script>
<script src="https://kit.fontawesome.com/8e012a278c.js"></script>
<title>리뷰어스 - 마이페이지</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
	<main class="main main-container" id="main">
	<div class="mypage-container">
	<jsp:include page="/WEB-INF/views/common/mypage-menu.jsp" />
		<div class="mypage-content">
			<div class="mypage-edit-title">1:1 문의 내역</div>
			<div class="mypage-edit-container">
				<div class="basic-info">
					<div class="qna-container">
						<div class="qna-title">
							<h3>나의 문의</h3>
						</div>

						<!-- 검색바 -->
						<form method="get" action="/member/myqna">
							<div class="search-container">
								<select name="searchType">
									<option value="" <c:if test="${empty searchCriteria.searchType}">selected</c:if>>전체</option>
									<option value="title" <c:if test="${searchCriteria.searchType == 'title'}">selected</c:if>>제목</option>
									<option value="content" <c:if test="${searchCriteria.searchType == 'content'}">selected</c:if>>내용</option>
									<option value="subject" <c:if test="${searchCriteria.searchType == 'subject'}">selected</c:if>>주제</option>
								</select> <input type="text" name="keyword" placeholder="검색어를 입력하세요" value="${searchCriteria.keyword}">
								<button type="submit">
									<i class="fa fa-search"></i>
								</button>
							</div>
						</form>
						<!-- 검색바 끝 -->

						<!-- 게시판 -->
						<table class="qna-table">
							<thead>
								<tr>
									<th>번호</th>
									<th>구분</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
									<th>상태</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty board}">
										<c:forEach items="${board}" var="board">
											<tr>
												<td class="qna-id">${board.boardId}</td>
												<td class="qna-subject">[${board.subject}]</td>
												<td class="qna-title"><a href="/member/myqna?page=${board.boardId}">${board.title}</a></td>
												<td class="qna-writer">${board.writer}</td>
												<td class="qna-date"><fmt:formatDate value="${board.writeDate}" pattern="yyyy.MM.dd" /></td>
												<td class="qna-status <c:if test="${board.isAnswered == true}">answered</c:if>"><c:if test="${board.isAnswered == false}">처리중</c:if> <c:if test="${board.isAnswered == true}">답변완료</c:if></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td class="result-empty" colspan="6">
												<div>
													<c:choose>
														<c:when test="${empty param.searchType and empty param.keyword}">
															<div>작성하신 문의가 없습니다.</div>
														</c:when>
														<c:otherwise>
															<div>
																<span class="user-keyword">'${param.keyword}'</span>에 대한 검색 결과가 존재하지 않습니다.
															</div>
              												<div>다른 검색어를 사용해보시거나 검색 기준을 변경해보세요.</div>
														</c:otherwise>
													</c:choose>
												</div>
											</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
						<!-- 게시판 끝 -->
					</div>

					<!-- 페이징 -->
					<div class="page-container">
						<c:if test="${pageMaker.prev}">
							<a class="page-group-btn" href="/member/myqna?page=${pageMaker.startPage - 1}&searchType=${searchCriteria.searchType}&keyword=${searchCriteria.keyword}"> <i class="fa-solid fa-chevron-left"></i>
							</a>
						</c:if>
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="page">
							<c:choose>
								<c:when test="${page eq searchCriteria.page}">
									<a class="currentPage">${page}</a>
								</c:when>
								<c:otherwise>
									<a class="page-link" href="/member/myqna?page=${page}&perPageNum=${searchCriteria.perPageNum}&searchType=${searchCriteria.searchType}&keyword=${searchCriteria.keyword}">${page}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${pageMaker.next}">
							<a class="page-group-btn" href="/member/myqna?page=${pageMaker.endPage + 1}&perPageNum=${searchCriteria.perPageNum}&searchType=${searchCriteria.searchType}&keyword=${searchCriteria.keyword}"><i class="fa-solid fa-chevron-right"></i></a>
						</c:if>
					</div>
					<!-- 페이징 끝 -->
				</div>
			</div>
		</div>
	</div>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script>
		$(function() {
			// 뒤로가기 버튼
			$(".btn__cancel").click(function() {
				history.back();
			});

			// 회원가입 버튼
			$(".btn__sign-up").click(function() {
				$(location).attr("href", "/member/sign-up");
			});

			// 하단 팝업
			$(".pop-up__bottom").show(function() {
				$(this).delay(700).fadeOut(2000);
			});

			$(".imgModBtn").on("click", function() {
				var file = $("#file").val();
				if (file == "") {
					alert("파일을 선택해주세요.");
					return;
				}
				$("#userImageForm").submit();
			});
		});
	</script>
</body>
</html>