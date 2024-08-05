const express = require("express");
const mysql = require("mysql");
const cors = require("cors");
const bodyParser = require("body-parser");
const session = require("express-session");
const port = 8037;
const app = express();

const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "paket",
});

connection.connect((err) => {
  if (err) {
    console.error("Error connecting to the database:", err);
    return;
  }
  console.log("Connected to the database");
});

app.use(cors());

// Middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "http://localhost:8080"); // The origin of your frontend application
  res.header("Access-Control-Allow-Credentials", "true");
  res.header("Access-Control-Allow-Methods", "GET,POST,PUT,DELETE,OPTIONS");
  res.header("Access-Control-Allow-Headers", "Content-Type, Authorization");
  next();
});

app.use(
  session({
    secret: "rahasia", // Use a strong, unpredictable secret
    resave: false, // Do not save session if not modified
    saveUninitialized: false, // Do not save uninitialized sessions
    cookie: {
      secure: false, // Set to true if using HTTPS
      maxAge: 24 * 60 * 60 * 1000, // 24 hours, adjust as needed
    },
  })
);

app.use((err, req, res, next) => {
  if (res.headersSent) {
    return next(err);
  }
  res.status(500).send("Something went wrong");
});

app.use((req, res, next) => {
  console.log("Session at start of request:", req.session);
  next();
});

// login
app.post("/login_users", (req, res) => {
  const username = req.body.username;
  const password = req.body.password;

  if (username && password) {
    const sql = "SELECT * FROM users WHERE username = ? AND password = ?";
    connection.query(sql, [username, password], (error, results, fields) => {
      if (error) throw error;
      if (results.length > 0) {
        // bcrypt.compare(password, results[0].password, (err, result) => {
        if (results) {
          req.session.isLoggedIn = true;
          req.session.username = username;
          req.session.save((err) => {
            if (err) {
              // Handle error and send a response
              if (!res.headersSent) {
                return res.status(500).send("Error saving session");
              }
            }

            // Ensure no other response has been sent
            if (!res.headersSent) {
              res.send("Session data set!");
            }
          });
          // req.session.save((err) => {
          //   if (err) {
          //     console.error("Error saving session:", err);
          //     return res.status(500).send("Error saving session");
          //   }

          //   // Ensure no other response has been sent
          //   if (!res.headersSent) {
          //     res.send("Session variable set and saved!");
          //   }
          // });
          console.log(req.session);
          res.json({
            code: "200",
            message: "Login successful!",
            username: req.session.username,
          });
        } else {
          res.json({ code: "401", message: "Incorrect Password!" });
        }
        // });
      } else {
        res.json({ code: "404", message: "Username or Level not found!" });
      }
    });
  } else {
    res.json({
      code: "400",
      message: "Please enter Username, Password, and Level!",
    });
  }
});

app.use((req, res, next) => {
  console.log("Session at start of request:", req.session);
  next();
});

app.get("/check-session", (req, res) => {
  try {
    if (!req.session) {
      console.log("No session found");
      return res.status(400).send("No session found");
    }
    console.log("Session check2:", req.session);
    res.send("Session data logged");
  } catch (error) {
    console.error("Error during session check:", error);
    res.status(500).send("Internal Server Error");
  }
});

app.use((req, res, next) => {
  console.log("Session at end of request:", req.session);
  next();
});

app.get("/session-data", (req, res) => {
  res.json(req.session.username); // Send the session data as JSON
});

// get users
app.get("/users", (req, res) => {
  const sql = "SELECT * FROM users";
  connection.query(sql, (err, data) => {
    if (err) return res.json("Error");
    return res.json({ code: "200", data });
  });
});

app.use(
  cors({
    origin: "http://localhost:8080/packetin",
    credentials: true,
  })
);

app.listen(port, () => {
  console.log("Server Ready on port " + port);
});
