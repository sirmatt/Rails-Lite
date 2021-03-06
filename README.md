#Rails Lite => A web server M[VC] framework inspired by the functionality of Ruby on Rails!

### RubyGems Used

* Active Support / Core-ext (mostly for helper methods)
* ERB (for the templates)
* Rack (for wrapping HTTP requests + responses)
* JSON (for serializing stuff)

### How to use and run code

_The core code is found in the <code>lib</code> directory._

* You're going to need Ruby installed on your computer to see the magic happen. Follow the directions [here](http://installrails.com/steps/choose_os) and you'll be good to go.

* Download all the files of this repository [here](https://github.com/sirmatt/Rails-Lite/archive/master.zip).

* Pop open your terminal/console/shell and change directories into the folder where you saved these files. Let's pretend you saved the repository to your Desktop:

![Imgur](http://i.imgur.com/yIFQYUj.png)

* Use your terminal to open the entire directory with your favorite text editor. If you're not sure how, google the name of your editor and "opening files from terminal" and you should be golden. For me, I use Atom:

![Imgur](http://i.imgur.com/i0eKIhc.png)

* Run _bundle install_ so you have all the RubyGems you need from the Gemfile

![Imgur](http://i.imgur.com/O8G8Imu.png)

* There are 3 test servers that are all setup for you inside of the *test* folder. For example, type this into your terminal if you want Ruby to run the <code>router_server.rb</code> file:

![Imgur](http://i.imgur.com/8EM7NNv.png)

Your terminal should look similar to this:
![Imgur](http://i.imgur.com/N5z1DK6.png)

* Finally, open up your browser and type <code>localhost:3000</code> into the url. _Enjoy_.
