-- 表：Employee
--
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | name        | varchar |
-- | salary      | int     |
-- | managerId   | int     |
-- +-------------+---------+
-- id 是该表的主键（具有唯一值的列）。
-- 该表的每一行都表示雇员的ID、姓名、工资和经理的ID。
--
--
-- 编写解决方案，找出收入比经理高的员工。
--
-- 以 任意顺序 返回结果表。
--
-- 结果格式如下所示。
--
--
--
-- 示例 1:
--
-- 输入:
-- Employee 表:
-- +----+-------+--------+-----------+
-- | id | name  | salary | managerId |
-- +----+-------+--------+-----------+
-- | 1  | Joe   | 70000  | 3         |
-- | 2  | Henry | 80000  | 4         |
-- | 3  | Sam   | 60000  | Null      |
-- | 4  | Max   | 90000  | Null      |
-- +----+-------+--------+-----------+
-- 输出:
-- +----------+
-- | Employee |
-- +----------+
-- | Joe      |
-- +----------+
-- 解释: Joe 是唯一挣得比经理多的雇员。


CREATE TABLE Employee (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary INT,
    managerId INT
);

INSERT INTO Employee (id, name, salary, managerId) VALUES
(1, 'Joe', 70000, 3),
(2, 'Henry', 80000, 4),
(3, 'Sam', 60000, NULL),
(4, 'Max', 90000, NULL);


-- my answer
SELECT a.name as Employee FROM Employee a
JOIN Employee b ON a.managerId = b.id
WHERE a.salary > b.salary;







-- expected answer
SELECT e.name AS Employee
FROM Employee e
JOIN Employee m ON e.managerId = m.id
WHERE e.salary > m.salary;
