-- 表: Employee
--
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | name        | varchar |
-- | department  | varchar |
-- | managerId   | int     |
-- +-------------+---------+
-- id 是此表的主键（具有唯一值的列）。
-- 该表的每一行表示雇员的名字、他们的部门和他们的经理的id。
-- 如果managerId为空，则该员工没有经理。
-- 没有员工会成为自己的管理者。
--
--
-- 编写一个解决方案，找出至少有五个直接下属的经理。
--
-- 以 任意顺序 返回结果表。
--
-- 查询结果格式如下所示。
--
--
--
-- 示例 1:
--
-- 输入:
-- Employee 表:
-- +-----+-------+------------+-----------+
-- | id  | name  | department | managerId |
-- +-----+-------+------------+-----------+
-- | 101 | John  | A          | Null      |
-- | 102 | Dan   | A          | 101       |
-- | 103 | James | A          | 101       |
-- | 104 | Amy   | A          | 101       |
-- | 105 | Anne  | A          | 101       |
-- | 106 | Ron   | B          | 101       |
-- +-----+-------+------------+-----------+
-- 输出:
-- +------+
-- | name |
-- +------+
-- | John |
-- +------+
DROP TABLE Employee;

CREATE TABLE Employee (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100),
    managerId INT
);

INSERT INTO Employee (id, name, department, managerId) VALUES
(101, 'John',  'A', NULL),
(102, 'Dan',   'A', 101),
(103, 'James', 'A', 101),
(104, 'Amy',   'A', 101),
(105, 'Anne',  'A', 101),
(106, 'Ron',   'B', 101);



-- myanswer

SELECT e.name FROM Employee e
    JOIN
(
    SELECT managerId FROM Employee WHERE managerId IS NOT NULL
                                   GROUP BY managerId
                                   HAVING count(*) >= 5
) m ON e.id = m.managerId;








-- solution

SELECT e.name
FROM Employee e
JOIN (
    SELECT managerId
    FROM Employee
    WHERE managerId IS NOT NULL
    GROUP BY managerId
    HAVING COUNT(*) >= 5
) m ON e.id = m.managerId;



