export const buildUpdateQuery = (data, allowedFields) => {
	const fieldsToUpdate = [];
	const values = [];

	for (const field of allowedFields) {
		if (data[field] !== undefined) {
			fieldsToUpdate.push(`${field} = ?`);
			values.push(data[field]);
		}
	}

	return { fieldsToUpdate, values };
};
