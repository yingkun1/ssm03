package online.luffyk.controller;

import online.luffyk.domain.Department;
import online.luffyk.service.DepartmentService;
import online.luffyk.utils.Result;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

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


    @ResponseBody
    @RequestMapping("depts")
    public Object getDepartments(){
        List<Department> departments = departmentService.showAllDepartmentService();
        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("departments",departments);
        if(departments.size()>0){
            return new Result("所有部门的信息",hashMap,200);
        }else{
            return new Result("没有获取到部门的信息",hashMap,400);
        }
    }

}
