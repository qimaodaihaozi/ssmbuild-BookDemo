<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>书籍展示</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <div class="row clearfix">
        <div class="col-md-12">
            <div class="page-header">
                <h1>
                    <small>书籍列表----显示所有书籍</small>

                </h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/book/toAddBook">新增书籍</a>
            </div>
            <div class="col-md-4">
                <%--查询书籍--%>
                <form class="form-inline" action="${pageContext.request.contextPath}/book/queryBook" method="post">
                   <span>${error}</span>
                    <input type="text"  name="queryBookName" class="form-control" style="float:right" placeholder="请输入要查询书籍名称">
                    <input type="submit" value="查询" class="btn btn-primary">

                </form>
            </div>
        </div>
    </div>
    <div class="row clearfix">
        <div class="col-md-12 column">
            <table class="table table-hover table-striped">
                <thead>
                <tr>
                    <th>书籍编号</th>
                    <th>书籍名称</th>
                    <th>书籍数量</th>
                    <th>书籍详情</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                <c:forEach var="book" items="${list1}">  <%-- model.addAttribute("list1", list)的list1--%>
                    <tr>
                        <td>${book.bookID}</td>
                        <td>${book.bookname}</td>
                        <td>${book.bookcounts}</td>
                        <td>${book.detail}</td>

                        <td>
                            <a href="${pageContext.request.contextPath}/book/toUpdate?id=${book.bookID}">修改</a>
                            &nbsp;| &nbsp;
                                <%--老风格 Controller把/{bookID123} @PathVariable("bookID123")删除即可使用--%>
                                <%--<a href="${pageContext.request.contextPath}/book/deleteBook?id=${book.bookID}">删除1</a>--%>
                                <%--restful风格 传的id被解析成bookID123 转成int id
                      @RequestMapping("/deleteBook/{bookID123}")
                      public  String deleteBook(@PathVariable("bookID123") int id)｛｝--%>
                            <a href="${pageContext.request.contextPath}/book/deleteBook/${book.bookID}">删除</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

    </div>

</div>
</div>

</body>
</html>
