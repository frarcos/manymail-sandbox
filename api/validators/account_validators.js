import { body } from 'express-validator';
import { validationBuilder } from '../middleware/validation_middleware.js';

export const validateCredentials = validationBuilder([
	body('username').isString().withMessage('Invalid username').trim(),
	body('password').isString().withMessage('Invalid password').trim(),
]);
