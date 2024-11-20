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
