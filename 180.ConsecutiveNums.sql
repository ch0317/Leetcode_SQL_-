-- 表：Logs
--
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | num         | varchar |
-- +-------------+---------+
-- 在 SQL 中，id 是该表的主键。
-- id 是一个自增列。
--
--
-- 找出所有至少连续出现三次的数字。
--
-- 返回的结果表中的数据可以按 任意顺序 排列。
--
-- 结果格式如下面的例子所示：
--
--
--
-- 示例 1:
--
-- 输入：
-- Logs 表：
-- +----+-----+
-- | id | num |
-- +----+-----+
-- | 1  | 1   |
-- | 2  | 1   |
-- | 3  | 1   |
-- | 4  | 2   |
-- | 5  | 1   |
-- | 6  | 2   |
-- | 7  | 2   |
-- +----+-----+
-- 输出：
-- Result 表：
-- +-----------------+
-- | ConsecutiveNums |
-- +-----------------+
-- | 1               |
-- +-----------------+
-- 解释：1 是唯一连续出现至少三次的数字。

CREATE TABLE Logs(
    id SERIAL PRIMARY KEY,
    num VARCHAR(10)
);

INSERT INTO Logs (num) VALUES
('1'),
('1'),
('1'),
('2'),
('1'),
('2'),
('2')

SELECT DISTINCT l1.num AS ConsecutiveNums
FROM Logs AS l1
JOIN LOGS AS l2 ON l1.id = l2.id - 1
JOIN LOGS AS l3 ON l1.id = l3.id - 2
WHERE l1.num = l2.num AND l2.num = l3.num;