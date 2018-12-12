When given two inputs files: Access.log and Error.log, we have to implement the following requests:

* total get requests
* how many unique ip addresses were seen
* which was most commnly seen ip address
* how many of the get requests were for faculty/staff pages
* which faculty/staff was the most popular, and how many requests did they get
* what are the 3 most popular pages/resources requested listed from most popular at the top, to least popular toward the bottom
* what was the single most popular page/resource requested that wasn't a faculty/staff page
* How many requests for robots.txt
* How many validly identified, unique bots spidered the site
* note: valid bot name is of form "botname/version;"
* What were the 3 most active bots
* display 3 columns: botname, botversion and requests
* note: display from most active to least active
* How many permission denied requests were there?
* How many unique faculty/staff had permission denied requests
* Which faculty/staff had the most permisson denied errors attempting to access their content
* How many unique ip addresses had errors
* Which IP address had the most errors and how many
* How unique process IDs showed up in the logs
* Which process ID showed up the most and how many times
* What is the frequency of an error out of all requests? ((error_count / (error_count + access_count)) * 100) + " percent"
* How many days did the access log cover
* Display number of accesses each day
* How many days did the error log cover
* Display number of errors each day
