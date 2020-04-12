
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
                    <small>修改书籍</small>
                </h1>
            </div>
        </div>
    </div>
    <form action="${pageContext.request.contextPath}/book/updateBook" method="post">
        <input type="hidden" name="bookID" value="${Qbook.bookID}"/>
        <div class="form-group">
            <label for="bkname">书籍名称:</label>
            <input type="text" name="bookname" class="form-control" value="${Qbook.bookname}" id="bkname">
        </div>
        <div class="form-group">
            <label for="bkcount">书籍数量:</label>
            <input type="text" name="bookcounts" class="form-control" value="${Qbook.bookcounts}" id="bkcount">
        </div>
        <div class="form-group">
            <label for="bkdetail">书籍描述:</label>
            <input type="text"  name="detail" class="form-control" value="${Qbook.detail}" id="bkdetail">
        </div>
        <div class="form-group">
            <input type="submit" class="form-control" value="修改 ">  <%--点击添加 跳转到book/addBook--%>
        </div>
</body>
</html>
