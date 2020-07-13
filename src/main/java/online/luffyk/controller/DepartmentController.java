package online.luffyk.controller;

import online.luffyk.domain.Department;
import online.luffyk.service.DepartmentService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

@RequestMapping("department")
@Controller
public class DepartmentController {
    @Resource
    private DepartmentService departmentService;

    @RequestMapping("insert")
    public String insertDepartment(){
        Department department = new Department();
        department.setDeptName("餐饮部");
        Integer count = departmentService.insertOneDepartmentService(department);
        System.out.println("受影响的行数为:"+count);
        return "hello";
    }
}
