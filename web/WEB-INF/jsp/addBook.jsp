<%--
  Created by IntelliJ IDEA.
  User: xzh
  Date: 2020/4/11
  Time: 19:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <div class="row clearfix">
        <div class="col-md-12">
            <div class="page-header">
                <h1>
                    <small>新增书籍</small>
                </h1>
            </div>
        </div>
    </div>
<form action="${pageContext.request.contextPath}/book/addBook" method="post">  <%-- 点击提交后 跳转/book/addBook @RequestMapping("/book") @RequestMapping("/addBook") 对应BookController方法 public  String addBook(Books books){ --%>
    <div class="form-group">
        <label for="bkname">书籍名称:</label>
         <input type="text" name="bookname" class="form-control"  id="bkname">
    </div>
    <div class="form-group">
        <label for="bkcount">书籍数量:</label>
        <input type="text" name="bookcounts" class="form-control"  id="bkcount">
    </div>
    <div class="form-group">
        <label for="bkdetail">书籍描述:</label>
        <input type="text"  name="detail" class="form-control" id="bkdetail">
    </div>
    <div class="form-group">
        <input type="submit" class="form-control" value="添加 ">  <%--点击添加 跳转到book/addBook--%>
    </div>
</form>
</div>
</div>
</body>
</html>
