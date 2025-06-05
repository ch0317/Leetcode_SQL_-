-- Table: Activity
--
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | player_id    | int     |
-- | device_id    | int     |
-- | event_date   | date    |
-- | games_played | int     |
-- +--------------+---------+
-- （player_id，event_date）是此表的主键（具有唯一值的列的组合）。
-- 这张表显示了某些游戏的玩家的活动情况。
-- 每一行是一个玩家的记录，他在某一天使用某个设备注销之前登录并玩了很多游戏（可能是 0）。
--
--
-- 编写解决方案，报告在首次登录的第二天再次登录的玩家的 比率，四舍五入到小数点后两位。
-- 换句话说，你需要计算从首次登录日期开始至少连续两天登录的玩家的数量，然后除以玩家总数。
--
-- 结果格式如下所示：
--
--
--
-- 示例 1：
--
-- 输入：
-- Activity table:
-- +-----------+-----------+------------+--------------+
-- | player_id | device_id | event_date | games_played |
-- +-----------+-----------+------------+--------------+
-- | 1         | 2         | 2016-03-01 | 5            |
-- | 1         | 2         | 2016-03-02 | 6            |
-- | 2         | 3         | 2017-06-25 | 1            |
-- | 3         | 1         | 2016-03-02 | 0            |
-- | 3         | 4         | 2018-07-03 | 5            |
-- +-----------+-----------+------------+--------------+
-- 输出：
-- +-----------+
-- | fraction  |
-- +-----------+
-- | 0.33      |
-- +-----------+
-- 解释：
-- 只有 ID 为 1 的玩家在第一天登录后才重新登录，所以答案是 1/3 = 0.33

WITH first_login as (
    SELECT Min(event_date) as first_login_day, player_id
    FROM Activity GROUP BY player_id
),
second_login as(
    SELECT Activity.player_id as second_login_player FROM
        first_login t JOIN Activity
        ON Activity.player_id = t.player_id
        AND Activity.event_date = t.first_login_day + INTERVAL '1 day'
),
total_players as(
    SELECT count(DISTINCT player_id) as total_cnt
    FROM Activity
),
res as(
    SELECT count(DISTINCT second_login_player) as second_cnt
    FROM second_login
)
SELECT
    ROUND(
           1.0 * r.second_cnt / t.total_cnt,
           2
    )  as fraction
FROM res r, total_players t;


-- my solution

WITH first_login AS (
    SELECT
        player_id,
        MIN(event_date) AS first_login_day
    FROM Activity
    GROUP BY player_id
),
second_login AS (
    SELECT
        a.player_id AS second_login_player
    FROM first_login t
    JOIN Activity a
        ON a.player_id = t.player_id
        AND a.event_date = t.first_login_day + INTERVAL '1 day'
),
total_players AS (
    SELECT COUNT(DISTINCT player_id) AS total_cnt
    FROM Activity
),
res AS (
    SELECT COUNT(DISTINCT second_login_player) AS second_cnt
    FROM second_login
)
SELECT
    ROUND(
        1.0 * r.second_cnt / t.total_cnt,
        2
    ) AS fraction
FROM res r, total_players t; -- 或者 FROM res r CROSS JOIN total_players t;











--answer
CREATE TABLE Activity (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT,
    PRIMARY KEY (player_id, event_date)
);

INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES
(1, 2, '2016-03-01', 5),
(1, 2, '2016-03-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3, 4, '2018-07-03', 5);

WITH first_login AS (
    SELECT
        player_id,
        MIN(event_date) AS first_login_date
    FROM Activity
    GROUP BY player_id
),
second_day_login AS (
    SELECT
        a.player_id
    FROM Activity a
    JOIN first_login f
      ON a.player_id = f.player_id
     AND a.event_date = f.first_login_date + INTERVAL '1 day'
),
total_players AS (
    SELECT COUNT(DISTINCT player_id) AS total_cnt
    FROM Activity
),
res AS (
    SELECT COUNT(DISTINCT player_id) AS second_day_cnt
    FROM second_day_login
)
SELECT
    ROUND(
        1.0 * r.second_day_cnt / t.total_cnt,
        2
    ) AS fraction
FROM res r, total_players t;
