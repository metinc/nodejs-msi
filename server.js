var http = require('http');

http.createServer(function (req, res) {
  res.write('hello world');
  res.end();
}).listen(9000);