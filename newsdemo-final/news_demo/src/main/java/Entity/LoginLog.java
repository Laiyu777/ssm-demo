package Entity;

import java.sql.Timestamp;

/**
 * Created by Administrator on 2018/5/31.
 */
public class LoginLog {
    private String username;
    private Timestamp loginTime;
    private String ipAddress;
    private String result;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Timestamp getLoginTime() {
        return loginTime;
    }

    public void setLoginTime(Timestamp loginTime) {
        this.loginTime = loginTime;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    @Override
    public String toString() {
        return "LoginLog{" +
                "username='" + username + '\'' +
                ", loginTime=" + loginTime +
                ", ipAddress='" + ipAddress + '\'' +
                ", result='" + result + '\'' +
                '}';
    }
}
