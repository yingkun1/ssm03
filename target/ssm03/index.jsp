<%--
  Created by IntelliJ IDEA.
  User: luffyk
  Date: 2020/7/13
  Time: 17:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<script type="text/javascript">
    $(function () {
        $.ajax({
            url: "/emps",
            data: "from=2&pageSize=10",
            type: "GET",
            dataType: "json",
            success: function(data) {
                console.log(data);
                build_emps_table(data);
                build_page_info(data);
                build_page_nav(data);
            }
        });
        function build_emps_table(result) {
            var emplist = result.data.pageInfo.list;
            $.each(emplist,function (index,item) {
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var genderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
                var emailTd = $("<td></td>").append(item.email);
                var deptNameTd =$("<td></td>").append(item.department.deptName);
                var editButTd = $("<button></button>").append("编辑");
                var deleteButTd = $("<button></button>").append("删除");
                var btnTd=$("<td></td>").append(editButTd).append(" ").append(deleteButTd);
                $("<tr></tr>").append(empIdTd).append(empNameTd).append(genderTd).append(emailTd).append(deptNameTd).append(btnTd).appendTo("#emps_tables tbody")
            })
        }
        function build_page_info(result) {
            var pageInfo = result.data.pageInfo;
            $("#page_info_area").append("当前第"+pageInfo.pageNum+"页,共有"+pageInfo.pages+"页,总计"+pageInfo.total+"条记录")
        }
        function build_page_nav(result) {
            var ul = $("<ul></ul>");
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
            ul.append(firstPageLi).append(prePageLi);
            var prePageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
            var navigatepageNums = result.data.pageInfo.navigatepageNums;
            $.each(navigatepageNums,function (index,item) {
                var numsLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
                ul.append(numsLi);
            });
            ul.append(prePageLi);
            ul.append(lastPageLi);
            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area")
        }
    })
</script>
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
            <table style="border: solid 1px" id="emps_tables">
                <thead>
                    <tr>
                        <th>id</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>邮箱</th>
                        <th>部门</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>



            </table>
        </div>
    </div>
    <!--分页行-->
    <div class="row">
        <div id="page_info_area">

        </div>
        <div id="page_nav_area">

        </div>
    </div>
</div>
</body>
</html>