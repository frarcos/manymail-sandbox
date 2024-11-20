<img src="logo.png" alt="logo" width="200"/>

# ManyMail Sandbox SMTP Server Documentation

ManyMail Sandbox SMTP is an open-source project designed for developers to self-host a mail server for testing purposes. It offers features like concurrent SSL, TLS, and unauthenticated servers, a web interface for reading emails, and an API for programmatic email management.

## Table of Contents

1. [Key Features](#1-key-features)
2. [Quick Start](#2-quick-start)
3. [Configuration](#3-configuration)
4. [API Endpoints](#4-api-endpoints)
5. [Troubleshooting](#5-troubleshooting)
6. [Usage Examples](#6-usage-examples-client)
7. [Valid alternatives](#7-valid-alternatives)
8. [Contributions](#8-contributions)

## 1. Key Features

1. Concurrent SMTP Servers:
   SSL, TLS, and no-authentication servers can run simultaneously.
2. Web Interface:
   A simple UI for viewing received emails.
   Accessible at http://localhost:8080.
3. API Access:
   REST API for managing and retrieving emails.
   Runs on port 8080.
4. Authentication:
   Unified username and password for SMTP servers and the web interface.
   Credentials are stored in the `.env` file.
5. High Customizability:
   Extensive configuration options via the `.env` file.
   Installation and Setup
   You can set up ManyMail Sandbox SMTP using npm or Docker.

## 2. Quick Start

### Option 1: Using npm

1. Clone the repository and install npm packages:

   ```bash
   git clone https://github.com/frarcos/manymail-sandbox.git
   cd manymail-sandbox
   npm install
   ```

2. (OPTIONAL) Configure the `.env` file (see details below).
3. Start the server:
   ```bash
   npm start
   ```
4. Send emails to the sandbox SMTP server (see [examples](#6-usage-examples-client) below)
5. Access the web interface at [http://localhost:8080]() using the credentials specified in the `.env` file (_ADMIN_USERNAME_ and _ADMIN_PASSWORD_).

### Option 2: Using Docker

1. Clone the repository:
   ```bash
   git clone https://github.com/frarcos/manymail-sandbox.git
   cd manymail-sandbox
   ```
2. (OPTIONAL) Configure the `.env` file (see details below).
3. Build and run the Docker container.
   For the docker execution, environment variables are stored in the environment section of the docker.compose.yml file, see env variables setup below
   ```bash
   docker-compose -f docker-compose.yml up --build -d --force-recreate
   ```
4. Send emails to the sandbox SMTP server (see [examples](#6-usage-examples) below)
5. Access the web interface at [http://localhost:8080]() using the credentials specified in the `.env` file (_ADMIN_USERNAME_ and _ADMIN_PASSWORD_).

## 3. Configuration

The `.env` file is used to customize the behavior of ManyMail Sandbox SMTP. Below is a detailed explanation of each configuration:

| Variable                 | Default | Description                                                                   |
| ------------------------ | ------- | ----------------------------------------------------------------------------- |
| ADMIN_USERNAME           | root    | Username for authentication in the web app and SMTP servers                   |
| ADMIN_PASSWORD           | root    | Password for authentication in the web app and SMTP servers                   |
| UNSECURE_SMTP_PORT       | 25      | Port for the unauthenticated SMTP server                                      |
| SMTP_PORT                | 465     | Port for the unauthenticated SMTP server                                      |
| STARTTLS_PORT            | 587     | Port for the STARTTLS SMTP server                                             |
| RUN_UNSECURE_SMTP_SERVER | true    | Set to true to enable the unauthenticated SMTP server (true/false)            |
| RUN_SMTP_SERVER          | true    | Set to true to enable the SSL SMTP server (true/false)                        |
| RUN_STARTTLS_SERVER      | true    | Set to true to enable the STARTTLS SMTP server (true/false)                   |
| ENABLE_LOGGING           | true    | Set to true to enable logging of server activities and API calls (true/false) |
| MAX_STORED_MESSAGES      | 1000000 | Maximum number of emails to store in memory                                   |
| SMTP_KEY_FILE            |         | Path to the private key file for SSL/TLS. Required if SSL/TLS is enabled.     |
| SMTP_CERT_FILE           |         | Path to the certificate file for SSL/TLS. Required if SSL/TLS is enabled.     |

## 4. API Endpoints

The API runs on port 8080 and provides endpoints for managing emails programmatically. API docs are WIP.

## 5. Troubleshooting

- Cannot connect to SMTP servers:
  Verify that the required ports (25, 465, 587) are not in use by another process.
  Check the `.env` file for correct configurations.
- Authentication issues:
  Ensure ADMIN_USERNAME and ADMIN_PASSWORD are correctly set in the `.env` file.
  Restart the server after updating the .env.
- SSL/TLS setup:
  Ensure `SMTP_KEY_FILE` and `SMTP_CERT_FILE` paths are valid and accessible.

## 6. Usage Examples (Client)

#### NodeJS (`nodemailer` library)

```javascript
import nodemailer from 'nodemailer';

const transporter = nodemailer.createTransport({
	host: 'localhost',
	port: 25,
	secure: false,
	tls: {
		rejectUnauthorized: false,
	},
});

const mailOptions = {
	from: '"Sender Name" <your-email@example.com>',
	to: 'recipient@example.com',
	subject: 'Test Email',
	text: 'Hello, this is a test email!',
	html: `<b>Hello, this is a test email!</b>`,
};

transporter.sendMail(mailOptions, (error, info) => {
	if (error) {
		return console.log('An error occurred:', error);
	}
	console.log('Email sent:', info.response);
});
```

#### Python (`smtplib` and `email` libraries)

```python
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

host = "localhost"
port = 25

sender_email = "your-email@example.com"
recipient_email = "recipient@example.com"
subject = "Test Email"
text_body = "Hello, this is a test email!"
html_body = "<b>Hello, this is a test email!</b>"

message = MIMEMultipart("alternative")
message["From"] = f"Sender Name <{sender_email}>"
message["To"] = recipient_email
message["Subject"] = subject

message.attach(MIMEText(text_body, "plain"))
message.attach(MIMEText(html_body, "html"))

try:
    with smtplib.SMTP(host, port) as server:
        server.starttls()  # Start TLS if needed
        server.sendmail(sender_email, recipient_email, message.as_string())
        print("Email sent successfully!")
except Exception as e:
    print(f"An error occurred: {e}")
```

#### Ruby (`mail` gem)

```ruby
require 'mail'

# Mail setup
options = {
  address: 'localhost',
  port: 25,
  enable_starttls_auto: false # Disable TLS verification
}

Mail.defaults do
  delivery_method :smtp, options
end

# Create and send email
mail = Mail.new do
  from    'Sender Name <your-email@example.com>'
  to      'recipient@example.com'
  subject 'Test Email'
  text_part do
    body 'Hello, this is a test email!'
  end
  html_part do
    content_type 'text/html; charset=UTF-8'
    body '<b>Hello, this is a test email!</b>'
  end
end

begin
  mail.deliver!
  puts "Email sent successfully!"
rescue => e
  puts "An error occurred: #{e}"
end
```

## 7. Valid alternatives

Here is a list of valid alternatives:

1. [Mailtrap Fake SMTP service](https://mailtrap.io/fake-smtp-server/)
2. [MailHog](https://github.com/mailhog/MailHog)

## 8. Contributions

We welcome contributions! Feel free to fork the repository and submit a pull request.
