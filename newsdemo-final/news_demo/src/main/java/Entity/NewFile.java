package Entity;

/**
 * Created by Administrator on 2018/6/13.
 */
public class NewFile {
    private String fileName;
    private Long newId;

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public Long getNewId() {
        return newId;
    }

    public void setNewId(Long newId) {
        this.newId = newId;
    }

    @Override
    public String toString() {
        return "NewFile{" +
                "fileName='" + fileName + '\'' +
                ", newId=" + newId +
                '}';
    }
}
