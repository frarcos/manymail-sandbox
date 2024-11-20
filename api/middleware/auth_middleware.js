import httpStatus from 'http-status';

export const validateBasicAuth = (req, res, next) => {
	const authHeader = req.headers.authorization;

	if (!authHeader || !authHeader.startsWith('Basic ')) {
		return res
			.status(httpStatus.UNAUTHORIZED)
			.json({ message: 'Authorization header missing or malformed' });
	}

	const base64Credentials = authHeader.split(' ')[1];
	const credentials = Buffer.from(base64Credentials, 'base64').toString(
		'utf-8'
	);
	const [username, password] = credentials.split(':');

	if (
		username !== process.env.ADMIN_USERNAME ||
		password !== process.env.ADMIN_PASSWORD
	) {
		return res
			.status(httpStatus.UNAUTHORIZED)
			.json({ message: 'Invalid credentials' });
	}

	next();
};
