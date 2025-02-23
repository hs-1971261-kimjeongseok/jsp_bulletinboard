<%@page import="board.CommentBean"%>
<%@page import="board.Comment"%>
<%@page import="java.util.List"%>
<%@page import="board.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="board" scope="request" class="board.Board"/>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/board.css" type="text/css" media="screen"/>
<meta charset="UTF-8">
<title>board_detail</title>
</head>
<body>
<div align="center">
    <h2>게시판 : 상세 화면 </h2>
    <hr>
    <form>
        <c:set var="board" value="${board}" />
        <table style="width: 80%; max-width: 600px;">
            <tr>
                <th style="width: 15%;">제목</th>
                <td style="width: 35%;">${board.board_title}</td>
                <th style="width: 15%;">번호</th>
                <td style="width: 35%;">${board.board_num}</td>
            </tr>
            <tr>
                <th>작성자</th>
                <td colspan="3">${board.board_name}</td>
            </tr>
            <tr>
                <th>작성일</th>
                <td colspan="3">${board.board_date}</td>
            </tr>
            <tr>
                <th>내용</th>
                <td colspan="3">${board.board_content}</td>
            </tr>
        </table>
        <div style="width: 80%; max-width:600px; margin-top: 20px; display: flex; justify-content: flex-end;">
            <button style="margin: 5px; border: 0px;" type="button" onclick="doUpdate('${board.board_id}')">수정</button>
            <button style="margin: 5px; border: 0px;" type="button" onclick="doRemove('${board.board_id}')">삭제 </button>
            <button style="margin: 5px; border: 0px;" type="button" onclick="location.href='board_control.jsp?action=list'">목록</button>
        </div>
    </form>
    <form action="comment_insert.jsp" method="post">
        <input type="hidden" name="boardNum" value="${board.board_num}">
        <textarea name="content" required></textarea>
        <input type="submit" value="댓글 작성">
    </form>
<h3>댓글 목록</h3>
<%
    CommentBean commentBean = new CommentBean();
    List<Comment> commentList = commentBean.getComments(board.getBoard_num());
    String sessionId = (String) session.getAttribute("s_id");
    String sessionName = (String) session.getAttribute("s_name");
    for (Comment comment : commentList) {
%>
    <p><strong><%= comment.getMemberId() %></strong>: <%= comment.getContent() %>
        <% if (sessionId != null && sessionName.equals(comment.getMemberId())) { %>
            <button type="button" onclick="deleteComment('<%= comment.getMemberId() %>', <%= comment.getCommentId() %>, <%= board.getBoard_num() %>)">삭제</button>
        <% } %>
    </p>
<%
    }
%>
</div>
<script type="text/javascript">
    var s_id = "${s_id}";
    var s_pw = "${s_pw}";

    function doRemove(board_id) {
        var checkPassword = prompt("비밀번호를 입력하세요");
        
        if(board_id == s_id && checkPassword == s_pw){
            var result = confirm("정말로 삭제하시겠습니까?");
            if(result){
                document.location.href="board_control.jsp?action=delete&board_num=${board.board_num}";    
            } else {
                return false;
            }
        } else {
            if(board_id != s_id){
                alert("작성자가 아닙니다.");
            }else {
                alert("비밀번호가 틀렸습니다.");
            }
            return false;
        }
    }

    function doUpdate(board_id) {
        var checkPassword = prompt("비밀번호를 입력하세요");
        
        if(board_id == s_id && checkPassword == s_pw){
            document.location.href="board_control.jsp?action=update&board_num=${board.board_num}";
        } else {
            if(board_id != s_id){
                alert("작성자가 아닙니다.");
            }else {
                alert("비밀번호가 틀렸습니다.");
            }
            return false;
        }
    }

    function deleteComment(member_id, comment_id, board_num) {
        if (confirm("정말로 삭제하시겠습니까?")) {
            document.location.href="comment_delete.jsp?memberid=" + member_id + "&commentid=" + comment_id+ "&boardnum=" + board_num;
        }
    }
</script>
</body>
</html>
