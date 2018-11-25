## SQL injection: Allowing the user to run their own database queries
A long time ago, my favourite website was a web forum dedicated to the [Final Fantasy video game series](https://en.wikipedia.org/wiki/Final_Fantasy). Like the users of the _Animal Crossing_ forum, I'd while away many hours [arguing with other people on the internet](https://xkcd.com/386/) about my favourite characters, my favourite stories, and the [greatest controversies of the day](https://www.youtube.com/watch?v=KQc7o2rm7po).

One day, I noticed people were acting strangely. Users were being uncharacteristically nasty and posting in private areas of the forum they wouldn't normally have access to. Then messages started disappearing, and user accounts for well-respected people were banned.

It turns out someone had discovered a way of logging in to any other user account, using a secret password that allowed them to do literally anything they wanted. What was this password that granted untold power to those who wielded it?

`' OR '1'='1`

[SQL](https://en.wikipedia.org/wiki/SQL) is a computer language that is used to query databases. When you fill out a login form, just like the one above, your username and your password are usually inserted into an SQL query like this:

![SQL for a login form](./img/sql-injection-1.gif)
```
SELECT COUNT(*)
FROM USERS
WHERE USERNAME='Alice'
AND PASSWORD='hunter2'
```

This query selects users from the database that match the username _Alice_ and the password _hunter2_. If there is at least one user matching record, the user will be granted access. Let's see what happens when we use our magic password instead!

![Injecting SQL into a login form](./img/sql-injection-2.gif)
```
SELECT COUNT(*)
FROM USERS
WHERE USERNAME='Admin'
AND PASSWORD='' OR '1'='1'
```

Does the password look like part of the query to you? That's because it is! This password is a deliberate attempt to inject our own SQL into the query, hence the term _SQL injection_. The query is now looking for users matching the username _Admin_, with a password that is blank, or _1=1_. In an SQL query, _1=1_ is always _true_, which makes this query select _every single record_ in the database. As long as the forum software is checking for _at least one_ matching user, it will grant the person logging in access. This password will work for _any user registered on the forum!_

So how can you protect yourself from SQL injection?

Never build SQL queries by [concatenating strings](https://en.wikipedia.org/wiki/Concatenation). Instead, use parameterised query tools. PHP offers [prepared statements](http://php.net/manual/en/pdo.prepared-statements.php), and Node.JS has the [knex](http://npmjs.com/package/knex) package. Alternatively, you can use an [ORM](https://en.wikipedia.org/wiki/Object-relational_mapping) tool, such as [Propel](http://propelorm.org/) or [sequelize](https://www.npmjs.com/package/sequelize).

Expert help in the form of language features or software tools is a key ally for securing your code. Get all the help you can!
