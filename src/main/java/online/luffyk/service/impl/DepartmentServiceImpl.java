package online.luffyk.service.impl;

import online.luffyk.dao.DepartmentMapper;
import online.luffyk.domain.Department;
import online.luffyk.service.DepartmentService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class DepartmentServiceImpl implements DepartmentService {
    @Resource
    private DepartmentMapper departmentMapper;

    @Override
    public Integer insertOneDepartmentService(Department department) {
        return departmentMapper.insertOneDepartment(department);
    }

    @Override
    public List<Department> showAllDepartmentService() {
        return departmentMapper.showAllDepartment();
    }
}
