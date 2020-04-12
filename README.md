# ssmbuild-BookDemo

实现书籍增删改查和ssm基本配置
#                           SpringMVC

## 1.hello

创建项目 maven项目 直接next  然后右键add frame 添加web 就补上了web web-inf文件夹

idea 到projectsetting Artifacts  WEBINF 创建lib 把maven那些导一遍或者右边put into

pom.xml
```
 <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-webmvc</artifactId>
        <version>5.1.2.RELEASE</version>
    </dependency>
    <dependency>
        <groupId>junit</groupId>
        <artifactId>junit</artifactId>
        <version>4.12</version>
    </dependency>
    <dependency>
        <groupId>javax.servlet</groupId>
        <artifactId>javax.servlet-api</artifactId>
        <version>3.0.1</version>
        <scope>provided</scope>
    </dependency>
    <dependency>
        <groupId>javax.servlet.jsp</groupId>
        <artifactId>jsp-api</artifactId>
        <version>2.1</version>
    </dependency>
    <dependency>
        <groupId> javax.servlet</groupId>
        <artifactId>jstl</artifactId>
        <version>1.2</version>
    </dependency>
```



### 第一步写个servlet跳转过去

配置web.xml(即DispatchServlet springmvc核心 请求分发器，前端控制器)

```
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd"
         version="3.1">
    <!--DispatchServlet springmvc核心 请求分发器，前端控制器)-->
    <servlet>
        <servlet-name>springmvc</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <!--DispatchServlet要绑定的spring配置文件 自己在resources建的sprimvc-servlet.xml-->
        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>classpath:spring-mvc.xml</param-value>
        </init-param>
    </servlet>
    <!--  /:只匹配所有请求 不匹配jsp页面 /*:匹配所有请求包括jsp页面-->
    <servlet-mapping>
        <servlet-name>springmvc</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>
    <!--乱码过滤-->
    <filter>
        <filter-name>encodingFilter</filter-name>
        <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
        <init-param>
            <param-name>encoding</param-name>
            <param-value>utf-8</param-value>
        </init-param>
    </filter>
    <filter-mapping>
        <filter-name>encodingFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>
</web-app>
```

### 第二步创建web-inf下的jsp目录和jsp文件 创建resources下的DispatchServlet要绑定的spring配置文件.xml文件

```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
        http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-3.0.xsd
        http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc-3.2.xsd">
   
   <!--注解写法-->
    <!--自动扫描包，让指定包注解生效，由ioc容器管理-->
    <context:component-scan base-package="com.kuang.controller"/>
    <!--让springmvc不处理静态资源 如mp4 .css .js-->
    <mvc:default-servlet-handler/>
    <!--支持mvc注解驱动 要使@RequestMapping生效     向上下文注册HandlerMapping HandlerAdapter  annotation-driven自动完成2个实例注入-->
    <mvc:annotation-driven/>
   
   <!--非注解写法
    <!--处理器映射器-->
    <bean class="org.springframework.web.servlet.handler.BeanNameUrlHandlerMapping"/>
    <!--处理器适配器-->
    <bean class="org.springframework.web.servlet.mvc.SimpleControllerHandlerAdapter"/>
    <!--BeanNameUrlHandlerMapping:bean 处理器映射适配hello 交给HelloController-->
    注解写法@RequestMapping("/hello") 写在Controller类里
    <bean id="/hello" class="com.kuang.controller.HelloController"/>
-->

    <!--视图解析器 这个可以变 换成thymeleaf 等等-->
    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver" id="internalResourceViewResolver">
        <!--前缀-->
        <property name="prefix" value="/WEB-INF/jsp/"/>
        <!--后缀-->
        <property name="suffix" value=".jsp"/>
    </bean>
    
</beans>
```

### 第三步创建Controller

```java

public class HelloController implements Controller {

    @Nullable/*是Controller接口的类 alt+enter*/
    public ModelAndView handleRequest(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws Exception {
        ModelAndView modelAndView = new ModelAndView();
        /*业务代码*/
        String result = "hellomvc";
        modelAndView.addObject("msg", result);
        /*视图跳转*/
        modelAndView.setViewName("test");
        return modelAndView;
    }
}

```

注解写法Controller

```java
@Controller
public class HelloController {
    @RequestMapping("/hello")
    public String hello(Model model) {
        String result = "hellomvc";
        model.addAttribute("msg", result);
        return "test";
    }


}

```



## 2.jackson



```
       <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-databind</artifactId>
            <version>2.9.7</version>
        </dependency>
```

## 3.整合ssm  ssmbuild

### sql

` 数字1左边的键

USE `ssmbuild`;
Drop table if exists `books`;
CREATE TABLE `books`(
 `bookID` INT(10) not null auto_increment COMMENT '书id',
 `bookname` varchar(100) not null comment '书名',
 `bookcounts`  int(11) not null comment '数量',
 `detail` VARCHAR(200) not null comment '描述',
 key `bookid`(`bookid`)
)ENGINE=INNODB DEFAULT CHARSET=utf8;

INSERT into `books` (`bookID`,`bookname`,`bookcounts`,`detail`) VALUES
(1,'java',1,'从入门到放弃'),
(2,'mysql',18,'从删库到跑路'),
(3,'linux',12,'从进门到进牢');



#### pom设置
```
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.xzh</groupId>
    <artifactId>ssmbuild</artifactId>
    <version>1.0-SNAPSHOT</version>
    <groupId>com.xzh</groupId>
    <artifactId>ssmbuild</artifactId>
    <version>1.0-SNAPSHOT</version>
    <!--依赖 junit，数据库驱动，连接池，servlet，jsp，mybatisspring-->
    <dependencies>
        <!--junit-->
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.12</version>
        </dependency>
        <!--数据库驱动-->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>5.1.38</version>
        </dependency>
        <!--数据库连接池-->
        <dependency>
            <groupId>com.mchange</groupId>
            <artifactId>c3p0</artifactId>
            <version>0.9.5.2</version>
        </dependency>
        <!--servlet jsp-->
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>servlet-api</artifactId>
            <version>2.5</version>
        </dependency>
        <dependency>
            <groupId>javax.servlet.jsp</groupId>
            <artifactId>jsp-api</artifactId>
            <version>2.2</version>
        </dependency>
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>jstl</artifactId>
            <version>1.2</version>
        </dependency>
        <!--mybatis-->
        <dependency>
            <groupId>org.mybatis</groupId>
            <artifactId>mybatis</artifactId>
            <version>3.4.6</version>
        </dependency>
        <dependency>
            <groupId>org.mybatis</groupId>
            <artifactId>mybatis-spring</artifactId>
            <version>1.3.2</version>
        </dependency>
        <!--spring-->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-jdbc</artifactId>
            <version>5.1.2.RELEASE</version>
        </dependency>
          <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-context</artifactId>
            <version>4.3.13.RELEASE</version>
        </dependency>

        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-test</artifactId>
            <version>4.3.13.RELEASE</version>
        </dependency>

        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-beans</artifactId>
            <version>4.3.13.RELEASE</version>
        </dependency>

        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-webmvc</artifactId>
            <version>4.3.13.RELEASE</version>
        </dependency>
        <!--lombok-->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <version>1.16.10</version>
        </dependency>
    </dependencies>
    <!--maven资源过滤设置 任何项目都可以加-->
    <build>
        <resources>
            <resource>
                <directory>src/main/java</directory>
                <includes>
                    <include>**/*.properties</include>
                    <include>**/*.xml</include>
                </includes>
                <filtering>false</filtering>
            </resource>
            <resource>
                <directory>src/main/resources</directory>
                <includes>
                    <include>**/*.properties</include>
                    <include>**/*.xml</include>
                </includes>
                <filtering>false</filtering>
            </resource>
        </resources>
    </build>
    </project>
```

#### mybatis-config.xml基本

configuration   改掉

```
<?xml version="1.0" encoding="UTF-8" ?>

<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>

</configuration>
```
#### applicationContext.xml基本

```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-3.0.xsd
     http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">

  
   

</beans>
```

#### 整合后 

mybatis-config.xml  

```

<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    <!-- typeAliases别名 不写明alias=""就是批量命名别名※注意：批量命名别名时，默认命名为的别名为类名（不区别大小写）。-->
<typeAliases>
    <package name="com.xzh.pojo"/>
</typeAliases>
    <mappers>
        <mapper class="com.xzh.dao.BookMapper"/>
    </mappers>

</configuration>
```

BookMapper.xml  
```
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.xzh.dao.BookMapper">
<insert id="addBook" parameterType="Books" >
    INSERT INTO ssmbuild.books(bookname, bookcounts, detail)
    VALUES (#{bookname},#{bookcounts},#{detail});
</insert>
    <delete id="deleteBookById" parameterType="int">
        DELETE  FROM ssmbuild.books WHERE bookID=#{bookId};
    </delete>
    <update id="updateBook" parameterType="Books">
        UPDATE  ssmbuild.books set bookname=#{bookname},bookcounts=#{bookcounts},detail=#{detail} WHERE bookID=#{bookID};
    </update>
    <select id="queryBookById"  resultType="Books">
        SELECT * FROM ssmbuild.books WHERE bookID=#{bookId}
    </select>
    <select id="queryAllBook"  resultType="Books">
        SELECT * FROM ssmbuild.books
    </select>
</mapper>
```

 主文件applicationContext    <import resource="classpath:spring-dao.xml"/>
    <import resource="classpath:spring-service.xml"/><import resource="classpath:spring-mvc.xml"/>

<!--spring 整合dao和service-->
<!--将spring-dao和spring-service都导入 相当于合并-->

第一步关联数据库文件，然后连接池，然后sqlsessionfactory，然后mybatis文件识别

```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-3.0.xsd
     http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">

    <!--                            spring-dao                                                               -->
    <!--1.关联数据库配置文件 即database.properties resources下自己建的jdbc.driver=com.mysql.jdbc.driver之类的-->
    <context:property-placeholder location="classpath:database.properties"/>
    <!--2..连接池 c3p0 ,druid,dbcp 这几个都要pom里加才能用 本例子用c3p0-->
    <bean id="dataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource">
        <!--这4个property是一定有的 直接打 跟database.properties对应-->
        <property name="driverClass" value="${jdbc.driver}"/>
        <property name="jdbcUrl" value="${jdbc.url}"/>
        <property name="user" value="${jdbc.username}"/>
        <property name="password" value="${jdbc.password}"/>
        <!--       c3p0连接池私有属性               -->

        <property name="maxPoolSize" value="30"/>
        <property name="minPoolSize" value="30"/>
        <!--关闭连接后不自动commit-->
        <property name="autoCommitOnClose" value="false"/>
        <!--获取超时时间-->
        <property name="checkoutTimeout" value="10000"/>
        <!--连接失败重试次数-->
        <property name="acquireRetryAttempts" value="2"/>
    </bean>
    <!-- 3.        SQLsessionfactory   beanid和注入的value对应   -->
    <bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
        <property name="dataSource" ref="dataSource"/>
        <!--绑定Mybatis的配置文件-->
        <property name="configLocation" value="classpath:mybatis-config.xml"/>
    </bean>
    <!--4.配置dao接口扫描包，动态实现Dao接口注入到spring容器中  就是不用手动写dao下的BookMapperImpl-->
    <bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
        <!--注入sqlsessionfactory-->
        <property name="sqlSessionFactoryBeanName" value="sqlSessionFactory"/>
        <!--要扫描的dao包 -->
        <property name="basePackage" value="com.xzh.dao"/>
    </bean>

</beans>

```
spring-service.xml 
```

<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-3.0.xsd
     http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">

<import resource="spring-dao.xml"/>
    <!--     spring service  -->
    <context:annotation-config />
    <!--1.扫描service下的包-->
    <context:component-scan base-package="com.xzh.service"/>
    <!--2.将业务类注入到spring，可以通过配置或者autowired注解实现 impl中的bookMapper-->
  <!--<bean id="bookServiceImpl" class="com.xzh.service.BookServiceImpl"><property name="bookMapper" ref="bookMapper"/></bean>-->
         <!--扫描dao的@Repository 解决idea autowired报红问题-->
    <context:component-scan base-package="com.xzh.dao"/>
<!--声明事务配置-->
    <bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
        <property name="dataSource" ref="dataSource"/>
    </bean>
</beans>
```



配置springmvc相关

web.xml见hello  改成 classpath:applicationContext.xml因为 applicationContext包含spring-mvc.xml还有service层的东西

spring-mvc.xml

```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
        http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-3.0.xsd
        http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc-3.2.xsd">

    <!--启动注解识别-->
    <context:annotation-config/>

    <!--注解驱动-->
    <mvc:annotation-driven/>
    <!-- 扫描包-->
    <context:component-scan base-package="com.xzh.controller"/>
    <!--静态资源的过滤-->
    <mvc:default-servlet-handler/>

    <!-- 视图定位 -->
    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="prefix" value="/WEB-INF/jsp/"/>
        <property name="suffix" value=".jsp"/>
    </bean>

    <!-- 对上传文件的解析-->
    <bean id="multipartResolver" class="org.springframework.web.multipart.commons.CommonsMultipartResolver"/>
</beans>
```

ssm配置到此都配置好了 

接下来写controller层和jsp交互

service层调用dao层

在ServiceImpl调用 BookMapper是dao接口

```
private BookMapper bookMapper; 
```

 controller调用service层

```
private BookService bookService;
```







