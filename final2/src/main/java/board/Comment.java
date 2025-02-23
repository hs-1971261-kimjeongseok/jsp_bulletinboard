package board;

import java.sql.Timestamp;

public class Comment {
    private int commentId;
    private int boardNum;
    private String memberId;
    private String content;
    private Timestamp createdAt;

    public int getCommentId() { return commentId; }
    public void setCommentId(int commentId) { this.commentId = commentId; }

    public int getBoardNum() { return boardNum; }
    public void setBoardNum(int boardNum) { this.boardNum = boardNum; }

    public String getMemberId() { return memberId; }
    public void setMemberId(String memberId) { this.memberId = memberId; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
