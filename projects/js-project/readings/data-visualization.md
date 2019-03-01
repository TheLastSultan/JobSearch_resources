# Building a Data Visualization Project

## D3

If you're building a data visualization project, you're most likely planning on using D3. While we do not have an official D3 curriculum, we do have TAs with D3 experience and have compiled this getting started guide for you. You should recognize right off the bat that D3 has a steep learning curve, so you should plan on completing tutorials on reading for the first 2-3 days of the week. This will result in a huge payoff at the end of the week, putting you into a position to quickly manipulate your data and render it in different ways.

## Planning

In your proposal you should include an additional section called `Data and APIs`. In this section, you should describe the source of your data and their API. Do you have to hit an endpoint to collect the data? Can you download the information once and store it locally as [JSON](https://www.w3schools.com/js/js_json_intro.asp)? Or, do you need a backend so that you can hit an API every time the site is loaded? Perhaps you can use the [JavaScript fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch) instead. Be certain that the data you need is actually available - there's nothing worse than having to change your project halfway through the week.

## Schedule

Follow this schedule to quickly familarize yourself with D3 and set yourself up for success:

### W11D1

* Get inspired by the [D3 Gallery](https://github.com/d3/d3/wiki/gallery)
* Make sure to check out the [Game of Thrones project](https://mimno.github.io/showcase/project2/got/)
* [Learn D3 in 5 Minutes](https://medium.freecodecamp.org/learn-d3-js-in-5-minutes-c5ec29fb0725) (yeah, right, but it's a useful article)
* Build on your knowledge by following [these examples](https://dev.to/rxhl/getting-started-with-d3js-390)
* If you are storing your data locally, make sure to download everything you need today. If you need to hit an API, use Postman.
* If your project visualizes data from an API, test the endpoints in Postman with the approporiate headers.

### W11D2

* You will need to pick and choose tutorials today based on the type of data visualization you are trying to generate. Find specific techniques on the [D3 Tutorials](https://github.com/d3/d3/wiki/Tutorials) repo.
* If you are storing your data locally, format it in JSON (or your prefferred format) today. You may have to write your own script to do this. Be creative.
* If your project visualizes data from an API, get a [simple Node backend](https://github.com/appacademy/node-api-backend) set up today and make sure your can `console.log` a response from your API. There is a demo of this backend today during evening office hours.

### W11D3

* Familarize yourself with the [documentation](https://github.com/d3/d3/wiki).
* Learn how to [read data in D3](http://learnjsdata.com/read_data.html).
* If your project visualizes data from an API, make sure you are passing data to your frontend and can utilize it in D3.
* Begin to manipulate your actual data and create your graphs, plots, and charts.

## Next Steps

* On days 4-5, you should be focusing on rendering your data on the page in several useful and interesting ways.
* Over the weekend, you should spend your time styling and deploying your site to a live URL.
* Let the career coaches know if you encountered any helpful resources we should include in this document.