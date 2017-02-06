# Venue Management #

### What is it ? ###

You are a venue manager and your business is to organize corporate events in your venue. You need a tool to track the availability of your different meeting rooms, the goal is to check which is available and a customer wants to make a reservation.

on a web app, the manager is able to add/remove meeting rooms, and book them for a certain time period. also he can check if a room is available for the demanded period of time, or check all the rooms at once and get the available ones listed.

### How do I get set up ? ###

this app works on ruby 2.3.3, but should work for 2.2+ also.
It's easy to get setup:

```
$ bundle install
$ rails db:migrate
```

You will need the sqlite3 on your system, and thats it, now launch rails with this:

`$ rails s`

###### Happy venue management.
