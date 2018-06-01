package entity;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created by Administrator on 2017/12/6.
 */
public class Situation {
    private Integer situationId;
    private String username;
    private Timestamp createTime;

    private List<SituationDetail> situationDetails;

    @Override
    public String toString() {
        return "Situation{" +
                "situationId=" + situationId +
                ", username='" + username + '\'' +
                ", createTime=" + createTime +
                ", situationDetails=" + situationDetails +
                '}';
    }

    public Integer getSituationId() {
        return situationId;
    }

    public void setSituationId(Integer situationId) {
        this.situationId = situationId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public List<SituationDetail> getSituationDetails() {
        for(SituationDetail detail:situationDetails){
            detail.setSituationId(this.situationId);
        }
        return situationDetails;
    }

    public void setSituationDetails(List<SituationDetail> situationDetails) {

        this.situationDetails = situationDetails;
    }

    public void addSituationDetails(List<SituationDetail> list){
        for(SituationDetail situationDetail:list){
            this.situationDetails.add(situationDetail);
        }
    }
}
