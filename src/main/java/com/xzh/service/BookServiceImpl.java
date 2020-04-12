package com.xzh.service;

import com.xzh.dao.BookMapper;
import com.xzh.pojo.Books;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;

@Service
public class BookServiceImpl implements BookService {
    /*service调dao层 组合dao*/
    @Autowired
    private BookMapper bookMapper;


    public int addBook(Books books) {
        return bookMapper.addBook(books);
    }

    public int deleteBookById(int id) {
        return bookMapper.deleteBookById(id);
    }

    public int updateBook(Books books) {
        return bookMapper.updateBook(books);
    }

    public Books queryBookById(int id) {
        return bookMapper.queryBookById(id);
    }

    public  Books queryBookByName(String bookname){
        return bookMapper.queryBookByName(bookname);
    }

    /*查询全部书*/
    public List<Books> queryAllBook() {
        return bookMapper.queryAllBook();
    }


}
