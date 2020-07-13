package online.luffyk.dao;

import online.luffyk.dao.DepartmentMapper;
import online.luffyk.domain.Department;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class DepartmentMapperTest {
    @Resource
    private DepartmentMapper departmentMapper;

    @Test
    public void testInsertOneDepartment(){
        Department department = new Department(null, "测试部123");
        Integer count = departmentMapper.insertOneDepartment(department);
        System.out.println("影响的行数:"+count);
    }
}
