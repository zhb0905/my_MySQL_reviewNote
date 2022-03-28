##### 第10章_创建和管理表


-- 从系统架构的层次上看，MySQL 数据库系-- 统从大到小依次是`数据库服务器`、`数据库`、`数据表`、数据表的`行与列`。
-- 必须保证你的字段没有和保留字、数据库系统或常用方法冲突。如果坚持使用，请在SQL语句中使用`（着重号）引起来
-- | 类型             | 类型举例                                                     |
-- | ---------------- | ------------------------------------------------------------ |
-- | 整数类型         | TINYINT、SMALLINT、MEDIUMINT、**INT(或INTEGER)**、BIGINT     |
-- | 浮点类型         | FLOAT、DOUBLE                                                |
-- | 定点数类型       | **DECIMAL**                                                  |
-- | 位类型           | BIT                                                          |
-- | 日期时间类型     | YEAR、TIME、**DATE**、DATETIME、TIMESTAMP                    |
-- | 文本字符串类型   | CHAR、**VARCHAR**、TINYTEXT、TEXT、MEDIUMTEXT、LONGTEXT      |
-- | 枚举类型         | ENUM                                                         |
-- | 集合类型         | SET                                                          |
-- | 二进制字符串类型 | BINARY、VARBINARY、TINYBLOB、BLOB、MEDIUMBLOB、LONGBLOB      |
-- | JSON类型         | JSON对象、JSON数组                                           |
-- | 空间数据类型     | 单值：GEOMETRY、POINT、LINESTRING、POLYGON；<br/>集合：MULTIPOINT、MULTILINESTRING、MULTIPOLYGON、GEOMETRYCOLLECTION |

-- 其中，常用的几类类型介绍如下：

-- | 数据类型      | 描述                                                         |
-- | ------------- | ------------------------------------------------------------ |
-- | INT           | 从-2^31到2^31-1的整型数据。存储大小为 4个字节                |
-- | CHAR(size)    | 定长字符数据。若未指定，默认为1个字符，最大长度255           |
-- | VARCHAR(size) | 可变长字符数据，根据字符串实际长度保存，**必须指定长度**     |
-- | FLOAT(M,D)    | 单精度，占用4个字节，M=整数位+小数位，D=小数位。 D<=M<=255,0<=D<=30，默认M+D<=6 |
-- | DOUBLE(M,D)   | 双精度，占用8个字节，D<=M<=255,0<=D<=30，默认M+D<=15         |
-- | DECIMAL(M,D)  | 高精度小数，占用M+2个字节，D<=M<=65，0<=D<=30，最大取值范围与DOUBLE相同。 |
-- | DATE          | 日期型数据，格式'YYYY-MM-DD'                                 |
-- | BLOB          | 二进制形式的长文本数据，最大可达4G                           |
-- | TEXT          | 长文本数据，最大可达4G                                       |

-- 2. 创建和管理数据库
-- 注意：DATABASE 不能改名。一些可视化工具可以改名，它是建新库，把所有表复制到新库，再删旧库完成的。

-- 2.1 创建数据库
-- CREATE DATABASE [IF NOT EXISTS] 数据库名 [CHARACTER SET 字符集];
 

-- 2.2 使用数据库
-- 注意：要操作表格和数据之前必须先说明是对哪个数据库进行操作，否则就要对所有对象加上“数据库名.”。
-- SHOW DATABASES; 
-- select database();#查看当前正在使用的数据库,使用的一个 mysql 中的全局函数
-- show tables from 数据库名;
-- SHOW CREATE DATABASE 数据库名;
-- USE 数据库名;

-- 2.3 修改数据库
-- alter database 数据库名 character set 字符集;

-- 2.4 删除数据库
-- DROP DATABASE [ IF EXISTS ] 数据库名;



-- 3. 创建表
-- **必须具备：**
-- - CREATE TABLE权限
-- - 存储空间
-- 在MySQL 8.x版本中，不再推荐为INT类型指定显示长度，并在未来的版本中可能去掉这样的语法。

-- CREATE TABLE [IF NOT EXISTS] 表名(
-- 	字段1, 数据类型 [约束条件] [默认值],
-- 	字段2, 数据类型 [约束条件] [默认值],
-- 	字段3, 数据类型 [约束条件] [默认值],
-- 	……
-- 	[表约束条件]
-- );

-- create table 表名 [(column,column...)]
-- AS subquery;

-- SHOW CREATE TABLE 表名 ;#不仅可以查看表创建时的详细语句，还可以查看存储引擎和字符编码。

-- 4. 修改表
-- ALTER TABLE 表名 ADD 【COLUMN】 字段名 字段类型 【FIRST|AFTER 字段名】;
-- ALTER TABLE 表名 MODIFY 【COLUMN】 字段名1 字段类型 【DEFAULT 默认值】【FIRST|AFTER 字段名2】;
-- - 对默认值的修改只影响今后对表的修改
-- - 此外，还可以通过此种方式修改列的约束。
-- ALTER TABLE 表名 CHANGE 【column】 列名 新列名 新数据类型;
-- ALTER TABLE 表名 DROP 【COLUMN】字段名

## 5. 重命名表

-- - 方式一：使用RENAME
-- RENAME TABLE emp
-- TO myemp;

-- - 方式二：
-- ALTER table dept
-- RENAME [TO] detail_dept;  

-- - 必须是对象的拥有者

-- 6. 删除表
-- DROP TABLE [IF EXISTS] 数据表1 [, 数据表2, …, 数据表n];

-- DROP TABLE 语句不能回滚
-- - 在MySQL中，当一张数据表`没有与其他任何数据表形成关联关系`时，可以将当前数据表直接删除。
-- - 数据和结构都被删除
-- - 所有正在运行的相关事务被提交
-- - 所有相关索引被删除

-- 7. 清空表

-- TRUNCATE TABLE detail_dept;

-- TRUNCATE语句**不能回滚**，而使用 DELETE 语句删除数据，可以回滚
-- - 删除表中所有的数据
-- - 释放表的存储空间

-- 对比 
-- SET autocommit = FALSE;   
-- DELETE FROM emp2; 
-- #TRUNCATE TABLE emp2; 
-- SELECT * FROM emp2;
-- ROLLBACK;
-- SELECT * FROM emp2;

##### 阿里开发规范：

-- 【参考】TRUNCATE TABLE 比 DELETE 速度快，且使用的系统和事务日志资源少，但 TRUNCATE 无事务且不触发 TRIGGER，有可能造成事故，故不建议在开发代码中使用此语句。 

-- 说明：TRUNCATE TABLE 在功能上与不带 WHERE 子句的 DELETE 语句相同。

### 阿里巴巴《Java开发手册》之MySQL字段命名

-- - 【`强制`】表名、字段名必须使用小写字母或数字，禁止出现数字开头，禁止两个下划线中间只出现数字。数据库字段名的修改代价很大，因为无法进行预发布，所以字段名称需要慎重考虑。
--   - 正例：aliyun_admin，rdc_config，level3_name 
--   - 反例：AliyunAdmin，rdcConfig，level_3_name

-- - 【`强制`】禁用保留字，如 desc、range、match、delayed 等，请参考 MySQL 官方保留字。

-- - 【`强制`】表必备三字段：id, gmt_create, gmt_modified。 

--   - 说明：其中 id 必为主键，类型为BIGINT UNSIGNED、单表时自增、步长为 1。gmt_create, gmt_modified 的类型均为 DATETIME 类型，前者现在时表示主动式创建，后者过去分词表示被动式更新

-- - 【`推荐`】表的命名最好是遵循 “业务名称_表的作用”。 

--   - 正例：alipay_task 、 force_project、 trade_config

-- - 【`推荐`】库名与应用名称尽量一致。

-- - 【参考】合适的字符存储长度，不但节约数据库表空间、节约索引存储，更重要的是提升检索速度。 

--   - 正例：无符号值可以避免误存负数，且扩大了表示范围。

### 如何理解清空表、删除表等操作需谨慎？！

-- `表删除`操作将把表的定义和表中的数据一起删除，并且MySQL在执行删除操作时，不会有任何的确认信息提示，因此执行删除操时应当慎重。在删除表前，最好对表中的数据进行`备份`，这样当操作失误时可以对数据进行恢复，以免造成无法挽回的后果。

-- 同样的，在使用 `ALTER TABLE` 进行表的基本修改操作时，在执行操作过程之前，也应该确保对数据进行完整的`备份`，因为数据库的改变是`无法撤销`的，如果添加了一个不需要的字段，可以将其删除；相同的，如果删除了一个需要的列，该列下面的所有数据都将会丢失。

1### 拓展3：MySQL8新特性—DDL的原子化

-- 在MySQL 8.0版本中，InnoDB表的DDL支持事务完整性，即`DDL操作要么成功要么回滚`。DDL操作回滚日志写入到data dictionary数据字典表mysql.innodb_ddl_log（该表是隐藏的表，通过show tables无法看到）中，用于回滚操作。通过设置参数，可将DDL操作日志打印输出到MySQL错误日志中。

-- 分别在MySQL 5.7版本和MySQL 8.0版本中创建数据库和数据表，结果如下：

-- CREATE DATABASE mytest;

-- USE mytest;

-- CREATE TABLE book1(
-- book_id INT ,
-- book_name VARCHAR(255)
-- );

-- SHOW TABLES;
-- （1）在MySQL 5.7版本中，测试步骤如下：
-- 删除数据表book1和数据表book2，结果如下：

-- ```mysql
-- mysql> DROP TABLE book1,book2;
-- ERROR 1051 (42S02): Unknown table 'mytest.book2'
-- ```

-- 再次查询数据库中的数据表名称，结果如下：
-- mysql> SHOW TABLES;
-- Empty set (0.00 sec)

-- 在MySQL 8.0版本中，测试步骤如下：
-- mysql> DROP TABLE book1,book2;
-- ERROR 1051 (42S02): Unknown table 'mytest.book2'
-- mysql> show tables;

-- 从结果可以看出，数据表book1并没有被删除。