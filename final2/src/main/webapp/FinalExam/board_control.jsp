<%-- 1971261 김정석, 완성 --%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="board.Board"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="board.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mb" scope="page" class="board.MemberBean"/>
<jsp:useBean id="member" class="board.Member"/>
<jsp:setProperty name="member" property="*"/>

<jsp:useBean id="boardbean" scope="page" class="board.BoardBean"/>
<jsp:useBean id="board" class="board.Board"/>
<jsp:setProperty name="board" property="*"/>


<%
    String action = request.getParameter("action");

    if (action == null || action.equals("list")) {
        ArrayList<Board> boards = boardbean.getBoardList();
        request.setAttribute("boards", boards);
        pageContext.forward("board_list.jsp");
    }

    if(action.equals("search")) {
        String keyword = request.getParameter("keyword");
        String searchType = request.getParameter("searchType");
        ArrayList<Board> boards;

        if (keyword != null && !keyword.trim().isEmpty()) {
            if ("title".equals(searchType)) {
                boards = boardbean.searchBoardsByTitle(keyword);
            } else if ("content".equals(searchType)) {
                boards = boardbean.searchBoardsByContent(keyword);
            } else {
                boards = boardbean.getBoardList();
            }
        } else {
            boards = boardbean.getBoardList();
        }

        request.setAttribute("boards", boards);
        pageContext.forward("board_list.jsp");
    }


    if(action.equals("login")){
        response.sendRedirect("login.jsp");
    }


    if (action.equals("join")){
        if(mb.insertMember(member)){
            response.sendRedirect("board_control.jsp?action=login");
        } else {
            throw new Exception("회원가입 오류");
        }
    }


    if(action.equals("loginProc")){
        String m_id = member.getM_id();
        String m_pw = member.getM_pw();
        
        if(mb.checkMember(m_id, m_pw)){
            session.setAttribute("s_id", m_id);
            session.setAttribute("s_pw", m_pw);
            session.setAttribute("s_name", mb.getUserName(m_id));
            
            response.sendRedirect("board_control.jsp?action=list");
        } else {
            response.sendRedirect("board_control.jsp?action=login");
        }
    }

    if(action.equals("logOut")){
        session.removeAttribute("s_id");
        response.sendRedirect("board_control.jsp?action=login");
    }


    if(action.equals("insertBoard")){
        if(boardbean.insertBoard(board)){
            response.sendRedirect("board_control.jsp?action=list");
        } else {
            throw new Exception("게시글작성 오류");
        }
    }

    if(action.equals("detail")){
        int board_num = Integer.parseInt(request.getParameter("board_num"));
        if(boardbean.getBoard(board_num) != null){
            Board boardData = boardbean.getBoard(board_num);
            request.setAttribute("board", boardData);
            pageContext.forward("board_detail.jsp");
        } else{
            throw new Exception("게시글조회 오류");
        }
    }

    if(action.equals("delete")){
        int board_num = Integer.parseInt(request.getParameter("board_num"));
        if(boardbean.deleteBoard(board_num)){
            response.sendRedirect("board_control.jsp?action=list");
        } else {
            throw new Exception("DB삭제 오류");
        }
    }


    if(action.equals("update")){
        int board_num = Integer.parseInt(request.getParameter("board_num"));
        if(boardbean.getBoard(board_num) != null){
            Board boardData = boardbean.getBoard(board_num);
            request.setAttribute("board", boardData);
            pageContext.forward("board_update.jsp");
        } else {
            throw new Exception("DB수정 오류");
        }
    }


    if(action.equals("updateProc")){
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String today = sdf.format(date);
        board.setBoard_date(today);

        if(boardbean.updateBoard(board)){
            response.sendRedirect("board_control.jsp?action=list");
        } else {
            throw new Exception("DB수정 오류");
        }
    }


    if(action.equals("memberDelete")) {
        String m_id = request.getParameter("m_id");
        String m_pw = request.getParameter("m_pw");
        String re_m_pw = request.getParameter("re_m_pw");

        // 유효성 검사
        // 1) 아이디가 존재하는지
        if(mb.checkIdValidation(m_id)){
            // 2) 비밀번호, 비밀번호 확인이 일치하는지
            if(m_pw.equals(re_m_pw)) {
                // 3) 아이디 비밀번호 체크
                if(mb.checkMember(m_id, m_pw)){
                    if(mb.deleteUser(m_id, m_pw)){
                        pageContext.forward("login.jsp");
                    } else {
                        throw new Exception("회원 탈퇴 실패");
                    }
                } else {
                    request.setAttribute("msg","회원 정보가 일치하지 않습니다.");
                    pageContext.forward("member_delete.jsp");
                }
            } else {
                request.setAttribute("msg","해당 비밀번호가 일치하지 않습니다.");
                pageContext.forward("member_delete.jsp");
            }
        } else {
            request.setAttribute("msg","해당 아이디가 존재하지 않습니다.");
            pageContext.forward("member_delete.jsp");
        }
    }
%>
