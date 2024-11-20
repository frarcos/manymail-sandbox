import httpStatus from 'http-status';
import { catchSend } from '../error_handling/catch_send.js';
import { matchedData } from 'express-validator';
import {
	removeMessage,
	selectAttachmentContentById,
	selectMessageById,
	selectMessageContentById,
	selectMessages,
	selectNewMessages,
} from '../services/message_service.js';

export const getNewMessages = async (req, res) => {
	try {
		let data = matchedData(req);
		let { messages, total } = await selectNewMessages(data.query, data.from);
		res.status(httpStatus.OK).json({ messages, total });
	} catch (e) {
		catchSend(res, e);
	}
};

export const getMessages = async (req, res) => {
	try {
		let data = matchedData(req);
		let { messages, has_next_page, total } = await selectMessages(
			data.page,
			data.query,
			data.from
		);
		res.status(httpStatus.OK).json({ messages, has_next_page, total });
	} catch (e) {
		catchSend(res, e);
	}
};

export const getMessageById = async (req, res) => {
	try {
		let data = matchedData(req);
		let { success, message, content_url, attachments } =
			await selectMessageById(data.message_id);
		if (success) {
			res.status(httpStatus.OK).json({ content_url, attachments });
		} else {
			res.status(httpStatus.BAD_REQUEST).json({
				message,
			});
		}
	} catch (e) {
		catchSend(res, e);
	}
};

export const getMessageContentById = async (req, res) => {
	try {
		let data = matchedData(req);
		let { success, message, content } = await selectMessageContentById(
			data.message_id
		);
		if (success) {
			res.status(httpStatus.OK).json({ ...content });
		} else {
			res.status(httpStatus.BAD_REQUEST).json({
				message,
			});
		}
	} catch (e) {
		catchSend(res, e);
	}
};

export const getAttachmentContentById = async (req, res) => {
	try {
		let data = matchedData(req);
		let { success, message, messageAttachment, fileContent } =
			await selectAttachmentContentById(data.attachment_id);
		if (success) {
			res.setHeader('Content-Type', messageAttachment.content_type);
			res.status(httpStatus.OK).send(fileContent);
		} else {
			res.status(httpStatus.BAD_REQUEST).json({
				message,
			});
		}
	} catch (e) {
		catchSend(res, e);
	}
};

export const deleteMessage = async (req, res) => {
	try {
		let data = matchedData(req);
		let { success, message } = await removeMessage(data.message_id);
		if (success) {
			res
				.status(httpStatus.OK)
				.json({ success: true, message: 'Message deleted' });
		} else {
			res.status(httpStatus.BAD_REQUEST).json({
				success,
				message,
			});
		}
	} catch (e) {
		catchSend(res, e);
	}
};
