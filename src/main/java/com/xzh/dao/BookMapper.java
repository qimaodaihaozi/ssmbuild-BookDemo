package com.xzh.dao;

import com.xzh.pojo.Books;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookMapper {
    /*增删改查*/
    int addBook(Books books);

    int deleteBookById(int id);

    int updateBook(Books books);

    Books queryBookById(int id);

    /*查询全部书*/
    List<Books> queryAllBook();

    Books queryBookByName(String bookname);
}
