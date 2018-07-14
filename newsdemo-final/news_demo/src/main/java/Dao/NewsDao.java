package Dao;

import Entity.New;
import Entity.NewFile;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2018/6/12.
 */
public interface NewsDao {
    void insertOneRecord(New _new);

    New getNewsById(@Param("id") Long id);

    void insertNewsFiles(List<NewFile> list);

    List<NewFile> getFileNamesByNewsId(String id);

    List<New> getAllNews();

    List<New> getNewsByUsername(String username);

    void modifyNews(New _new);

    @Delete("delete from news_files where news_id = #{id} and file_name = #{fileName}")
    void deleteNewFile(@Param("id") String id, @Param("fileName") String fileName);

    @Delete("delete from news where id = #{id}")
    void deleteOneRecord(String id);

    @Update("update `news` set status = #{status} where id = #{id}")
    void updateNewStatus(@Param("id") Long id, @Param("status") String status);

    List<New> getLastNewList();

    List<New> getNewsByMenuName(String menuName);

    List<New> getNewsBySubmenuName(String submenuName);

    List<New> getNewsByNewsKeyword(@Param("keyword") String keyword,@Param("username")String username);

    List<New> getNewsByConditions(Map<String, String> conditions);

    List<New> getNewsByStatus(@Param("status") String status,@Param("username")String username);

    List<New> getAllNewsInIndex(@Param("menuId") String menuId,@Param("submenuId")String submenuId);
}
