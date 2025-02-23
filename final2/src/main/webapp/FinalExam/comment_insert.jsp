<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.CommentBean"%>
<%@ page import="board.Comment"%>
<%
    request.setCharacterEncoding("UTF-8");
    int boardNum = Integer.parseInt(request.getParameter("boardNum"));
    String memberId = (String)session.getAttribute("s_name");
    String content = request.getParameter("content");

    if (memberId == null) {
        out.println("<script>");
        out.println("alert('로그인이 필요합니다.');");
        out.println("location.href='login.jsp';");
        out.println("</script>");
    } else {
        Comment comment = new Comment();
        comment.setBoardNum(boardNum);
        comment.setMemberId(memberId);
        comment.setContent(content);

        CommentBean commentBean = new CommentBean();
        int result = commentBean.insertComment(comment);

        if (result == 1) {
            response.sendRedirect("board_control.jsp?action=detail&board_num=" + boardNum);
        } else {
            out.println("<script>");
            out.println("alert('댓글 작성에 실패했습니다.');");
            out.println("history.back();");
            out.println("</script>");
        }
    }
%>
