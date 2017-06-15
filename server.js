var fs = require('fs');
var express = require('express');
var app = express();
var http = require('http');
var join = require('path').join;

module.exports = function (PORT, log) {

  app.use(express.static(join(__dirname, '/development')));

  app.get('/',function(req, res, next) {
    var indexPage = join(__dirname, 'development/index.html');
    return res.status(200).sendFile(indexPage);
  })

  var httpServer = http.createServer(app);

  httpServer.listen(PORT, function(){
    log("Server running on ", PORT);
  })

}