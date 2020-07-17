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

    /**
     *
     * @param employee 员工的信息
     * @return 返回受影响的行数
     */
    Integer insertEmployee(Employee employee);

    /**
     *
     * @param empName 员工姓名
     * @return 同名的人数
     */
    Integer checkEmpName(String empName);

    /**
     *
     * @param empId 员工id
     * @return 根据员工id返回员工的信息
     */
    Employee getEmployee(Integer empId);

    Integer updateEmployee(Employee employee);

    /**
     *
     * @param empIds 要删除的员工id集合
     * @return 返回删除的行数
     */
    Integer deleteEmpById(List<Integer> empIds);


}
