package online.luffyk.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import online.luffyk.domain.Employee;
import online.luffyk.service.EmployeeService;
import online.luffyk.utils.Result;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

@Controller
public class EmployeeController {
    @Resource
    private EmployeeService employeeService;

    @ResponseBody
    @RequestMapping("emps")
    public Object getEmps(@RequestParam(defaultValue = "1",required = false) Integer from, @RequestParam(defaultValue = "10",required = false) Integer pageSize, Model model){
        //使用PageHelper插件
//        PageHelper.startPage(from,pageSize);
//        List<Employee> employees = employeeService.showAllEmployee2Service();
//        PageInfo<Employee> employeePageInfo = new PageInfo<>(employees,5);
//        model.addAttribute("employeePageInfo",employeePageInfo);
//        return "list";

        PageHelper.startPage(from,pageSize);
        List<Employee> employees = employeeService.showAllEmployee2Service();
        PageInfo<Employee> employeePageInfo = new PageInfo<>(employees,5);
        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("pageInfo",employeePageInfo);
        return new Result("分页信息", hashMap, 200);
    }
}
