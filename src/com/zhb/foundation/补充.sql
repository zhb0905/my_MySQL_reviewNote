#####

-- DDL

-- CREATETABLE：创建数据库表
-- ALTER TABLE：更改表结构、添加、删除、修改列长度DROP TABLE：删除表
-- CREATE INDEX：在表上建立索引
-- DROP INDEX：删除索引

-- DCL
-- GRANT：授予访问权限
-- REVOKE：撤销访问权限
-- COMMIT：提交事务处理
-- ROLLBACK：事务处理回退
-- SAVEPOINT：设置保存点
-- LOCK：对数据库的特定部分进行锁定

-- DBMS分为两类：
-- – 基于共享文件系统的DBMS （Access ） – 基于客户机——服务器的DBMS
-- （MySQL、Oracle、SqlServer）

-- LAMP: LINUX APACHE MYSQL PHP/Perl/Python
-- Apache(音译为阿帕奇)是世界使用排名第一的Web服务器软件。它可以运行在几乎所有广泛使用的计算机平台上，由于其跨平台和安全性被广泛使用，是最流行的Web服务器端软件之一。它快速、可靠并且可通过简单的API扩充，将Perl/Python等解释器编译到服务器中。
-- 可以在列名和别名之间加入关键字
-- ‘AS’，别名使用双引号，以便在别名中包含空
-- 格或特殊的字符并区分大小写。
-- 事务是由完成若干项工作的DML语句组成的

-- UPDATE 语句语法

-- 可以一次更新多条数据。
-- • 如果需要回滚数据，需要保证在DML前，进行
-- 设置：SET AUTOCOMMIT = FALSE;

-- TRUNCATE语句不能回滚
-- • 可以使用 DELETE 语句删除数据,可以回滚

-- timestamp和实际时区有关，更能反映实际的日
-- 期，而datetime则只能反映出插入时的当地时区
-- 3、timestamp的属性受Mysql版本和SQLMode的影响
-- 很大

#### 

-- MySQL会给唯一约束的列上默认创建一个唯一索引
-- 主键约束相当于唯一约束+非空约束的组合，主
-- 键约束列不允许重复，也不允许出现空值
-- • 如果是多列组合的主键约束，那么这些列都不允
-- 许为空值，并且组合的值不允许重复。
-- • 每个表最多只允许一个主键，建立主键约束可以
-- 在列级别创建，也可以在表级别上创建。
-- • MySQL的主键名总是PRIMARY，当创建主键约束
-- 时，系统默认会在所在的列和列组合上建立对应的
-- 唯一索引。

-- 外键约束的参照列，在主表中引用的只能是
-- 主键或唯一键约束的列

-- 视图：MySQL从5.0.1版本开始提供视图功能。一种虚拟
-- 存在的表，行和列的数据来自定义视图的查询中使用的表
-- ，并且是在使用视图时动态生成的，只保存了sql逻辑，不
-- 保存查询结果


-- 创建视图的语法：
-- create [or replace] view view_name
-- As select_statement
-- [with|cascaded|local|check option]
-- • 修改视图的语法：
-- alter view view_name
-- As select_statement
-- [with|cascaded|local|check option]

-- 视图的可更新性和视图中查询的定义有关系，以下类型的
-- 视图是不能更新的。
-- • 包含以下关键字的sql语句：分组函数、distinct、group by
-- 、having、union或者union all
-- • 常量视图
-- • Select中包含子查询
-- • join
-- • from一个不能更新的视图
-- • where子句的子查询引用了from子句中的表

-- 修改存储过程：
-- alter procedure 存储过程名 [charactristic…]
-- • 修改函数：
-- alter function 函数名 [charactristic…]
-- characteristic:
-- {contains sql|no sql|reads sql data|modifies sql data}
-- |sql security{definer|invoker}
-- |comment ‘string



• 事务的概念和特性
• 事务的隔离级别
• 事务的案例演示

事务的概念
 事务：事务由单独单元的一个或多个SQL语句组成，在这
个单元中，每个MySQL语句是相互依赖的。而整个单独单
元作为一个不可分割的整体，如果单元中某条SQL语句一
旦执行失败或产生错误，整个单元将会回滚。所有受到影
响的数据将返回到事物开始以前的状态；如果单元中的所
有SQL语句均执行成功，则事物被顺利执行。

MySQL 中的存储引擎[了解] 1、概念：在mysql中的数据用各种不同的技术存储
在文件（或内存）中。
2、通过show engines；来查看mysql支持的存储引
擎。
3、 在mysql中用的最多的存储引擎有：innodb，
myisam ,memory 等。其中innodb支持事务，而
myisam、memory等不支持事务

 事务的ACID(acid)属性
 1. 原子性（Atomicity）
原子性是指事务是一个不可分割的工作单位，事务中的操作要么
都发生，要么都不发生。
 2. 一致性（Consistency）
事务必须使数据库从一个一致性状态变换到另外一个一致性状态
。 3. 隔离性（Isolation）
事务的隔离性是指一个事务的执行不能被其他事务干扰，即一个
事务内部的操作及使用的数据对并发的其他事务是隔离的，并发
执行的各个事务之间不能互相干扰。
 4. 持久性（Durability）
持久性是指一个事务一旦被提交，它对数据库中数据的改变就是
永久性的，接下来的其他操作和数据库故障不应该对其有任何影
响

事务的使用

 以第一个 DML 语句的执行作为开始
 以下面的其中之一作为结束:  COMMIT 或 ROLLBACK 语句
 DDL 或 DCL 语句（自动提交）
 用户会话正常结束
 系统异常终了


数据库的隔离级别

 对于同时运行的多个事务, 当这些事务访问数据库中相同的数据时, 如果没
有采取必要的隔离机制, 就会导致各种并发问题:  脏读: 对于两个事务 T1, T2, T1 读取了已经被 T2 更新但还没有被提交的字段. 
之后, 若 T2 回滚, T1读取的内容就是临时且无效的.  不可重复读: 对于两个事务T1, T2, T1 读取了一个字段, 然后 T2 更新了该字段. 
之后, T1再次读取同一个字段, 值就不同了.  幻读: 对于两个事务T1, T2, T1 从一个表中读取了一个字段, 然后 T2 在该表中插 入了一些新的行. 之后, 如果 T1 再次读取同一个表, 就会多出几行.  数据库事务的隔离性: 数据库系统必须具有隔离并发运行各个事务的能力, 
使它们不会相互影响, 避免各种并发问题. 
 一个事务与其他事务隔离的程度称为隔离级别. 数据库规定了多种事务隔
离级别, 不同隔离级别对应不同的干扰程度, 隔离级别越高, 数据一致性就
越好, 但并发性越弱
数据库提供的 4 种事务隔离级别: 
READ UNCOMMITTED 食物期间可读其他事务改未提交的，有3
READ COMMITTED  食物期间可可读其他事务改已提交的，无脏读有2
REPEATABLE READ 食物期间禁止其他事务改更新字段，无脏读不可重复读有幻读
SERIALIZABLE(串行化) 事务期间锁表，不允许并发的插改删，可避免所有并发问题，性能底下

 Oracle 支持的 2 种事务隔离级别：READ COMMITED, 
SERIALIZABLE。 Oracle 默认的事务隔离级别为: READ 
COMMITED 
 Mysql 支持 4 种事务隔离级别. Mysql 默认的事务隔离级别
为: REPEATABLE READ

在 MySql 中设置隔离级别

 每启动一个 mysql 程序, 就会获得一个单独的数据库连接. 每
个数据库连接都有一个全局变量 @@tx_isolation, 表示当前的
事务隔离级别. 
 查看当前的隔离级别: SELECT @@tx_isolation;
 设置当前 mySQL 连接的隔离级别: 
 set transaction isolation level read committed;  设置数据库系统的全局的隔离级别:  set global transaction isolation level read committed;

###



###



###

#### 



###



###



###

#### 



###



###



###

#### 



###



###



###

#### 



###



###



###

#### 



###



###



###

#### 



###



###



###

#### 



###



###



###

#### 



###



###



###

#### 



###



###



###

#### 



###



###



###

#### 



###



###



###

#### 



###



###



###














