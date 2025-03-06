<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-1000">
    <div class="cell center">
        <h1>관리자 - 공지목록</h1>
    </div>
	<div class="cell center">
        <form action="list" method="get">
            <select name="column" class="field">
                <option value="notice_title" ${param.column == '' ? 'selected' : ''}>제목</option>
                <option value="notice_writer" ${param.column == '' ? 'selected' : ''}>작성자</option>
            </select>
            <input type="text" name="keyword" value="" class="field w-50">
            <button class="btn btn-positive">검색</button>
        </form>
    </div>
    
    <div class="cell">
    	<a href="add" class="btn btn-neutral">공지등록</a>
    </div>
    
    <div class="cell my-20">
        <table class="table table-border table-hover table-stripe">
            <thead>
                <tr>
                    <th width="5%">번호</th>
                    <th width="15%">작성자</th>
                    <th>제목</th>
                    <th width="15%">작성일</th>
                </tr>
            </thead>
            <tbody class="center">
                <tr>
                    <td>1</td>
                    <td>작성자</td>
                    <td><a href="detail?noticeNo=">제목</a></td>
                    <td>2025-01-01</td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>작성자</td>
                    <td><a href="detail?noticeNo=">제목</a></td>
                    <td>2025-01-01</td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>작성자</td>
                    <td><a href="detail?noticeNo=">제목</a></td>
                    <td>2025-01-01</td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>작성자</td>
                    <td><a href="detail?noticeNo=">제목</a></td>
                    <td>2025-01-01</td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>작성자</td>
                    <td><a href="detail?noticeNo=">제목</a></td>
                    <td>2025-01-01</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>