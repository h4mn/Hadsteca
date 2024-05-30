#import SimpleHTTPServer
import http.server
import socketserver

PORT = 8082

try:
	Handler = http.server.SimpleHTTPRequestHandler

	with socketserver.TCPServer(("", PORT), Handler) as httpd:
		print("Pressione ^C para sair")
		print("Servidor web na porta ", PORT)
		httpd.serve_forever()

except KeyboardInterrupt:
	print("Saindo...")
	httpd.socket.close()