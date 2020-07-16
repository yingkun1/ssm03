package online.luffyk.service;

import online.luffyk.domain.Employee;

import java.util.List;

public interface EmployeeService {
    Integer insertOneEmployeeService(Employee employee);

    List<Employee> showAllEmployeeService(Integer start, Integer pageSize);

    List<Employee> showAllEmployee2Service();

    Integer insertEmployeeService(Employee employee);

    Integer checkEmpNameService(String empName);

    Employee getEmployeeService(Integer empId);

    Integer updateEmployeeService(Employee employee);
}
