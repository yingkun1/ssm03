<%--
  Created by IntelliJ IDEA.
  User: luffyk
  Date: 2020/7/14
  Time: 14:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>" />
    <title>Title</title>
    <script type="text/javascript" src="static/js/jquery-1.12.4.min.js"></script>
    <link type="text/css" href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <script type="text/javascript" src="static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</head>
<body>
    <!--搭建显示页面-->
    <div class="container">
        <!--标题行-->
        <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>
        <!--按钮行-->
        <div class="row">
            <div style="margin-left: 1000px">
                <button>新增</button>
                <button>删除</button>
            </div>
        </div>
        <!--数据行-->
        <div class="row">
            <div>
                <table class="table" style="border: solid 1px">
                    <tr>
                        <th>id</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>邮箱</th>
                        <th>部门</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${employeePageInfo.list}" var="employee">
                        <tr>
                            <th>${employee.empId}</th>
                            <th>${employee.empName}</th>
                            <th>
                                <c:choose>
                                    <c:when test="${employee.gender eq 'M'}">男</c:when>
                                    <c:otherwise>女</c:otherwise>
                                </c:choose>
                            </th>
                            <th>${employee.email}</th>
                            <th>${employee.department.deptName}</th>
                            <th>
                                <button>编辑</button>
                                <button>删除</button>
                            </th>
                        </tr>
                    </c:forEach>

                </table>
            </div>
        </div>
        <!--分页行-->
        <div class="row">
            <div>
                当前第${employeePageInfo.pageNum}页,共有${employeePageInfo.pages}页,总计${employeePageInfo.total}条记录
            </div>
            <div>
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li><a href="/emps">首页</a></li>
                        <c:if test="${employeePageInfo.hasPreviousPage}">
                            <li>
                                <a href="/emps?from=${employeePageInfo.prePage}&pageSize=10" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach items="${employeePageInfo.navigatepageNums}" var="navigatepageNum">
                                <li><a href="/emps?from=${navigatepageNum}&pageSize=10">${navigatepageNum}</a></li>
                        </c:forEach>
                        <c:if test="${employeePageInfo.hasNextPage}">
                            <li>
                                <a href="/emps?from=${employeePageInfo.nextPage}&pageSize=10" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <li><a href="/emps?from=${employeePageInfo.pages}&pageSize=10">末页</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</body>
</html>

