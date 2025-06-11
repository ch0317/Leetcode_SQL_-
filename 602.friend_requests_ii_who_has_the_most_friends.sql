-- RequestAccepted 表：
--
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | requester_id   | int     |
-- | accepter_id    | int     |
-- | accept_date    | date    |
-- +----------------+---------+
-- (requester_id, accepter_id) 是这张表的主键(具有唯一值的列的组合)。
-- 这张表包含发送好友请求的人的 ID ，接收好友请求的人的 ID ，以及好友请求通过的日期。
--
--
-- 编写解决方案，找出拥有最多的好友的人和他拥有的好友数目。
--
-- 生成的测试用例保证拥有最多好友数目的只有 1 个人。
--
-- 查询结果格式如下例所示。
--
--
--
-- 示例 1：
--
-- 输入：
-- RequestAccepted 表：
-- +--------------+-------------+-------------+
-- | requester_id | accepter_id | accept_date |
-- +--------------+-------------+-------------+
-- | 1            | 2           | 2016/06/03  |
-- | 1            | 3           | 2016/06/08  |
-- | 2            | 3           | 2016/06/08  |
-- | 3            | 4           | 2016/06/09  |
-- +--------------+-------------+-------------+
-- 输出：
-- +----+-----+
-- | id | num |
-- +----+-----+
-- | 3  | 3   |
-- +----+-----+
-- 解释：
-- 编号为 3 的人是编号为 1 ，2 和 4 的人的好友，所以他总共有 3 个好友，比其他人都多。
--
--
-- 进阶：在真实世界里，可能会有多个人拥有好友数相同且最多，你能找到所有这些人吗？

-- 创建 RequestAccepted 表
CREATE TABLE RequestAccepted (
    requester_id INT,
    accepter_id INT,
    accept_date DATE,
    PRIMARY KEY (requester_id, accepter_id)
);

INSERT INTO RequestAccepted (requester_id, accepter_id, accept_date) VALUES
(1, 2, '2016-06-03'),
(1, 3, '2016-06-08'),
(2, 3, '2016-06-08'),
(3, 4, '2016-06-09');



-- my solution



SELECT id, COUNT(id) as num
FROM
    (
        SELECT requester_id as id FROM RequestAccepted
        UNION ALL
        SELECT accepter_id as id FROM RequestAccepted
    )
GROUP BY id
ORDER BY num DESC
LIMIT 1;










-- answer
-- 查询拥有最多好友的用户
SELECT id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id FROM RequestAccepted
) AS all_friends
GROUP BY id
ORDER BY num DESC
LIMIT 1;


WITH all_friends AS (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id FROM RequestAccepted
),
friend_counts AS (
    SELECT id, COUNT(*) AS num
    FROM all_friends
    GROUP BY id
),
max_num AS (
    SELECT MAX(num) AS max_friend_num FROM friend_counts
)
SELECT id, num
FROM friend_counts
WHERE num = (SELECT max_friend_num FROM max_num);
