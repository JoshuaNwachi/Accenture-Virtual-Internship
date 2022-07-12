select *
from dbo.Reactions

select *
from dbo.content

select *
from dbo.Profile

select *
from dbo.ReactionTypes

-- merging tables together 
select a.content_id,b.user_id,a.type as reaction_type,a.datetime,b.type as content_type ,b.category,c.sentiment,c.score
from dbo.Reactions as a 
left join dbo.content as b
on a.User_ID=b.User_ID
left join dbo.ReactionTypes as c
on a.Type=c.type
where b.type is not null

-- sum of score by category
with cte as (
				select a.content_id,b.user_id,a.type as reaction_type,a.datetime,b.type as content_type ,b.category,c.sentiment,c.score
				from dbo.Reactions as a 
				left join dbo.content as b
				on a.User_ID=b.User_ID
				left join dbo.ReactionTypes as c
				on a.Type=c.type
				where b.type is not null)

select category,
		sum(score) as total_score,
		dense_rank() over(order by sum(score) desc) as no_rank
from cte
group by Category
order by sum(score) desc

-- no of content type 
with cte as ( 
				select a.content_id,b.user_id,a.type as reaction_type,a.datetime,b.type as content_type ,b.category,c.sentiment,c.score
				from dbo.Reactions as a 
				left join dbo.content as b
				on a.User_ID=b.User_ID
				left join dbo.ReactionTypes as c
				on a.Type=c.type
				where b.type is not null)

select content_type, count(content_type) as no_content
from cte
group by content_type
order by 2 desc

--no of sentiment 
with cte as ( 
				select a.content_id,b.user_id,a.type as reaction_type,a.datetime,b.type as content_type ,b.category,c.sentiment,c.score
				from dbo.Reactions as a 
				left join dbo.content as b
				on a.User_ID=b.User_ID
				left join dbo.ReactionTypes as c
				on a.Type=c.type
				where b.type is not null)

select Sentiment, count(Sentiment) as no_sentiment
from cte
group by Sentiment
order by 2 desc 

with cte as ( 
				select a.content_id,b.user_id,a.type as reaction_type,a.datetime,b.type as content_type ,b.category,c.sentiment,c.score
				from dbo.Reactions as a 
				left join dbo.content as b
				on a.User_ID=b.User_ID
				left join dbo.ReactionTypes as c
				on a.Type=c.type
				where b.type is not null)
 
select reaction_type, count(reaction_type) as no_content
from cte
group by reaction_type
order by 2 desc 