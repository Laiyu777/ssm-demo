package Entity;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

/**
 * Created by Administrator on 2018/6/26.
 */
public class StayInfo {
    private Long id;
    private String content1;
    private String content2;
    private String deptName;
    private Date date;

    List<Employee> dayEmps;
    List<Employee> nightEmps;

    public List<Employee> getDayEmps() {
        return dayEmps;
    }

    public void setDayEmps(List<Employee> dayEmps) {
        this.dayEmps = dayEmps;
    }

    public List<Employee> getNightEmps() {
        return nightEmps;
    }

    public void setNightEmps(List<Employee> nightEmps) {
        this.nightEmps = nightEmps;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getContent1() {
        return content1;
    }

    public void setContent1(String content1) {
        this.content1 = content1;
    }

    public String getContent2() {
        return content2;
    }

    public void setContent2(String content2) {
        this.content2 = content2;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Override
    public String toString() {
        return "StayInfo{" +
                "id=" + id +
                ", content1='" + content1 + '\'' +
                ", content2='" + content2 + '\'' +
                ", deptName='" + deptName + '\'' +
                ", date=" + date +
                ", dayEmps=" + dayEmps +
                ", nigtEmps=" + nightEmps +
                '}';
    }
}
