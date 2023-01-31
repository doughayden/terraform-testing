# ### #
#
#
# https://codelabs.developers.google.com/codelabs/cloud-run-hello-python3#0
#
#
# ### #

from flask import Flask, request

app = Flask(__name__)

@app.route('/')
def main():
    who = request.args.get("who", default="World")
    return f"Hello {who}!\n", 200

if __name__ == "__main__":
    app.run(host='localhost', port=8080, debug=True)
