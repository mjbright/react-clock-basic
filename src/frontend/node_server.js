
var listenPort = '9090';
//var listenPort = '80';
var listenIface = '0.0.0.0';
//var listenIface = '127.0.0.1';

// IP:port of react service:
var redirectUrl = '127.0.0.1:8080';

var listenAddr = `${listenIface}:${listenPort}`;

var http = require('http');
var hostname = require('os').hostname().split('.').shift();
var child_process = require("child_process");
var fqdn = hostname;

var color = require("ansi-color").set;
// var COLOR = color("HELLO", "red"); console.log(COLOR);
var COLOR="__XX__";

var MSG = `Hello World`;

process.argv.forEach(function (val, index, array) {
    // console.log(index + ': ' + val);

    if (index == 3) { MSG=val; }
    if (index == 2) { COLOR=val; }
});

color_log = function (msg) {
  console.log( color(msg, COLOR) );
}

if (COLOR.includes('__')) { COLOR="red"; }

child_process.exec("hostname -f", function(err, stdout, stderr) {
    fqdn = stdout.trim();
});

var handleRequest = function(request, response) {
  fullUrl = request.headers.host + request.url;
  client = (request.headers['x-forwarded-for'] || '').split(',')[0] || request.connection.remoteAddress;

  ua = request.headers['user-agent'];
  msg=`Received request from ${client} [${ua}] for URL: ${fullUrl}`;
  color_log(msg); //msg=color(msg, COLOR); //console.log(msg);

  response_msg = `${MSG}\n`;
  response_msg=color(response_msg, COLOR); //#console.log(response_msg);
  response.writeHead(200);
  response.end(response_msg);
  return;
};

var www = http.createServer(handleRequest);

var msg = `Listening for requests on ${listenAddr}`;
//msg=color(msg, COLOR); //console.log( msg );
color_log( msg );

www.listen( listenPort, listenIface );

