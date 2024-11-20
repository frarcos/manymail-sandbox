import fs from 'fs';
import csv from 'csv-parser';

export const readCsv = async (filePath) => {
	const data = [];
	return new Promise((resolve, reject) => {
		fs.createReadStream(filePath)
			.pipe(csv())
			.on('data', (row) => {
				if (Object.keys(row).length > 0) {
					data.push(row);
				}
			})
			.on('end', () => resolve(data))
			.on('error', (err) => reject(err));
	});
};

export const escapeCsvValue = (value, separator) => {
	if (
		typeof value === 'string' &&
		(value.includes(separator) || value.includes('"') || value.includes('\n'))
	) {
		return `"${value.replace(/"/g, '""')}"`;
	}
	return value;
};

export const writeCsv = (filePath, dataList, separator = ',') => {
	if (dataList.length === 0) {
		if (fs.existsSync(filePath)) {
			fs.unlinkSync(filePath);
			return;
		}
	}
	if (!Array.isArray(dataList) || dataList.length === 0) {
		throw new Error('Data should be a non-empty array of objects.');
	}
	const header = Object.keys(dataList[0]);
	const headerRow =
		header.map((key) => escapeCsvValue(key, separator)).join(separator) + '\n';
	fs.writeFileSync(filePath, headerRow);
	dataList.forEach((data) => {
		const row = header.map((key) => escapeCsvValue(data[key], separator) || '');
		const csvRow = row.join(separator) + '\n';
		fs.appendFileSync(filePath, csvRow);
	});
};
