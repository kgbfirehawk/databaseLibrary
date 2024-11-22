// app.js


/*
    SETUP
*/
// Express
var express = require('express');   // We are using the express library for the web server
var app     = express();            // We need to instantiate an express object to interact with the server in our code
PORT        = 8727;                 // Set a port number at the top so it's easy to change in the future

// Database
var db = require('./database/db-connector')

// Handlebars
const { engine } = require('express-handlebars');
var exphbs = require('express-handlebars');     // Import express-handlebars
app.engine('.hbs', engine({extname: ".hbs"}));  // Create an instance of the handlebars engine to process templates
app.set('view engine', '.hbs');                 // Tell express to use the handlebars engine whenever it encounters a *.hbs file.
const hbs = require('handlebars');
hbs.registerHelper('eq', function(a, b) {
  return a === b;
});

app.use(express.urlencoded({ extended: true })); 
app.use(express.json()); 

/*
    ROUTES
*/
const staffRoutes = require('./routes/staffRoutes');  // Import staff routes
app.use('/', staffRoutes);  // Use staff routes

app.get('/', function(req, res)
    {  
        let query1 = "SELECT * FROM Staff;";               // Define our query

        db.pool.query(query1, function(error, rows, fields){    // Execute the query

           res.render('index', {data: rows});                  // Render the index.hbs file, and also send the renderer
        }) 
                                                                // an object where 'data' is equal to the 'rows' we
    });                                                         // received back from the query

 /*
    LISTENER
*/
app.listen(PORT, function(){            // This is the basic syntax for what is called the 'listener' which receives incoming requests on the specified PORT.
  console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.')
});   
