package com.xzh.controller;

import com.xzh.pojo.Books;
import com.xzh.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/book")
public class BookController {
    /*Controller调service层*/
    @Autowired
    private BookService bookService;

    //查询全部书籍
    @RequestMapping("/allBook")
    public String list(Model model) {
        List<Books> list = bookService.queryAllBook();
        model.addAttribute("list1", list);
        return "allBook";
    }

    //跳转到增加书籍页面
    @RequestMapping("/toAddBook")
    public String toAddPaper() {
        return "addBook";
    }
    //添加书籍请求
    @RequestMapping("/addBook")
    public  String addBook(Books books){
        System.out.println("addbook=>"+books);
        bookService.addBook(books);
        return  "redirect:/book/allBook";// 表单传过来 回首页allBook重定向到@RequestMapping("/allBook")请求
    }
    /*跳转到修改页面*/
    @RequestMapping("/toUpdate")
    public String toUpdatePaper(int id,Model model) {
        Books books = bookService.queryBookById(id);
         model.addAttribute("Qbook",books);
        return "updateBook";
    }
    @RequestMapping("/updateBook")
    public  String  updateBook(Books books)
    {
        System.out.println("updatebook=>"+books);
        bookService.updateBook(books);
        return  "redirect:/book/allBook";
    }
    /*删除 restful风格传*/
    @RequestMapping("/deleteBook/{bookID123}")
    public  String deleteBook(@PathVariable("bookID123") int id){
        bookService.deleteBookById(id);
        return  "redirect:/book/allBook";
    }
    /*名称查询书籍*/
    @RequestMapping("/queryBook")
    public String queryBook(String queryBookName,Model model)
    {
       Books books = bookService.queryBookByName(queryBookName);
       List<Books> list = new ArrayList<Books>();
       list.add(books);
        if(books==null){
        list = bookService.queryAllBook();
        model.addAttribute("error","未查到");
        }
       model.addAttribute("list1",list);
        return "allBook";
    }
}
