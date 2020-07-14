package online.luffyk.dao;

import online.luffyk.domain.Department;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DepartmentMapper {
    /**
     *
     * @param department 部门的信息
     * @return 影响的行数
     */
    Integer insertOneDepartment(Department department);

    /**
     *
     * @return 获取所有的部门信息
     */
    List<Department> showAllDepartment();
}
