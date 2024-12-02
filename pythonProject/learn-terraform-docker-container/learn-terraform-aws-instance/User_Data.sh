#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Fetch instance ID from EC2 metadata
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Create the HTML file with the dynamic instance ID
cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Served by Instance: $INSTANCE_ID</title>
    <style>
      body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; }
      h1 { color: #333; }
      p { font-size: 1.2em; }
    </style>
  </head>
  <body>
    <h1>Welcome to My Website</h1>
    <p>This response is served from instance: <strong>$INSTANCE_ID</strong></p>
    <p>The Sky is cloudy &#x2601; & it will rain &#x1F327; today.</p>
    <hr>
    <h2>Forms</h2>
    <form action="/server">
      <div>
        <label for="username">Enter your username:</label>
        <input type="text" id="username" placeholder="Enter your username" name="user">
      </div>
      <div>
        <label for="password">Password:</label>
        <input type="password" id="password" placeholder="Password" name="password">
      </div>
      <div>
        <button type="submit">Submit</button>
      </div>
    </form>
    <hr>
    <div>
      <form action="https://www.youtube.com/results">
        <label for="search-youtube">YouTube Search:</label>
        <input type="text" placeholder="Search on YouTube" name="search_query">
        <button>Search</button>
      </form>
    </div>
    <div>
      <form action="https://www.google.com/search">
        <label for="search-google">Google Search:</label>
        <input type="text" placeholder="Search on Google" name="q">
        <button>Search</button>
      </form>
    </div>
  </body>
</html>
EOF
