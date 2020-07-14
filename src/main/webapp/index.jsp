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
            to_page(1,10);
        });

        function to_page(from,pageSize) {
            $.ajax({
                url: "/emps",
                data: "from="+from+"&pageSize="+pageSize,
                type: "GET",
                dataType: "json",
                success: function(data) {
                    console.log(data);
                    build_emps_table(data);
                    build_page_info(data);
                    build_page_nav(data);
                }
            });
        }
        function build_emps_table(result) {
            $("#emps_tables tbody").empty();
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
            $("#page_info_area").empty();
            var pageInfo = result.data.pageInfo;
            $("#page_info_area").append("当前第"+pageInfo.pageNum+"页,共有"+pageInfo.pages+"页,总计"+pageInfo.total+"条记录")
        }
        function build_page_nav(result) {
            $("#page_nav_area").empty();
            var ul = $("<ul></ul>");
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            firstPageLi.click(function () {
                to_page(1,10);
            });
            if(result.data.pageInfo.hasPreviousPage){
                var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
                prePageLi.click(function () {
                    to_page(result.data.pageInfo.prePage,10)
                })
            }
            ul.append(firstPageLi).append(prePageLi);
            if(result.data.pageInfo.hasNextPage){
                var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
                nextPageLi.click(function () {
                    to_page(result.data.pageInfo.nextPage,10);
                })
            }
            var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
            lastPageLi.click(function () {
                to_page(result.data.pageInfo.pages,10)
            });
            var navigatepageNums = result.data.pageInfo.navigatepageNums;
            $.each(navigatepageNums,function (index,item) {
                var numsLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
                if(result.data.pageInfo.pageNum==item){
                    numsLi.addClass("active");
                }
                numsLi.click(function () {
                    to_page(item,10);
                });
                ul.append(numsLi);
            });
            ul.append(nextPageLi);
            ul.append(lastPageLi);
            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area")
        }
        function model_click(){
            $("#empAndModal").modal({
                backdrop:"static"
            })
        }



</script>
<body>
<%--<!-- Button trigger modal -->--%>
<%--<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">--%>
<%--    Launch demo modal--%>
<%--</button>--%>

<!-- Modal -->
<div class="modal fade" id="empAndModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName" placeholder="">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">员工邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email" placeholder="">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">性别</label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" id="inlineRadio1" checked="checked" value="M"> 男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" id="inlineRadio2" value="F"> 女
                        </label>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">部门列表</label>
                        <select class="form-control" name="dId">
                            <option>1</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                            <option>5</option>
                        </select>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>
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
            <input type="button" onclick="model_click()" value="新增">
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