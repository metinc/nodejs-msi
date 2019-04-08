const http = require('http');

const port = normalizePort(process.env.PORT || '9000');

http.createServer(function (req, res) {
  res.write('hello world');
  res.end();
}).listen(port);


/**
 * Normalize a port into a number, string, or false.
 */

function normalizePort(val) {
  let port = parseInt(val, 10);

  if (isNaN(port)) {
    // named pipe
    return val;
  }

  if (port >= 0) {
    // port number
    return port;
  }

  return false;
}