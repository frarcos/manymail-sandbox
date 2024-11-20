import httpStatus from 'http-status';
import ApiError from './api_error.js';

export const catchSend = function (res, e) {
	if (e instanceof ApiError) {
		res.status(e.statusCode).json({
			message: e.message,
		});
	} else if (e.code === 'ER_DUP_ENTRY') {
		res.status(httpStatus.CONFLICT).json({
			message:
				'Duplicate entry. The data you are trying to insert already exists.',
		});
	} else {
		console.log(e);
		res.status(httpStatus.INTERNAL_SERVER_ERROR).json({
			message: e.toString(),
		});
	}
};
