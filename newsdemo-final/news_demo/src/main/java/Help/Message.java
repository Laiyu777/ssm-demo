package Help;

/**
 * Created by Administrator on 2018/5/31.
 */
public class Message {
    private Integer code;
    private String info;

    public Message(){}

    public Message(Integer code, String info){
        this.code = code;
        this.info = info;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    @Override
    public String toString() {
        return "Message{" +
                "code=" + code +
                ", info='" + info + '\'' +
                '}';
    }
}
