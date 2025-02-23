<%-- 1971261 김정석, 완성 --%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="board.Board"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="boards" scope="request" class="java.util.ArrayList" />
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="css/board.css" type="text/css" media="screen"/>
<head>
    <meta charset="UTF-8">
    <title>게시판 목록</title>
</head>
<body>
<div align="center">
    <h2>게시판 : 목록 화면 </h2>
    <hr>
    
    <div>
        <u><a href="board_control.jsp?action=logOut"> 로그아웃 </a></u>
    </div>
    
    <h2>게시판</h2>
    

    <form method="get" action="board_control.jsp">
        <input type="hidden" name="action" value="search">
        <select name="searchType">
            <option value="title" <%= "title".equals(request.getParameter("searchType")) ? "selected" : "" %>>제목</option>
            <option value="content" <%= "content".equals(request.getParameter("searchType")) ? "selected" : "" %>>내용</option>
        </select>
        <input type="text" name="keyword" value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>" placeholder="검색어 입력">
        <input type="submit" value="검색">
    </form>
    
    <form>
    
        <table style="width: 80%;">
            <tr bgcolor="yellow">
                <th style="width: 10%;">번호</th>
                <th style="width: 40%; min-width: 300px;">제목</th>
                <th style="width: 20%;">작성자</th>
                <th style="width: 30%;">작성일</th>
            </tr>

            <c:set var="boards" value="${boards}"/>
            <c:choose>
                <c:when test="${!empty param.pageNum}">
                    <c:set var="pageNum" value="${param.pageNum}" scope="page"/>
                </c:when>
                <c:otherwise>
                    <c:set var="pageNum" value="1" scope="page"/>
                </c:otherwise>
            </c:choose>
            <c:set var="pageSize" value="10" />
            <c:set var="start" value="${(pageNum - 1) * pageSize}" />
            <c:set var="end" value="${start + pageSize}" />

            <c:forEach var="i" begin="${start}" end="${end - 1}">
                <c:if test="${i < fn:length(boards)}">
                    <c:set var="board" value="${boards[i]}"/>
                    <tr>
                        <td><a href="board_control.jsp?action=detail&board_num=${board.board_num}">${board.board_num}</a></td>
                        <td><a href="board_control.jsp?action=detail&board_num=${board.board_num}">${board.board_title}</a></td>
                        <td>${board.board_name}</td>
                        <td>${board.board_date}</td>
                    </tr>
                </c:if>
            </c:forEach>
        </table>
        
        <div style="width: 80%; text-align: center; margin-top: 20px;">
            <c:set var="totalPages" value="${fn:length(boards) / pageSize + (fn:length(boards) % pageSize == 0 ? 0 : 1)}" />
            <c:if test="${pageNum > 1}">
                <a href="board_control.jsp?action=list&pageNum=${pageNum - 1}">이전</a>
            </c:if>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <c:choose>
                    <c:when test="${i == pageNum}">
                        <strong>${i}</strong>
                    </c:when>
                    <c:otherwise>${i}</c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${pageNum < totalPages - 1 && totalPages > 1}">
                <a href="board_control.jsp?action=list&pageNum=${pageNum + 1}">다음</a>
            </c:if>
        </div>
        <div style="width: 80%; text-align: right; margin-top: 20px;">
            <button style="border: 0px; background: #fff" type="button" onclick="location.href='board_form.jsp'"><u> 글쓰기 </u></button>
        </div>
    </form>
</div>
</body>
</html>
