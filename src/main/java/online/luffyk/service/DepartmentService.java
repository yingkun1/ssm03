package online.luffyk.service;

import online.luffyk.domain.Department;

import java.util.List;

public interface DepartmentService {
    Integer insertOneDepartmentService(Department department);

    List<Department> showAllDepartmentService();
}
