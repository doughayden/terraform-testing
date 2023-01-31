# ### #
#
# https://codelabs.developers.google.com/codelabs/cloud-run-hello-python3#0
#
# ### #

from flask import Flask, request

app = Flask(__name__)

@app.route('/')
def main():
    qui = request.args.get("qui", default="Le monde")
    return f"Bonjour {qui}!\n", 200

if __name__ == "__main__":
    app.run(host='localhost', port=8080, debug=True)
