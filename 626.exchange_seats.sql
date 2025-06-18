-- 表: Seat
--
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | student     | varchar |
-- +-------------+---------+
-- id 是该表的主键（唯一值）列。
-- 该表的每一行都表示学生的姓名和 ID。
-- ID 序列始终从 1 开始并连续增加。
--
--
-- 编写解决方案来交换每两个连续的学生的座位号。如果学生的数量是奇数，则最后一个学生的id不交换。
--
-- 按 id 升序 返回结果表。
--
-- 查询结果格式如下所示。
--
--
--
-- 示例 1:
--
-- 输入:
-- Seat 表:
-- +----+---------+
-- | id | student |
-- +----+---------+
-- | 1  | Abbot   |
-- | 2  | Doris   |
-- | 3  | Emerson |
-- | 4  | Green   |
-- | 5  | Jeames  |
-- +----+---------+
-- 输出:
-- +----+---------+
-- | id | student |
-- +----+---------+
-- | 1  | Doris   |
-- | 2  | Abbot   |
-- | 3  | Green   |
-- | 4  | Emerson |
-- | 5  | Jeames  |
-- +----+---------+
-- 解释:
-- 请注意，如果学生人数为奇数，则不需要更换最后一名学生的座位。


CREATE TABLE Seat (
    id INT PRIMARY KEY,
    student VARCHAR(100)
);

INSERT INTO Seat (id, student) VALUES
(1, 'Abbot'),
(2, 'Doris'),
(3, 'Emerson'),
(4, 'Green'),
(5, 'Jeames');




--my solution

SELECT
CASE
    WHEN id % 2 = 1 AND id + 1 <= (SELECT max(id) from Seat) THEN id + 1
    WHEN id % 2 = 0 THEN id - 1
    ELSE id
END AS id,
    student
From Seat
order by id;












SELECT
    CASE
        WHEN id % 2 = 1 AND id + 1 <= (SELECT MAX(id) FROM Seat) THEN id + 1
        WHEN id % 2 = 0 THEN id - 1
        ELSE id
    END AS id,
    student
FROM Seat
ORDER BY id;
