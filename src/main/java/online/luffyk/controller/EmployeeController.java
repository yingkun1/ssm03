package online.luffyk.controller;

import online.luffyk.domain.Employee;
import online.luffyk.service.EmployeeService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

@RequestMapping("employee")
@Controller
public class EmployeeController {
    @Resource
    private EmployeeService employeeService;

    @RequestMapping("insert")
    public String insertEmployee(){
        Employee employee = new Employee(null, "赵六", "男", "9258456@qq.com", 1, null);
        Integer count = employeeService.insertOneEmployeeService(employee);
        System.out.println("受影响的行数为:"+count);
        return "hello";
    }
}
