from flask import Flask

# ### #
#
# This is to test a cloudbuild trigger.
# More testing.
# Test again.
# And again.
# once more.
#
# ### #

app = Flask(__name__)

@app.route('/')
def main():
    return "here's another fake function", 200

if __name__ == "__main__":
    app.run(debug=True,host='0.0.0.0',port=8080)