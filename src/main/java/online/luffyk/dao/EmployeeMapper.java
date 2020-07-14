package online.luffyk.dao;

import online.luffyk.domain.Employee;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EmployeeMapper {
    /**
     *
     * @param employee 员工的信息
     * @return 受影响的行数
     */
    Integer insertOneEmployee(Employee employee);

    /**
     *
     * @return 获取所有的员工信息，以及员工的部门名称
     * @param start
     * @param pageSize
     */
    List<Employee> showAllEmployee(@Param("start") Integer start,@Param("pageSize") Integer pageSize);

    /**
     *
     * @return 获取所有的员工信息，以及员工的部门名称
     */
    List<Employee> showAllEmployee2();
}
