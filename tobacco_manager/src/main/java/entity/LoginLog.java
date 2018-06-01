package entity;

import java.sql.Timestamp;

/**
 * 日志类的实体
 * Created by Administrator on 2018/3/22.
 */
public class LoginLog {
    private Timestamp loginTime;
    private String username;
    private String ipAddress;
    private String result;

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public Timestamp getLoginTime() {
        return loginTime;
    }

    public void setLoginTime(Timestamp loginTime) {
        this.loginTime = loginTime;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    @Override
    public String toString() {
        return "LoginLog{" +
                "loginTime=" + loginTime +
                ", username='" + username + '\'' +
                ", ipAddress='" + ipAddress + '\'' +
                ", result='" + result + '\'' +
                '}';
    }
}
