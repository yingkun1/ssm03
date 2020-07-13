package online.luffyk.controller;

import online.luffyk.domain.User;
import online.luffyk.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.List;

@RequestMapping("user")
@Controller
public class UserController {
    @Resource
    private UserService userService;

    @RequestMapping("hello")
    public String hello(){
        System.out.println("你好SpringMVC");
        List<User> users = userService.showAllUsersService();
        for(User user:users){
            System.out.println(user);
        }
        return "hello";
    }
}
