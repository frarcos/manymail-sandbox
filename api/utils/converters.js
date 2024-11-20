export const convertIsoToMySql = (isoDate) => {
	const date = new Date(isoDate);
	const year = date.getUTCFullYear();
	const month = String(date.getUTCMonth() + 1).padStart(2, '0');
	const day = String(date.getUTCDate()).padStart(2, '0');
	const hours = String(date.getUTCHours()).padStart(2, '0');
	const minutes = String(date.getUTCMinutes()).padStart(2, '0');
	const seconds = String(date.getUTCSeconds()).padStart(2, '0');
	return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
};

export const convertBooleanToMysql = (value) => {
	if (value === true || value === 'true') {
		return 1;
	} else if (value === false || value == 'false') {
		return 0;
	}
};
