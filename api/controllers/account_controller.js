import httpStatus from 'http-status';
import { catchSend } from '../error_handling/catch_send.js';
import { matchedData } from 'express-validator';

export const validateAccountCredentials = async (req, res) => {
	try {
		let data = matchedData(req);
		let success =
			data.username === process.env.ADMIN_USERNAME &&
			data.password === process.env.ADMIN_PASSWORD;
		res.status(httpStatus.OK).json({ success });
	} catch (e) {
		catchSend(res, e);
	}
};
