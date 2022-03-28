##### 第04章_运算符
##### 第05章_排序与分页


#####第04章_运算符

#### 1. 算术运算符
-- 加（+）、减（-）、乘（*）、除（/）和取模（%）运算。
-- 在Java中，+的左右两边如果有字符串，那么表示字符串的拼接。但是在MySQL中+只表示数值相加。如果遇到非数值类型，先尝试转成数值，如果转失败，就按0计算。（补充：MySQL中字符串拼接要使用字符串函数CONCAT()实现）

-- 一个数除以整数后，不管是否能除尽，结果都为一个浮点数；
-- 一个数除以另一个数，除不尽时，结果为一个浮点数，并保留到小数点后4位；
-- 在数学运算中，0不能用作除数，在MySQL中，一个数除以0为NULL。

#### 2. 比较运算符
-- ，比较的结果为真则返回1，比较的结果为假则返回0，其他情况则返回NULL。
-- =,<=>,<>(!=),<,<=,>,>=
-- 等号运算符（=）判断等号两边的值、字符串或表达式是否相等，
-- - 如果等号两边的值一个是整数，另一个是字符串，则MySQL会将字符串转化为数字进行比较。
-- - 如果等号两边的值、字符串或表达式中有一个为NULL，则比较结果为NULL。
-- 安全等于运算符（<=>）与等于运算符（=）的作用是相似的，`唯一的区别`是‘<=>’可以用来对NULL进行判断。在两个操作数均为NULL时，其返回值为1，而不为NULL；当一个操作数为NULL时，其返回值为0，而不为NULL。
-- 不等于运算符不能判断NULL值。如果两边的值有任意一个为NULL，或两边都为NULL，则结果为NULL。



####  此外，还有非符号类型的运算符：
###
-- is null,is not null,least,greatest,between...and...,isnull,in,
-- not in,like,regexp,rlike


-- 空运算符（IS NULL或者ISNULL）判断一个值是否为NULL，如果为NULL则返回1，否则返回0。
-- mysql> SELECT NULL IS NULL, ISNULL(NULL), ISNULL('a'), 1 IS NULL;
-- 语法格式为：LEAST(值1，值2，...，值n)
-- mysql> SELECT LEAST (1,0,2), LEAST('b','a','c'), LEAST(1,NULL,2);当比较值列表中有NULL时，不能判断大小，返回值为NULL。

-- mysql> SELECT 1 BETWEEN 0 AND 1, 10 BETWEEN 11 AND 12, 'b' BETWEEN 'a' AND 'c';
-- SELECT last_name, salary
-- FROM   employees
-- WHERE  salary BETWEEN 2500 AND 3500;
-- mysql> SELECT 'a' IN ('a','b','c'), 1 IN (2,3), NULL IN ('a','b'), 'a' IN ('a', NULL);如果给定的值为NULL，或者IN列表中存在NULL，则结果为NULL。
-- SELECT employee_id, last_name, salary, manager_id
-- FROM   employees
-- WHERE  manager_id IN (100, 101, 201);

### 11. LIKE运算符
###
-- “%”：匹配0个或多个字符。
-- “_”：只能匹配一个字符。
-- LIKE运算符主要用来匹配字符串，通常用于模糊匹配，如果满足条件则返回1，否则返回0。如果给定的值或者匹配条件为NULL，则返回结果为NULL。
-- SELECT	first_name
-- FROM 	employees
-- WHERE	first_name LIKE 'S%';

-- **ESCAPE**
-- - 回避特殊符号的：**使用转义符**。
-- 例如：将[%]转为[$%]、[]转为[$]，然后再加上[ESCAPE‘$’]即可。
-- SELECT job_id
-- FROM   jobs
-- WHERE  job_id LIKE ‘IT\_%‘;
-- 如果使用\表示转义，要省略ESCAPE。如果不是\，则要加上ESCAPE。
-- SELECT job_id
-- FROM   jobs
-- WHERE  job_id LIKE ‘IT$_%‘ escape ‘$‘;

### **12. REGEXP运算符**
###
-- REGEXP运算符用来匹配字符串，语法格式为：`expr REGEXP 匹配条件`。如果expr满足匹配条件，返回1；如果不满足，则返回0。若expr或匹配条件任意一个为NULL，则结果为NULL。

-- REGEXP运算符在进行匹配时，常用的有下面几种通配符：

-- （1）‘^’匹配以该字符后面的字符开头的字符串。
-- （2）‘$’匹配以该字符前面的字符结尾的字符串。
-- （3）‘.’匹配任何一个单字符。
-- （4）“[...]”匹配在方括号内的任何字符。例如，“[abc]”匹配“a”或“b”或“c”。为了命名字符的范围，使用一个‘-’。“[a-z]”匹配任何字母，而“[0-9]”匹配任何数字。
-- （5）‘*’匹配零个或多个在它前面的字符。例如，“x*”匹配任何数量的‘x’字符，“[0-9]*”匹配任何数量的数字，而“*”匹配任何数量的任何字符。

#### 3. 逻辑运算符
### not(!),and(&&),or(||),XOR,

-- not null 返回null
-- 0 AND NULL ==0
-- 1 AND NULL ==null
-- 1 OR NULL == 1
-- 0 || NULL == null
-- NULL || NULL == null
-- OR可以和AND一起使用，但是在使用时要注意两者的优先级，由于AND的优先级高于OR，因此先对AND两边的操作数进行操作，再与OR中的操作数结合。
-- 逻辑异或（XOR）运算符是当给定的值中任意一个值为NULL时，则返回NULL；如果两个非NULL的值都是0或者都不等于0时，则返回0；如果一个值为0，另一个值不为0时，则返回1。

#### 4. 位运算符
### &,!,^(位异或),~(位取反),>>,<<

-- 位运算符是在二进制数上进行计算的运算符。位运算符会先将操作数变成二进制数，然后进行位运算，最后将计算结果从二进制变回十进制数。
-- 由于按位取反（~）运算符的优先级高于按位与（&）运算符的优先级，所以10 & ~1，首先，对数字1进行按位取反操作，结果除了最低位为0，其他位都为1，然后与10进行按位与操作，结果为10。
-- 按位右移（>>）运算符将给定的值的二进制数的所有位右移指定的位数。右移指定的位数后，右边低位的数值被移出并丢弃，左边高位空出的位置用0补齐。

#### 5. 运算符的优先级
-- 1 :=,=(赋值)
-- 2 ||,or,XOR
-- 3 &&,and
-- 4 not
-- 5 between ,case,when,then,else
-- 6 =,<=>,is like,regexp,in
-- 7 |
-- 8 &
-- 9 <<,>>
-- 10 -,+
-- 11 *,/,DIV,%,MOD
-- 12 ^
-- 13 -,~
-- 14 !
-- 15 ()
-- -- 数字编号越大，优先级越高，优先级高的运算符先进行计算。可以看到，赋值运算符的优先级最低，使用“()”括起来的表达式的优先级最高。

#### 使用正则表达式查询
### ^,$,.,*,+(1至无限次),<字符串>（ 匹配指定字符串），[字符集合],[^(表示非)],字符串{n,},字符串{n,m}##n至m次，两端包含
 
-- 正则表达式通常被用来检索或替换那些符合某个模式的文本内容，根据指定的匹配模式匹配文本中符合要求的特殊字符串。例如，从一个文本文件中提取电话号码，查找一篇文章中重复的单词或者替换用户输入的某些敏感词语等，这些地方都可以使用正则表达式。正则表达式强大而且灵活，可以应用于非常复杂的查询。

-- MySQL中使用REGEXP关键字指定正则表达式的字符匹配模式。下表列出了REGEXP操作符中常用字符匹配列表。

##### 第05章_排序与分页

-- - **ASC（ascend）: 升序**
-- - **DESC（descend）:降序*

-- ### 1.3 多列排序
-- SELECT last_name, department_id, salary
-- FROM   employees
-- ORDER BY department_id, salary DESC;
-- - 可以使用不在SELECT列表中的列排序。
-- - 在对多列进行排序的时候，首先排序的第一列必须有相同的列值，才会对第二列进行排序。如果第一列数据中所有值都是唯一的，将不再对第二列进行排序。

### 2. 分页
### LIMIT [位置偏移量,] 行数

-- 第一个“位置偏移量”参数指示MySQL从哪一行开始显示，是一个可选参数，如果不指定“位置偏移量”，将会从表中的第一条记录开始（第一条记录的位置偏移量是0，第二条记录的位置偏移量是1，以此类推）；第二个参数“行数”指示返回的记录条数。

-- MySQL 8.0中可以使用“LIMIT 3 OFFSET 4”，意思是获取从第5条记录开始后面的3条记录，和“LIMIT 4,3;”返回的结果相同。

-- - 使用 LIMIT 的好处

-- 约束返回结果的数量可以`减少数据表的网络传输量`，也可以`提升查询效率`。如果我们知道返回结果只有 1 条，就可以使用`LIMIT 1`，告诉 SELECT 语句只需要返回一条记录即可。这样的好处就是 SELECT 不需要扫描完整的表，只需要检索到一条符合条件的记录即可返回。

### 2.3 拓展

-- 在不同的 DBMS 中使用的关键字可能不同。在 MySQL、PostgreSQL、MariaDB 和 SQLite 中使用 LIMIT 关键字，而且需要放到 SELECT 语句的最后面。
-- - 如果是 SQL Server 和 Access，需要使用 `TOP` 关键字，比如：

-- ```mysql
-- SELECT TOP 5 name, hp_max FROM heros ORDER BY hp_max DESC
-- ```

-- - 如果是 DB2，使用`FETCH FIRST 5 ROWS ONLY`这样的关键字：


-- ```mysql
-- SELECT name, hp_max FROM heros ORDER BY hp_max DESC FETCH FIRST 5 ROWS ONLY
-- ```

-- - 如果是 Oracle，你需要基于 `ROWNUM` 来统计行数：


-- ```mysql
-- SELECT rownum,last_name,salary FROM employees WHERE rownum < 5 ORDER BY salary DESC;
-- ```

-- 需要说明的是，这条语句是先取出来前 5 条数据行，然后再按照 hp_max 从高到低的顺序进行排序。但这样产生的结果和上述方法的并不一样。我会在后面讲到子查询，你可以使用

-- ```mysql
-- SELECT rownum, last_name,salary
-- FROM (
--     SELECT last_name,salary
--     FROM employees
--     ORDER BY salary DESC)
-- WHERE rownum < 10;
-- ```

-- 得到与上述方法一致的结果。


















