package online.luffyk.dao;

import online.luffyk.domain.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserMapper {
    /**
     *
     * @return 获取所有用户的信息
     */
    List<User> showAllUsers();
}
