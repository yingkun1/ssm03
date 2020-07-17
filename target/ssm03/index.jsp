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
        var totalRecord;
        var currentPage;
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
                var checkBoxTd = $("<td><input type='checkbox' class='check_item' /></td>");
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var genderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
                var emailTd = $("<td></td>").append(item.email);
                var deptNameTd =$("<td></td>").append(item.department.deptName);
                var editButTd = $("<button></button>").append("编辑").addClass("edit_btn");
                var deleteButTd = $("<button></button>").append("删除").addClass("delete_btn");
                var btnTd=$("<td></td>").append(editButTd).append(" ").append(deleteButTd);
                editButTd.attr("edit_id",item.empId);
                deleteButTd.attr("delete_id",item.empId);
                $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(genderTd).append(emailTd).append(deptNameTd).append(btnTd).appendTo("#emps_tables tbody")
            })
        }
        function build_page_info(result) {
            $("#page_info_area").empty();
            var pageInfo = result.data.pageInfo;
            totalRecord =  result.data.pageInfo.total;
            currentPage = pageInfo.pageNum;
            $("#page_info_area").append("当前第"+currentPage+"页,共有"+pageInfo.pages+"页,总计"+totalRecord+"条记录")
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
            $("#empAndModal form")[0].reset();
            get_depts("#empAndModal select");
            $("#empAndModal").modal({
                backdrop:"static"
            })
        }

        function get_depts(ele) {
            $(ele).empty();
            $.ajax({
                url: "/depts",
                data: null,
                type: "GET",
                dataType: "json",
                success: function(data) {
                    $.each(data.data.departments,function (index,item) {
                        var optionEle = $("<option></option>").append(item.deptName).attr("value",item.deptId);
                        optionEle.appendTo(ele)
                    })
                }
            });
        }

        function changeText() {
            console.log("文本内容发生改变");
            var value = $("#empNameInput").val();
            console.log("empName="+value);
            $.ajax({
                url: "/checkuser",
                data:"empName="+value,
                type: "GET",
                dataType: "json",
                success:function (data) {
                    console.log(data);
                }
            })
        }


        function saveEmployee() {
            console.log("点击了保存按钮");
            var serialize = $("#empAndModal form").serialize();
            $.ajax({
                url: "/emp",
                data: serialize,
                type: 'POST',
                dataType: "json",
                success(data){
                    console.log(data);
                    $("#empAndModal").modal("hide");
                    to_page(totalRecord+1,10)
                }
            })
        }
        


        $(document).on("click",".edit_btn",function () {
            get_depts("#empUpdateModal select");
            getEmp($(this).attr("edit_id"));
            $("#empUpdateButton").attr("edit_id",$(this).attr("edit_id"));
            $("#empUpdateModal").modal({
                backdrop:"static"
            });

        })

        $(document).on("click",".delete_btn",function () {
            var empName = $(this).parents("tr").find("td:eq(1)").text();
            console.log("empName:"+empName);
            var empId = $(this).attr("delete_id");
            $.ajax({
                url: "/emp/"+empId,
                data:null,
                type: 'DELETE',
                dataType: "json",
                success(data){
                    console.log(data);
                    to_page(currentPage,10);
                }
            })
        })

        function updateEmployee(){
            console.log("点击了修改按钮");
            $.ajax({
                url: "/emp/"+$("#empUpdateButton").attr("edit_id"),
                data:$("#empUpdateModal form").serialize(),
                type: 'PUT',
                dataType: "json",
                success(data){
                    console.log(data);
                    $("#empUpdateModal").modal("hide");
                    to_page(currentPage,10);
                }
            })
        }

        function getEmp(id) {
            $.ajax({
                url: "/emp/"+id,
                data: null,
                type: 'GET',
                dataType: "json",
                success(data){
                    console.log(data);
                    $("#empNameUpdateInput").text(data.data.empInfo.empName);
                    $("#emailUpdateInput").val(data.data.empInfo.email);
                    $("#empUpdateModal input[type=radio]").val([data.data.empInfo.gender]);
                    $("#empUpdateModal select").val([data.data.empInfo.department.deptId])

                }
            })
        }

        $(document).on("click","#check_all",function () {
            console.log($(this).prop("checked"));
            $(".check_item").prop("checked",$(this).prop("checked"));
        })

        $(document).on("click",".check_item",function () {
            var flag = $(".check_item:checked").length==$(".check_item").length;
            $("#check_all").prop("checked",flag);
        })

        $(document).on("click","#emp_delete_all_button",function () {
            console.log("点击了删除全部按钮");
            var empIdstr="";
            $.each($(".check_item:checked"),function () {
                var empId =  $(this).parents("tr").find("td:eq(1)").text();
                console.log(empId);
                empIdstr=empIdstr+empId+"-";
            })
            var substringIds = empIdstr.substring(0,empIdstr.length-1);
            console.log(substringIds);

            $.ajax({
                url: "/emp/"+substringIds,
                data:null,
                type: 'DELETE',
                dataType: "json",
                success(data){
                    console.log(data);
                    to_page(currentPage,10);
                }
            })
        })





</script>
<body>
<!--员工修改-->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <p id="empNameUpdateInput" name=""empName"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">员工邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" id="emailUpdateInput" name="email" class="form-control" id="email" placeholder="">
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
                        <select class="form-control" name="dId" >

                        </select>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" id="empUpdateButton" onclick="updateEmployee()" class="btn btn-primary">修改</button>
            </div>
        </div>
    </div>
</div>
<!-- Modal 员工添加 -->
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
                            <input type="text" id="empNameInput" onchange="changeText()" name="empName" class="form-control" id="empName" placeholder="">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">员工邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" id="emailInput" name="email" class="form-control" id="email" placeholder="">
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
                        <select class="form-control" name="dId" >

                        </select>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" onclick="saveEmployee()" class="btn btn-primary">保存</button>
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
            <button id="emp_delete_all_button" >删除</button>
        </div>
    </div>

    <!--数据行-->
    <div class="row">
        <div>
            <table style="border: solid 1px" id="emps_tables">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all"/>
                        </th>
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