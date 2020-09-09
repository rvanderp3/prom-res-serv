# Basic prometheus query result server.  

from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import urlparse
from urllib.parse import parse_qs
class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):

    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()        
        queryParams = parse_qs(urlparse(self.path).query)
        metricName = queryParams["query"][0]
        print(metricName)
        f = open(metricName,"rb")
        self.wfile.write(f.read())
        f.close()

httpd = HTTPServer(('0.0.0.0', 8000), SimpleHTTPRequestHandler)
httpd.serve_forever()
