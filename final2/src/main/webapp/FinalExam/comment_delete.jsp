<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.CommentBean"%>
<%
    request.setCharacterEncoding("UTF-8");
    int commentId = Integer.parseInt(request.getParameter("commentid"));
    int boardnum = Integer.parseInt(request.getParameter("boardnum"));
    String memberid = request.getParameter("memberid");
    String memberId = (String) session.getAttribute("s_name");
	
    if (!memberId.equals(memberid) && !memberId.equals("admin")) {
        out.println("<script>");
        out.println("alert('댓글 작성자가 아닙니다.');");
        out.println("history.back();");
        out.println("</script>");
    } else {
        CommentBean commentBean = new CommentBean();
        int result = commentBean.deleteComment(memberid,commentId);

        if (result == 1) {
        	response.sendRedirect("board_control.jsp?action=detail&board_num=" + boardnum);
        
        } else {
            out.println("<script>");
            out.println("alert('댓글 삭제에 실패했습니다.');");
            out.println("history.back();");
            out.println("</script>");
        }
    }
%>
