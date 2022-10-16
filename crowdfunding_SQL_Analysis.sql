-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 

Select c.cf_id ,c.backers_count as bc
from campaign as c
Where outcome = 'live' 
order by bc  desc;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT c.cf_id , count(b.backer_id) as number_of_backers
from backers as b
inner join campaign as c
on b.cf_id = c.cf_id
Where c.outcome = 'live' 
Group by c.cf_id
order by number_of_backers desc;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 

SELECT co.first_name , co.last_name ,co.email,
   (ca.goal-ca.pledged) as "Remaining goal amount"
INTO email_contacts_remaining_goal_amount
FROM contacts as co
Inner JOIN campaign as ca
on co.contact_id = ca.contact_id
where outcome ='live'
order by "Remaining goal amount" DESC;


-- Check the table

SELECT first_name, last_name, email, "Remaining goal amount"
	FROM public.email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

-- NOTE : The question mentioned to order the table by email from backers table but the image showed different ordering. 
--  Hence, to match the outcome in the image the order is done by last name and email in ASC order.

SELECT b.email ,b.first_name, b.last_name ,
	c.cf_id, c.company_name,c.description,
	c.end_date,(c.goal-c.pledged) as "Left of Goal"
INTO email_backers_remaining_goal_amount
FROM backers as b
INNER JOIN campaign as c
ON b.cf_id = c.cf_id
WHERE outcome ='live'
ORDER BY b.last_name ,b.email;

-- Check the table
SELECT email, first_name, last_name, cf_id, company_name, description, end_date, "Left of Goal"
	FROM public.email_backers_remaining_goal_amount;


