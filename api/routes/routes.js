import { Router } from 'express';
import {
	deleteMessage,
	getAttachmentContentById,
	getMessageById,
	getMessageContentById,
	getMessages,
	getNewMessages,
} from '../controllers/message_controller.js';
import {
	validateAttachmentId,
	validateMessageId,
	validateMessages,
	validateNewMessages,
} from '../validators/message_validators.js';
import { validateBasicAuth } from '../middleware/auth_middleware.js';
import { validateAccountCredentials } from '../controllers/account_controller.js';
import { validateCredentials } from '../validators/account_validators.js';

const router = Router();

router
	.route('/account/validate')
	.post(validateCredentials, validateAccountCredentials);
router.route('/messages').get(validateBasicAuth, validateMessages, getMessages);
router
	.route('/messages/new')
	.get(validateBasicAuth, validateNewMessages, getNewMessages);
router
	.route('/messages/:message_id')
	.get(validateBasicAuth, validateMessageId, getMessageById)
	.delete(validateBasicAuth, validateMessageId, deleteMessage);
router
	.route('/messages/:message_id/content')
	.get(validateBasicAuth, validateMessageId, getMessageContentById);

router
	.route('/attachments/:attachment_id/content')
	.get(validateBasicAuth, validateAttachmentId, getAttachmentContentById);

export default router;
