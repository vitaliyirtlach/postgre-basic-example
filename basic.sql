-- drop table posts | users | followers;

create table users (
	id serial primary key,
	username text not null unique
);

create table posts (
	id serial primary key,
	title text not null, 
	content text not null,
	"authorID" int references users(id)
);

create table followers (
	"follower_id" int references users(id),
	"following_id" int references users(id)
);


insert into users(username) values ( 'random_user' );
insert into posts(title, content, "authorID") values (
	'Second blog title',
	'Second blog content',
	2
);



-- select all from tables 
select * from users;
select * from posts;
select * from followers;
-- =======

select username, title from users 
inner join posts 
on users.id = posts."authorID";

insert into followers("follower_id", "following_id") values (1, 4);

select follower_id "id", u1.username, u2.username "following"  from followers 
inner join users u1
on followers."follower_id" = u1.id
inner join users u2
on followers."following_id" =  u2.id;


select count(*) from followers where "following_id" = 1; -- 

-- array of followings id
select username, array_agg(following_id) as "Following id's" from users 
inner join followers
on users.id = followers.follower_id
group by username
order by count(*) desc; -- for the most


-- array of following usernames
select users.username, array_agg(u.username) as "Following id's" from users 
inner join followers
on users.id = followers.follower_id
inner join users u on u.id = followers.following_id 
group by users.username
order by count(*) desc
; 


select username, array_agg(title) as "Blog titles"  from posts 
inner join users on posts."authorID"  = users.id
group  by username 
;
