import path from 'path';
import fs from 'fs';
import { pageSize } from '../constants/pagination.js';
import { readCsv, writeCsv } from './csv_service.js';

const messagesFilePath = path.join(path.resolve(), 'data', 'messages.csv');
const attachmentsFilePath = path.join(
	path.resolve(),
	'data',
	'attachments.csv'
);

export var messages = [];
export var attachments = [];

const initialize = async () => {
	const messagesDir = path.dirname(messagesFilePath);
	if (!fs.existsSync(messagesDir)) {
		fs.mkdirSync(messagesDir, { recursive: true });
	}
	if (!fs.existsSync(messagesFilePath)) {
		fs.writeFileSync(messagesFilePath, '');
	}
	messages = (await readCsv(messagesFilePath)) ?? [];
	const attachmentsDir = path.dirname(attachmentsFilePath);
	if (!fs.existsSync(attachmentsDir)) {
		fs.mkdirSync(attachmentsDir, { recursive: true });
	}
	if (!fs.existsSync(attachmentsFilePath)) {
		fs.writeFileSync(attachmentsFilePath, '');
	}
	attachments = (await readCsv(attachmentsFilePath)) ?? [];
};
initialize();

export const addMessageToDb = async (
	id,
	email_id,
	recipients,
	sender,
	subject,
	short_text
) => {
	if (messages.length > process.env.MAX_STORED_MESSAGES) {
		throw Error(
			`Maximum stored messages (${process.env.MAX_STORED_MESSAGES}) exceeded`
		);
	}
	const created_at = new Date().toISOString();
	const message = {
		id,
		email_id,
		recipients,
		sender,
		subject,
		short_text,
		created_at,
	};
	messages.unshift(message);
	writeCsv(messagesFilePath, messages);
	return id;
};

export const addAttachmentToDb = async (
	id,
	message_id,
	filename,
	content_type
) => {
	const attachment = { id, message_id, filename, content_type };
	attachments.unshift(attachment);
	writeCsv(attachmentsFilePath, attachments);
};

export const selectNewMessages = async (query = '', from = '') => {
	let filteredData = messages;
	if (query) {
		filteredData = messages.filter((message) =>
			[message.recipients, message.sender, message.subject].some(
				(field) => field && field.toLowerCase().includes(query.toLowerCase())
			)
		);
	}

	if (from) {
		const fromDate = new Date(from);
		if (!isNaN(fromDate.getTime())) {
			filteredData = filteredData.filter(
				(message) => new Date(message.created_at) >= fromDate
			);
		}
	}
	return {
		messages: filteredData,
		total: messages.length,
	};
};

export const selectMessages = async (page, query = '', from = '') => {
	let filteredData = messages;
	if (query) {
		filteredData = messages.filter((message) =>
			[message.recipients, message.sender, message.subject].some(
				(field) => field && field.toLowerCase().includes(query.toLowerCase())
			)
		);
	}

	if (from) {
		const fromDate = new Date(from);
		if (!isNaN(fromDate.getTime())) {
			filteredData = filteredData.filter(
				(message) => new Date(message.created_at) >= fromDate
			);
		}
	}
	const offset = (page - 1) * pageSize;
	const paginatedData = filteredData.slice(offset, offset + pageSize);
	return {
		messages: paginatedData,
		has_next_page: filteredData.length > offset + pageSize,
		total: messages.length,
	};
};

export const selectMessageById = async (id) => {
	const message = messages.find((msg) => msg.id === id);
	if (!message) {
		return { success: false, message: 'Message not found' };
	}
	const messageAttachments = attachments.filter(
		(attachment) => attachment.message_id === id
	);
	return {
		success: true,
		message: 'Message retrieved successfully',
		attachments: messageAttachments,
	};
};

export const selectMessageContentById = async (id) => {
	const message = messages.find((msg) => msg.id === id);
	if (!message) {
		return { success: false, message: 'Message not found' };
	}
	const contentFilePath = path.join(
		path.resolve(),
		'data',
		'uploads',
		'messages',
		message.id
	);
	const fileContent = fs.readFileSync(contentFilePath, 'utf8');
	const content = JSON.parse(fileContent);
	return {
		success: true,
		message: 'Message retrieved successfully',
		content,
	};
};

export const selectAttachmentContentById = async (id) => {
	const messageAttachment = attachments.find(
		(attachment) => attachment.id === id
	);
	if (!messageAttachment) {
		return { success: false, message: 'Attachment not found' };
	}
	const contentFilePath = path.join(
		path.resolve(),
		'data',
		'uploads',
		'attachments',
		messageAttachment.id
	);
	const fileContent = fs.readFileSync(contentFilePath);
	return {
		success: true,
		message: 'Message retrieved successfully',
		messageAttachment,
		fileContent,
	};
};

export const removeMessage = async (id) => {
	const message = messages.find((msg) => msg.id === id);
	if (!message) {
		return { success: false, message: 'Message not found' };
	}
	const contentFilePath = path.join(
		path.resolve(),
		'data',
		'uploads',
		'messages',
		message.id
	);
	if (fs.existsSync(contentFilePath)) {
		fs.unlinkSync(contentFilePath);
	}
	const messageAttachments = attachments.filter(
		(attachment) => attachment.message_id === id
	);
	messageAttachments.forEach((attachment) => {
		const attachmentFilePath = path.join(
			path.resolve(),
			'data',
			'uploads',
			'attachments',
			attachment.id
		);
		if (fs.existsSync(attachmentFilePath)) {
			fs.unlinkSync(attachmentFilePath);
		}
	});
	messages = messages.filter((message) => message.id !== id);
	writeCsv(messagesFilePath, messages);
	attachments = attachments.filter(
		(attachment) => attachment.message_id !== id
	);
	writeCsv(attachmentsFilePath, attachments);
	return {
		success: true,
		message: 'Message and associated files deleted',
	};
};
