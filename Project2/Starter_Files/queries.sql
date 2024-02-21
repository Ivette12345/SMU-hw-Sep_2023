--1. List the companies names that failed including the US as the country.
select company_name, outcome, country
from campaign
where outcome='failed'and country='US';


--2. List the frequency counts in descending order of categories with successful outcome.
select category.category_id, category, count(outcome) 
from category
join campaign
on category.category_id=campaign.category_id
where outcome='successful'
group by category.category_id, outcome
order by count(outcome)desc;

--3. List the contact_id for contacts whose last name begins with letter B along with company_name
select contacts.contact_id, contacts.last_name, campaign.company_name
from contacts
join campaign
on contacts.contact_id=campaign.contact_id
where last_name like'B%';







