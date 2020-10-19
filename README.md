# README
##  Take home test
A program that will read the full list of customers and output the names and user ids of matching customers (within 100km), sorted by User ID (ascending).
### Ruby version : 2.5.1
Run **bundle install** to install all required gems.
### Test
Tests written using RSpec can be run using **bundle exec rspec** or  **bin/test**. 
### Run
The program can be run using a rake task, type **rake invitation_list** on the console.

 1. Output is printed on the console.
 2. Output file can be found under **/data/output.txt**.

### Debugging
Added [**byebug**]([https://github.com/deivid-rodriguez/byebug]) gem for debugging and  can be invoked using **require 'byebug'** and then calling **byebug** inside the methods to pause the execution flow.