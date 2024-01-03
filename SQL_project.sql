/* Query 1 - query used for first insight */
WITH t1 AS (
			SELECT f.title film,
			c.name category,
			r.rental_date rental
			FROM   film f
			JOIN   film_category fc
			ON     f.film_id = fc.film_id
			JOIN   category c
			ON     c.category_id = fc.category_id
			JOIN   inventory i
			ON     i.film_id = f.film_id
			JOIN   rental r
			ON     r.inventory_id = i.inventory_id
			WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music'))
SELECT DISTINCT t1.film film_title,
       t1.category category_name,
       COUNT(t1.rental) OVER (PARTITION BY t1.film) rental_count
FROM   t1
ORDER BY 2, 1;


/* Query 2 */
SELECT f.title title,
       c.name category,
       f.rental_duration rental_duration,
       NTILE(4) OVER (ORDER BY rental_duration) AS standard_quartile
FROM   film f
JOIN   film_category fc
ON     f.film_id = fc.film_id
JOIN   category c
ON     c.category_id = fc.category_id
WHERE  c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')


/* Query 3 - query used for second insight */
WITH t1 AS (
		SELECT f.title title,
		       c.name category,
		       f.rental_duration rental_duration,
		       NTILE(4) OVER (ORDER BY rental_duration) AS standard_quartile
		FROM   film f
		JOIN   film_category fc
		ON     f.film_id = fc.film_id
		JOIN   category c
		ON     c.category_id = fc.category_id
		WHERE  c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music'))
SELECT category,
       standard_quartile,
       COUNT(*) count
FROM   t1
GROUP BY 1, 2
ORDER BY 1, 2


/* Query 4 - query used for third insight */
SELECT DATE_PART('month', r.rental_date) "Rental_month",
	   DATE_PART('year', r.rental_date) "Rental_year",
	   s.store_id "Store_ID",
	   COUNT(rental_date) "Count_rentals"
FROM   rental r
JOIN   staff sf
ON     r.staff_id = sf.staff_id
JOIN   store s
ON     sf.store_id = s.store_id
GROUP BY 1,2,3
ORDER BY 4 DESC;



/* Query 5 - query used for fourth insight */
WITH t1 AS (
		SELECT c.customer_id id,
		       c.first_name || ' ' || c.last_name fullname,
		       SUM(amount) pay_amount
		FROM   payment p
		JOIN   customer c
		ON     p.customer_id = c.customer_id
		WHERE  DATE_PART('year', p.payment_date) = 2007
		GROUP BY 1, 2
		ORDER BY 3 DESC
		LIMIT 10),
	 t2 AS (
	 	SELECT c.customer_id id,
	           DATE_TRUNC('month', p.payment_date) pay_mon,
		       COUNT(*) pay_countpermon,
	           SUM(amount) pay_amount
	    FROM   payment p
	    JOIN   customer c
	    ON     p.customer_id = c.customer_id
	    GROUP BY 1,2)
SELECT t2.pay_mon,
       t1.fullname,
       t2.pay_countpermon,
       t2.pay_amount
FROM   t1
JOIN   t2
ON     t1.id = t2.id
GROUP BY 1, 2, 3, 4
ORDER BY 2, 1


/* Query 6 */
WITH t1 AS (
		SELECT c.customer_id id,
		       c.first_name || ' ' || c.last_name fullname,
		       SUM(amount) pay_amount
		FROM   payment p
		JOIN   customer c
		ON     p.customer_id = c.customer_id
		WHERE  DATE_PART('year', p.payment_date) = 2007
		GROUP BY 1, 2
		ORDER BY 3 DESC
		LIMIT 10),
	 t2 AS (
	 	SELECT c.customer_id id,
	           DATE_TRUNC('month', p.payment_date) pay_mon,
		       COUNT(*) pay_countpermon,
	           SUM(amount) pay_amount
	    FROM   payment p
	    JOIN   customer c
	    ON     p.customer_id = c.customer_id
	    GROUP BY 1,2)
SELECT t2.pay_mon,
       t1.fullname,
       t2.pay_amount,
       LEAD(t2.pay_amount) OVER (PARTITION BY t1.fullname ORDER BY t2.pay_mon) lead,
       COALESCE(LEAD(t2.pay_amount) OVER (PARTITION BY t1.fullname ORDER BY t2.pay_mon), 0) - t2.pay_amount AS lead_difference
FROM   t1
JOIN   t2
ON     t1.id = t2.id
GROUP BY 1, 2, 3
ORDER BY 5 DESC;
