package entity;

/**
 * Created by Administrator on 2018/3/26.
 */
public class DataWrapper {
    private boolean isUploaded;
    private  Situation situation;

    public boolean isUploaded() {
        return isUploaded;
    }

    public void setUploaded(boolean uploaded) {
        isUploaded = uploaded;
    }

    public Situation getSituation() {
        return situation;
    }

    public void setSituation(Situation situation) {
        this.situation = situation;
    }
}
