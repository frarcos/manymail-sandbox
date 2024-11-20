import { param, query } from 'express-validator';
import { validationBuilder } from '../middleware/validation_middleware.js';

export const validateNewMessages = validationBuilder([
	query('query').optional().isString().withMessage('Invalid query').trim(),
	query('from')
		.optional()
		.isISO8601()
		.withMessage('Invalid from parameter')
		.trim(),
]);

export const validateMessages = validationBuilder([
	query('page').isInt({ min: 1 }).withMessage('Invalid page, min 1'),
	query('query').optional().isString().withMessage('Invalid query').trim(),
	query('from')
		.optional()
		.isISO8601()
		.withMessage('Invalid from parameter')
		.trim(),
]);

export const validateMessageId = validationBuilder([
	param('message_id').isUUID().withMessage('Invalid message id'),
]);

export const validateAttachmentId = validationBuilder([
	param('attachment_id').isUUID().withMessage('Invalid message id'),
]);
