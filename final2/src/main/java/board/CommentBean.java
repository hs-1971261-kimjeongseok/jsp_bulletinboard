package board;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentBean {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public CommentBean() {
        try {
            String dbURL = "jdbc:mysql://127.0.0.1:3306/jspdb";
            String dbID = "jspbook1";
            String dbPassword = "hansung";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int insertComment(Comment comment) {
        String SQL = "INSERT INTO comments(board_num, m_id, content) VALUES (?, ?, ?)";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, comment.getBoardNum());
            pstmt.setString(2, comment.getMemberId());
            pstmt.setString(3, comment.getContent());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // Database error
    }

    public List<Comment> getComments(int boardNum) {
        String SQL = "SELECT * FROM comments WHERE board_num = ?";
        List<Comment> commentList = new ArrayList<Comment>();
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, boardNum);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Comment comment = new Comment();
                comment.setCommentId(rs.getInt("comment_id"));
                comment.setBoardNum(rs.getInt("board_num"));
                comment.setMemberId(rs.getString("m_id"));
                comment.setContent(rs.getString("content"));
                comment.setCreatedAt(rs.getTimestamp("created_at"));
                commentList.add(comment);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return commentList;
    }

    public int deleteComment(String memberId, int commentId) {
        String SQL = "DELETE FROM comments WHERE comment_id = ? AND m_id = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, commentId);
            pstmt.setString(2, memberId);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // Database error
    }

}