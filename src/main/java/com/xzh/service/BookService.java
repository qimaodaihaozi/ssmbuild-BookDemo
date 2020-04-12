package com.xzh.service;

import com.xzh.pojo.Books;

import java.util.List;

public interface BookService {
    /*增删改查*/

    int addBook(Books books);

    int deleteBookById(int id);

    int updateBook(Books books);

    Books queryBookById(int id);

    /*查询全部书*/
    List<Books> queryAllBook();

    /*根据名称查找书籍*/
    Books queryBookByName(String bookname);
}
