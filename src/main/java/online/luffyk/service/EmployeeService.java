package online.luffyk.service;

import online.luffyk.domain.Employee;

import java.util.List;

public interface EmployeeService {
    Integer insertOneEmployeeService(Employee employee);

    List<Employee> showAllEmployeeService(Integer start, Integer pageSize);

    List<Employee> showAllEmployee2Service();
}
