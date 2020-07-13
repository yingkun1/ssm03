package online.luffyk.dao;

import online.luffyk.domain.Employee;
import org.springframework.stereotype.Repository;

@Repository
public interface EmployeeMapper {
    /**
     *
     * @param employee 员工的信息
     * @return 受影响的行数
     */
    Integer insertOneEmployee(Employee employee);
}
