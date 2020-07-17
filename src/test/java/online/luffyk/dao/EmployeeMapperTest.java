package online.luffyk.dao;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import online.luffyk.domain.Employee;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.List;
import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class EmployeeMapperTest {
    @Resource
    private EmployeeMapper employeeMapper;

//    @Resource
//    private SqlSessionTemplate sqlSessionTemplate;

    @Test
    public void testInsertOneEmployee(){
        Employee employee = new Employee(null, "张杰", "M", "ZHANGJIE@qq.com", 1, null);
        Integer count = employeeMapper.insertOneEmployee(employee);
        System.out.println("受影响的行数："+count);
    }

//    @Test
//    public void testBatchInsertEmployee(){
//        EmployeeMapper employeeMapper = sqlSessionTemplate.getMapper(EmployeeMapper.class);
//        for(int i=0;i<1000;i++){
//            String uuid = UUID.randomUUID().toString().substring(0, 6) + i;
//            Employee employee = new Employee(null, uuid, "M", uuid+"@qq.com", 1, null);
//            employeeMapper.insertOneEmployee(employee);
//        }
//        System.out.println("批处理操作完成");
//    }

    @Test
    public void testShowAllEmployee(){
        int from =-10;
        int pageSize=10;
        PageHelper.startPage(from,pageSize);
        List<Employee> employees = employeeMapper.showAllEmployee2();
        PageInfo<Employee> employeePageInfo = new PageInfo<>(employees,5);
        System.out.println(employeePageInfo);
//        List<Employee> list = employeePageInfo.getList();
//        for(Employee employee:list){
//            System.out.println(employee);
//        }
//        int[] navigatepageNums = employeePageInfo.getNavigatepageNums();
//        for(int value:navigatepageNums){
//            System.out.println(value);
//        }
//        int pageSize1 = employeePageInfo.getPageSize();
//        System.out.println("该页面的记录条数为:"+pageSize1);
//        int pageNum = employeePageInfo.getPageNum();
//        System.out.println("当前页面的页码为:"+pageNum);
//        long total = employeePageInfo.getTotal();
//        System.out.println("查询到的总记录数："+total);
//        int prePage = employeePageInfo.getPrePage();
//        int nextPage = employeePageInfo.getNextPage();
//        System.out.println("前一页："+prePage);
//        System.out.println("后一页："+nextPage);
    }

    @Test
    public void testSaveEmployee(){
        Employee employee = new Employee(null, "刘侠234", "F", "123@qq.com", 1,null);
        Integer count = employeeMapper.insertOneEmployee(employee);
        System.out.println("受影响的行数:"+count);
    }

    @Test
    public void testCheckEmpName(){
        Integer count = employeeMapper.checkEmpName("kun yingasdasdasdasdasdasdasd");
        System.out.println("同名的人数为："+count);
    }


    @Test
    public void testGetEmployee(){
        Employee employee = employeeMapper.getEmployee(1);
        System.out.println(employee);
    }

    @Test
    public void testUpdateEmployee(){
//        Employee employee = new Employee(1027, "刘侠234", "F", "123343423424@qq.com", 1,null);
        Employee employee = new Employee(1027, "刘侠343247",null, null, null,null);
        Integer count = employeeMapper.updateEmployee(employee);
        System.out.println("受影响的行数:"+count);
    }

    @Test
    public void test(){
        String str = "1-2-3-4-5-6-7-8";
        String[] split = str.split("-");
        for(String value:split){
            System.out.println(value);
        }
    }
}
