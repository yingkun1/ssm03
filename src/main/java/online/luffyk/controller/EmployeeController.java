package online.luffyk.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import online.luffyk.domain.Employee;
import online.luffyk.service.EmployeeService;
import online.luffyk.utils.Result;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

@Controller
public class EmployeeController {
    @Resource
    private EmployeeService employeeService;

    @ResponseBody
    @RequestMapping(value = "emps",method = RequestMethod.GET)
    public Object getEmps(@RequestParam(defaultValue = "1",required = false) Integer from, @RequestParam(defaultValue = "10",required = false) Integer pageSize, Model model){
        PageHelper.startPage(from,pageSize);
        List<Employee> employees = employeeService.showAllEmployee2Service();
        PageInfo<Employee> employeePageInfo = new PageInfo<>(employees,5);
        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("pageInfo",employeePageInfo);
        return new Result("分页信息", hashMap, 200);
    }

    @ResponseBody
    @RequestMapping(value = "emp",method = RequestMethod.POST)
    public Object saveEmps(@Valid Employee employee, BindingResult bindingResult){
        if(!bindingResult.hasErrors()){
            System.out.println("employee:"+employee);
            Integer count = employeeService.insertEmployeeService(employee);
            System.out.println("count:"+count);
            if(count == 1){
                return new Result("插入成功",null,200);
            }else{
                return new Result("插入失败",null,400);
            }
        }else{
            HashMap<String, Object> hashMap = new HashMap<>();
            List<FieldError> fieldErrors = bindingResult.getFieldErrors();
            for(FieldError fieldError:fieldErrors){
                System.out.println("错误的字段:"+fieldError.getField());
                System.out.println("错误的信息:"+fieldError.getDefaultMessage());
                hashMap.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            HashMap<String, Object> map = new HashMap<>();
            map.put("errorFields",hashMap);
            return new Result("插入失败",map,400);
        }

    }

    @ResponseBody
    @RequestMapping("checkuser")
    public Object checkEmpName(String empName){
        System.out.println("empName:"+empName);
        if(empName.length()<3){
            return new Result("用户名最少需要三个字符",false,400);
        }
        Integer count = employeeService.checkEmpNameService(empName);
        if(count>0){
            return new Result("用户名已存在",false,400);
        }else{
            return new Result("用户名可以使用",true,200);
        }
    }

    @ResponseBody
    @RequestMapping(value = "emp/{empId}",method = RequestMethod.GET)
    public Object getEmp(@PathVariable("empId")Integer empId){
        System.out.println("empId:"+empId);
        Employee employee = this.employeeService.getEmployeeService(empId);
        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("empInfo",employee);
        if(employee!=null){
            return new Result("员工信息获取成功",hashMap,200);
        }else{
            return new Result("员工信息获取失败",null,400);
        }
    }

    @ResponseBody
    @RequestMapping(value = "emp/{empId}",method = RequestMethod.PUT)
    public Object updateEmp(Employee employee, HttpServletRequest httpServletRequest){
        System.out.println("employee:"+employee);
        Enumeration parameterNames = httpServletRequest.getParameterNames();
        while (parameterNames.hasMoreElements()){
            String key = (String)parameterNames.nextElement();
            String value = httpServletRequest.getParameter(key);
            System.out.println("key:"+key+",value:"+value);
        }
//        Integer count = employeeService.updateEmployeeService(employee);
//        if(count==1){
//            return new Result("员工信息修改成功",true,200);
//        }else{
//            return new Result("员工信息修改成功",true,400);
//        }
        return null;
    }
}
