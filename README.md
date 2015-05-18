#Family Tree
<h2>Authors:</h2>
Brent Bailey and Andrew Burt

<h2>Description:</h2>
This app allows a user to create and view a family tree, automating different relationships (cousins, aunts and uncles, siblings, grandparents) after the user has assigned different people parents and children. It uses a many-to-many relationship on the People class (many parents have many children, many children have many parents) and a self-join table for People to do so.

<h2>Setup instructions:</h2>
  Runs under ruby v2 on OS X. You'll need to run postgres as following:

    $ postgres

  Leave this running. Now create the database tables as follows:

    $ rake db:create
    $ rake db:migrate
    $ rake db:test:prepare

  Then run the app:

    $ ruby app.rb

The tables will appear as follows:

People:

id  | name
------------- | -------------
1  | Kevin Bacon
2  | Rick James

Assuming Kevin Bacon is Rick James' father:


Family Table:

id  | parent_id | child_id
--- | ------- | -----------
1  | 1 | 2


<h2>Copyright</h2>
 MIT License. Copyright 2015 Brent Bailey & Andrew David Burt
