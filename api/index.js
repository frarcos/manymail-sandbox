import express from 'express';
import bodyParser from 'body-parser';
import httpStatus from 'http-status';
import morgan from 'morgan';
import winston from 'winston';
import router from './routes/routes.js';
import { validateBasicAuth } from './middleware/auth_middleware.js';
import path from 'path';
import { fileURLToPath } from 'url';

export const app = express();
export const port = 8080;

const logger = winston.createLogger({
	level: 'info',
	format: winston.format.combine(
		winston.format.timestamp(),
		winston.format.json()
	),
	transports: [
		new winston.transports.Console(),
		new winston.transports.File({ filename: 'logs/server.log' }),
	],
});

app.enable('trust proxy');
if (process.env.ENABLE_LOGGING) {
	app.use(
		morgan('combined', {
			stream: {
				write: (message) => logger.info(message.trim()),
			},
		})
	);
}
app.use(bodyParser.json());
app.use((req, res, next) => {
	res.setHeader('Access-Control-Allow-Origin', '*');
	res.setHeader(
		'Access-Control-Allow-Methods',
		'GET, POST, OPTIONS, PUT, PATCH, DELETE'
	);
	res.setHeader('Access-Control-Allow-Headers', '*');
	res.setHeader('Access-Control-Allow-Credentials', true);
	next();
});

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const buildPath = path.resolve(__dirname, '..', 'frontend', 'build', 'web');
app.use(express.static(buildPath));
app.get('/', (req, res) => {
	res.sendFile(path.join(buildPath, 'index.html'));
});

app.use('/api', router);
app.use(
	'/data',
	validateBasicAuth,
	express.static(path.join(path.resolve(), 'data'))
);
app.use((req, res) => {
	res.status(httpStatus.NOT_FOUND).json({
		message: 'API path not found',
	});
});
app.use((err, req, res, next) => {
	if (process.env.ENABLE_LOGGING) {
		logger.error(err.stack);
	}
	res.status(httpStatus.INTERNAL_SERVER_ERROR).json({
		message: 'An unexpected error occurred',
	});
});
