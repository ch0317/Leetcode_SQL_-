-- Customers 表：
--
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | name        | varchar |
-- +-------------+---------+
-- 在 SQL 中，id 是该表的主键。
-- 该表的每一行都表示客户的 ID 和名称。
-- Orders 表：
--
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | customerId  | int  |
-- +-------------+------+
-- 在 SQL 中，id 是该表的主键。
-- customerId 是 Customers 表中 ID 的外键( Pandas 中的连接键)。
-- 该表的每一行都表示订单的 ID 和订购该订单的客户的 ID。
--
--
-- 找出所有从不点任何东西的顾客。
--
-- 以 任意顺序 返回结果表。
--
-- 结果格式如下所示。
--
--
--
-- 示例 1：
--
-- 输入：
-- Customers table:
-- +----+-------+
-- | id | name  |
-- +----+-------+
-- | 1  | Joe   |
-- | 2  | Henry |
-- | 3  | Sam   |
-- | 4  | Max   |
-- +----+-------+
-- Orders table:
-- +----+------------+
-- | id | customerId |
-- +----+------------+
-- | 1  | 3          |
-- | 2  | 1          |
-- +----+------------+
-- 输出：
-- +-----------+
-- | Customers |
-- +-----------+
-- | Henry     |
-- | Max       |
-- +-----------+

-- 创建 Customers 表
CREATE TABLE Customers (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- 创建 Orders 表
CREATE TABLE Orders (
    id INT PRIMARY KEY,
    customerId INT,
    FOREIGN KEY (customerId) REFERENCES Customers(id)
);

-- 插入 Customers 表数据
INSERT INTO Customers (id, name) VALUES
(1, 'Joe'),
(2, 'Henry'),
(3, 'Sam'),
(4, 'Max');

-- 插入 Orders 表数据
INSERT INTO Orders (id, customerId) VALUES
(1, 3),
(2, 1);


-- my
SELECT Customers.name AS Customers
FROM Customers left join Orders ON Customers.id = Orders.customerId
WHERE Orders.id IS NULL;




--answer
SELECT name AS Customers
FROM Customers
LEFT JOIN Orders
ON Customers.id = Orders.customerId
WHERE Orders.id IS NULL;
