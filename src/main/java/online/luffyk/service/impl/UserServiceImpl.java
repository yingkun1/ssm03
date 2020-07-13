package online.luffyk.service.impl;

import online.luffyk.dao.UserMapper;
import online.luffyk.domain.User;
import online.luffyk.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Resource
    private UserMapper userMapper;

    @Override
    public List<User> showAllUsersService() {
        return userMapper.showAllUsers();
    }
}
