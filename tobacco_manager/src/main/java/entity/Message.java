package entity;

import java.sql.Timestamp;

/**
 * Created by Administrator on 2018/3/29.
 */
public class Message {
    private String to;
    private String from;
    private Timestamp date;
    private int userIfRead;
    private int adminIfRead;
    private int ifReply;
    private String content;

    private int id;

    private String theme;



    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public int getUserIfRead() {
        return userIfRead;
    }

    public void setUserIfRead(int userIfRead) {
        this.userIfRead = userIfRead;
    }

    public int getAdminIfRead() {
        return adminIfRead;
    }

    public void setAdminIfRead(int adminIfRead) {
        this.adminIfRead = adminIfRead;
    }

    public int getIfReply() {
        return ifReply;
    }

    public void setIfReply(int ifReply) {
        this.ifReply = ifReply;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
