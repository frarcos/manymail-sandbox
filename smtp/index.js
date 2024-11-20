import { SMTPServer } from 'smtp-server';
import { simpleParser } from 'mailparser';
import { v4 as uuidv4 } from 'uuid';
import path from 'path';
import fs from 'fs';
import {
	addMessageToDb,
	addAttachmentToDb,
} from '../api/services/message_service.js';

async function saveMessageToDb(id, parsed) {
	await addMessageToDb(
		id,
		parsed.messageId,
		parsed.to.text,
		parsed.from.text,
		parsed.subject || null,
		(parsed.text ?? '').substring(0, 200)
	);
	return id;
}

async function saveAttachments(messageId, attachments) {
	for (const attachment of attachments) {
		const id = uuidv4();
		const saveTo = path.join(
			path.resolve(),
			'data',
			'uploads',
			'attachments',
			id
		);
		const directoryPath = path.dirname(saveTo);
		fs.mkdirSync(directoryPath, { recursive: true });
		fs.writeFileSync(saveTo, attachment.content);
		addAttachmentToDb(
			id,
			messageId,
			attachment.filename,
			attachment.contentType
		);
	}
}

async function handleIncomingEmail(stream, session, callback) {
	let data = '';
	stream.on('data', (chunk) => {
		data += chunk;
	});

	stream.on('end', async () => {
		try {
			const parsed = await simpleParser(data);

			const headersObject = {};
			for (const [key, value] of parsed.headers) {
				headersObject[key] = value;
			}

			const id = uuidv4();
			const saveTo = path.join(
				path.resolve(),
				'data',
				'uploads',
				'messages',
				id
			);
			const directoryPath = path.dirname(saveTo);
			fs.mkdirSync(directoryPath, { recursive: true });
			fs.writeFileSync(
				saveTo,
				JSON.stringify({
					headers: headersObject,
					text_body: parsed.text,
					text_html: parsed.html,
				})
			);
			await saveMessageToDb(id, parsed);
			if (parsed.attachments.length > 0) {
				await saveAttachments(id, parsed.attachments);
			}
			console.log(`Received: ${id} ${parsed.messageId}`);
		} catch (err) {
			console.error('Error processing email:', err);
		} finally {
			callback();
		}
	});

	stream.on('error', (err) => {
		console.error('Stream error:', err);
		callback();
	});
}

const unsecureSmtpPort = process.env.UNSECURE_SMTP_PORT;
const smtpPort = process.env.SMTP_PORT;
const startTLSPort = process.env.STARTTLS_PORT;
const options = {
	key:
		process.env.SSL_PRIVATEKEY && fs.readFileSync(process.env.SSL_PRIVATEKEY),
	cert:
		process.env.SSL_CERTIFICATE && fs.readFileSync(process.env.SSL_CERTIFICATE),
};

const unsecureSmtpServer = new SMTPServer({
	secure: false,
	port: unsecureSmtpPort,
	disabledCommands: ['AUTH'],
	banner: 'Welcome to ManyMail Sandbox SMTP server',
	onConnect(session, callback) {
		console.log('Secure SMTP - Client connected:', session.remoteAddress);
		callback();
	},
	onError(err) {
		console.error('Secure SMTP - Server error:', err);
	},
	onData: handleIncomingEmail,
});

const smtpServer = new SMTPServer({
	secure: true,
	port: smtpPort,
	banner: 'Welcome to ManyMail Sandbox SMTP server',
	key: options.key,
	cert: options.cert,
	async onAuth(auth, session, callback) {
		if (
			auth.username === process.env.ADMIN_USERNAME &&
			auth.password === process.env.ADMIN_PASSWORD
		) {
			return callback(null, { user: {} });
		}
		return callback(new Error('Invalid username or password'));
	},
	onConnect(session, callback) {
		console.log('Secure SMTP - Client connected:', session.remoteAddress);
		callback();
	},
	onError(err) {
		console.error('Secure SMTP - Server error:', err);
	},
	onData: handleIncomingEmail,
});

const startTLSServer = new SMTPServer({
	secure: false,
	port: startTLSPort,
	banner: 'Welcome to ManyMail Sandbox SMTP Server with STARTTLS',
	key: options.key,
	cert: options.cert,
	async onAuth(auth, session, callback) {
		if (
			auth.username === process.env.ADMIN_USERNAME &&
			auth.password === process.env.ADMIN_PASSWORD
		) {
			return callback(null, { user: {} });
		}
		return callback(new Error('Invalid username or password'));
	},
	onConnect(session, callback) {
		console.log('STARTTLS Server - Client connected:', session.remoteAddress);
		callback();
	},
	onError(err) {
		console.error('STARTTLS Server - Server error:', err);
	},
	onData: handleIncomingEmail,
});

export {
	unsecureSmtpServer,
	unsecureSmtpPort,
	smtpServer,
	smtpPort,
	startTLSServer,
	startTLSPort,
};
