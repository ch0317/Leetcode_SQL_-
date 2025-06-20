-- 表：Trips
-- +-------------+----------+
-- | Column Name | Type     |
-- +-------------+----------+
-- | id          | int      |
-- | client_id   | int      |
-- | driver_id   | int      |
-- | city_id     | int      |
-- | status      | enum     |
-- | request_at  | varchar  |
-- +-------------+----------+
-- id 是这张表的主键（具有唯一值的列）。
-- 这张表中存所有出租车的行程信息。每段行程有唯一 id ，其中 client_id 和 driver_id 是 Users 表中 users_id 的外键。
-- status 是一个表示行程状态的枚举类型，枚举成员为(‘completed’, ‘cancelled_by_driver’, ‘cancelled_by_client’) 。
-- 表：Users
--
-- +-------------+----------+
-- | Column Name | Type     |
-- +-------------+----------+
-- | users_id    | int      |
-- | banned      | enum     |
-- | role        | enum     |
-- +-------------+----------+
-- users_id 是这张表的主键（具有唯一值的列）。
-- 这张表中存所有用户，每个用户都有一个唯一的 users_id ，role 是一个表示用户身份的枚举类型，枚举成员为 (‘client’, ‘driver’, ‘partner’) 。
-- banned 是一个表示用户是否被禁止的枚举类型，枚举成员为 (‘Yes’, ‘No’) 。
-- 取消率 的计算方式如下：(被司机或乘客取消的非禁止用户生成的订单数量) / (非禁止用户生成的订单总数)。
--
-- 编写解决方案找出 "2013-10-01" 至 "2013-10-03" 期间有 至少 一次完整行程的非禁止用户（乘客和司机都必须未被禁止）的 取消率。
-- 非禁止用户即 banned 为 No 的用户，禁止用户即 banned 为 Yes 的用户。其中取消率 Cancellation Rate 需要四舍五入保留 两位小数 。
--
-- 返回结果表中的数据 无顺序要求 。
--
-- 结果格式如下例所示。
--
--
--
-- 示例 1：
--
-- 输入：
-- Trips 表：
-- +----+-----------+-----------+---------+---------------------+------------+
-- | id | client_id | driver_id | city_id | status              | request_at |
-- +----+-----------+-----------+---------+---------------------+------------+
-- | 1  | 1         | 10        | 1       | completed           | 2013-10-01 |
-- | 2  | 2         | 11        | 1       | cancelled_by_driver | 2013-10-01 |
-- | 3  | 3         | 12        | 6       | completed           | 2013-10-01 |
-- | 4  | 4         | 13        | 6       | cancelled_by_client | 2013-10-01 |
-- | 5  | 1         | 10        | 1       | completed           | 2013-10-02 |
-- | 6  | 2         | 11        | 6       | completed           | 2013-10-02 |
-- | 7  | 3         | 12        | 6       | completed           | 2013-10-02 |
-- | 8  | 2         | 12        | 12      | completed           | 2013-10-03 |
-- | 9  | 3         | 10        | 12      | completed           | 2013-10-03 |
-- | 10 | 4         | 13        | 12      | cancelled_by_driver | 2013-10-03 |
-- +----+-----------+-----------+---------+---------------------+------------+
-- Users 表：
-- +----------+--------+--------+
-- | users_id | banned | role   |
-- +----------+--------+--------+
-- | 1        | No     | client |
-- | 2        | Yes    | client |
-- | 3        | No     | client |
-- | 4        | No     | client |
-- | 10       | No     | driver |
-- | 11       | No     | driver |
-- | 12       | No     | driver |
-- | 13       | No     | driver |
-- +----------+--------+--------+
-- 输出：
-- +------------+-------------------+
-- | Day        | Cancellation Rate |
-- +------------+-------------------+
-- | 2013-10-01 | 0.33              |
-- | 2013-10-02 | 0.00              |
-- | 2013-10-03 | 0.50              |
-- +------------+-------------------+
-- 解释：
-- 2013-10-01：
--   - 共有 4 条请求，其中 2 条取消。
--   - 然而，id=2 的请求是由禁止用户（user_id=2）发出的，所以计算时应当忽略它。
--   - 因此，总共有 3 条非禁止请求参与计算，其中 1 条取消。
--   - 取消率为 (1 / 3) = 0.33
-- 2013-10-02：
--   - 共有 3 条请求，其中 0 条取消。
--   - 然而，id=6 的请求是由禁止用户发出的，所以计算时应当忽略它。
--   - 因此，总共有 2 条非禁止请求参与计算，其中 0 条取消。
--   - 取消率为 (0 / 2) = 0.00
-- 2013-10-03：
--   - 共有 3 条请求，其中 1 条取消。
--   - 然而，id=8 的请求是由禁止用户发出的，所以计算时应当忽略它。
--   - 因此，总共有 2 条非禁止请求参与计算，其中 1 条取消。
--   - 取消率为 (1 / 2) = 0.50


-- my sulotion








--anwser


CREATE TABLE Users (
  users_id INT PRIMARY KEY,
  banned ENUM('Yes', 'No'),
  role ENUM('client', 'driver', 'partner')
);

CREATE TABLE Trips (
  id INT PRIMARY KEY,
  client_id INT,
  driver_id INT,
  city_id INT,
  status ENUM('completed', 'cancelled_by_driver', 'cancelled_by_client'),
  request_at VARCHAR(10),
  FOREIGN KEY (client_id) REFERENCES Users(users_id),
  FOREIGN KEY (driver_id) REFERENCES Users(users_id)
);


INSERT INTO Users (users_id, banned, role) VALUES
(1, 'No', 'client'),
(2, 'Yes', 'client'),
(3, 'No', 'client'),
(4, 'No', 'client'),
(10, 'No', 'driver'),
(11, 'No', 'driver'),
(12, 'No', 'driver'),
(13, 'No', 'driver');


INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES
(1, 1, 10, 1, 'completed', '2013-10-01'),
(2, 2, 11, 1, 'cancelled_by_driver', '2013-10-01'),
(3, 3, 12, 6, 'completed', '2013-10-01'),
(4, 4, 13, 6, 'cancelled_by_client', '2013-10-01'),
(5, 1, 10, 1, 'completed', '2013-10-02'),
(6, 2, 11, 6, 'completed', '2013-10-02'),
(7, 3, 12, 6, 'completed', '2013-10-02'),
(8, 2, 12, 12, 'completed', '2013-10-03'),
(9, 3, 10, 12, 'completed', '2013-10-03'),
(10, 4, 13, 12, 'cancelled_by_driver', '2013-10-03');



SELECT
  t.request_at AS Day,
  ROUND(
    SUM(CASE WHEN t.status IN ('cancelled_by_driver', 'cancelled_by_client') THEN 1 ELSE 0 END)
    / COUNT(*), 2
  ) AS `Cancellation Rate`
FROM Trips t
JOIN Users c ON t.client_id = c.users_id AND c.banned = 'No' AND c.role = 'client'
JOIN Users d ON t.driver_id = d.users_id AND d.banned = 'No' AND d.role = 'driver'
WHERE t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY t.request_at;
