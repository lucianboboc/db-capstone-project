SELECT
	customers.customer_id AS CustomerID,
	CONCAT(customers.first_name, " ", customers.last_name) AS FullName,
	orders.order_id AS OrderID,
	orders.total AS Cost,
	menu_items.starter_name AS MenuName,
	menu_items.course_name as CourseName
FROM customers
	INNER JOIN orders ON orders.customer_id = customers.customer_id
	INNER JOIN menu ON orders.menu_id = menu.menu_id
	INNER JOIN menu_items ON menu_items.menu_item_id = menu.menu_item_id
ORDER BY Cost;