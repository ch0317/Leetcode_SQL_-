-- 表： Employee
--
-- +--------------+---------+
-- | 列名          | 类型    |
-- +--------------+---------+
-- | id           | int     |
-- | name         | varchar |
-- | salary       | int     |
-- | departmentId | int     |
-- +--------------+---------+
-- 在 SQL 中，id是此表的主键。
-- departmentId 是 Department 表中 id 的外键（在 Pandas 中称为 join key）。
-- 此表的每一行都表示员工的 id、姓名和工资。它还包含他们所在部门的 id。
--
--
-- 表： Department
--
-- +-------------+---------+
-- | 列名         | 类型    |
-- +-------------+---------+
-- | id          | int     |
-- | name        | varchar |
-- +-------------+---------+
-- 在 SQL 中，id 是此表的主键列。
-- 此表的每一行都表示一个部门的 id 及其名称。
--
--
-- 查找出每个部门中薪资最高的员工。
-- 按 任意顺序 返回结果表。
-- 查询结果格式如下例所示。
--
--
--
-- 示例 1:
--
-- 输入：
-- Employee 表:
-- +----+-------+--------+--------------+
-- | id | name  | salary | departmentId |
-- +----+-------+--------+--------------+
-- | 1  | Joe   | 70000  | 1            |
-- | 2  | Jim   | 90000  | 1            |
-- | 3  | Henry | 80000  | 2            |
-- | 4  | Sam   | 60000  | 2            |
-- | 5  | Max   | 90000  | 1            |
-- +----+-------+--------+--------------+
-- Department 表:
-- +----+-------+
-- | id | name  |
-- +----+-------+
-- | 1  | IT    |
-- | 2  | Sales |
-- +----+-------+
-- 输出：
-- +------------+----------+--------+
-- | Department | Employee | Salary |
-- +------------+----------+--------+
-- | IT         | Jim      | 90000  |
-- | Sales      | Henry    | 80000  |
-- | IT         | Max      | 90000  |
-- +------------+----------+--------+
-- 解释：Max 和 Jim 在 IT 部门的工资都是最高的，Henry 在销售部的工资最高。

CREATE TABLE Employee (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    salary INT,
    departmentId INT,
    FOREIGN KEY (departmentId) REFERENCES Department(id)
);

INSERT INTO Employee (id, name, salary, departmentId) VALUES
(1, 'Joe', 70000, 1),
(2, 'Jim', 90000, 1),
(3, 'Henry', 80000, 2),
(4, 'Sam', 60000, 2),
(5, 'Max', 90000, 1);

CREATE TABLE Department (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

INSERT INTO Department (id, name) VALUES
(1, 'IT'),
(2, 'Sales');


SELECT d.name AS Department,
       e.name AS Employee,
       e.salary AS Salary
FROM Employee e
JOIN Department d ON e.departmentId = d.id
WHERE (e.departmentId, e.salary) IN
(
    SELECT departmentId,max(salary)
    FROM Employee
    GROUP BY departmentId
);

SELECT
    d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary
FROM Employee e
JOIN Department d ON e.departmentId = d.id
WHERE (e.salary, e.departmentId) IN (
    SELECT MAX(salary), departmentId
    FROM Employee
    GROUP BY departmentId
);