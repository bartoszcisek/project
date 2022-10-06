from flask import Flask, request, make_response, jsonify
import socket
import psutil
import sys

app = Flask(__name__)


@app.route('/-/health')
def health():
    p = psutil.Process()
    memory = p.memory_info()
    cpu = p.cpu_times()
    debug = {
        "platform": sys.platform,
        "hostname": socket.gethostname(),
        "rss": memory._asdict(),
        "cpu": cpu._asdict(),
    }

    response = make_response(jsonify(debug))
    response.headers["Content-Type"] = "application/json"
    return response


@app.route('/api/echo', methods=['GET'])
def echo():
    if request.method == 'GET':
        response = request.args
    return response
