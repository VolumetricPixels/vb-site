# vb-site [![Build Status](https://travis-ci.org/VolumetricPixels/vb-site.png)](https://travis-ci.org/VolumetricPixels/vb-site)

The code to the VolumetricBans website.

## Testing

Unit tests can be run with the simple command:

```
npm test
```

## Running

### On your own computer

It is very easy to run the website on your own computer. You just need to:

1. Install [MongoDB](http://www.mongodb.org/) and run it
2. Seed the database - `cake db:seed`
3. Run the server - `cake server`

The database needs to be seeded to be able to test everything, as new users
cannot be created without SendGrid. (yet)

### On Heroku

This website is built to run on [Heroku](http://heroku.com). You can test 
everything in this site using only the free plans. The following is a set of 
commands you can run to get the website working properly on a new Heroku 
instance.

```
heroku create
heroku addons:add mongohq
heroku addons:add sendgrid
heroku addons:add nodetime
heroku config:set NODE_ENV=production
git push heroku master
```

* **MongoHQ** is used for MongoDB.
* **SendGrid** is used to send emails.
* **Nodetime** is used to monitor the performance of the application.

You may also want to seed the database with `heroku run cake db:seed`.

Now you can develop easily by using `git push heroku master` to update the site!

## License

VolumetricBans's website is licensed under the Affero General Public License Version 3. In essence this means any modifications to this code must be made open source. The full text to the license can be found in LICENSE.txt.
