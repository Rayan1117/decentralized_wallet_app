const sql = require('mssql');

class DatabaseAccess {
    #dbConfig = {
        server: 'ASUS',
        database: 'DAPP',
        user: 'ADMIN',
        password: 'db33937778db',
        options: {
            trustServerCertificate: true
        }
    }

    #connectToDB() {
        try {
            if (!sql.pool) {
                sql.pool = sql.connect(this.#dbConfig);
            }
            return sql.pool;
        } catch (err) {
            throw err;
        }
    }

    async executeQuery(query, parameters = null) {
        try {
            const pool = await this.#connectToDB();
            const request = pool.request();
            if (parameters) {
                for (const key in parameters) {
                    if (parameters.hasOwnProperty(key)) {
                        request.input(key, parameters[key]['type'], parameters[key]['value']);
                    }
                }
            }

            const results = await request.query(query);
            
            return results.recordset;
        } catch (err) {
            throw err;
        }
    }
}

module.exports.Database = DatabaseAccess;