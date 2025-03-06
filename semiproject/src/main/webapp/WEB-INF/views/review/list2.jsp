<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-1000">
    <div class="cell center">
        <h1>후기 목록</h1>
    </div>
	<div class="cell center">
        <form action="list" method="get">
            <select name="column" class="field">
                <option value="place_no" ${param.column == '' ? 'selected' : ''}>여행지</option>
                <option value="review_writer" ${param.column == '' ? 'selected' : ''}>작성자</option>
            </select>
            <input type="text" name="keyword" value="" class="field w-50">
            <button class="btn btn-positive">검색</button>
        </form>
    </div>
    
    <div class="cell my-20">
        <table class="table table-border table-hover table-stripe">
            <thead>
                <tr>
                    <th width="5%">번호</th>
                    <th width="15%">작성자</th>
                    <th width="15%">여행지</th>
                    <th>제목</th>
                    <th width="7%">조회수</th>
                    <th width="15%">작성일</th>
                </tr>
            </thead>
            <tbody class="center">
                <tr>
                    <td>1</td>
                    <td>작성자</td>
                    <td>~~공원</td>
                    <td><a href="detail?reviewNo=">제목</a></td>
                    <td>조회수</td>
                    <td>2025-01-01</td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>작성자</td>
                    <td>~~공원</td>
                    <td><a href="detail?reviewNo=">제목</a></td>
                    <td>조회수</td>
                    <td>2025-01-01</td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>작성자</td>
                    <td>~~공원</td>
                    <td><a href="detail?reviewNo=">제목</a></td>
                    <td>조회수</td>
                    <td>2025-01-01</td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>작성자</td>
                    <td>~~공원</td>
                    <td><a href="detail?reviewNo=">제목</a></td>
                    <td>조회수</td>
                    <td>2025-01-01</td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>작성자</td>
                    <td>~~공원</td>
                    <td><a href="detail?reviewNo=">제목</a></td>
                    <td>조회수</td>
                    <td>2025-01-01</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
