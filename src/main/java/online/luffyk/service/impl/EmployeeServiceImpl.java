package online.luffyk.service.impl;

import online.luffyk.dao.EmployeeMapper;
import online.luffyk.domain.Employee;
import online.luffyk.service.EmployeeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {
    @Resource
    private EmployeeMapper employeeMapper;

    @Override
    public Integer insertOneEmployeeService(Employee employee) {
        return employeeMapper.insertOneEmployee(employee);
    }

    @Override
    public List<Employee> showAllEmployeeService(Integer start, Integer pageSize) {
        return employeeMapper.showAllEmployee(start,pageSize);
    }

    @Override
    public List<Employee> showAllEmployee2Service() {
        return employeeMapper.showAllEmployee2();
    }

    @Override
    public Integer insertEmployeeService(Employee employee) {
        return employeeMapper.insertEmployee(employee);
    }

    @Override
    public Integer checkEmpNameService(String empName) {
        return employeeMapper.checkEmpName(empName);
    }

    @Override
    public Employee getEmployeeService(Integer empId) {
        return employeeMapper.getEmployee(empId);
    }

    @Override
    public Integer updateEmployeeService(Employee employee) {
        return employeeMapper.updateEmployee(employee);
    }
}
