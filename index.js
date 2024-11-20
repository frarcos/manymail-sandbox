import { app, port } from './api/index.js';
import {
	unsecureSmtpServer,
	unsecureSmtpPort,
	smtpServer,
	smtpPort,
	startTLSServer,
	startTLSPort,
} from './smtp/index.js';

console.log(`
    .:--=--.       .:--=--.      .:-=+++=:       :--==-:.   
  -+++++++++-    :=++++++++-   .=+++++++++-   .=+++++++++:  
.++++++++++++: :++++++++++++..=++++++++++++..=++++++++++++  
=-:-+++++++++==+++++++++++++=++=-++++++++++-++++++++++++++. 
    =+++++++++=.  .++++++++++:   .++++++++++-.  :+++++++++  
    +++++++++-     ++++++++=     .+++++++++.    :++++++++=  
   :++++++++-     .++++++++:     -++++++++.     -++++++++:  
   =+++++++=      -++++++++      ++++++++=      +++++++++   
  :++++++++-      +++++++++     :++++++++=     -++++++++-   
  =++++++++=     :+++++++++     =++++++++=     +++++++++.   
 .++++++++++.    =+++++++++:   .++++++++++.   .+++++++++.   
 :++++++++++:    ++++++++++-   :++++++++++.   :+++++++++-..-
 .++++++++++     ++++++++++:   .++++++++++    .++++++++++++:
   +++++++.        +++++++       +++++++=      -+++++++++ 	
`);
console.log(`
==================================================
✨  Welcome to ManyMail Sandbox SMTP Server! ✨

Here's how to get started:

1️⃣  Connect to our SMTP servers:
    - Standard Port: 25
    - Secure Ports: 465* (SSL), 587* (STARTTLS)

2️⃣  Access the admin dashboard:
    - Open: http://localhost:8080
    - Login with your admin credentials.

3️⃣  Use the sandbox to send and test emails in a secure environment!

*Note:
   - Admin credentials are the same as the SMTP login credentials.
   - Configure them via the .env file or Docker Compose environment variables.

📖  Checkout the user guide in the readme.md directly from the repo (https://github.com/frarcos/manymail-sandbox/readme.md)

Happy emailing! 🚀
==================================================
`);

app.listen(port, () => {
	console.log(`✅  ManyMail Sandbox Web & API are running on port ${port}\n`);
});

if (process.env.RUN_UNSECURE_SMTP_SERVER === 'true') {
	unsecureSmtpServer.listen(unsecureSmtpPort, () => {
		console.log(
			`✅  ManyMail Sandbox Unsecure SMTP server is running on port ${unsecureSmtpPort}\n`
		);
	});
}

if (process.env.RUN_SMTP_SERVER === 'true') {
	smtpServer.listen(smtpPort, () => {
		console.log(
			`✅  ManyMail Sandbox Secure SMTP server is running on port ${smtpPort}\n`
		);
	});
}

if (process.env.RUN_STARTTLS_SERVER === 'true') {
	startTLSServer.listen(startTLSPort, () => {
		console.log(
			`✅  ManyMail Sandbox SMTP server with STARTTLS is running on port ${startTLSPort}\n`
		);
	});
}
