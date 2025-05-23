-- 表: Employee
--
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | salary      | int  |
-- +-------------+------+
-- id 是该表的主键（列中的值互不相同）。
-- 该表的每一行都包含有关员工工资的信息。
--
--
-- 编写一个解决方案查询 Employee 表中第 n 高的 不同 工资。如果少于 n 个不同工资，查询结果应该为 null 。
--
-- 查询结果格式如下所示。
--
--
--
-- 示例 1:
--
-- 输入:
-- Employee table:
-- +----+--------+
-- | id | salary |
-- +----+--------+
-- | 1  | 100    |
-- | 2  | 200    |
-- | 3  | 300    |
-- +----+--------+
-- n = 2
-- 输出:
-- +------------------------+
-- | getNthHighestSalary(2) |
-- +------------------------+
-- | 200                    |
-- +------------------------+
-- 示例 2:
--
-- 输入:
-- Employee 表:
-- +----+--------+
-- | id | salary |
-- +----+--------+
-- | 1  | 100    |
-- +----+--------+
-- n = 2
-- 输出:
-- +------------------------+
-- | getNthHighestSalary(2) |
-- +------------------------+
-- | null                   |
-- +------------------------+


CREATE TABLE Employee (
    id INT PRIMARY KEY,
    salary INT
);

-- 示例数据
INSERT INTO Employee (id, salary) VALUES
(1, 100),
(2, 200),
(3, 300);


CREATE OR REPLACE FUNCTION getNthHighestSalary(n INT)
RETURNS INT AS $$
BEGIN
    RETURN (
        SELECT (
            SELECT DISTINCT Employee.salary
            FROM Employee
            ORDER BY salary DESC
            LIMIT 1 OFFSET n - 1
                   ) AS t
        );

END;
$$ LANGUAGE plpgsql;

SELECT getNthHighestSalary(1);